if (super)
{
    for (var i = 0; i < 16; i++)
    {
        var _xx = sin((current_time * 0.001) + (2 * i)) * 2 * i;
        var _yy = cos((current_time * 0.001) + (1 * i)) * 2 * i;
        var _alpha = abs(sin((current_time * 0.001) + (5 * i))) * 0.1;
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(sprite_index, image_index, x + _xx, y + _yy, xscaleMulti * xscale, 1 * yscaleMulti, image_angle, c_red, image_alpha * _alpha);
        gpu_set_blendmode(bm_normal);
    }
}

pal_swap_set(spr_palette, palIndex, false);
draw_sprite_ext(sprite_index, image_index, x, y, xscale * xscaleMulti * squashX, 1 * yscaleMulti * squashY, image_angle, image_blend, image_alpha);
shader_reset();
squashX = lerp(squashX, 1, 0.25);
squashY = lerp(squashY, 1, 0.25);
pattern_draw(sprite_index, image_index, x, y, xscale * xscaleMulti * squashX, 1 * yscaleMulti * squashY, image_angle, image_blend, image_alpha, global.patternSpr, global.PlayerCharacters[character].patColors);

if (flash)
{
    shader_set(shd_flash);
    draw_sprite_ext(sprite_index, image_index, x, y, xscaleMulti * xscale * squashX, 1 * yscaleMulti * squashY, image_angle, image_blend, image_alpha);
    shader_reset();
}
