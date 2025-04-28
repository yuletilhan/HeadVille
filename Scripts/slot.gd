extends Panel

@onready var backgroundSprite = $background
@onready var iconSprite = $CenterContainer/Panel/icon
@onready var amountLabel: Label=  $CenterContainer/Panel/Label

func update(slot: InventorySlot):
    if !slot.item:
        backgroundSprite.frame= 0
        iconSprite.visible= false
        amountLabel.visible= false
    else:
        backgroundSprite.frame=1
        iconSprite.visible= true
        iconSprite.texture=slot.item.texture
    
        if slot.amount > 1:
            amountLabel.visible= true
            amountLabel.text=str(slot.amount)
        else:
            amountLabel.visible= false
