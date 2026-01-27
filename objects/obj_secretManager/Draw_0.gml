if (!surface_exists(tileSurf))
    tileSurf = surface_create(obj_screensizer.displayWidth, obj_screensizer.displayHeight);

var _tile_count = array_length(tiles);
surface_set_target(tileSurf);
draw_clear_alpha(c_black, 0);
shader_set(shd_pattern);
var q = sprite_get_texture(spr_secretColors, 0);
var p = sprite_get_uvs(spr_secretColors, 0);
var s = texture_get_texel_height(q);
texture_set_stage(global.patternColors, q);
shader_set_uniform_f(global.patternUVs, p[0], p[1], p[2], p[3]);
shader_set_uniform_f(global.patternTexel, s);
var _tileCount = array_length(tiles);
draw_set_alpha(1);

for (var i = 0; i < _tile_count; i++)
    draw_tilemap(tiles[i], -camera_get_view_x(view_camera[0]), -camera_get_view_y(view_camera[0]));

shader_reset();
gpu_set_blendmode(bm_min);
draw_sprite_tiled(spr_tileDoodles, patternIndex, -camera_get_view_x(view_camera[0]), -camera_get_view_y(view_camera[0]) + patternPos);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_set_alpha(patternAlpha);
pal_swap_set(spr_whitefix, 1, false);
draw_surface(tileSurf, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));
shader_reset();
draw_set_alpha(1);
pal_swap_set(spr_secretColors, 1, false);

for (var i = 0; i < _tile_count; i++)
    draw_tilemap(tiles[i], 0, 0);

shader_reset();

for (var i = 0; i < array_length(collectables); i++)
{
    q = collectables[i];
    
    if (!instance_exists(q.id))
    {
        draw_set_alpha(0.3);
        draw_sprite(q.sprite, q.index, q.x, q.y);
    }
    
    q.index += 0.35;
}

draw_set_alpha(1);
