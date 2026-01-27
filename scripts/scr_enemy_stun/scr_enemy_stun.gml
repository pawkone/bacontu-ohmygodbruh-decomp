function scr_enemy_stun()
{
    scared--;
    image_speed = 0.35;
    hsp = movespeed * xscale;
    
    if (grounded)
        movespeed = approach(movespeed, 0, 0.35);
    
    if (scared <= 0)
    {
        sprite_index = spr_move;
        image_index = 0;
        state = states.move;
        hsp = movespeed * xscale;
    }
    
    if (obj_player.state == states.taunt)
    {
        scared = 0;
        
        if (obj_player.x != x)
            xscale = sign(obj_player.x - x);
        
        vsp = -4;
    }
}
