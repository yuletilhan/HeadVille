#ItemList

extends Node
class_name ItemDatabase

static func get_item_data(item_id: String) -> Dictionary:
    var items = {
        "wood": {
            "name": "Wood",
            "icon": preload("res://Assets/icons/wood.png"),
            "stack_size": 99
        },
        "stone": {
            "name": "Stone", 
            "icon": preload("res://Assets/icons/stone.png"),
            "stack_size": 99
        },
        "iron": {
            "name": "Iron",
            "icon": preload("res://Assets/icons/iron.png"),
            "stack_size": 50
        },
        "copper": {
            "name": "Copper",
            "icon": preload("res://Assets/icons/copper.png"),
            "stack_size": 50
        },
        "gold": {
            "name": "Gold",
            "icon": preload("res://Assets/icons/gold.png"),
            "stack_size": 25
        },
        "coal": {
            "name": "Coal",
            "icon": preload("res://Assets/icons/coal.png"),
            "stack_size": 50
        }
    }
    return items.get(item_id, {}).duplicate(true)

static func get_all_item_ids() -> Array:
    return ["wood", "stone", "iron", "copper", "gold", "coal"]
