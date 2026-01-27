var _rm = hotel_receptionentrance;
var _dr = "A";

with (obj_player)
{
    generalReset();
    targetRoom = _rm;
    door = _dr;
    movespeed = 0;
    vsp = 0;
    hsp = 0;
    state = states.enterdoor;
}

global.level = -4;
global.resetRoom = _rm;

if (!instance_exists(obj_fadeout))
    instance_create(0, 0, obj_fadeout);
