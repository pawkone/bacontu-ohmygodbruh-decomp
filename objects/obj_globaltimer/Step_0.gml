var s = delta_time / 1000000;
global.save_timer += s;

if (global.level != -4 && !obj_pause.active && !instance_exists(obj_rank))
    global.level_timer += s;
