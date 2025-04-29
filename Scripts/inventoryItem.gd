# Envanter öğelerinin temel özelliklerini tanımlayan sınıf
extends Resource
class_name InventoryItem

# Öğenin görüntülenecek adı (Inspector'da düzenlenebilir)
@export var name: String = ""

# Öğenin envanterde gösterilecek resmi (Inspector'da atanabilir)
@export var texture: Texture2D

# Bir slotta maksimum kaç adet yığınlanabileceği (Inspector'da ayarlanabilir)
@export var maxAmountPerStack: int = 1

### TEMEL ÖZELLİKLER ###

# 1. name:
#   - Öğenin oyun içinde görünecek adı
#   - Örneğin: "Demir Kılıç", "Sağlık İksiri"
#   - Boş bırakılmamalıdır

# 2. texture:
#   - Envanter arayüzünde gösterilecek 2D görsel
#   - Genellikle 64x64 veya 32x32 piksel boyutunda olur
#   - Öğeyi temsil eden ikonik bir görsel olmalı

# 3. maxAmountPerStack:
#   - Bir slotta maksimum kaç adet birikebileceği
#   - 1 = yığınlanamaz (kılıç, zırh gibi)
#   - >1 = yığınlanabilir (madeni para, iksir gibi)
#   - Genellikle 64, 99 gibi standart değerler kullanılır

### KULLANIM ÖRNEKLERİ ###

# Yeni bir öğe oluşturma:
# var yeni_oge = InventoryItem.new()
# yeni_oge.name = "Elma"
# yeni_oge.texture = preload("res://resimler/elma.png")
# yeni_oge.maxAmountPerStack = 10

# Öğe bilgilerini gösterme:
# print("Öğe Adı: ", self.name)
# print("Maksimum Yığın: ", self.maxAmountPerStack)

### ÖNEMLİ NOTLAR ###

# - Bu sınıf tüm envanter öğelerinin TEMEL SINIFIDIR
# - Özel öğe tipleri için bu sınıftan türetim yapılabilir
# - Resource olduğu için diske .tres uzantısıyla kaydedilebilir
# - Oyun başında Resources olarak önceden yüklenebilir
