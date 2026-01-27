with (obj_player)
{
    generalReset();
    movespeed = 0;
    vsp = 0;
    hsp = 0;
    state = states.enterdoor;
    door = "NONE";
    room_goto(backtohubRoom);
    
    if (instance_exists(obj_backtohub))
        instance_destroy(obj_backtohub);
    
    instance_create(x, y, obj_backtohub);
}

global.level = -4;
global.resetRoom = -4;
