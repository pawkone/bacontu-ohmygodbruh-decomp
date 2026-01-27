points = approach(points, 0, 5);
var _sprite = asset_get_index(string("spr_collect{0}", irandom_range(1, 5)));
create_collect(_sprite, x, y, true);
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y);
