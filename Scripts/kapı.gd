extends Node2D

var is_open := false
var animation_playing := false

func _input(event):
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        var mouse_pos = get_global_mouse_position()
        if $Sprite2D.get_rect().has_point(to_local(mouse_pos)) and not animation_playing:
            toggle_door()

func toggle_door():
    animation_playing = true
    if is_open:
        $AnimationPlayer.play("close")
    else:
        $AnimationPlayer.play("open")
    is_open = !is_open

func _on_animation_player_animation_finished(anim_name):
    if anim_name == "open" or anim_name == "close":
        set_collision(!is_open)  # Kapı açıksa collision kapalı, kapalıysa collision açık
        animation_playing = false

func set_collision(enabled: bool):
    $StaticBody2D/CollisionShape2D.disabled = not enabled
