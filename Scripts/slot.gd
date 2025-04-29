# Envanterdeki tek bir slotu temsil eden buton sınıfı
extends Button

# Düğüm referansları
@onready var backgroundSprite = $background  # Slot arkaplan sprite'ı
@onready var container: CenterContainer = $CenterContainer  # İçerik konteyneri
@onready var inventory = preload("res://Inventory/playerInventory.tres")  # Oyuncu envanteri

# Slot özellikleri
var itemStackGui: ItemStackGui  # Slot içindeki öğe GUI'si
var index: int  # Bu slotun envanterdeki indeksi

# Slota öğe ekleme fonksiyonu
func insert(isg: ItemStackGui):
    # Yeni öğeyi slotun değişkenine ata
    itemStackGui = isg
    
    # Arkaplan sprite'ını seçili/dolu görünüme çevir (frame 1)
    backgroundSprite.frame = 1
    
    # Öğeyi konteynere ekle
    container.add_child(itemStackGui)
    
    # Eğer öğe boşsa veya zaten doğru slota atanmışsa envanteri güncelleme
    if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot:
        return
        
    # Envanter verisini güncelle
    inventory.insertSlot(index, itemStackGui.inventorySlot)
    
# Slotdaki öğeyi alma fonksiyonu
func takeItem():
    # Öğeyi geçici değişkene sakla
    var item = itemStackGui
    
    # Envanterden bu öğeyi kaldır
    inventory.removeSlot(itemStackGui.inventorySlot)
    
    # Öğeyi görsel olarak kaldır
    container.remove_child(itemStackGui)
    itemStackGui = null
    
    # Arkaplan sprite'ını boş görünüme çevir (frame 0)
    backgroundSprite.frame = 0
    
    # Alınan öğeyi döndür
    return item

# Slotun boş olup olmadığını kontrol eden fonksiyon
func isEmpty():
    return !itemStackGui  # itemStackGui null ise true (boş), değilse false (dolu) döner
