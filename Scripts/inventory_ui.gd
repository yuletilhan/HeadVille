extends Control

signal opened
signal closed

var isOpen: bool = false
var itemInHand: ItemStackGui
var oldIndex: int = -1

@onready var inventory: Inventory = preload("res://Inventory/playerInventory.tres")
@onready var ItemStackGuiClass = preload("res://Scenes/itemStackGui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
    connectSlots()
    inventory.updated.connect(update)
    update()
    set_process_input(true)  # Input işlemeyi aktifleştir

func connectSlots():
    for i in range(slots.size()):
        var slot = slots[i]
        slot.index = i
        slot.pressed.connect(onSlotClicked.bind(slot))

func update():
    for i in range(min(inventory.slots.size(), slots.size())):
        var inventorySlot = inventory.slots[i]
        
        if !inventorySlot.item: 
            if slots[i].itemStackGui:
                slots[i].takeItem()
            continue
            
        var itemStackGui = slots[i].itemStackGui
        if !itemStackGui:
            itemStackGui = ItemStackGuiClass.instantiate()
            slots[i].insert(itemStackGui)
            
        itemStackGui.inventorySlot = inventorySlot
        itemStackGui.update()

func open():
    visible = true
    isOpen = true
    opened.emit()

func close():
    visible = false
    isOpen = false
    closed.emit()

func onSlotClicked(slot):
    if slot.isEmpty():
        if !itemInHand: return
        insertItemInSlot(slot)
        return
    
    if !itemInHand:
        takeItemFromSlot(slot)
        return
    
    if slot.itemStackGui.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
        stackItems(slot)
        return
    
    swapItems(slot)

func takeItemFromSlot(slot):
    itemInHand = slot.takeItem()
    add_child(itemInHand)
    updateItemInHand()
    oldIndex = slot.index

func insertItemInSlot(slot):
    var item = itemInHand
    remove_child(itemInHand)
    itemInHand = null
    slot.insert(item)
    oldIndex = -1

func swapItems(slot):
    var tempItem = slot.takeItem()
    insertItemInSlot(slot)
    itemInHand = tempItem
    add_child(itemInHand)
    updateItemInHand()

func stackItems(slot):
    var slotItem = slot.itemStackGui
    var maxAmount = slotItem.inventorySlot.item.maxAmountPerStack
    var totalAmount = slotItem.inventorySlot.amount + itemInHand.inventorySlot.amount
    
    if slotItem.inventorySlot.amount == maxAmount:
        swapItems(slot)
        return
        
    if totalAmount <= maxAmount:
        slotItem.inventorySlot.amount = totalAmount
        remove_child(itemInHand)
        itemInHand = null
        oldIndex = -1
    else:
        slotItem.inventorySlot.amount = maxAmount
        itemInHand.inventorySlot.amount = totalAmount - maxAmount
        
    slotItem.update()
    if itemInHand: 
        itemInHand.update()

func updateItemInHand():
    if !itemInHand: return
    itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2

func putItemBack():
    if !itemInHand: return
    
    # Eski konum boşsa veya geçersizse boş slot ara
    if oldIndex < 0 || oldIndex >= slots.size() || !slots[oldIndex].isEmpty():
        for i in range(slots.size()):
            if slots[i].isEmpty():
                oldIndex = i
                break
    
    if oldIndex >= 0 && oldIndex < slots.size() && slots[oldIndex].isEmpty():
        insertItemInSlot(slots[oldIndex])
    else:
        # Hiç boş slot yoksa envantere zorla ekle
        var emptySlot = inventory.get_first_empty_slot()
        if emptySlot >= 0:
            inventory.slots[emptySlot] = itemInHand.inventorySlot
            remove_child(itemInHand)
            itemInHand = null
            oldIndex = -1
            inventory.updated.emit()

func _input(event):
    updateItemInHand()
    
    if event.is_action_pressed("right_click") && itemInHand:
        putItemBack()
        
        # DEBUG
    if event is InputEventMouseButton:
        print("Mouse Event: ", event)
        print("Button Index: ", event.button_index)
        print("Pressed: ", event.pressed)
        print("Action Check: ", event.is_action("right_click"))
    
    if event.is_action_pressed("right_click"):
        print("--- RIGHT CLICK DETECTED ---")
        if itemInHand:
            print("Item in hand detected, trying to put back...")
            putItemBack()
        else:
            print("No item in hand")
