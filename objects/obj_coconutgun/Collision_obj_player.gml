if (other.state == states.grab)
{
    with (other)
    {
        x = other.x;
        y = other.y;
        state = states.coconut_intro;
        sprite_index = spr_player_coconut_intro;
        image_index = 0;
    }
    
    instance_destroy();
}
