if (place_meeting(x, y, obj_player))
{
    if ((escape && global.escape.active) || (hit && onetime))
    {
        instance_destroy();
        
        with (instance_create(x, y, obj_baddiedead))
        {
            image_speed = 0;
            sprite_index = other.sprite_index;
        }
        
        exit;
    }
    
    if (sprite_index == spr_presentbox_idle)
    {
        hit = true;
        sprite_index = spr_presentbox_activate;
        image_index = 0;
        
        with (obj_player)
        {
            x = other.x;
            y = other.y;
            
            if (sign(other.image_yscale) == 1)
            {
                state = states.superjump;
                sprite_index = spr_player_spinout;
                image_index = 0;
                verticalMovespeed = -14;
                vsp = verticalMovespeed;
                movespeed = 0;
                hsp = 0;
                FMODevent_oneshot("event:/Sfx/Player/superjumprelease", x, y);
            }
            else if (sign(other.image_yscale) == -1)
            {
                state = states.groundpound;
                sprite_index = spr_player_spinout;
                image_index = 0;
                create_particleStatic(spr_cloudeffect, x, y, 1, 1);
                buffers.crazyothereffect = 0;
                vsp = 14;
                movespeed = 0;
                hsp = 0;
            }
        }
    }
}

if (animation_end() && sprite_index == spr_presentbox_activate)
    sprite_index = spr_presentbox_idle;
