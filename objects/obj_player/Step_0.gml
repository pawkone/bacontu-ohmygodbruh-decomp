if (FMODevent_isplaying(soundsOk))
    FMODSet3dPos(soundsOk, x, y);

if (FMODevent_isplaying(soundsLaugh))
    FMODSet3dPos(soundsLaugh, x, y);

var _insta = sprite_index == spr_milton_dive || state == states.slip || state == states.mach3 || state == states.skateboard || state == states.skateboardwall || state == states.skateboardramp || state == states.skateboardmove || state == states.hammerattack || (state == states.machturn && sprite_index == spr_player_mach3turn) || state == states.superjump || state == states.uppercut || state == states.groundpound || state == states.groundpoundstart || state == states.buzzsaw || state == states.snowball || state == states.snowball_jump || state == states.snowball_wall;
instakill = _insta;

if (hitstun.is == false)
{
    if (!instance_exists(obj_technicaldifficulty) && obj_player.state != states.enterdoor && obj_player.state != states.skateboardIntro && obj_player.state != states.walkfront && !instance_exists(obj_fadeout) && obj_player.state != -4)
        global.combo.timer = approach(global.combo.timer, 0, 0.15);
    
    if (global.combo.previouscombo != global.combo.amt)
    {
        global.combo.previouscombo = global.combo.amt;
        
        if (global.combo.amt > 0 && (global.combo.amt % 5) == 0)
        {
            instance_destroy(obj_comboTitle);
            
            with (instance_create(811, 350, obj_comboTitle))
            {
                combo = floor(global.combo.amt / 5);
                
                if (floor(global.combo.amt / 5) > 15)
                    very = true;
                
                combo = wrap(combo, 0, 14);
                image_index = self.getProper(combo);
            }
            
            FMODevent_oneshot("event:/Sfx/UI/Combo/comboup");
        }
    }
    
    if (global.combo.timer == 0 && global.combo.amt > 0)
    {
        global.combo.savecombo = global.combo.amt;
        
        if (global.combo.savecombo > global.combo.highest)
            global.combo.highest = global.combo.savecombo;
        
        global.combo.amt = 0;
        
        if (!instance_exists(obj_rank))
        {
            if (!global.combo.dropped)
                FMODevent_oneshot("event:/Sfx/UI/Combo/prankfail");
            
            global.combo.dropped = true;
            FMODevent_oneshot("event:/Sfx/UI/Combo/comboend");
            instance_destroy(obj_comboTitle);
            
            with (instance_create(811, 350, obj_comboTitle))
            {
                combo = floor(global.combo.savecombo / 5);
                
                if (floor(global.combo.savecombo / 5) > 15)
                    very = true;
                
                lostcombo = true;
                combo = wrap(combo, 0, 14);
                image_index = self.getProper(combo);
                points = 10 * global.combo.savecombo;
                global.collect += points;
            }
        }
    }
    
    scr_collision();
    scr_collide_destructibles();
    
    if (grounded)
        coyote_time = 10;
    else if (vsp < 0)
        coyote_time = 0;
    
    coyote_time--;
    
    if (state != states.hurt)
        i_frame = approach(i_frame, 0, 1);
    
    if (i_frame > 0 && state != states.hurt)
        image_alpha = round(wave(0, 1, 0.1, 0));
    else
        image_alpha = 1;
    
    if (state == states.walkfront)
        image_blend = make_colour_hsv(0, 0, (image_index / image_number) * 255);
    else
        image_blend = make_colour_hsv(0, 0, 255);
    
    if (flash == true && alarm[0] <= 0)
        alarm[0] = 5;
    
    if (y < -500 || (y > (room_height + 500) && state != -4 && !instance_exists(obj_fadeout)))
    {
        if (!instance_exists(obj_technicaldifficulty))
        {
            instance_create(x, y, obj_technicaldifficulty);
            shake_camera(25);
            FMODevent_oneshot("event:/Sfx/Player/slam", x, y);
        }
    }
    switch (state)
    {
        case states.normal:
            scr_player_normal();
            break;
        
        case states.jump:
            scr_player_jump();
            break;
        
        case states.crouch:
            scr_player_crouch();
            break;
        
        case states.mach2:
            scr_player_mach2();
            break;
        
        case states.machslide:
            scr_player_machslide();
            break;
        
        case states.mach3:
            scr_player_mach3();
            break;
        
        case states.machturn:
            scr_player_machturn();
            break;
        
        case states.hitwall:
            scr_player_hitwall();
            break;
        
        case states.superjumpprep:
            scr_player_superjumpprep();
            break;
        
        case states.superjump:
            scr_player_superjump();
            break;
        
        case states.freefallland:
            scr_player_freefallland();
            break;
        
        case states.taunt:
            scr_player_taunt();
            break;
        
        case states.tumble:
            scr_player_tumble();
            break;
        
        case states.climbwall:
            scr_player_climbwall();
            break;
        
        case states.groundpound:
            scr_player_groundpound();
            break;
        
        case states.groundpoundstart:
            scr_player_groundpoundstart();
            break;
        
        case states.enterdoor:
            scr_player_enterdoor();
            break;
        
        case states.grab:
            scr_player_grab();
            break;
        
        case states.hauling:
            scr_player_hauling();
            break;
        
        case states.finishingblow:
            scr_player_finishingblow();
            break;
        
        case states.uppercut:
            scr_player_uppercut();
            break;
        
        case states.hurt:
            scr_player_hurt();
            break;
        
        case states.ladder:
            scr_player_ladder();
            break;
        
        case states.buzzsaw:
            scr_player_buzzsaw();
            break;
        
        case states.walkfront:
            scr_player_walkfront();
            break;
        
        case states.parry:
            scr_player_parry();
            break;
        
        case states.surfing:
            scr_player_surfing();
            break;
        
        case states.diveboard:
            scr_player_diveboard();
            break;
        
        case states.ski:
            scr_player_ski();
            break;
        
        case states.skibounce:
            scr_player_skibounce();
            break;
        
        case states.skirow:
            scr_player_skirow();
            break;
        
        case states.hammerattack:
            scr_player_hammerattack();
            break;
        
        case states.hammerwirl:
            scr_player_hammertwirl();
            break;
        
        case states.snowball:
            scr_player_snowball();
            break;
        
        case states.snowball_jump:
            scr_player_snowball_jump();
            break;
        
        case states.snowball_wall:
            scr_player_snowball_wall();
            break;
        
        case states.skateboard:
            scr_player_skateboard();
            break;
        
        case states.skateboardIntro:
            scr_player_skateboardIntro();
            break;
        
        case states.skateboardmove:
            scr_player_skateboardmove();
            break;
        
        case states.skateboardhitwall:
            scr_player_skateboardhitwall();
            break;
        
        case states.skateboardramp:
            scr_player_skateboardramp();
            break;
        
        case states.skateboardwall:
            scr_player_skateboardwall();
            break;
        
        case states.skateboardAim:
            scr_player_skateboardAim();
            break;
        
        case states.slip:
            scr_player_slip();
            break;
        
        case states.coconut_intro:
            scr_player_coconut_intro();
            break;
        
        case states.coconut_gun:
            scr_player_coconut_gun();
            break;
        
        case states.coconut_shoot:
            scr_player_coconut_shoot();
            break;
        
        case states.noclip:
            get_input();
            var spd = key_attack ? 20 : 10;
            var move = key_right + key_left;
            var move2 = key_down - key_up;
            y += (move2 * spd);
            x += (move * spd);
            hsp = 0;
            vsp = 0;
            
            if (key_jump2)
                state = states.normal;
            
            break;
    }
    
    if (state == states.crouch || state == states.tumble || state == states.superjumpprep)
        mask_index = spr_crouchmask;
    else
        mask_index = spr_player_mask;
}
else
{
    get_input();
    
    if (hitstun.time > 0)
    {
        image_speed = 0;
        x = hitstun.x + irandom_range(-5, 5);
        y = hitstun.y + irandom_range(-5, 5);
        hitstun.time--;
        
        if (instance_exists(obj_fadeout))
        {
            hitstun.time = 0;
            x = hitstun.x;
            y = hitstun.y;
            hitstun.is = false;
        }
    }
    else
    {
        x = hitstun.x;
        y = hitstun.y;
        hitstun.is = false;
    }
}
