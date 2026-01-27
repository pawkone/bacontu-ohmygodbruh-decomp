function scr_enemy_grabbed()
{
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
    movespeed = 0;
    xscale = playerID.xscale;
    
    if (playerID.state == states.hauling)
    {
        x = playerID.x - (10 * xscale);
        y = playerID.y - 46;
        
        if (playerID.sprite_index == spr_player_haulingjump || playerID.sprite_index == spr_player_haulingfall)
        {
            x = playerID.x - (5 * xscale);
            y = playerID.y - 55;
        }
        
        if (playerID.sprite_index == spr_player_haulingland)
        {
            x = playerID.x - (10 * xscale);
            
            switch (floor(playerID.image_index))
            {
                case 0:
                    y = playerID.y - 15;
                    break;
                
                case 1:
                    y = playerID.y - 24;
                    break;
                
                case 2:
                    y = playerID.y - 34;
                    break;
                
                case 3:
                    y = playerID.y - 37;
                    break;
                
                case 4:
                    y = playerID.y - 40;
                    break;
            }
        }
        
        if (playerID.sprite_index == spr_player_swingading)
        {
            y = playerID.y - 15;
            
            switch (floor(playerID.image_index))
            {
                case 0:
                    x = playerID.x + (25 * xscale);
                    break;
                
                case 1:
                    x = playerID.x + (5 * xscale);
                    break;
                
                case 2:
                    x = playerID.x;
                    break;
                
                case 3:
                    x = playerID.x - (5 * xscale);
                    break;
                
                case 4:
                    x = playerID.x - (25 * xscale);
                    break;
                
                case 5:
                    x = playerID.x - (5 * xscale);
                    break;
                
                case 6:
                    x = playerID.x;
                    break;
                
                case 7:
                    x = playerID.x + (5 * xscale);
                    break;
            }
        }
    }
    else if (playerID.state == states.groundpound || playerID.state == states.groundpoundstart)
    {
        x = playerID.x + (45 * xscale);
        y = playerID.y - 25;
    }
    else
    {
        x = playerID.x + (50 * xscale);
        y = playerID.y - 5;
    }
    
    if (playerID.state != states.hauling && playerID.state != states.finishingblow && playerID.state != states.groundpoundstart && playerID.state != states.groundpound)
    {
        xscale = obj_player.xscale;
        scared = 120;
        state = states.stun;
        x = playerID.x;
        y = playerID.y;
    }
}

function scr_enemy_thrown()
{
    image_speed = 0.35;
    sprite_index = spr_stun;
    
    if (hsp != 0)
        xscale = sign(-hsp);
    
    hsp = hitHsp;
    vsp = hitVsp;
    
    if (place_meeting(x + hsp, y, obj_destructibles))
    {
        with (instance_place(x + hsp, y, obj_destructibles))
            instance_destroy();
    }
    
    if (place_meeting(x + hsp, y + vsp, obj_solid) && !place_meeting(x + hsp, y, obj_destructibles))
        instance_destroy();
    
    if (place_meeting(x + hsp, y + vsp, obj_baddie))
    {
        with (instance_place(x + hsp, y + vsp, obj_baddie))
            instance_destroy();
    }
}
