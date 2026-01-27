global.collect += 5;
global.combo.timer = 60;
points -= 5;
var _sprite = asset_get_index(string("spr_collect{0}", irandom_range(1, 5)));
create_collect(_sprite, x, y);
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y);

if (points > 0)
    alarm[0] = 4;
else
    alarm[1] = 25;
