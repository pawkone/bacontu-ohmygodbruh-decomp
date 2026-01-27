instance_create(x, y, obj_magician);
global.magician = true;
FMODevent_oneshot("event:/Sfx/General/Level/Gerome/collect", x, y);
instance_destroy();
ds_list_add(global.saveroom, id);
