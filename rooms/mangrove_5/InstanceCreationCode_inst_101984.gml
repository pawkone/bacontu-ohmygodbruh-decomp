totem = 1;
ini_open(global.saveFile);
var isCollected = ini_read_real("General", string("Totem{0}", totem), false);
ini_close();

if (isCollected)
    instance_destroy();
