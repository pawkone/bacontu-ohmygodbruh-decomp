if (toppinPos < array_length(toppins))
{
    toppins[toppinPos][0] = true;
    toppinPos++;
    alarm[2] = 10;
    FMODevent_oneshot("event:/Sfx/Player/minijohnpunch", obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2);
}
