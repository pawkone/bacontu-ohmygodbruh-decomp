treasureEffectIndex += 0.35;

if (!got)
{
    y = wave(ystart - 5, ystart + 5, 2, 2);
    
    if (place_meeting(x, y, obj_player))
    {
        with (obj_player)
        {
            movespeed = 0;
            hsp = 0;
            vsp = 0;
            state = -4;
            image_speed = 0.2;
            sprite_index = spr_player_treasureget;
        }
        
        fmod_studio_system_set_parameter_by_name("musicfade", 1, false);
        FMODevent_oneshot("event:/Music/treasure", x, y);
        scr_transfotip(lang_get_phrase("treasure_get"));
        got = true;
        ds_list_add(global.saveroom, id);
        alarm[0] = 120;
    }
}
else
{
    with (obj_player)
    {
        hsp = 0;
        vsp = 0;
    }
    
    x = obj_player.x;
    y = obj_player.y - 60;
    global.combo.timer = 60;
    
    if (obj_player.state != -4)
    {
        global.combo.timer = 60;
        global.collect += 3000;
        create_smalltext(3000);
        instance_destroy();
        global.treasure = true;
        fmod_studio_system_set_parameter_by_name("musicfade", 0, false);
    }
}
