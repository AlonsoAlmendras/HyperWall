shader_type spatial;
render_mode unshaded;

uniform sampler2D video_texture; // Textura del video
uniform vec2 highlight_center = vec2(0.8, 0.2); // Centro del resaltado (esquina superior derecha)
uniform float highlight_radius = 0.15; // Tamaño del área resaltada
uniform float darkness = 0.3; // Oscuridad fuera del resaltado (0 = negro, 1 = sin cambios)

void fragment() {
    vec2 uv = UV; // Coordenadas UV del píxel actual
    vec4 video_color = texture(video_texture, uv); // Color del video en este píxel

    // Calcula la distancia entre el píxel actual y el centro del resaltado
    float dist = distance(uv, highlight_center);

    // Si el píxel está dentro del área resaltada, no lo oscurezcas
    if (dist < highlight_radius) {
        ALBEDO = video_color.rgb; // Mantén el color original
    } else {
        ALBEDO = video_color.rgb * darkness; // Oscurece el color
    }
}