extends Sprite2D

var is_open := false

func _input(event):
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        var mouse_pos = get_global_mouse_position()
        if $StaticBody2D/CollisionShape2D.shape.get_rect().has_point(to_local(mouse_pos)):
            toggle_chest()

func toggle_chest():
    if is_open:
        $AnimationPlayer.play("chestclose2")
    else:
        $AnimationPlayer.play("chestopen2")
    is_open = !is_open
