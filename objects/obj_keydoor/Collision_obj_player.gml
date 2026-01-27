if (other.grounded && other.key_up && other.state != states.enterdoor && other.state != states.walkfront && other.state != states.snowball && open)
{
    global.key = false;
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
        
        if (ds_list_find_index(global.saveroom, id) == -1)
        {
            ds_list_add(global.saveroom, id);
            image_index = 0;
            sprite_index = spr_player_doorunlock;
        }
        else
        {
            image_index = 0;
            sprite_index = spr_player_lookdoor;
            FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
            instance_create(x, y, obj_fadeout);
        }
    }
}
