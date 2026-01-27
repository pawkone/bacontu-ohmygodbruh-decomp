function scr_player_slip()
{
    get_input();
    hsp = movespeed * xscale;
    image_speed = 0.35;
    
    if (animation_end() && (sprite_index == spr_player_slipsyrup || sprite_index == spr_player_beakerintro))
        image_index = image_number - 1;
    
    if (place_meeting(x + hsp, y, obj_solid))
    {
        create_particleStatic(spr_bangeffect, x, y, 1);
        sprite_index = spr_player_spinout;
        xscale *= -1;
        FMODevent_oneshot("event:/Sfx/Player/slipbump", x, y);
    }
    
    if (!grounded && sprite_index == spr_player_beakerintro)
        sprite_index = spr_player_spinout;
    
    if (grounded)
    {
        if (sprite_index == spr_player_slipsyrup)
        {
            vsp = -5;
            create_particleStatic(spr_bangeffect, x, y, 1);
            sprite_index = spr_player_spinout;
            image_index = 0;
            FMODevent_oneshot("event:/Sfx/Player/slipbump", x, y);
        }
        
        if (sprite_index != spr_player_beakerintro && sprite_index == spr_player_spinout)
        {
            FMODevent_oneshot("event:/Sfx/Player/slipend", x, y);
            sprite_index = spr_player_beakerintro;
            image_index = 0;
        }
        
        movespeed = approach(movespeed, 0, 0.5);
        
        if (movespeed == 0 && animation_end && sprite_index == spr_player_beakerintro)
        {
            state = states.normal;
            movespeed = 0;
            sprite_index = spr_player_land;
        }
    }
}
