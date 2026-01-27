draw_self();

if (totemAlpha > 0)
{
    draw_set_alpha(totemAlpha);
    draw_set_font(global.creditsfont);
    ini_open(global.saveFile);
    draw_set_halign(fa_center);
    var _countTotems = (ini_read_real("General", "Totem0", false) == true) + (ini_read_real("General", "Totem1", false) == true) + (ini_read_real("General", "Totem2", false) == true);
    draw_textEX(x, y - 164, string("{0}/3", _countTotems));
    ini_close();
    draw_set_alpha(1);
}
