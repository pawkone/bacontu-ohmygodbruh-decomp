fmod_studio_event_instance_stop(idlesnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
fmod_studio_event_instance_release(idlesnd);

if (ds_list_find_index(global.saveroom, id) == -1)
{
    with (instance_create(x + 32, y + 48, obj_baddiedead))
    {
        image_xscale = other.image_xscale;
        sprite_index = spr_cabbit_dead;
    }
    
    FMODevent_oneshot("event:/Sfx/General/Enemy/killenemy", x, y);
    FMODevent_oneshot("event:/Sfx/General/Enemy/Cabbit/death", x, y);
    create_particleStatic(spr_genericpoofeffect, x, y, 1, -2);
    ds_list_add(global.saveroom, id);
    global.combo.timer = 60;
    global.combo.amt += 1;
    obj_player.supertaunt++;
    shake_camera(5);
}
