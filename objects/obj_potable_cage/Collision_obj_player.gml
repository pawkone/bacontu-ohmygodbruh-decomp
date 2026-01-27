instance_create(x, y, content);
instance_destroy();

repeat (10)
    create_particleDebri(spr_juiceboxcage_debri, irandom_range(0, sprite_get_number(spr_juiceboxcage_debri)), x, y, 1);

ds_list_add(global.saveroom, id);

with (obj_player)
{
    if (irandom(100) <= 25)
        fmod_studio_event_instance_start(soundsLaugh);
}
