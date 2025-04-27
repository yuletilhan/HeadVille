extends CharacterBody2D

# Hareket ayarları
@export var speed := 100
@export var camera_smoothing_speed := 5.0
var last_horizontal_direction := 1
var inventory = {}

func _ready():
    # Oyuncuyu "player" grubuna ekle
    add_to_group("player")
    
    # Eğer Inventory node'u yoksa, oluştur
    if not has_node("Inventory"):
        var inventory_node = Node.new()
        inventory_node.name = "Inventory"
        add_child(inventory_node)
        # Inventory scriptini eklemek için proje dosyalarında olmalı veya harici olarak eklenmiş olmalı

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
        if last_horizontal_direction < 0:
            $Sprite2D.flip_h = true
        else:
            $Sprite2D.flip_h = false

func collect_item(item_id):
    if has_node("Inventory"):
        if $Inventory.has_method("add_item"):
            $Inventory.add_item(item_id)
            print("Item eklendi: ", item_id)
        else:
            # Inventory node'u var ama add_item metodu yok
            add_item_to_inventory(item_id)
            print("Item eklendi (dahili): ", item_id)
    else:
        # Inventory node'u yok, dahili envanter kullan
        add_item_to_inventory(item_id)
        print("Item eklendi (dahili): ", item_id)

func add_item_to_inventory(item_id):
    # Temel envanter fonksiyonu
    if inventory.has(item_id):
        inventory[item_id] += 1
    else:
        inventory[item_id] = 1
    print("Şu anki envanter:", inventory)
    
    
