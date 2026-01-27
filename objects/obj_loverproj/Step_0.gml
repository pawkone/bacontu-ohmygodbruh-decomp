var targobj = obj_player;

if (!touched)
{
    var dir = point_direction(x, y, targobj.x, targobj.y);
    hsp = approach(hsp, lengthdir_x(12, dir), 0.75);
    vsp = approach(vsp, lengthdir_y(12, dir), 0.75);
    
    if (place_meeting(x, y, targobj))
        touched = true;
}
else
{
    var accel = 0.9;
    
    if (obj_player.x < x)
        hsp -= accel;
    else if (obj_player.x > x)
        hsp += accel;
    
    if (obj_player.y < y)
        vsp -= accel;
    else if (obj_player.y > y)
        vsp += accel;
    
    if (alarm[0] < 0)
        alarm[0] = 25;
}

if (hsp != 0)
    image_xscale = sign(hsp);

x += hsp;
y += vsp;
