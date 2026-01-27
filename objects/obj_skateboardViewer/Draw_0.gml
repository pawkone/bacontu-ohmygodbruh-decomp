var pl = obj_player;
draw_healthbar(pl.x - 64, pl.y - 64, (pl.x - 64) + 12, (pl.y - 64) + 12, (pl.sprayCans / 4) * 100, c_black, c_white, c_white, 3, true, false);

if (pl.state == states.skateboardAim)
{
    var _vert = pl.key_up;
    var _horiz = pl.key_right + pl.key_left;
    
    if (_horiz != 0)
        guideXscale = _horiz;
    
    var _aim = 0;
    
    if (_horiz)
        _aim = 0;
    else if (_vert)
        _aim = 1;
    
    draw_sprite_ext(spr_skateboardAim, _aim, x, y, guideXscale, 1, 0, c_white, 1);
}
