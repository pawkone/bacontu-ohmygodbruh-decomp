if (global.hide_hud)
    exit;

if (totemAlpha > 0)
{
    draw_set_alpha(totemAlpha);
    draw_sprite(spr_totems, totemIndex, 96, obj_screensizer.displayHeight - 92);
    draw_set_font(global.creditsfont);
    ini_open(global.saveFile);
    draw_set_halign(fa_center);
    var _countTotems = (ini_read_real("General", "Totem0", false) == true) + (ini_read_real("General", "Totem1", false) == true) + (ini_read_real("General", "Totem2", false) == true);
    draw_textEX(96, obj_screensizer.displayHeight - 164, string("[wave]{0}/3!", _countTotems));
    ini_close();
    draw_set_alpha(1);
}
