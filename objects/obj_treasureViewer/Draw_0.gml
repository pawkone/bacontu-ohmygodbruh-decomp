draw_self();
ini_open(global.saveFile);
var _hasTreasure = ini_read_real(level, "Treasure", 0) == 1;

if (_hasTreasure)
{
    var _x = x + (sprite_width / 2);
    draw_sprite(spr_treasure, treasureIndex, _x, (y - 42) + wave(-5, 5, 2, 2));
}

ini_close();
