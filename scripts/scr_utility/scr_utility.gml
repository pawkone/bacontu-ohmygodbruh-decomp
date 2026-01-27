function scr_savelevel()
{
    ini_open(global.saveFile);
    var _rankString = "D";
    
    if (global.collect >= global.Crank)
        _rankString = "C";
    
    if (global.collect >= global.Brank)
        _rankString = "B";
    
    if (global.collect >= global.Arank)
        _rankString = "A";
    
    if (global.collect >= global.Srank)
        _rankString = "S";
    
    if (scr_Prank())
        _rankString = "P";
    
    if (ini_read_real(global.level, "Highscore", 0) < global.collect)
    {
        ini_write_real(global.level, "Highscore", global.collect);
        ini_write_string(global.level, "Rank", _rankString);
        ini_write_real(global.level, "Toppin1", global.toppins.bean);
        ini_write_real(global.level, "Toppin2", global.toppins.cup);
        ini_write_real(global.level, "Toppin3", global.toppins.lime);
        ini_write_real(global.level, "Toppin4", global.toppins.bag);
        ini_write_real(global.level, "Toppin5", global.toppins.orange);
        ini_write_real(global.level, "Treasure", global.treasure);
        ini_write_real(global.level, "Secrets", global.secretCount);
    }
    
    obj_savesystem.saveiconTimer = 30;
    ini_close();
}

function animation_end()
{
    return (image_index + (image_speed * sprite_get_speed(sprite_index))) >= image_number;
}

function shake_camera(arg0, arg1)
{
    if (is_undefined(arg1))
        arg1 = arg0;
    
    obj_camera.cameraShakeTimer = arg1;
    obj_camera.cameraShake = arg0;
}

function tv_anim(arg0, arg1 = 0)
{
    with (obj_hud.tv)
    {
        if (expressionSprite != arg0)
        {
            switchindex = 0;
            state = states.move;
            expressionSprite = arg0;
            expressionTimer = arg1;
        }
    }
}

function instance_create(arg0, arg1, arg2, arg3 = {})
{
    return instance_create_depth(arg0, arg1, 0, arg2, arg3);
}

function distance_to_pos(arg0, arg1, arg2, arg3, arg4, arg5)
{
    return point_distance(arg0, 0, arg2, 0) <= arg4 && point_distance(0, arg1, 0, arg3 <= arg5);
}

function scr_cutoff()
{
    for (var _x = 0; _x < abs(sprite_width / 32); _x++)
    {
        instance_create(x + (_x * 32) + 32, y, obj_cutoff, 
        {
            image_angle: 180
        });
        instance_create(x + (_x * 32), y + sprite_height, obj_cutoff);
    }
    
    for (var _y = 0; _y < abs(sprite_height / 32); _y++)
    {
        instance_create(x + sprite_width, y + (_y * 32) + 32, obj_cutoff, 
        {
            image_angle: 90
        });
        instance_create(x, y + (_y * 32), obj_cutoff, 
        {
            image_angle: -90
        });
    }
}

function save_to_ini(arg0, arg1, arg2, arg3 = working_directory + "options.ini")
{
    ini_open(arg3);
    
    if (is_string(arg2))
    {
        if (ini_read_string(arg0, arg1, arg2) == arg2)
            return false;
        
        ini_write_string(arg0, arg1, arg2);
    }
    else
    {
        if (ini_read_real(arg0, arg1, arg2) == arg2)
            return false;
        
        ini_write_real(arg0, arg1, arg2);
    }
    
    ini_close();
    return true;
}

function create_smalltext(arg0, arg1 = x, arg2 = y)
{
    instance_create(arg1, arg2, obj_smalltext).text = arg0;
}

function in_camera(arg0 = bbox_left, arg1 = bbox_right, arg2 = bbox_bottom, arg3 = bbox_top)
{
    var camx = camera_get_view_x(view_camera[0]);
    var camy = camera_get_view_y(view_camera[0]);
    var camw = camera_get_view_width(view_camera[0]);
    var camh = camera_get_view_height(view_camera[0]);
    return arg0 < (camx + camw) && arg1 > camx && arg3 < (camy + camh) && arg2 > camy;
}

function tile_delete(arg0, arg1)
{
    var layers = layer_get_all();
    
    for (var i = 0; i < array_length(layers); i++)
    {
        var lay = layers[i];
        var layer_name = layer_get_name(lay);
        
        if (layer_name != "Tiles_BG1" && layer_name != "Tiles_BG" && layer_name != "Tiles_BG2" && layer_name != "Tiles_BG3")
        {
            var ID = layer_get_id(layer_name);
            var tilemapID = layer_tilemap_get_id(ID);
            var tiledata = tilemap_get_at_pixel(tilemapID, arg0, arg1);
            tile_set_empty(tiledata);
            tilemap_set_at_pixel(tilemapID, 0, arg0, arg1);
        }
    }
}

function escape_background(arg0, arg1)
{
    var layers = layer_get_all();
    
    for (var i = 0; i < array_length(layers); i++)
    {
        var lay = layers[i];
        var layer_name = layer_get_name(lay);
        var ID = layer_get_id(layer_name);
        var BGID = layer_background_get_id(ID);
        var BGSPR = layer_background_get_sprite(BGID);
        
        if (BGSPR == arg0 && global.escape.active)
            layer_background_sprite(BGID, arg1);
        else if (BGSPR == arg1 && !global.escape.active)
            layer_background_sprite(BGID, arg0);
    }
}

function scr_transfotip(arg0)
{
    if (instance_exists(obj_transfotip))
        instance_destroy(obj_transfotip);
    
    var q = instance_create(x, y, obj_transfotip);
    
    with (q)
        text = arg0;
    
    return q;
}

function timeString(arg0)
{
    var _ms = string_digits(frac(arg0));
    _ms = string_char_at(_ms, 2);
    var _realSecond = floor(arg0);
    var _s = _realSecond;
    _s = wrap(_s, 0, 59);
    
    if (_s < 10)
        _s = string_concat("0", _s);
    
    var _m = floor(_realSecond / 60);
    _m = wrap(_m, 0, 59);
    
    if (_m < 10)
        _m = string_concat("0", _m);
    
    var _h = floor(_realSecond / 3600);
    
    if (_h < 10)
        _h = string_concat("0", _h);
    
    return string("{0}:{1}:{2}.{3}", _h, _m, _s, _ms);
}
