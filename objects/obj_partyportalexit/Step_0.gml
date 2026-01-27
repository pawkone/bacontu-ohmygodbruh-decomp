if (cutscene)
{
    visible = true;
    
    if (animation_end())
        instance_destroy();
    
    if (obj_player.state == -4)
    {
        obj_player.xscaleMulti = 0;
        obj_player.yscaleMulti = 0;
        
        with (obj_player)
        {
            x = other.xstart;
            y = other.ystart;
        }
        
        if (floor(image_index) == 7)
        {
            instance_create(x, y, obj_lap2visual);
            global.escape.party = true;
            
            with (obj_player)
            {
                jumpstop = true;
                vsp = 5;
                sprite_index = spr_player_fall;
                state = states.jump;
                xscaleMulti = 1;
                yscaleMulti = 1;
            }
        }
    }
}
