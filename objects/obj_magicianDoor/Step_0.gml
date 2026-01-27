with (obj_player)
{
    if (state == states.enterdoor && animation_end() && place_meeting(x, y, other) && !instance_exists(obj_fadeout) && sprite_index == spr_player_doorunlock)
    {
        FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
        instance_create(x, y, obj_fadeout);
    }
}
