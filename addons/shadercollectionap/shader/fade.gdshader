shader_type canvas_item;

// Параметры остаются прежними
uniform float divide = 0.065;
uniform float blur = 0.385;
uniform float fade_width = 0.995;

void fragment() {
    float top_fade_edge = fade_width;
    float bottom_fade_edge = 1.0 - fade_width;
    
    float horizontal_leftFade = 1.0;
    float horizontal_rightFade = 1.0;
    float vertical_topFade = 1.0;
    float vertical_bottomFade = 1.0;

    // Градиент слева направо (горизонтальная ось)
    if (UV.x < top_fade_edge) {        
        float px = UV.x / fade_width;
        horizontal_leftFade = smoothstep(divide, divide + blur, px);   
    }

    if (UV.x > bottom_fade_edge) {
        float px = (1.0 - UV.x) / fade_width;   // зеркальное отражение
        horizontal_rightFade = smoothstep(divide, divide + blur, px);
    }

    // Градиент сверху вниз (вертикальная ось)
    if (UV.y < top_fade_edge) {
        float py = UV.y / fade_width;
        vertical_topFade = smoothstep(divide, divide + blur, py);
    }

    if (UV.y > bottom_fade_edge) {
        float py = (1.0 - UV.y) / fade_width;   // зеркальное отражение
        vertical_bottomFade = smoothstep(divide, divide + blur, py);
    }

    // Минимальные значения обоих направлений определяют итоговую прозрачность
    float finalFade = min(horizontal_leftFade * horizontal_rightFade,
                          vertical_topFade * vertical_bottomFade);

    COLOR.w *= finalFade;
}