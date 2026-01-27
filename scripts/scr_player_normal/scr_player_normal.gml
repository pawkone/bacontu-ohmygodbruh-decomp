function scr_player_normal()
{
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    
    if (sprite_index == sprites.move)
    {
        if ((floor(image_index) == 3 || floor(image_index) == 8) && buffers.step <= 0)
        {
            buffers.step = 12;
            FMODevent_oneshot("event:/Sfx/Player/step", x, y);
            create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
        }
        
        buffers.step--;
    }
    
    if (move != 0)
    {
        if (sprite_index != sprites.move && sprite_index != spr_player_land2 && sprite_index != spr_player_machslideend && sprite_index != spr_player_littledanceydance)
        {
            image_index = 0;
            sprite_index = sprites.move;
        }
        
        if (sprite_index != spr_player_littledanceydance)
            image_speed = movespeed / 15;
        
        xscale = move;
        
        if (!place_meeting(x + xscale, y, obj_solid))
        {
            movespeed = approach(movespeed, 6, 0.5);
        }
        else
        {
            movespeed = approach(movespeed, 0, 0.65);
            
            if (sprite_index != spr_player_littledanceydance)
                image_speed = 0.1;
        }
        
        if (animation_end() && sprite_index == spr_player_land2)
        {
            image_index = 0;
            sprite_index = sprites.move;
        }
        
        if (animation_end() && sprite_index == spr_player_machslideend)
        {
            image_index = 0;
            sprite_index = sprites.move;
        }
    }
    else
    {
        if (sprite_index != sprites.idle && sprite_index != spr_player_idleanim1 && sprite_index != spr_player_idleanim2 && sprite_index != spr_player_idleanim3 && sprite_index != spr_player_idleanim4 && sprite_index != spr_player_idleanim5 && sprite_index != spr_player_land && sprite_index != spr_player_machslideend && sprite_index != spr_player_littledanceydance && sprite_index != spr_player_statue && sprite_index != spr_player_statuestart)
        {
            image_speed = movespeed / 15;
            
            if (movespeed == 0)
            {
                image_index = 0;
                sprite_index = sprites.idle;
                image_speed = 0.35;
                buffers.idle = 150;
            }
        }
        
        movespeed = approach(movespeed, 0, 0.65);
        
        if (sprite_index == sprites.idle)
            buffers.idle--;
        
        if (buffers.idle <= 0 && sprite_index != spr_player_littledanceydance && sprite_index != spr_player_statue && sprite_index != spr_player_statuestart)
        {
            buffers.idle = 150;
            image_index = 0;
            sprite_index = choose(spr_player_idleanim1, spr_player_idleanim2, spr_player_idleanim3, spr_player_idleanim4, spr_player_idleanim5);
            image_speed = 0.35;
            
            if (irandom(100) <= 25)
                fmod_studio_event_instance_start(soundsOk);
        }
        
        if (animation_end() && (sprite_index == spr_player_idleanim1 || sprite_index == spr_player_idleanim2 || sprite_index == spr_player_idleanim3 || sprite_index == spr_player_idleanim4 || sprite_index == spr_player_idleanim5))
        {
            image_index = 0;
            sprite_index = sprites.idle;
        }
        
        if (animation_end() && sprite_index == spr_player_land)
        {
            image_index = 0;
            sprite_index = sprites.idle;
        }
        
        if (animation_end() && sprite_index == spr_player_statuestart)
        {
            image_index = 0;
            sprite_index = spr_player_statue;
        }
        
        if (animation_end() && sprite_index == spr_player_machslideend)
        {
            image_index = 0;
            sprite_index = sprites.idle;
        }
    }
    
    if (key_taunt)
    {
        buffers.breakdanceheld++;
    }
    else
    {
        buffers.breakdanceheld = 0;
        buffers.notes = 10;
        breakdancespeed = 0.25;
        
        if (sprite_index == spr_player_littledanceydance)
            sprite_index = sprites.idle;
        
        image_speed = 0.35;
    }
    
    if (buffers.breakdanceheld > 10)
    {
        breakdancespeed = approach(breakdancespeed, 0.6, 0.005);
        
        if (sprite_index != spr_player_littledanceydance)
            sprite_index = spr_player_littledanceydance;
        
        image_speed = breakdancespeed;
    }
    
    if (breakdancespeed > 0.5)
    {
        if (breakdanceID == -4)
        {
            with (instance_create(x, y, obj_beatbox))
            {
                other.breakdanceID = id;
                target = other.id;
            }
        }
        
        if (!instance_exists(breakdanceID))
            breakdanceID = -4;
        
        if (buffers.notes <= 0)
        {
            buffers.notes = 10;
            
            if (instance_exists(obj_server))
            {
                with (obj_server)
                    instance_create_online(other.x + irandom_range(-70, 70), other.y + irandom_range(-70, 70), other.depth, obj_notes);
            }
            
            instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_notes);
        }
    }
    
    buffers.notes = approach(buffers.notes, 0, 1);
    
    if (!coyote_time)
    {
        freefalling = 0;
        image_index = 0;
        sprite_index = spr_player_fall;
        state = states.jump;
    }
    
    if (jumpBuffer && coyote_time)
    {
        jumpBuffer = false;
        create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        image_index = 0;
        sprite_index = spr_player_jump;
        state = states.jump;
        vsp = -12;
        jumpstop = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
    }
    
    if (key_down && grounded)
    {
        image_speed = 0.35;
        image_index = 0;
        sprite_index = spr_player_crouchstart;
        state = states.crouch;
    }
    
    if (key_attack && !place_meeting(x + xscale, y, obj_solid))
    {
        create_particleStatic(spr_grabcloud, x, y, xscale, 1);
        movespeed = 6;
        sprite_index = spr_player_mach1;
        image_index = 0;
        state = states.mach2;
    }
    
    doTaunt();
    doGrab();
}
