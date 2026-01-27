function scr_player_mach3()
{
    get_input();
    hsp = movespeed * xscale;
    
    if (sprite_index == spr_player_superjumpcancel)
        image_speed = lerp(image_speed, 0.5, 0.15);
    else
        image_speed = (sprite_index == sprites.crazyrun) ? 0.6 : 0.35;
    
    if (!instance_exists(chargeeffect))
        chargeeffect = instance_create(x, y, obj_chargeeffect);
    
    if (!instance_exists(speedlineseffect) && movespeed > 13)
        speedlineseffect = instance_create(x, y, obj_speedlines);
    
    buffers.bigdashcloud--;
    
    if (buffers.bigdashcloud <= 0 && grounded)
    {
        buffers.bigdashcloud = 24;
        create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
    }
    
    buffers.crazyothereffect--;
    
    if (buffers.crazyothereffect <= 0 && sprite_index == sprites.crazyrun)
    {
        buffers.crazyothereffect = 9;
        create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1).image_speed = 0.5;
    }
    
    var move = key_right + key_left;
    var _accel = (character == chars.milton) ? 0.01 : 0.025;
    
    if (mach4mode)
        _accel = (character == chars.milton) ? 0.05 : 0.1;
    
    if (move == xscale && grounded)
        movespeed = approach(movespeed, 20, _accel);
    
    if (animation_end() && sprite_index == spr_player_buzzsawCancel)
        image_index = image_number - 2;
    
    if (animation_end() && (sprite_index == sprites.mach3jump || sprite_index == sprites.mach3hit || sprite_index == spr_player_rollgetup))
    {
        image_index = 0;
        sprite_index = sprites.mach3;
    }
    
    if (movespeed >= 16 && sprite_index != sprites.crazyrun && sprite_index != spr_player_buzzsawCancel)
    {
        sprite_index = sprites.crazyrun;
        flash = true;
    }
    
    mach4mode = (character == chars.milton) ? (movespeed >= 24) : (movespeed >= 16);
    
    if (movespeed < 18)
        slope_momentum(0.1);
    
    if (sprite_index == sprites.crazyrun)
    {
        buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
        
        if (buffers.afterimageBlur == 0)
        {
            buffers.afterimageBlur = 3;
            create_blur_effect(sprite_index, image_index, x, y, xscale);
        }
        
        buffers.step--;
        
        if (buffers.step <= 0)
        {
            buffers.step = 5;
            create_particleStatic(spr_flamecloud, x, y, 1, 1);
        }
    }
    
    if (grounded && (sprite_index == spr_player_superjumpcancel || sprite_index == spr_player_buzzsawCancel))
    {
        flash = true;
        image_index = 0;
        sprite_index = sprites.mach3;
    }
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (jumpBuffer && coyote_time && sprite_index != spr_player_mach3turn)
    {
        grounded = false;
        jumpBuffer = false;
        create_particleStatic(spr_grabcloud, x, y, xscale, 1);
        image_index = 0;
        sprite_index = sprites.mach3jump;
        vsp = -12;
        jumpstop = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
    }
    
    buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
    
    if (buffers.afterimageMach <= 0)
    {
        buffers.afterimageMach = 6;
        create_machEffect(sprite_index, image_index, x, y, xscale);
    }
    
    if (move != xscale && move != 0 && grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/machturn", x, y);
        movespeed = 12;
        sprite_index = spr_player_mach3turn;
        image_index = 0;
        state = states.machturn;
        show_debug_message("mach turned from mach 3");
        exit;
    }
    
    if ((((key_up && global.dirGround) || (key_superjump && !global.dirGround)) && grounded) && !place_meeting(x, y - 32, obj_solid))
    {
        movespeed = 12;
        image_index = 0;
        sprite_index = spr_player_superjumpprepstart;
        state = states.superjumpprep;
        exit;
    }
    
    if (!key_attack && grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/machend", x, y);
        state = states.machslide;
        sprite_index = spr_player_machslidestart;
        image_index = 0;
        exit;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x, y + 1, obj_slope) && grounded && !place_meeting(x + sign(hsp), y, obj_metalblock) && !place_meeting(x + sign(hsp), y, obj_secretmetalblock))
    {
        FMODevent_oneshot("event:/Sfx/Player/slam", x, y);
        state = states.hitwall;
        shake_camera(15);
        sprite_index = spr_player_mach3hitwall;
        image_index = 0;
        vsp = -6;
        movespeed = -6;
    }
    
    if (((place_meeting(x + sign(hsp), y, obj_solid) && !grounded) || (scr_slope(x, y + 4) && place_meeting(x + sign(hsp), y - 4, obj_solid))) && !place_meeting(x + hsp, y, obj_metalblock) && !place_meeting(x + hsp, y, obj_secretmetalblock))
    {
        var _climb = true;
        
        if (isMildred)
            _climb = doBump(40, abs(hsp) + 1);
        
        if (_climb)
        {
            verticalMovespeed = movespeed;
            state = states.climbwall;
            sprite_index = spr_player_wallclimb;
            exit;
        }
    }
    
    if (key_down)
    {
        image_index = 0;
        sprite_index = spr_player_rollstart;
        state = states.tumble;
        create_particleStatic(spr_grabcloud, x, y, xscale, 1);
        exit;
    }
    
    doTaunt();
    doGrab();
}
