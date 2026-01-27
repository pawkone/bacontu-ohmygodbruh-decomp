draw_self();

if (usePalette)
{
    pal_swap_set(spr_palette, paletteIndex, false);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    shader_reset();
    pattern_draw(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha, spr_pattern, patColors, spr_palette, paletteIndex);
}
