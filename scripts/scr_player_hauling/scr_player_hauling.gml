function scr_player_hauling()
{
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    
    if (animation_end() && sprite_index == spr_player_haulingland)
    {
        sprite_index = spr_player_haulingidle;
        image_index = 0;
    }
    
    if (animation_end() && sprite_index == spr_player_haulingjump)
    {
        sprite_index = spr_player_haulingfall;
        image_index = 0;
    }
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (grounded && (sprite_index == spr_player_haulingfall || sprite_index == spr_player_haulingjump) && sprite_index != spr_player_swingading)
    {
        sprite_index = spr_player_haulingidle;
        image_index = 0;
        create_particleStatic(spr_landeffect, x, y, 1, 1);
    }
    
    if (sprite_index == spr_player_swingading)
    {
        movespeed = approach(movespeed, 0, 0.15);
        
        if (movespeed == 0)
        {
            image_index = 0;
            sprite_index = spr_player_haulingidle;
            exit;
        }
        
        if (place_meeting(x + xscale, y, obj_solid) && !place_meeting(x + xscale, y, obj_destructibles))
        {
            state = states.finishingblow;
            sprite_index = spr_player_swingadingend;
            image_index = 0;
            exit;
        }
    }
    
    if (sprite_index != spr_player_swingading)
    {
        if (move != 0)
        {
            if (sprite_index == spr_player_haulingidle)
            {
                image_index = 0;
                sprite_index = spr_player_haulingwalk;
            }
            
            xscale = move;
            movespeed = approach(movespeed, 6, 0.5);
            buffers.step--;
            
            if (sprite_index == spr_player_haulingwalk)
            {
                image_speed = movespeed / 15;
                
                if ((floor(image_index) == 3 || floor(image_index) == 8) && buffers.step <= 0)
                {
                    buffers.step = 12;
                    FMODevent_oneshot("event:/Sfx/Player/step", x, y);
                    create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
                }
            }
        }
        else
        {
            movespeed = 0;
            image_speed = 0.35;
            
            if (sprite_index == spr_player_haulingwalk)
            {
                image_index = 0;
                sprite_index = spr_player_haulingidle;
            }
        }
    }
    
    if (sprite_index == spr_player_swingading)
        image_speed = movespeed / 13;
    
    if (!grounded && sprite_index != spr_player_haulingjump && sprite_index != spr_player_haulingfall && sprite_index != spr_player_swingading)
    {
        image_index = 0;
        sprite_index = spr_player_haulingfall;
    }
    
    if (jumpBuffer && grounded && sprite_index != spr_player_swingading)
    {
        jumpBuffer = false;
        create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        image_speed = 0.35;
        image_index = 0;
        sprite_index = spr_player_haulingjump;
        vsp = -12;
        jumpstop = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
    }
    
    if (slapBuffer)
    {
        slapBuffer = false;
        state = states.finishingblow;
        
        if (key_up)
            sprite_index = spr_player_finisheruppercut;
        else if (sprite_index == spr_player_swingading)
            sprite_index = spr_player_swingadingend;
        else
            sprite_index = choose(spr_player_finisher1, spr_player_finisher2);
        
        image_index = 0;
        exit;
    }
    
    if (key_down && grounded)
    {
        image_speed = 0.35;
        image_index = 0;
        sprite_index = spr_player_crouch;
        state = states.crouch;
    }
    
    if (key_down2 && !grounded)
    {
        vsp = -6;
        sprite_index = spr_player_piledriver;
        image_index = 0;
        state = states.groundpoundstart;
    }
    
    if (!instance_exists(enemyID))
    {
        state = states.normal;
        sprite_index = spr_player_idle;
    }
}

function scr_player_finishingblow()
{
    image_speed = 0.4;
    hsp = movespeed * xscale;
    
    if (floor(image_index) < 4 && sprite_index != spr_player_swingadingend)
        movespeed = approach(movespeed, 0, 1);
    
    if (instance_exists(enemyID) && (floor(image_index) > 4 || sprite_index == spr_player_swingadingend) && enemyID.state == states.grab)
    {
        movespeed = -5;
        vsp = -5;
        FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
        
        repeat (8)
        {
            create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
            create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
        }
        
        create_particleStatic(spr_kungfueffect, x, y, 1, 2);
        
        if (sprite_index == spr_player_finisheruppercut)
        {
            with (enemyID)
            {
                hitHsp = 0;
                hitVsp = -25;
                state = states.thrown;
            }
        }
        else
        {
            with (enemyID)
            {
                hitHsp = 25 * other.xscale;
                hitVsp = 0;
                state = states.thrown;
            }
        }
        
        enemyID = -4;
    }
    
    if (animation_end())
    {
        slapBuffer = false;
        state = states.jump;
        sprite_index = spr_player_fall;
        jumpstop = true;
    }
    
    buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
    
    if (buffers.afterimageMach == 0)
    {
        buffers.afterimageMach = 4;
        create_machEffect(sprite_index, image_index, x, y, xscale, 1);
    }
}
