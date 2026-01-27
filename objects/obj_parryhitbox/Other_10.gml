with (obj_player)
{
    shake_camera(25);
    state = states.parry;
    sprite_index = spr_player_parry1;
    create_particleStatic(spr_parryeffect, x, y, 1);
    FMODevent_oneshot("event:/Sfx/Player/parry", x, y);
    image_index = 0;
    movespeed = -6;
    flash = true;
}
