draw_sprite_ext(sprite_index, image_index, x + xoffset, y + yoffset, xscaleMulti * xscale, yscaleMulti, image_angle, image_blend, image_alpha);

if (state == states.scared)
{
    gpu_set_fog(true, c_red, 0, 1);
    draw_sprite_ext(sprite_index, image_index, x + xoffset, y + yoffset, xscaleMulti * xscale, yscaleMulti, image_angle, image_blend, fear / 120);
    gpu_set_fog(false, c_red, 0, 1);
    exit;
}

xscaleMulti = lerp(xscaleMulti, 1, 0.35);
yscaleMulti = lerp(yscaleMulti, 1, 0.35);
