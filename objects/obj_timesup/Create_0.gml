x = obj_screensizer.displayWidth / 2;
y = -200;
FMODevent_oneshot("event:/Music/General/timesup", x, y);
alarm[0] = 174;
alarm[1] = 360;
vsp = 0;
falling = false;
depth = 15;
generalReset();

with (obj_music)
    stop_music();

with (obj_player)
{
    state = -4;
    x = obj_screensizer.displayWidth / 2;
    y = obj_screensizer.displayHeight / 2;
    sprite_index = sprites.gateslam;
    image_index = 0;
    image_speed = 0.35;
}
