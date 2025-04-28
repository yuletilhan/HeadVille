extends TileMapLayer  # Veya TileMap düğümüne doğrudan ekleyebilirsin

func _ready():
    # TileMap'i al
    var tilemap = $Sıfır
    
    # Kullanılan alanı (hücre cinsinden) ve hücre boyutunu al
    var used_rect = tilemap.get_used_rect()
    var cell_size = tilemap.cell_size
    
    # Piksel cinsinden boyutu hesapla
    var width_px = used_rect.size.x * cell_size.x
    var height_px = used_rect.size.y * cell_size.y
    
    # Sonucu konsola yazdır
    print("═" * 50)
    print("🏡 Sahne Boyutu Bilgisi:")
    print("├─ Hücre Sayısı (Genişlik x Yükseklik): ", used_rect.size)
    print("├─ Tek Hücre Boyutu (Piksel): ", cell_size)
    print("└─ Toplam Sahne Boyutu (Piksel): ", Vector2(width_px, height_px))
    print("═" * 50)
