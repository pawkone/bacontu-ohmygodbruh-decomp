if (sprite_index != spr_magician_unlock)
{
    event_inherited();
}
else if (animation_end())
{
    image_speed = 0;
    image_index = image_number - 1;
}
