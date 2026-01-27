if (!instance_exists(obj_option))
    getMenu_input();

var _nopauseRooms = room == rm_intro || room == timesup_room || room == Mainmenu || instance_exists(obj_fadeout) || instance_exists(obj_rank) || instance_exists(obj_technicaldifficulty) || instance_exists(obj_titlecard) || obj_shell.isOpen;

if (!active && key_start2 && !_nopauseRooms)
{
    doPause();
}
else if (active && !instance_exists(obj_option) && buffer == 0)
{
    graphBack.alpha = approach(graphBack.alpha, 0.55, 0.01);
    var move = key_down2 - key_up2;
    
    if (move != 0)
        selected += move;
    
    selected = clamp(selected, 0, array_length(options) - 1);
    
    if (key_slap2 || key_start2)
        doUnpause();
    
    if (key_jump2)
        options[selected].func();
    
    var _pos = fmod_studio_event_instance_get_timeline_position(pauseMusic) * 0.01;
}

buffer = approach(buffer, 0, 1);
