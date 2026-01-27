image_speed = 0.35;
depth = 50;
cutscene = false;
ini_open(global.saveFile);
canEnter = ini_read_real("General", "Lap", false);

if (!canEnter)
    sprite_index = spr_partyportal_empty;

ini_close();
