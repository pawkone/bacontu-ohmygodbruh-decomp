if (canGive)
{
    with (other)
    {
        x = other.x + (other.sprite_width / 2);
        y = (other.y + (other.sprite_height / 2)) - 12;
        image_index = 0;
        image_speed = 0.35;
        sprite_index = spr_player_skate_intro;
        state = states.skateboardIntro;
        movespeed = 0;
        scr_transfotip("[wave][U][D][L][R] Aim [G] Charge [J] Jump");
    }
}
