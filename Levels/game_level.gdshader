shader_type canvas_item;

// DALGA PARAMETRELERİ
uniform float speed = 5.0;
uniform float amplitude = 0.2;
uniform float frequency = 0.2;
uniform vec2 direction = vec2(0.9, 0.1); // %90 yatay, %10 dikey

// RENK KONTROLLERİ (YENİ)
uniform float saturation = 1.2;    // Renk doygunluğu (1.0 = normal)
uniform float brightness = 1.0;    // Parlaklık (1.0 = normal)
uniform vec3 water_color = vec3(0.3, 0.5, 0.8); // Temel su rengi (RGB)

void fragment() {
    // 1. GERÇEKÇİ DALGA FORMÜLÜ
    vec2 world_uv = UV * TEXTURE_PIXEL_SIZE;
    float wave = sin(TIME * speed + dot(world_uv, direction / frequency)) * amplitude;
    
    // 2. RENK KORUMA (YENİ)
    vec2 distorted_uv = vec2(
        UV.x + wave * 0.3, // Yatay hafif kayma
        UV.y + wave        // Dikey hareket
    );
    
    // 3. ORİJİNAL TEXTURE'DAN RENK AL
    vec4 tex_color = texture(TEXTURE, distorted_uv);
    
    // 4. RENK DÜZENLEME (YENİ)
    // a) Temel su rengiyle karıştır
    vec3 blended_color = mix(tex_color.rgb, water_color, 0.3);
    
    // b) Doygunluk ve parlaklık ayarı
    float luminance = dot(blended_color, vec3(0.299, 0.587, 0.114));
    blended_color = mix(vec3(luminance), blended_color, saturation);
    blended_color *= brightness;
    
    // 5. KÖPÜK KORUMA
    // Texture'daki beyazlık oranını koru (alpha ile blend)
    float foam = step(0.7, tex_color.r); // Beyaz piksel maskesi
    blended_color = mix(blended_color, tex_color.rgb, foam * 0.8);
    
    // 6. FİNAL ÇIKTI
    COLOR = vec4(blended_color, tex_color.a);
}