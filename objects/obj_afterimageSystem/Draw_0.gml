if (!ds_list_empty(afterimages))
{
    for (var i = 0; i < ds_list_size(afterimages); i++)
    {
        var q = ds_list_find_value(afterimages, i);
        
        with (q)
        {
            var _shd = false;
            var _blend = 16777215;
            var _drawPattern = false;
            
            switch (type)
            {
                case afterimagetype.normal:
                    _blend = image_blend;
                    break;
                
                case afterimagetype.blur:
                    pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false);
                    _blend = image_blend;
                    _shd = true;
                    _drawPattern = true;
                    break;
                
                case afterimagetype.buzzsaw:
                    var _col = 16071083;
                    var _col2 = 16749804;
                    var col = [color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255];
                    var col2 = [color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255];
                    shader_set(shd_fullshade);
                    shader_set_uniform_f_array(other.uniformLight, [col[0], col[1], col[2]]);
                    shader_set_uniform_f_array(other.uniformDark, [col2[0], col2[1], col2[2]]);
                    _shd = true;
                    break;
                
                case afterimagetype.mach:
                    var _col2 = merge_colour(image_blend, c_black, 0.5);
                    var _col = image_blend;
                    var col = [color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255];
                    var col2 = [color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255];
                    shader_set(shd_fullshade);
                    shader_set_uniform_f_array(other.uniformLight, [col[0], col[1], col[2]]);
                    shader_set_uniform_f_array(other.uniformDark, [col2[0], col2[1], col2[2]]);
                    _shd = true;
                    break;
                
                case afterimagetype.selectcolor:
                    var _col2 = selectcolor2;
                    var _col = selectcolor;
                    var col = [color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255];
                    var col2 = [color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255];
                    shader_set(shd_fullshade);
                    shader_set_uniform_f_array(other.uniformLight, [col[0], col[1], col[2]]);
                    shader_set_uniform_f_array(other.uniformDark, [col2[0], col2[1], col2[2]]);
                    _shd = true;
                    break;
                
                case afterimagetype.milton:
                    var _col = 16736352;
                    var _col2 = 9580846;
                    var col = [color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255];
                    var col2 = [color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255];
                    shader_set(shd_fullshade);
                    shader_set_uniform_f_array(other.uniformLight, [col[0], col[1], col[2]]);
                    shader_set_uniform_f_array(other.uniformDark, [col2[0], col2[1], col2[2]]);
                    _shd = true;
                    break;
                
                case afterimagetype.UNKNOWN_2:
                    break;
                
                case afterimagetype.UNKNOWN_3:
                    break;
            }
            
            if (visible == true)
                draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, _blend, image_alpha * alpha * fadeoutAlpha);
            
            if (_shd)
                shader_reset();
            
            if (_drawPattern)
                pattern_draw(sprite_index, image_index, x, y, image_xscale, 1, 0, _blend, image_alpha * alpha, global.patternSpr, global.PlayerCharacters[obj_player.character].patColors, obj_player.spr_palette, obj_player.palIndex);
            
            gpu_set_blendmode(bm_normal);
        }
    }
}
