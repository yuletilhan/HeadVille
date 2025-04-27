# item_slot.gd
extends Panel

@onready var icon = $TextureRect
@onready var amount_label = $AmountLabel
#@onready var name_label = $NameLabel  # İsteğe bağlı

func setup(texture, amount, item_name=""):
    icon.texture = texture
    if amount <= 1:
        amount_label.hide()
    else:
        amount_label.text = str(amount)
        amount_label.show()
    
    #if name_label and not item_name.is_empty():
        #name_label.text = item_name
