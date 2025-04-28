extends CharacterBody2D

@export var speed := 90
@export var camera_smoothing_speed := 5.0
@export var inventory: Inventory
var last_horizontal_direction := 1

func _ready():
    add_to_group("player")

func _physics_process(_delta):
    var direction = Vector2.ZERO
    
    if Input.is_action_pressed("right"): direction.x += 1
    if Input.is_action_pressed("left"): direction.x -= 1
    if Input.is_action_pressed("down"): direction.y += 1
    if Input.is_action_pressed("up"): direction.y -= 1
    
    velocity = direction.normalized() * speed
    move_and_slide()
    
    # Animasyon kontrolü
    if direction.x > 0:
        $AnimationPlayer.play("walk_right")
        $Sprite2D.flip_h = false
        last_horizontal_direction = 1
    elif direction.x < 0:
        $AnimationPlayer.play("walk_right")
        $Sprite2D.flip_h = true
        last_horizontal_direction = -1
    elif direction.y < 0:
        $AnimationPlayer.play("walk_up")
    elif direction.y > 0:
        $AnimationPlayer.play("walk_down")
    else:
        $AnimationPlayer.play("idle")
        $Sprite2D.flip_h = (last_horizontal_direction < 0)
        $Sprite2D.flip_h = false

func _on_hurt_box_area_entered(area):
    if area.has_method("collect"):
        area.collect(inventory)
