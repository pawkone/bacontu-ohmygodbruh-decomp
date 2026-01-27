depth = 3;
scr_collision_init();
grav = 0.5;
vsp = -11;
create_particleStatic(spr_genericpoofeffect, x, y, 1, -10);
target = obj_player;
mu = FMODcreate_event("event:/Music/breakdance");

if (room != hotel_soundtest)
{
    fmod_studio_event_instance_start(mu);
    fmod_studio_system_set_parameter_by_name("musicfade", 1, false);
}
