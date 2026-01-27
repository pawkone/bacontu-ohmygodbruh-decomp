function scr_player_snowball()
{
    get_input();
    move = key_left + key_right;
    hsp = movespeed * xscale;
    var maxspeed = 12;
    
    if (move != 0)
    {
        if (move == xscale)
        {
            if (movespeed < maxspeed)
                movespeed = approach(movespeed, maxspeed, 0.5);
            
            if (scr_slope(x, y + 4) && hsp != 0 && movespeed > 8 && movespeed < 18)
                slope_momentum(0.2, 0);
        }
        else if (move == -xscale)
        {
            if (movespeed <= 0)
            {
                xscale = move;
                movespeed = 0;
            }
            
            movespeed = approach(movespeed, 0, 0.5);
        }
    }
    else
    {
        movespeed = approach(movespeed, 0, 0.5);
    }
    
    if (movespeed < 1)
        sprite_index = spr_player_snowball_idle;
    else
        sprite_index = spr_player_snowball_move;
    
    if (grounded && vsp > 0 && jumpBuffer > 0)
    {
        jumpstop = false;
        state = states.snowball_jump;
        jumpBuffer = 0;
        vsp = -11;
        image_index = 0;
        exit;
    }
    
    if (place_meeting(x + (1 * sign(move)), y, obj_solid))
    {
        vsp = -5;
        state = states.snowball_wall;
        exit;
    }
    
    if (!grounded)
    {
        state = states.snowball_jump;
        exit;
    }
    
    image_speed = 0.35;
}

function scr_player_snowball_jump()
{
    get_input();
    move = key_left + key_right;
    hsp = movespeed * xscale;
    var maxspeed = 12;
    
    if (move != 0)
    {
        if (move == xscale)
        {
            if (movespeed < maxspeed)
                movespeed = approach(movespeed, maxspeed, 0.5);
        }
        else if (move == -xscale)
        {
            if (movespeed <= 0)
            {
                xscale = move;
                movespeed = 0;
            }
            
            movespeed = approach(movespeed, 0, 0.5);
        }
    }
    else
    {
        movespeed = approach(movespeed, 0, 0.5);
    }
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (key_down2 && vsp < 10)
        vsp = 10;
    
    if (vsp <= 0)
        sprite_index = spr_player_snowball_jump;
    else
        sprite_index = spr_player_snowball_fall;
    
    if (grounded && vsp > 0)
    {
        state = states.snowball;
        exit;
    }
    
    if (place_meeting(x + xscale, y, obj_solid))
    {
        if (vsp > 0)
            vsp = 0;
        
        state = states.snowball_wall;
        exit;
    }
}

function scr_player_snowball_wall()
{
    get_input();
    move = key_left + key_right;
    hsp = 0;
    grav = 0;
    vsp = approach(vsp, move * xscale * -12, 0.5);
    
    if (!place_meeting(x + xscale, y, obj_solid))
    {
        grav = 0.5;
        jumpstop = true;
        state = states.snowball_jump;
        exit;
    }
    
    if (jumpBuffer > 0)
    {
        grav = 0.5;
        xscale *= -1;
        movespeed = 5;
        jumpBuffer = 0;
        jumpstop = true;
        vsp = -11;
        state = states.snowball_jump;
        exit;
    }
    
    if (vsp > 1)
        sprite_index = spr_player_snowball_walldown;
    else if (vsp < 0)
        sprite_index = spr_player_snowball_wallup;
    else
        sprite_index = spr_player_snowball_wall;
}
