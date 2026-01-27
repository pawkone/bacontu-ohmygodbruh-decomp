if (cutscene == true)
{
    xscaleMulti = approach(xscaleMulti, 1, 0.1);
    yscaleMulti = approach(yscaleMulti, 1, 0.1);
    
    if (xscaleMulti == 1)
        image_speed = 1;
    
    with (obj_player)
    {
        x = other.x;
        y = other.y;
        vsp = 0;
        hsp = 0;
        xscaleMulti = approach(xscaleMulti, 1, 0.05);
        yscaleMulti = approach(yscaleMulti, 1, 0.05);
    }
    
    if (animation_end() && sprite_index == spr_dudle_open)
    {
        instance_destroy();
        FMODevent_oneshot("event:/Sfx/General/Level/Doodles/doodleget", x, y);
        create_particleDebri(spr_dudle_debri, 0, x, y, 1, -5);
        create_particleDebri(spr_dudle_debri, 1, x, y, 1, -5);
        
        with (obj_player)
        {
            jumpstop = true;
            vsp = 10;
            state = states.groundpound;
            sprite_index = spr_player_groundpound;
            xscaleMulti = 1;
            yscaleMulti = 1;
            roomstartX = x;
            roomstartY = y;
        }
    }
}
