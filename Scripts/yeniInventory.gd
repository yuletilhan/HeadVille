# Envanter verilerini yöneten temel sınıf
extends Resource
class_name Inventory

# Envanter güncellendiğinde tetiklenen sinyal
signal updated

# Envanter slotlarını tutan dizi (Inspector'dan ayarlanabilir)
@export var slots: Array[InventorySlot]

# Envantere yeni öğe ekleme fonksiyonu
func insert(item: InventoryItem):
    # 1. ÖNCE AYNI TÜRDEN VE DOLU OLMAYAN SLOTLARA BAK
    var dolu_olmayan_slotlar = slots.filter(
        func(slot): 
            # Aynı öğe tipinde ve maksimum miktara ulaşmamış slotları filtrele
            return slot.item == item and slot.amount < item.maxAmountPerStack
    )
    
    # Eğer uygun slot bulunduysa
    if not dolu_olmayan_slotlar.is_empty():
        # Bulunan ilk uygun slota 1 adet ekle
        dolu_olmayan_slotlar[0].amount += 1
    
    # 2. BOŞ SLOT ARA
    else:
        var bos_slotlar = slots.filter(
            func(slot): 
                # Tamamen boş olan slotları filtrele
                return slot.item == null
        )
        
        if not bos_slotlar.is_empty():
            # Boş slota yeni öğe yerleştir
            bos_slotlar[0].item = item
            bos_slotlar[0].amount = 1
        
        # 3. YER YOKSA UYARI VER
        else:
            print("Hata: Envanter dolu! Yeni öğe eklenemedi: ", item.name)
    
    # Değişiklikleri bildir
    updated.emit()

# Belirli bir slotu kaldırma fonksiyonu
func removeSlot(inventorySlot: InventorySlot):
    # Slotun listedeki konumunu bul
    var slot_index = slots.find(inventorySlot)
    
    # Eğer slot bulunamazsa çık
    if slot_index < 0:
        return
    
    # Slotu sıfırla (yeni boş slot oluştur)
    slots[slot_index] = InventorySlot.new()
    updated.emit()

# Belirli pozisyona slot ekleme fonksiyonu
func insertSlot(index: int, inventorySlot: InventorySlot):
    # Verilen konumdaki slotu güncelle
    slots[index] = inventorySlot
    updated.emit()
