# Envanter arayüzünü yöneten ana kontrol script'i
extends CanvasLayer

# Envanter arayüz referansı (otomatik bağlantılı)
@onready var inventory = $InventoryGui

# Oyun başladığında çalışan fonksiyon
func _ready():
    # Envanteri başlangıçta kapalı konuma getir
    inventory.close()
    
# Girdi işleme fonksiyonu
func _input(event):
    # "toggle_inventory" aksiyonu tetiklendiğinde (klavye tuşu/controller düğmesi)
    if event.is_action_pressed("toggle_inventory"):
        # Envanter açıksa kapat
        if inventory.isOpen:
            inventory.close()
        # Envanter kapalıysa aç
        else:
            inventory.open()

### TEMEL İŞLEVLER ###

# 1. inventory:
#   - Sahne hiyerarşisindeki InventoryGui düğümüne referans
#   - @onready sayesinde otomatik olarak bağlanır
#   - Envanter açma/kapama işlemleri bu düğüm üzerinden yapılır

# 2. _ready():
#   - Oyun yüklendiğinde envanterin kapalı başlamasını sağlar
#   - Kullanıcı arayüzünün başlangıç durumunu ayarlar

# 3. _input(event):
#   - Kullanıcı girdilerini dinler
#   - toggle_inventory aksiyonu için özel işlem yapar
#   - Envanterin açık/kapalı durumuna göre aksiyon alır

### PROJE AYARLARI ###

# "toggle_inventory" aksiyonunu eklemek için:
# 1. Project > Project Settings > Input Map sekmesine git
# 2. Yeni aksiyon ekle: "toggle_inventory"
# 3. Klavye kısayolu ata (genellikle "Tab" veya "I")
# 4. Controller düğmesi ek
