if (hitstun.is == false)
{
    event_inherited();
    
    switch (state)
    {
        case states.stun:
            scr_enemy_stun();
            break;
        
        case states.hit:
            scr_enemy_hit();
            break;
        
        case states.turn:
            scr_enemy_turn();
            break;
        
        case states.mach2:
            image_speed = 0.4;
            hsp = movespeed * xscale;
            movespeed = 8;
            sprite_index = spr_move;
            
            if (place_meeting(x + xscale, y, obj_solid) || place_meeting(x + xscale, y, obj_hallway) || (!(place_meeting(x + (xscale * 18), y + 31, obj_solid) || place_meeting(x + (xscale * 18), y + 31, obj_slope) || place_meeting(x + (xscale * 18), y + 31, obj_platform)) && grounded))
            {
                vsp = -5;
                xscale *= -1;
            }
            
            break;
        
        case states.crouch:
            image_speed = 0.5;
            sprite_index = spr_pancake_getup;
            
            if (animation_end())
            {
                if (obj_player.x != x)
                    xscale = -sign(obj_player.x - x);
                
                vsp = -11;
                state = states.mach2;
                
                with (instance_create(x, y, obj_slipperybutter))
                {
                    other.syrupInst = self;
                    vsp = -7;
                    hsp = -1 * other.xscale;
                }
            }
            
            break;
        
        case states.move:
            image_speed = 0.35;
            movespeed = 0;
            hsp = movespeed * xscale;
            sprite_index = spr_pancake_sleep;
            
            if (point_distance(x, 0, obj_player.x, 0) <= 512 && point_distance(0, y, 0, obj_player.y) <= 96)
            {
                if (sprite_index != spr_pancake_getup)
                {
                    image_index = 0;
                    sprite_index = spr_pancake_getup;
                    
                    if (obj_player.x != x)
                        xscale = sign(obj_player.x - x);
                    
                    state = states.crouch;
                }
            }
            
            break;
        
        case states.grab:
            scr_enemy_grabbed();
            break;
        
        case states.thrown:
            scr_enemy_thrown();
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
