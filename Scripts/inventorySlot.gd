# Tek bir envanter slotunun verisini tutan sınıf
extends Resource
class_name InventorySlot

# Slotun içindeki öğenin tanımı (Inspector'da görülebilir/ayarlanabilir)
@export var item: InventoryItem

# Slotta bulunan bu öğeden kaç tane olduğu (Inspector'da görülebilir/ayarlanabilir)
@export var amount: int

### ÖNEMLİ ÖZELLİKLER ###

# 1. item: 
#   - Bu slotta bulunan öğenin tanımını (InventoryItem) tutar
#   - null ise slot boş demektir
#   - Öğe tipi, görseli, yığınlanabilirliği gibi tüm özellikleri içerir

# 2. amount:
#   - Bu öğeden kaç adet bulunduğunu gösterir
#   - Genellikle 1'den büyükse yığınlanmış öğe anlamına gelir
#   - InventoryItem'daki maxAmountPerStack değerini aşamaz
