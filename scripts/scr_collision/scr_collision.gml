function scr_collision_init()
{
    vsp = 0;
    hsp = 0;
    grav = 0;
    grounded = false;
    coyote_time = 0;
    can_coyote = true;
}

function scr_collision()
{
    grounded = false;
    var o_x = x;
    var o_y = y;
    var __hspPlat = 0;
    var __vspPlat = 0;
    
    if (vsp < 20)
        vsp += (!place_meeting(x, y, obj_water) ? grav : (grav / 2));
    
    var finalHsp = hsp;
    var finalVsp = vsp;
    
    repeat (round(abs(finalVsp)))
    {
        o_y = y;
        
        if (abs(finalVsp) != 0)
            y += sign(finalVsp);
        else
            y += finalVsp;
        
        if (scr_solid(x, y))
        {
            y = o_y;
            vsp = 0;
            finalVsp = 0;
        }
    }
    
    repeat (round(abs(finalHsp)))
    {
        o_x = x;
        
        if (abs(finalHsp) != 0)
            x += sign(finalHsp);
        else
            x += finalHsp;
        
        var inc = 8;
        
        if (vsp >= -1)
        {
            for (var i = 0; i < inc; i++)
            {
                if (!scr_solid(x, y - i))
                {
                    while (scr_solid(x, y))
                        y--;
                }
                
                if (scr_solid(x, y + i + 1) && scr_solid(x - sign(finalHsp), y + i))
                {
                    while (!scr_solid(x, y + 1))
                        y++;
                }
            }
        }
        
        if (scr_solid(x, y))
        {
            x = o_x;
            hsp = 0;
            finalHsp = 0;
        }
    }
    
    grounded |= scr_solid(x, y + 1);
}

function scr_slope(arg0, arg1)
{
    var _collided = false;
    
    with (instance_place(arg0, arg1, obj_slope))
        _collided = scr_slope_collideCheck(other.id, arg0, arg1);
    
    return _collided;
}

function scr_solid(arg0, arg1)
{
    var _collided = false;
    var _id = id;
    var _collisionArray = [];
    array_push(_collisionArray, obj_solid);
    array_push(_collisionArray, obj_slope);
    array_push(_collisionArray, obj_platform);
    array_push(_collisionArray, obj_destructibles);
    
    for (var i = 0; i < array_length(_collisionArray); i++)
    {
        var _obj = _collisionArray[i];
        var _parentCheck = false;
        
        with (instance_place(arg0, arg1, _obj))
        {
            switch (object_index)
            {
                case obj_solid:
                    _collided = true;
                    break;
                
                case obj_slope:
                    _collided = scr_slope_collideCheck(_id, arg0, arg1);
                    break;
                
                case obj_platform:
                    if ((_id.bbox_bottom - 1) <= (bbox_top + 1) && _id.vsp >= 0)
                        _collided = true;
                    
                    break;
                
                default:
                    _parentCheck = true;
                    break;
            }
            
            if (_parentCheck)
            {
                switch (object_get_parent(object_index))
                {
                    case obj_destructibles:
                    case obj_solid:
                        _collided = true;
                        break;
                    
                    case obj_slope:
                        _collided = scr_slope_collideCheck(_id, arg0, arg1);
                        break;
                    
                    case obj_platform:
                        if ((_id.bbox_bottom - 1) <= (bbox_top + 1) && _id.vsp >= 0)
                            _collided = true;
                        
                        break;
                }
            }
        }
    }
    
    return _collided;
}

function scr_slope_collideCheck(arg0, arg1, arg2)
{
    var _height = arg0.bbox_bottom - arg0.y;
    var _slope = (bbox_bottom - bbox_top) / (bbox_right - bbox_left);
    var _side = arg1 + (arg0.bbox_left - arg0.x);
    var _slopeFinal = bbox_bottom + ((_side - bbox_right) * _slope);
    
    if (image_xscale > 0)
    {
        _side = arg1 + (arg0.bbox_right - arg0.x);
        _slopeFinal = bbox_bottom - ((_side - bbox_left) * _slope);
    }
    
    if (image_yscale < 0)
    {
        _height = arg0.y - arg0.bbox_top;
        return (arg2 + _height) < (bbox_top + (bbox_bottom - _slopeFinal));
    }
    
    return (arg2 + _height) > _slopeFinal;
}

function scr_slope_get(arg0 = 0, arg1 = 1)
{
    return instance_place(x + arg0, y + arg1, obj_slope);
}

function place_meeting_solid(arg0 = 0, arg1 = 1)
{
    return place_meeting(x + arg0, y + arg1, obj_solid);
}
