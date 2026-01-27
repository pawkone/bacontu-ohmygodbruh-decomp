depth = 10;
cutscene = false;
image_speed = 0;
facing = sign(image_xscale);
image_xscale = 1;
image_index = 0;

if (obj_player.door == "DOODLE")
{
    obj_player.x = x;
    obj_player.y = y;
    obj_player.sprite_index = spr_player_groundpound;
    cutscene = true;
    sprite_index = spr_dudle_open;
    image_index = 0;
    FMODevent_oneshot("event:/Sfx/General/Level/Progression/exitpage", x, y);
}

xscaleMulti = 0;
yscaleMulti = 0;
