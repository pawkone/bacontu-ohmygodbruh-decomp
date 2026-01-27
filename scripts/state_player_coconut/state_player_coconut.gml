function scr_player_coconut_intro()
{
    get_input();
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
    
    if (animation_end())
    {
        sprite_index = spr_player_coconut_idle;
        image_index = 0;
        state = states.coconut_gun;
        movespeed = 0;
        hsp = 0;
    }
}

function scr_player_coconut_gun()
{
    get_input();
    hsp = approach(hsp, movespeed * xscale, 0.35);
    var move = key_right + key_left;
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (move != 0)
    {
        image_speed = movespeed / 15;
        xscale = move;
        movespeed = 11;
        
        if (grounded)
            sprite_index = spr_player_coconut_walk;
    }
    else
    {
        image_speed = 0.35;
        movespeed = 0;
        
        if (grounded)
            sprite_index = spr_player_coconut_idle;
    }
    
    if (place_meeting(x + xscale, y, obj_solid))
    {
        movespeed = -8;
        hsp = movespeed * xscale;
        vsp = -4;
        jumpstop = true;
    }
    
    if (animation_end() && sprite_index == spr_player_coconut_jump)
        sprite_index = spr_player_coconut_fall;
    
    if (jumpBuffer && coyote_time && grounded)
    {
        jumpBuffer = false;
        create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        image_index = 0;
        sprite_index = spr_player_coconut_jump;
        vsp = -12;
        jumpstop = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
    }
    
    if (key_slap2)
    {
        sprite_index = spr_player_coconut_shoot;
        image_index = 0;
        state = states.coconut_shoot;
        
        with (instance_create(x + (16 * xscale), y - 16, obj_coconut_bomb))
        {
            xscale = other.xscale;
            vsp = -6;
            
            if (other.key_up)
            {
                vsp = -16;
                movespeed = 0;
            }
        }
    }
}

function scr_player_coconut_shoot()
{
    get_input();
    image_speed = 0.5;
    hsp = movespeed * xscale;
    movespeed = approach(movespeed, -2, 2);
    
    if (animation_end())
    {
        sprite_index = spr_player_coconut_idle;
        image_index = 0;
        state = states.coconut_gun;
        movespeed = 0;
    }
}
