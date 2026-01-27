surface_reset_target();
draw_clear(c_black);
gpu_set_blendenable(false);
draw_sprite_tiled(spr_letterbox, 0, 0, 0);
draw_rectangle_color(-1, -1, obj_screensizer.displayWidth + 1, obj_screensizer.displayHeight + 1, c_black, c_black, c_black, c_black, false);
draw_surface_stretched(gameSurface, 0 + ((obj_screensizer.displayWidth / 2) * (1 - size)), 0 + ((obj_screensizer.displayHeight / 2) * (1 - size)), obj_screensizer.displayWidth * size, obj_screensizer.displayHeight * size);
gpu_set_blendenable(true);
draw_set_colour(c_white);
gameframe_draw();

if (global.debug)
{
    var devWindow = [];
    array_push(devWindow, "POWERED BY AVOCADO ENGINE");
    array_push(devWindow, "PROPERTY OF THE SALTSHAKERS");
    array_push(devWindow, string("FPS: {0}", fps));
    array_push(devWindow, string("ROOM: {0}", room_get_name(room)));
    array_push(devWindow, string("Real FPS: {0}", fps_real));
    array_push(devWindow, "exe");
    array_push(devWindow, date_datetime_string(date_current_datetime()));
    
    if (instance_exists(obj_player))
    {
        array_push(devWindow, string("Player x: {0}", obj_player.x));
        array_push(devWindow, string("Player y: {0}", obj_player.y));
        array_push(devWindow, string("Player state: {0}", obj_player.state));
        array_push(devWindow, string("Player sprite: {0}", sprite_get_name(obj_player.sprite_index)));
    }
    
    draw_set_font(font_caption);
    draw_set_halign(fa_left);
    draw_set_alpha(0.1);
    draw_set_color(c_black);
    var _width = 0;
    var _height = 0;
    
    for (var i = 0; i < array_length(devWindow); i++)
    {
        if (string_width(devWindow[i]) > _width)
            _width = string_width(devWindow[i]);
        
        _height += string_height(devWindow[i]);
    }
    
    var _x = 32;
    var _y = obj_screensizer.displayHeight - _height - 64;
    draw_roundrect_ext(_x - 2, _y - 2, _x + _width + 2, _y + _height + 2, 12, 12, false);
    draw_set_alpha(0.35);
    draw_set_color(c_white);
    
    for (var i = 0; i < array_length(devWindow); i++)
        draw_text(_x, _y + (string_height("A") * i), devWindow[i]);
}

draw_set_alpha(1);
draw_set_color(c_white);
