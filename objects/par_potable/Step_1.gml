switch (state)
{
    case states.normal:
        image_speed = 0.35;
        
        if (sprite_index != spr_intro)
        {
            event_inherited();
            
            if (og_x != x || og_y != y)
            {
                sprite_index = spr_walk;
                og_x = x;
                og_y = y;
            }
            else
            {
                sprite_index = global.escape.active ? spr_panicidle : spr_idle;
            }
            
            if (obj_player.state == states.taunt)
            {
                sprite_index = spr_taunt;
                image_index = irandom_range(0, image_number);
                state = states.taunt;
                image_speed = 0;
            }
        }
        else if (animation_end())
        {
            sprite_index = spr_idle;
            interp = 0;
        }
        
        break;
    
    case states.taunt:
        var supertauntArr = [spr_player_supertaunt1, spr_player_supertaunt2, spr_player_supertaunt3];
        
        if (array_contains(supertauntArr, obj_player.sprite_index) && sprite_index == spr_taunt)
        {
            sprite_index = spr_intro;
            image_index = 0;
            image_speed = 0.35;
        }
        
        if (!instance_exists(tauntInst))
        {
            tauntInst = instance_create(x, y, obj_taunteffect);
            tauntInst.sprite_index = spr_tinytaunteffect;
            tauntInst.target = self;
        }
        
        if (obj_player.state != states.taunt)
        {
            state = states.normal;
            interp = 0;
        }
        
        break;
}
