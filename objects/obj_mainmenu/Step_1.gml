if (TVsprite == spr_mainmenu_tvStatic && !instance_exists(obj_option))
{
    fmod_studio_event_instance_set_paused(TVsnd, false);
    
    if (!FMODevent_isplaying(TVsnd))
        fmod_studio_event_instance_start(TVsnd);
}
else
{
    fmod_studio_event_instance_stop(TVsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
}
