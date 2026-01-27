with (obj_player)
{
    if (sprite_index == sprites.gateslam)
    {
        hsp = 0;
        vsp = 0;
        
        if (animation_end())
            image_index = image_number - 1;
        
        if (place_meeting(x, y, obj_timesup))
        {
            hsp = 4;
            vsp = -10;
            sprite_index = spr_player_hurt;
        }
    }
    
    if (sprite_index == spr_player_hurt)
    {
    }
}

if (falling)
{
    y = approach(y, obj_screensizer.displayHeight / 2, vsp);
    vsp += 1;
}
