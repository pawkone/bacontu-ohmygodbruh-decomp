function scr_collide_destructibles()
{
    with (obj_destructibles)
    {
        with (obj_player)
        {
            if (state == states.jump && vsp < 0)
            {
                if (place_meeting(x, y + vsp, other))
                {
                    var _destroy = true;
                    
                    if (_destroy)
                    {
                        instance_destroy(other);
                        vsp = 0;
                    }
                }
            }
            
            if (state == states.mach2 || state == states.mach3 || state == states.grab || state == states.tumble || state == states.hammerattack || (sprite_index == spr_player_swingading && state == states.hauling) || state == states.snowball)
            {
                if (place_meeting(x + (hsp * 2) + xscale, y - 1, other))
                {
                    var _destroy = true;
                    
                    if (_destroy)
                        instance_destroy(other);
                }
            }
            
            if (state == states.tumble || state == states.groundpound || state == states.uppercut || state == states.superjump || state == states.buzzsaw || state == states.climbwall || state == states.skateboard || state == states.skateboardmove || state == states.skateboardwall || state == states.skateboardramp || state == states.slip)
            {
                if (place_meeting(x + (hsp * 2), y + (vsp * 2), other))
                {
                    var _destroy = true;
                    
                    if (_destroy)
                        instance_destroy(other);
                }
            }
        }
    }
}
