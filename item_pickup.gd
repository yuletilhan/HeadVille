extends Node2D

# Define the signal properly at the top
signal item_picked_up(item_id)

var item_id : String

func _ready():
    # Eğer item_id başlangıçta ayarlanmadıysa
    if item_id.is_empty():
        # Rastgele bir item_id seçebilirsiniz veya varsayılan belirleyebilirsiniz
        item_id = "wood"
        setup(item_id)

func setup(id: String):
    item_id = id
    var item_data = ItemDatabase.get_item_data(id)
    if item_data.has("icon"):
        $Sprite2D.texture = item_data["icon"]

# Area2D node'u kullanıyorsanız
func _on_area_2d_body_entered(body):
    if body.is_in_group("player"):
        emit_signal("item_picked_up", item_id)
        body.collect_item(item_id)
        queue_free()

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        # Mouse tıklamasının item'a yakın olup olmadığını kontrol et
        if get_global_mouse_position().distance_to(global_position) < 50:
            var player = get_tree().get_first_node_in_group("player")
            if player:
                emit_signal("item_picked_up", item_id)
                player.collect_item(item_id)
                queue_free()
