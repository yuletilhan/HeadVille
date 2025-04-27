# InventoryUI.gd
extends Control

@onready var grid_container = $CanvasLayer/Panel/GridContainer
var item_slot_scene = preload("res://ui/item_slot.tscn")

func _ready():
    visible = false
    # Oyuncu karakterini bul ve sinyalleri bağla
    var player = get_tree().get_first_node_in_group("player")
    if player and player.has_node("Inventory"):
        player.get_node("Inventory").connect("inventory_updated", Callable(self, "update_inventory"))

func update_inventory(inventory_data):
    # Önce tüm slot'ları temizle
    for child in grid_container.get_children():
        child.queue_free()
    
    # Her eşya için bir slot ekle
    for item_id in inventory_data.keys():
        var amount = inventory_data[item_id]
        var item_data = ItemDatabase.get_item_data(item_id)
        
        var slot = item_slot_scene.instantiate()
        grid_container.add_child(slot)
        slot.setup(item_data["icon"], amount, item_data["name"])
        

    

func _input(event):
    if event.is_action_pressed("inventory_toggle"):
        visible = !visible
