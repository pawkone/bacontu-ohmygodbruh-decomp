if (points == 5)
    instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_notes).sprite_index = spr_heart_part;

global.collect += 2;
global.combo.timer = 60;
points--;
var _sprite = asset_get_index(string("spr_collect{0}", irandom_range(1, 5)));
create_collect(_sprite, x, y);
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y);

if (points > 0)
    alarm[0] = 4;
else
    instance_destroy();
