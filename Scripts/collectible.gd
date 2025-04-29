# Toplanabilir öğeler için temel script
extends Area2D

# Toplanacak öğenin verisi (Inspector'dan atanır)
@export var itemRes: InventoryItem

# Öğeyi toplama fonksiyonu
func collect(inventory: Inventory):
    # Geçersiz envanter kontrolü
    if inventory == null:
        printerr("Hata: Geçersiz envanter!")
        return
    
    # Öğe verisi kontrolü
    if itemRes == null:
        printerr("Hata: Öğe verisi tanımlı değil!")
        return
    
    # Öğeyi envantere ekle
    inventory.insert(itemRes)
    
    # Sahneden kaldır
    queue_free()

### TEMEL İŞLEVLER ###

# 1. itemRes:
#   - Bu öğenin envanter verisini tutar
#   - Inspector'da elle atama yapılmalıdır
#   - Örneğin: HealthPotion, IronSword gibi InventoryItem'lar

# 2. collect(inventory):
#   - Öğenin toplanma mantığını yönetir
#   - Parametre olarak oyuncu envanterini alır
#   - Önce null kontrolleri yapar
#   - Sonra envantere ekler ve sahneyi temizler


# Player script'inden çağırma örneği:
# func _on_area_entered(area):
#     if area.is_in_group("collectible"):
#         area.collect(self.inventory)
