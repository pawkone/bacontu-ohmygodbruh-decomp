switch (state)
{
    case states.normal:
        if (camera.target.state == states.mach2 || camera.target.state == states.mach3 || camera.target.state == states.tumble)
        {
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            var chargeSpd = 0.3;
            
            if ((far > 0 && xOffset < 0) || (far < 0 && xOffset > 0))
                chargeSpd = 8;
            
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else if (camera.target.state == states.surfing)
        {
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            var chargeSpd = 4;
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else if (abs(camera.target.hsp) >= 16)
        {
            var chargeSpd = 2.5;
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else
        {
            xOffset = approach(xOffset, 0, 8);
        }
        
        camera.x = camera.target.x + xOffset;
        camera.y = camera.target.y - 50;
        camera.zoom = lerp(camera.zoom, 1, 0.05);
        break;
    
    case -4:
        if (obj_player.state != -4)
            state = states.normal;
        
        break;
}

cameraShakeTimer = approach(cameraShakeTimer, 0, 1);

if (cameraShakeTimer == 0)
    cameraShake = 0;

var _realX = camera.x - (camera.width / 2);
var _realY = camera.y - (camera.height / 2);
_realX = clamp(_realX, 0, room_width - camera.width);
_realY = clamp(_realY, 0, room_height - camera.height);
camera.width = obj_screensizer.displayWidth * (1 + (1 - camera.zoom));
camera.height = obj_screensizer.displayHeight * (1 + (1 - camera.zoom));
var roomname = string_letters(room_get_name(room));
var _escapeShake1 = irandom_range(-global.escape.active, global.escape.active);
var _escapeShake2 = irandom_range(-global.escape.active, global.escape.active);
var _secret = string_pos("secret", roomname) > 0;

if (_secret)
{
    _escapeShake1 = 0;
    _escapeShake2 = 0;
}

camera_set_view_pos(view_camera[0], _realX + irandom_range(cameraShake, -cameraShake) + _escapeShake1, _realY + irandom_range(cameraShake, -cameraShake) + _escapeShake2);
camera_set_view_angle(view_camera[0], camera.angle);
camera_set_view_size(view_camera[0], camera.width, camera.height);
