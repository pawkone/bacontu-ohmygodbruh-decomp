function hurt_player(arg0 = -4)
{
    with (obj_player)
    {
        var _cantHurtStates = [states.skateboard, states.skateboardAim, states.skateboardhitwall, states.skateboardIntro, states.skateboardmove, states.skateboardramp, states.skateboardwall, states.coconut_gun, states.coconut_intro, states.UNKNOWN_53, states.coconut_shoot];
        
        if (array_contains(_cantHurtStates, state) || i_frame > 0)
            exit;
        
        FMODevent_oneshot("event:/Sfx/Player/hurt", x, y);
        global.collect -= 100;
        
        if (global.collect < 0)
            global.collect = 0;
        
        global.combo.timer -= 25;
        global.combo.timer = clamp(global.combo.timer, 0, 60);
        i_frame = 100;
        var sameFace = true;
        
        if (arg0 != -4)
        {
            var facing = sign(x - arg0.x);
            sameFace = xscale == facing;
            
            if (facing != 0)
                xscale = facing;
        }
        
        hsp = 8 * xscale;
        sprite_index = !sameFace ? spr_player_hurt : spr_player_hurt2;
        flash = true;
        state = states.hurt;
        vsp = -12;
        
        repeat (8)
        {
            create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
            create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
        }
        
        create_particleStatic(spr_hurteffect, x, y, 1);
    }
}

function doBump(arg0, arg1 = 4)
{
    var old_x = x;
    var old_y = y;
    x += (xscale * arg1);
    var ty = try_solid(0, -1, obj_solid, arg0);
    x = old_x;
    
    if (ty != -1)
    {
        y -= ty;
        x += xscale;
        
        if (scr_solid(x, y))
        {
            x = old_x;
            y = old_y;
            return true;
        }
        
        return false;
    }
    
    return true;
}

function try_solid(arg0, arg1, arg2, arg3)
{
    var old_x = x;
    var old_y = y;
    var n = -1;
    
    for (var i = 0; i < arg3; i++)
    {
        x += arg0;
        y += arg1;
        
        if (!scr_solid(x, y))
        {
            n = i + 1;
            break;
        }
    }
    
    x = old_x;
    y = old_y;
    return n;
}

function scr_Prank()
{
    return global.treasure && global.collect >= global.Srank && !global.combo.dropped && global.secretCount == 3 && global.escape.party;
}

function generalReset()
{
    instance_destroy(obj_comboTitle);
    instance_destroy(obj_hipnatuese);
    ds_list_clear(global.saveroom);
    ds_list_clear(global.escaperoom);
    ds_list_clear(global.followers);
    fmod_studio_system_set_parameter_by_name("musicfade", 0, false);
    global.level_timer = 0;
    global.collect = 0;
    global.secretCount = 0;
    global.magician = false;
    global.treasure = false;
    global.hasFlag = false;
    global.key = false;
    obj_player.door = "A";
    obj_player.visible = true;
    obj_player.hallway = false;
    obj_player.super = false;
    obj_player.xscaleMulti = 1;
    obj_player.yscaleMulti = 1;
    obj_player.hitstun.is = false;
    obj_player.supertaunt = 0;
    obj_player.canSupertaunt = false;
    
    with (obj_hud)
    {
        tv.sprite_index = spr_tv_off;
        combometer.y = -128;
        combometer.state = -1;
    }
    
    global.escape = 
    {
        active: false,
        timer: 7200,
        party: false
    };
    global.pumpkins = 
    {
        count: 0,
        amount: 12,
        activeStein: false
    };
    global.combo = 
    {
        dropped: false,
        amt: 0,
        timer: 60,
        previouscombo: 0,
        savecombo: 0,
        highest: 0
    };
    global.toppins = 
    {
        bean: false,
        cup: false,
        lime: false,
        bag: false,
        orange: false
    };
}

function playerSounds()
{
    if (state == states.tumble)
    {
        fmod_studio_event_instance_set_paused(soundsRoll, false);
        
        if (!FMODevent_isplaying(soundsRoll))
            fmod_studio_event_instance_start(soundsRoll);
        
        FMODSet3dPos(soundsRoll, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsRoll, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    if (state == states.hammerattack)
    {
        var s = 0;
        
        if (abs(movespeed) > 0)
            s = abs(movespeed) / 12;
        
        fmod_studio_event_instance_set_paused(soundsHammer, false);
        
        if (!FMODevent_isplaying(soundsHammer))
            fmod_studio_event_instance_start(soundsHammer);
        
        FMODSet3dPos(soundsHammer, x, y);
        
        if (fmod_studio_event_instance_get_parameter_by_name(soundsHammer, "state") != s)
            fmod_studio_event_instance_set_parameter_by_name(soundsHammer, "state", s);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsHammer, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    if (state == states.groundpoundstart || state == states.groundpound)
    {
        fmod_studio_event_instance_set_paused(soundsGroundpound, false);
        
        if (!FMODevent_isplaying(soundsGroundpound))
            fmod_studio_event_instance_start(soundsGroundpound);
        
        FMODSet3dPos(soundsGroundpound, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsGroundpound, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    if (sprite_index == spr_milton_dive)
    {
        fmod_studio_event_instance_set_paused(soundsHammerAir, false);
        
        if (!FMODevent_isplaying(soundsHammerAir))
            fmod_studio_event_instance_start(soundsHammerAir);
        
        FMODSet3dPos(soundsHammerAir, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsHammerAir, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    if (state == states.superjumpprep)
    {
        fmod_studio_event_instance_set_paused(soundsSuperjump, false);
        
        if (!FMODevent_isplaying(soundsSuperjump))
            fmod_studio_event_instance_start(soundsSuperjump);
        
        FMODSet3dPos(soundsSuperjump, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsSuperjump, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    if (state == states.skateboardmove || state == states.skateboardwall)
    {
        fmod_studio_event_instance_set_paused(soundsSkateboard, false);
        
        if (!FMODevent_isplaying(soundsSkateboard))
            fmod_studio_event_instance_start(soundsSkateboard);
        
        FMODSet3dPos(soundsSkateboard, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsSkateboard, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    if (state == states.skateboardAim)
    {
        fmod_studio_event_instance_set_paused(soundsSkateAim, false);
        
        if (!FMODevent_isplaying(soundsSkateAim))
            fmod_studio_event_instance_start(soundsSkateAim);
        
        FMODSet3dPos(soundsSkateAim, x, y);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsSkateAim, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    if (state == states.mach2 || state == states.mach3 || state == states.climbwall)
    {
        fmod_studio_event_instance_set_paused(soundsMach, false);
        
        if (!FMODevent_isplaying(soundsMach))
            fmod_studio_event_instance_start(soundsMach);
        
        var s = 0;
        
        if (state == states.mach2 && sprite_index == spr_player_mach1 && grounded)
            s = 0;
        else if (state == states.mach2 && sprite_index != spr_player_mach1)
            s = 1;
        else if (state == states.mach3 && sprite_index != sprites.crazyrun)
            s = 2;
        else if (sprite_index == sprites.crazyrun)
            s = 3;
        
        FMODSet3dPos(soundsMach, x, y);
        
        if (fmod_studio_event_instance_get_parameter_by_name(soundsMach, "state") != s)
            fmod_studio_event_instance_set_parameter_by_name(soundsMach, "state", s);
    }
    else
    {
        fmod_studio_event_instance_stop(soundsMach, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
}

function doGrab()
{
    var move = key_right + key_left;
    
    if (slapBuffer > 0)
    {
        if (character != chars.milton)
        {
            if (!key_up)
            {
                fmod_studio_event_instance_start(soundGrab);
                FMODSet3dPos(soundGrab, x, y);
                slapBuffer = false;
                state = states.grab;
                sprite_index = spr_player_grab;
                image_index = 0;
                create_particleStatic(spr_grabcloud, x, y, xscale, 1);
                
                if (movespeed < 8)
                    movespeed = 8;
            }
            else
            {
                FMODevent_oneshot("event:/Sfx/Player/uppercut", x, y);
                slapBuffer = false;
                state = states.uppercut;
                
                if (coyote_time)
                    vsp = -17;
                else
                    vsp = -12;
                
                sprite_index = spr_player_uppercut;
                image_index = 0;
                create_particleStatic(spr_jumpeffect, x, y, 1, 1);
                squashX = 1.5;
                squashY = 0.6;
            }
        }
        else
        {
            if (move != 0)
                xscale = move;
            
            vsp = 0;
            buffers.hammer = 25;
            slapBuffer = false;
            state = states.hammerattack;
            
            if (movespeed < 12)
                movespeed = 12;
            
            image_index = 0;
            sprite_index = spr_milton_hammerspin_prep;
        }
    }
}

function slope_momentum(arg0 = 0.1, arg1 = 0)
{
    if (scr_slope(x, y + 1))
    {
        var _obj = scr_slope_get();
        
        if (instance_exists(_obj))
        {
            if (sign(_obj.image_xscale) != xscale)
            {
                if (movespeed < 20)
                    movespeed += arg0;
            }
            else
            {
                movespeed -= arg1;
            }
        }
    }
}

function doTaunt()
{
    if (key_taunt2)
    {
        tauntVars = 
        {
            sprite_index: sprite_index,
            image_index: image_index,
            state: state,
            vsp: vsp,
            hsp: hsp,
            movespeed: movespeed,
            image_speed: image_speed
        };
        tauntTimer = 15;
        var _isSupertaunt = canSupertaunt && key_up;
        
        if (!_isSupertaunt)
        {
            state = states.taunt;
            image_speed = 0;
            sprite_index = sprites.taunt;
            image_index = irandom_range(0, image_number);
            instance_create(x, y, obj_taunteffect);
            instance_create(x, y, obj_parryhitbox);
            FMODevent_oneshot("event:/Sfx/Player/taunt", x, y);
        }
        else
        {
            state = states.taunt;
            image_speed = 0.35;
            sprite_index = choose(spr_player_supertaunt1, spr_player_supertaunt2, spr_player_supertaunt3);
            image_index = 0;
            FMODevent_oneshot("event:/Sfx/Player/supertaunt", x, y);
            supertaunt = 0;
            canSupertaunt = false;
            instance_create(x, y, obj_taunteffect);
            
            with (obj_baddie)
            {
                if (in_camera())
                {
                    supertauntKill = true;
                    instance_destroy();
                }
            }
        }
        
        if (instance_exists(obj_server))
        {
            with (obj_server)
                instance_create_online(other.x, other.y, other.depth + 2, obj_onlineTaunteffect);
        }
        
        if (place_meeting(x, y, obj_exitgate) && global.combo.timer > 0 && global.escape.active && global.level != "tutorial")
        {
            if (instance_place(x, y, obj_exitgate).tauntCount < 10)
            {
                obj_exitgate.tauntCount++;
                create_collect(spr_taunteffect, x, y);
                global.collect += 25;
                create_smalltext(25);
            }
        }
    }
}

function get_characterspr(arg0)
{
    var st = 
    {
        player: {},
        tv: {}
    };
    
    switch (arg0)
    {
        case chars.mildred:
            st.player.idle = spr_player_idle;
            st.player.taunt = spr_player_taunt;
            st.player.mach3 = spr_player_mach3;
            st.player.mach3hit = spr_player_mach3hit;
            st.player.mach3jump = spr_player_mach3jump;
            st.player.rolling = spr_player_rolling;
            st.player.move = spr_player_move;
            st.player.crazyrun = spr_player_crazyrun;
            st.player.dive = spr_player_dive;
            st.player.divebomb = spr_player_divebomb;
            st.player.gateslam = spr_player_gateslam;
            st.tv.idle = spr_tv_idle;
            st.tv.mach3 = spr_tv_mach;
            st.tv.crazyrun = spr_tv_crazyrun;
            break;
        
        case chars.milton:
            st.player.idle = spr_milton_idle;
            st.player.taunt = spr_milton_taunt;
            st.player.mach3 = spr_milton_mach3;
            st.player.mach3hit = spr_milton_mach3hit;
            st.player.mach3jump = spr_milton_mach3jump;
            st.player.rolling = spr_milton_roll;
            st.player.move = spr_milton_walk;
            st.player.crazyrun = spr_milton_crazyrun;
            st.player.dive = spr_milton_dive;
            st.player.divebomb = spr_player_divebomb;
            st.player.gateslam = spr_milton_gateslam;
            st.tv.idle = spr_tv_idleT;
            st.tv.mach3 = spr_tv_machT;
            st.tv.crazyrun = spr_tv_crazyrunT;
            break;
    }
    
    return st;
}
