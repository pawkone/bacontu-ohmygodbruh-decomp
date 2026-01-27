fmod_studio_event_instance_stop(mu, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
fmod_studio_event_instance_release(mu);
fmod_studio_system_set_parameter_by_name("musicfade", 0, false);
