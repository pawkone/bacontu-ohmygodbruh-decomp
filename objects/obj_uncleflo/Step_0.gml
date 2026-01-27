if (global.escape.active)
{
    text = "[wave]BRO YOU GOTTA LEAVE BRO!";
    
    if (place_meeting(x, y, obj_player))
    {
        instance_destroy();
        surface_free(surf);
        
        with (instance_create(x, y, obj_baddiedead))
        {
            image_speed = 0;
            sprite_index = spr_flodead;
        }
    }
}

if (distance_to_object(obj_player) < 16)
{
    if (sprite_index != spr_talk)
    {
        sprite_index = spr_talk;
        image_index = 0;
        
        if (!FMODevent_isplaying(snd_voice))
            fmod_studio_event_instance_start(snd_voice);
        
        FMODSet3dPos(snd_voice, x, y);
    }
    
    switch (borderpart)
    {
        case 0:
            borderY = approach(borderY, 43, borderVsp);
            borderVsp += 0.5;
            
            if (borderY >= 43)
                borderpart++;
            
            break;
        
        case 1:
            borderY = floor(lerp(borderY, 32 + wave(-2, 2, 8, 0), 0.15));
            break;
    }
}
else
{
    borderpart = 0;
    borderVsp = 0;
    borderY = approach(borderY, borderTargetpos, 5);
    sprite_index = spr_idle;
}

borderX = floor(32 + wave(-2, 2, 4, 0));
