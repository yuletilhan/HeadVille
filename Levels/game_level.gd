extends Node2D

# Spawn settings
@export var spawn_area : Rect2 = Rect2(0, 0, 800, 600)
@export var max_spawn_count : int = 10
@export var spawn_interval : float = 5.0

# Node references
@onready var spawn_timer : Timer = $SpawnTimer
@onready var player_cat = $PlayerCat

# Spawn variables
var current_items : int = 0
var spawn_weights := {
    "wood": 50,
    "stone": 30,
    "iron": 10,
    "copper": 8,
    "gold": 5,
    "coal": 2
}

func _ready():
    # Disable player initially
    player_cat.visible = false
    player_cat.set_process(false)
    player_cat.set_physics_process(false)
    
    # Timer setup
    spawn_timer.wait_time = spawn_interval
    spawn_timer.timeout.connect(_on_spawn_timer_timeout)
    spawn_timer.start()
    
    # Initial items
    for i in range(3):
        spawn_random_item()

func spawn_random_item():
    if current_items >= max_spawn_count:
        return
    
    var random_item_id = get_random_item_id()
    var spawn_pos = Vector2(
        randf_range(spawn_area.position.x, spawn_area.end.x),
        randf_range(spawn_area.position.y, spawn_area.end.y)
    )
    
    var item_scene = preload("res://scenes/item_pickup.tscn")
    var item_instance = item_scene.instantiate()
    item_instance.position = spawn_pos
    item_instance.setup(random_item_id)
    item_instance.item_picked_up.connect(_on_item_picked_up)
    add_child(item_instance)
    
    current_items += 1

func get_random_item_id() -> String:
    var total_weight = spawn_weights.values().reduce(func(a, b): return a + b)
    var roll = randf() * total_weight
    var cumulative = 0.0
    
    for item_id in spawn_weights:
        cumulative += spawn_weights[item_id]
        if roll <= cumulative:
            return item_id
    
    return "wood"  # Fallback

func _on_spawn_timer_timeout():
    spawn_random_item()

func _on_item_picked_up(item_id):
    current_items -= 1
    print("Item collected:", item_id)
    # Add inventory updates or scoring here
