# Öğe yığınlarını görsel olarak temsil eden GUI bileşeni
extends Panel
class_name ItemStackGui

# Düğüm referansları
@onready var itemSprite = $item  # Öğe görseli (TextureRect)
@onready var amountLabel: Label = $Label  # Miktar yazısı (Label)

# Bağlı envanter slotu
var inventorySlot: InventorySlot

# Görsel güncelleme fonksiyonu
func update():
    # Eğer envanter slotu veya öğe yoksa görselleri gizle
    if !inventorySlot || !inventorySlot.item: 
        itemSprite.visible = false
        amountLabel.visible = false
        return
    
    # Öğe görselini ayarla ve görünür yap
    itemSprite.visible = true
    itemSprite.texture = inventorySlot.item.texture
    
    # Eğer miktar 1'den fazlaysa miktar yazısını göster
    if inventorySlot.amount > 1:
        amountLabel.visible = true
        amountLabel.text = str(inventorySlot.amount)
    else:
        # Değilse miktar yazısını gizle
        amountLabel.visible = false
