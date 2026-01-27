global.Fmod3dDefaults = 
{
    position: 
    {
        x: 0,
        y: 0,
        z: 0
    },
    velocity: 
    {
        x: 0,
        y: 0,
        z: 0
    },
    forward: 
    {
        x: 0,
        y: 0,
        z: 1
    },
    up: 
    {
        x: 0,
        y: 1,
        z: 0
    }
};
global.FMOD_existingEvents = [];

function FMODcreate_event(arg0)
{
    var _desc = fmod_studio_system_get_event(arg0);
    var _inst = fmod_studio_event_description_create_instance(_desc);
    array_push(global.FMOD_existingEvents, _inst);
    return _inst;
}

function FMODget_eventLength(arg0)
{
    var _desc = fmod_studio_system_get_event(arg0);
    return fmod_studio_event_description_get_length(_desc);
}

function FMODevent_oneshot(arg0, arg1, arg2)
{
    var _inst = FMODcreate_event(arg0);
    fmod_studio_event_instance_start(_inst);
    
    if (!is_undefined(arg1) && !is_undefined(arg2))
        FMODSet3dPos(_inst, arg1, arg2);
    
    fmod_studio_event_instance_release(_inst);
    return _inst;
}

function FMODSet3dPos(arg0, arg1, arg2)
{
    var _att = global.Fmod3dDefaults;
    _att.position = 
    {
        x: arg1,
        y: arg2,
        z: 0
    };
    fmod_studio_event_instance_set_3d_attributes(arg0, _att);
}

function FMODsetPauseAll(arg0)
{
    for (var i = 0; i < array_length(global.FMOD_existingEvents); i++)
    {
        if (fmod_studio_event_instance_is_valid(global.FMOD_existingEvents[i]))
            fmod_studio_event_instance_set_paused(global.FMOD_existingEvents[i], arg0);
    }
}

function FMODstopAll()
{
    for (var i = 0; i < array_length(global.FMOD_existingEvents); i++)
    {
        if (fmod_studio_event_instance_is_valid(global.FMOD_existingEvents[i]))
            fmod_studio_event_instance_stop(global.FMOD_existingEvents[i], FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
    }
}

function FMODevent_isplaying(arg0)
{
    return fmod_studio_event_instance_get_playback_state(arg0) == FMOD_STUDIO_PLAYBACK_STATE.PLAYING;
}

function FMODevent_isstarting(arg0)
{
    return fmod_studio_event_instance_get_playback_state(arg0) == FMOD_STUDIO_PLAYBACK_STATE.STARTING;
}

function FMODget_path(arg0)
{
    var _des = fmod_studio_event_instance_get_description(arg0);
    return fmod_studio_event_description_get_path(_des);
}
