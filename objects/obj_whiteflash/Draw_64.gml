draw_set_alpha(image_alpha);
draw_set_color(c_white);
draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);

if (instance_exists(obj_player))
{
    with (obj_player)
        draw_sprite_ext(sprite_index, image_index, x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]), xscale * xscaleMulti, 1 * yscaleMulti, image_angle, c_black, other.image_alpha);
}

if (instance_exists(obj_baddiedead))
{
    with (obj_baddiedead)
    {
        if (sprite_index == spr_mugmonolith_dead)
            draw_sprite_ext(sprite_index, image_index, x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]), image_xscale, image_yscale, image_angle, c_black, other.image_alpha);
    }
}

draw_set_color(c_white);
draw_set_alpha(1);
