extends Button

@onready var backgroundSprite = $background
@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://Inventory/playerInventory.tres")

var itemStackGui: ItemStackGui
var index: int

func insert(isg: ItemStackGui):
    if isg == null:  # Null öğe eklenemez
        return
    
    itemStackGui = isg
    backgroundSprite.frame = 1
    container.add_child(itemStackGui)
    
    if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot:
        return
        
    inventory.insertSlot(index, itemStackGui.inventorySlot)

func takeItem():
    if itemStackGui == null or not is_instance_valid(itemStackGui):  # Çift kontrol
        return null
    
    var item = itemStackGui
    
    # Önce envanterden kaldır
    if itemStackGui.inventorySlot != null:
        inventory.removeSlot(itemStackGui.inventorySlot)
    
    # Görseli kaldır (child varsa)
    if container.get_children().has(itemStackGui):
        container.remove_child(itemStackGui)
    
    itemStackGui = null
    backgroundSprite.frame = 0
    return item

func isEmpty():
    return itemStackGui == null or not is_instance_valid(itemStackGui)
