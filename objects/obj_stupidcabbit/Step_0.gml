with (obj_player)
{
    if (place_meeting(x + hsp, y + vsp, other))
    {
        if (array_contains(other.transfoPass, state))
            instance_destroy(other);
    }
}

with (obj_crab)
{
    if (place_meeting(x + hsp, y + vsp, other))
    {
        if (state == states.taunt)
            instance_destroy(other);
    }
}

if (!FMODevent_isplaying(idlesnd))
    fmod_studio_event_instance_start(idlesnd);
