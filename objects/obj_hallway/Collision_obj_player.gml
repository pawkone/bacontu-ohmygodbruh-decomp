instance_destroy();

with (other)
{
    door = other.targetDoor;
    targetRoom = other.targetRoom;
    hallway = true;
    hallwayDirection = other.dir;
    
    if (!instance_exists(obj_fadeout))
    {
        FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
        instance_create(x, y, obj_fadeout);
    }
}
