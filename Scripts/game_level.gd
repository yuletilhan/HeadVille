extends Node2D

@onready var player_cat = $PlayerCat


func _ready():
    # Disable player initially
    player_cat.visible = false
    player_cat.set_process(false)
    player_cat.set_physics_process(false)
    

#func _on_inventory_gui_closed() -> void:
    #get_tree().paused=false


#func _on_inventory_gui_opened() -> void:
    #get_tree().paused=true
    
