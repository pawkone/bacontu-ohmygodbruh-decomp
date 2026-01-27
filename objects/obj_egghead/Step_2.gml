if (hitstun.is == false)
{
    event_inherited();
    chargeBuffer--;
    
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
        
        case states.crouch:
            image_speed = 0.4;
            hsp = movespeed * xscale;
            
            if (sprite_index == spr_egghead_charge)
            {
                movespeed = 8;
                
                if (place_meeting(x + hsp, y - 7, obj_solid))
                {
                    FMODevent_oneshot("event:/Sfx/Player/mach2bump", x, y);
                    xscaleMulti = 3;
                    yscaleMulti = 0.5;
                    vsp = -5;
                    scared = 120;
                    state = states.stun;
                    movespeed = -5;
                    sprite_index = spr_stun;
                }
            }
            
            if (animation_end() && sprite_index == spr_egghead_chargestart)
                sprite_index = spr_egghead_charge;
            
            break;
        
        case states.move:
            image_speed = 0.35;
            movespeed = 0;
            hsp = movespeed * xscale;
            sprite_index = spr_egghead;
            
            if (point_distance(x, 0, obj_player.x, 0) <= 320 && point_distance(0, y, 0, obj_player.y) <= 160 && chargeBuffer <= 0)
            {
                if (sprite_index != spr_egghead_charge)
                {
                    image_index = 0;
                    sprite_index = spr_egghead_chargestart;
                    
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
    
    hitbox = sprite_index == spr_egghead_charge;
    
    if (hitbox == true)
    {
        if (!instance_exists(hitboxInst))
        {
            hitboxInst = instance_create(x, y, obj_forkbox);
            
            with (hitboxInst)
                enemy_inst = other;
        }
    }
    else if (instance_exists(hitboxInst))
    {
        instance_destroy(hitboxInst);
        hitboxInst = -4;
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
