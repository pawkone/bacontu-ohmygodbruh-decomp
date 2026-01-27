var touch_me_midas_make_me_part_of = !(borderY == borderTargetpos);
BGX += 0.5;
BGY -= 0.5;

if (!surface_exists(surf))
    surf = surface_create(895.999968, 140.16 * borderscaleYmult);

surface_set_target(surf);
draw_clear_alpha(c_white, 0);
draw_sprite_ext(spr_npcborder, 1, 0, 0, 9.333333, 1.45 * borderscaleYmult, 0, c_white, 1);
gpu_set_blendmode(bm_min);
draw_sprite_tiled(spr_flobox, 0, BGX, BGY);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface(surf, borderX, borderY);
draw_sprite_ext(spr_npcborder, 0, borderX, borderY, 9.333333, 1.45 * borderscaleYmult, 0, c_white, 1);
draw_set_color(c_black);
draw_set_font(global.npcfont);
draw_set_halign(fa_left);
draw_textEX(borderX + 16, borderY + 10, text, 850);
var _height = (array_get(ds_map_find_value(global.textCache, text), 2) / string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ")) + 1;

if (rescaled == false)
{
    rescaled = true;
    
    for (var i = 0; i < _height; i++)
    {
        if (i > 2)
        {
            borderTargetpos -= 64;
            borderscaleYmult += 0.36;
        }
    }
    
    borderY = borderTargetpos;
    surface_resize(surf, 895.999968, 140.16 * borderscaleYmult);
}

draw_set_color(c_white);
