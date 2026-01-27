if (hitstun.is == false)
{
    event_inherited();
    
    switch (state)
    {
        case states.tumble:
            image_speed = 0.4;
            movespeed = 16;
            invincable = true;
            hsp = movespeed * xscale;
            sprite_index = spr_crab_roll;
            
            if (place_meeting(x + hsp + 2, y, obj_destructibles))
            {
                with (instance_place(x + hsp + 2, y, obj_destructibles))
                    instance_destroy();
            }
            
            if (place_meeting(x + hsp, y - 6, obj_solid) && !place_meeting(x + hsp, y - 6, obj_stupidcabbit))
                instance_destroy();
            
            if (place_meeting(x + hsp, y + vsp, obj_stupidcabbit))
            {
                with (instance_place(x + hsp, y + vsp, obj_stupidcabbit))
                    instance_destroy();
            }
            
            if (place_meeting(x + hsp, y + vsp, obj_baddie))
            {
                with (instance_place(x + hsp, y + vsp, obj_baddie))
                {
                    if (object_index == obj_tiki)
                    {
                        if (sprite_index != spr_tiki_kick)
                        {
                            sprite_index = spr_tiki_kick;
                            image_index = 0;
                            
                            if (other.x != x)
                                xscale = sign(other.x - x);
                            
                            with (other)
                            {
                                xscale *= -1;
                                x = other.x;
                                y = other.y;
                            }
                        }
                    }
                    else
                    {
                        instance_destroy();
                    }
                }
            }
            
            break;
        
        case states.stun:
            scr_enemy_stun();
            break;
        
        case states.hit:
            invincable = true;
            
            if (hitstun.is == false)
            {
                xscale = obj_player.xscale;
                state = states.tumble;
                sprite_index = spr_crab_roll;
                vsp = -6;
                movespeed = 16;
            }
            
            break;
        
        case states.turn:
            scr_enemy_turn();
            break;
        
        case states.normal:
            image_speed = 0.35;
            hsp = 0;
            
            if (place_meeting(x, y, obj_player))
            {
                awoken = true;
                awokenTimer = 25;
            }
            
            if (awoken)
            {
                awokenTimer--;
                
                if (awokenTimer <= 0)
                {
                    FMODevent_oneshot("event:/Sfx/Player/mach2bump", x, y);
                    xscaleMulti = 3;
                    yscaleMulti = 0.5;
                    vsp = -5;
                    scared = 120;
                    state = states.stun;
                    sprite_index = spr_stun;
                    image_blend = c_white;
                }
            }
            
            break;
        
        case states.move:
            image_speed = 0.35;
            hsp = movespeed * xscale;
            movespeed = 1;
            
            if (buffers.step <= 0)
            {
                buffers.step = 45;
                create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
            }
            
            buffers.step--;
            sprite_index = spr_move;
            
            if (place_meeting(x + xscale, y, obj_solid) || place_meeting(x + xscale, y, obj_hallway) || (!(place_meeting(x + (xscale * 15), y + 31, obj_solid) || place_meeting(x + (xscale * 15), y + 31, obj_slope) || place_meeting(x + (xscale * 15), y + 31, obj_platform)) && grounded))
            {
                image_speed = 0.35;
                xscale *= -1;
            }
            
            if (point_distance(x, 0, obj_player.x, 0) <= 320 && point_distance(0, y, 0, obj_player.y) <= 160 && (obj_player.state == states.mach3 || obj_player.state == states.buzzsaw))
            {
                vsp = -5;
                
                if (obj_player.x != x)
                    xscale = sign(obj_player.x - x);
                
                sprite_index = spr_scared;
                scared = 120;
                state = states.stun;
            }
            
            break;
        
        case states.grab:
            scr_enemy_grabbed();
            break;
        
        case states.thrown:
            invincable = true;
            state = states.tumble;
            sprite_index = spr_crab_roll;
            vsp = -2;
            movespeed = 16;
            break;
    }
}
else if (hitstun.time >= 0)
{
    image_speed = 0;
    x = hitstun.x + irandom_range(-5, 5);
    y = hitstun.y + irandom_range(-5, 5);
    hitstun.time--;
}
else
{
    x = hitstun.x;
    y = hitstun.y;
    hitstun.is = false;
}
