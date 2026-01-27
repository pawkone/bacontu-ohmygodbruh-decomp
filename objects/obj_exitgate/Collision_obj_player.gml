if (other.grounded && other.key_up && other.state != states.enterdoor && other.state != states.walkfront && global.escape.active)
{
    with (other)
    {
        vsp = 0;
        state = -4;
        sprite_index = spr_player_lookdoor;
        image_index = 0;
        FMODstopAll();
        global.combo.savecombo = global.combo.amt;
        
        if (global.combo.savecombo > global.combo.highest)
            global.combo.highest = global.combo.savecombo;
        
        if (global.combo.amt > 0 && global.combo.timer > 0)
            global.collect += (10 * global.combo.savecombo);
        
        instance_create(0, 0, obj_rank);
        scr_savelevel();
    }
}
