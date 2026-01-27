scr_collision();

if (grounded)
    instance_destroy();

if (place_meeting(x, y, obj_player))
{
    hurt_player(self);
    instance_destroy();
}
