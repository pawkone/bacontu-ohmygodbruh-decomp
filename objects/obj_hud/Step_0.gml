var sprites = global.PlayerCharacters[obj_player.character].sprites.tv;
visible = hudVisible();

with (kettle)
{
    kx = lerp(kx, x, 0.2) + irandom_range(shake, -shake);
    ky = lerp(ky, y, 0.05) + irandom_range(shake, -shake);
    shake = approach(shake, 0, 1);
    rankScale = approach(rankScale, 1, 0.2);
    cloudIndex += 0.15;
}

with (tv)
{
    var isSecret = string_pos("secret", string_letters(room_get_name(room))) > 0;
    var _idleSprite = sprites.idle;
    
    if (isSecret)
        _idleSprite = spr_tv_secret;
    
    if (global.escape.active && !isSecret)
        _idleSprite = spr_tv_escape;
    
    if (global.combo.amt >= 15 && !isSecret)
        _idleSprite = spr_tv_combo;
    
    if (obj_player.state == states.ski)
        _idleSprite = spr_tv_ski;
    
    if (!other.visible)
    {
        state = states.normal;
        sprite_index = spr_tv_off;
    }
    
    image_index += image_speed;
    
    switch (state)
    {
        case states.normal:
            switch (sprite_index)
            {
                case spr_tv_off:
                    image_index = 0;
                    sprite_index = spr_tv_turnon;
                    break;
                
                case spr_tv_turnon:
                    if (image_index >= sprite_get_number(sprite_index))
                    {
                        image_index = 0;
                        sprite_index = _idleSprite;
                    }
                    
                    break;
                
                case spr_tv_happy:
                    expressionTimer--;
                    
                    if (expressionTimer <= 0)
                        tv_anim(_idleSprite);
                    
                    break;
                
                case sprites.crazyrun:
                case sprites.mach3:
                    if (obj_player.state != states.mach3 && obj_player.state != states.climbwall && obj_player.state != states.buzzsaw)
                        tv_anim(_idleSprite);
                    
                    if (obj_player.mach4mode && expressionSprite == sprites.mach3)
                        tv_anim(sprites.crazyrun);
                    
                    if (!obj_player.mach4mode && expressionSprite == sprites.crazyrun)
                        tv_anim(sprites.mach3);
                    
                    break;
                
                case spr_tv_secret:
                case spr_tv_escape:
                case sprites.idle:
                case spr_tv_combo:
                case spr_tv_ski:
                    roomname = room_get_name(room);
                    roomname = string_letters(roomname);
                    isSecret = string_pos("secret", roomname) > 0;
                    
                    if (expressionSprite != _idleSprite)
                        tv_anim(_idleSprite);
                    
                    if (obj_player.state == states.mach3)
                        tv_anim(sprites.mach3);
                    
                    break;
            }
            
            break;
        
        case states.move:
            switchindex = approach(switchindex, sprite_get_number(spr_tv_switch) - 1, 0.35);
            
            if (switchindex >= (sprite_get_number(spr_tv_switch) - 1))
            {
                sprite_index = expressionSprite;
                switchindex = 0;
                state = states.normal;
                image_speed = 0.35;
            }
            
            break;
    }
}

var roomname = string_letters(room_get_name(room));
var _secret = string_pos("secret", roomname) > 0;
var _escape = global.escape.active == true;

if (!_secret)
    global.escape.timer = approach(global.escape.timer, 0, 1);

if (global.escape.timer == 0 && !instance_exists(obj_hipnatuese) && !_secret && global.level != "tutorial" && _escape)
    instance_create(obj_player.x, obj_player.y, obj_hipnatuese);

if (!ds_list_empty(collectVis))
{
    for (var i = 0; i < ds_list_size(collectVis); i++)
    {
        var q = ds_list_find_value(collectVis, i);
        
        with (q)
        {
            var targetxx = other.kettle.x;
            var targetyy = other.kettle.y;
            var point = point_direction(x, y, targetxx, targetyy);
            hsp = lengthdir_x(24, point);
            vsp = lengthdir_y(24, point);
            x += hsp;
            y += vsp;
            
            if (point_distance(x, y, targetxx, targetyy) <= 25)
            {
                with (other)
                {
                    kettle.shake = 5;
                    q = undefined;
                    ds_list_delete(collectVis, i);
                    i--;
                }
            }
        }
    }
}

global.Arank = global.Srank / 1.2;
global.Brank = global.Arank / 2;
global.Crank = global.Brank / 3;
