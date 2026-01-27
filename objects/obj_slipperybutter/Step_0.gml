scr_collision();

if (grounded)
{
    slippery = true;
    hsp = 0;
}

if (place_meeting(x, y, obj_player))
{
    var _cantSlip = [states.skateboard, states.skateboardhitwall, states.skateboardIntro, states.skateboardmove, states.skateboardramp, states.skateboardwall, states.skateboardAim];
    
    with (obj_player)
    {
        instance_destroy(other);
        
        if (!array_contains(_cantSlip, state))
        {
            state = states.slip;
            movespeed = 12;
            vsp = -15;
            sprite_index = spr_player_slipsyrup;
            image_index = 0;
            FMODevent_oneshot("event:/Sfx/Player/slip", x, y);
        }
    }
}
