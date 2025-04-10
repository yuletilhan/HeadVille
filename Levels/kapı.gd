extends Node2D

@onready var anim_tree = $AnimationTree
@onready var playback = anim_tree.get("parameters/playback") # StateMachine kontrolü için

var is_open := false

func _ready():
    # Başlangıçta kapalı olsun
    playback.start("close")  # Varsayılan olarak 'close' state'ine git
    set_collision(true)      # Collision aktif (kapalı)

func _input(event):
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        var mouse_pos = get_global_mouse_position()
        if $Sprite2D.get_rect().has_point(to_local(mouse_pos)):
            toggle_door()

func toggle_door():
    if is_open:
        playback.travel("close")  # Kapalı animasyonuna geç
        set_collision(true)       # Çarpışmayı aç
    else:
        playback.travel("open")   # Açık animasyonuna geç
        set_collision(false)      # Çarpışmayı kapat
    is_open = !is_open

func set_collision(enabled: bool):
    $StaticBody2D/CollisionShape2D.disabled = not enabled
