global.patternColors = shader_get_sampler_index(shd_pattern, "tex_setColors");
global.patternUVs = shader_get_uniform(shd_pattern, "tex_colorsUV");
global.patternTexel = shader_get_uniform(shd_pattern, "tex_height");

function pattern_draw(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = global.patternSpr, arg10 = spr_playerPatColors, arg11 = obj_player.spr_palette, arg12 = obj_player.palIndex)
{
    if (arg9 != -1)
    {
        var _surf = surface_create(sprite_get_width(arg0), sprite_get_height(arg0));
        surface_set_target(_surf);
        draw_clear_alpha(c_black, 0);
        shader_reset();
        shader_set(shd_pattern);
        var q = sprite_get_texture(arg10, 0);
        var p = sprite_get_uvs(arg10, 0);
        var s = texture_get_texel_height(q);
        texture_set_stage(global.patternColors, q);
        shader_set_uniform_f(global.patternUVs, p[0], p[1], p[2], p[3]);
        shader_set_uniform_f(global.patternTexel, s);
        draw_sprite_ext(arg0, arg1, sprite_get_xoffset(arg0), sprite_get_yoffset(arg0), 1, 1, arg6 * arg4, c_white, 1);
        shader_reset();
        gpu_set_blendmode(bm_min);
        pal_swap_set(arg11, arg12, false);
        draw_sprite_tiled_ext(arg9, 0, 0, 0, arg4, 1, c_white, 1);
        shader_reset();
        gpu_set_blendmode(bm_normal);
        surface_reset_target();
        draw_surface_ext(_surf, arg2 - (sprite_get_xoffset(arg0) * arg4), arg3 - (sprite_get_yoffset(arg0) * arg5), arg4, arg5, 0, arg7, arg8);
        surface_free(_surf);
    }
}
