extends Panel

@onready var backgroundSprite = $background
@onready var iconSprite = $CenterContainer/Panel/icon

func update(item: InventoryItem):
    if !item:
        backgroundSprite.frame= 0
        iconSprite.visible= false
    else:
        backgroundSprite.frame=1
        iconSprite.visible= true
        iconSprite.texture=item.texture
