scr_collision();

if (distance_to_object(obj_player) <= 300 && !instance_exists(baddieID))
{
    if (image_speed == 0)
        image_speed = 0.35;
    
    if (image_index != 7)
        exit;
    
    baddieID = instance_create(x, y - 50, content);
    
    with (baddieID)
    {
        vsp = -5;
        state = states.stun;
        scared = 100;
        sprite_index = spr_stun;
        xscale = other.image_xscale;
        spawned = true;
    }
}

if (animation_end())
{
    image_index = 0;
    image_speed = 0;
}
