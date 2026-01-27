if (global.hide_hud)
    exit;

draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, image_angle, image_blend, image_alpha);

if (very)
    draw_sprite_ext(spr_combomucho, image_index, x - 64, y - 32, scale, scale, image_angle, image_blend, image_alpha);

if (lostcombo)
{
    draw_sprite_ext(spr_comboend, image_index, x, y - 32, scale, scale, image_angle, image_blend, image_alpha);
    draw_set_alpha(image_alpha);
    draw_set_halign(fa_center);
    draw_set_font(global.smallfont);
    draw_text(x, y + 32, points);
    draw_set_alpha(1);
}
