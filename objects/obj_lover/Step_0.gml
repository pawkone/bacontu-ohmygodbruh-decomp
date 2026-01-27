if (active == false)
{
    sprite_index = asset_get_index(string("spr_lover{0}_idle", lover));
    
    if (place_meeting(x, y, obj_player))
    {
        image_index = 0;
        sprite_index = asset_get_index(string("spr_lover{0}_shoot", lover));
        active = true;
        ds_list_add(global.saveroom, id);
        FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", x, y);
    }
}
else if (sprite_index == asset_get_index(string("spr_lover{0}_shoot", lover)))
{
    if (!fly)
    {
        repeat (10)
        {
            instance_create(x + irandom_range(-50, 50), y + irandom_range(-50, 50), obj_loverproj);
            show_debug_message("disgusting little thing created");
        }
        
        fly = true;
    }
    
    if (animation_end())
        image_index = image_number - 1;
    
    if (fly)
    {
        vspeed = approach(vspeed, -14, 0.2);
        hspeed = approach(hspeed, -4, 0.5);
    }
    else
    {
        hspeed = approach(hspeed, 0, 0.5);
    }
}
