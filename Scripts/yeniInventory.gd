extends Resource
class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
    # Aynı item'ı taşıyan slotları bul
    var item_slots = slots.filter(func(slot): return slot.item == item and slot.amount < item.maxAmountPerStack)
    
    if !item_slots.is_empty():
        # Bulunan ilk uygun slota ekle
        item_slots[0].amount += 1
    else:
        # Boş slot bul
        var empty_slots = slots.filter(func(slot): return slot.item == null)
        if !empty_slots.is_empty():
            empty_slots[0].item = item
            empty_slots[0].amount = 1
        else:
            # Eğer boş slot da yoksa, item eklenemez
            print("Inventory is full!")
    
    updated.emit()
