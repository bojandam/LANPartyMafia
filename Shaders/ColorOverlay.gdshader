shader_type canvas_item;

uniform int colorCount; 
uniform vec4 target_colors[1] : source_color;
uniform vec4 replace_colors[1] : source_color; 
uniform float tolerance : hint_range(0, 1); 
 
void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
 	for(int i=0;i<colorCount;i++){
    	float dist = distance(tex_color.rgb, target_colors[i].rgb);
	    if (dist <= tolerance) {
	        tex_color.rgb = replace_colors[i].rgb;
	    }
	}
 
    COLOR = tex_color;
}



 
