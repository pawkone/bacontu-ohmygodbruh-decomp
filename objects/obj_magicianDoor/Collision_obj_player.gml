if (other.grounded && other.key_up && other.state != states.enterdoor && other.state != states.walkfront && global.magician)
{
    image_index = 1;
    ds_list_add(global.saveroom, id);
    
    with (other)
    {
        targetRoom = other.targetRoom;
        door = other.targetDoor;
        hallway = false;
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = states.enterdoor;
        
        if (instance_exists(obj_magician))
        {
            image_index = 0;
            sprite_index = spr_player_doorunlock;
        }
        else
        {
            FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
            instance_create(x, y, obj_fadeout);
            image_index = 0;
            sprite_index = spr_player_lookdoor;
        }
    }
    
    with (obj_magician)
    {
        x = (other.x + (other.sprite_width / 2)) - 16;
        y = other.y + (other.sprite_height / 2);
        sprite_index = spr_magician_unlock;
        xscale = 1;
        image_index = 0;
        persistent = false;
        image_speed = 0.35;
        FMODevent_oneshot("event:/Sfx/General/Level/Gerome/unlock", x, y);
    }
}
