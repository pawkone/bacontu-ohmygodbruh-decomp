if (global.hide_hud || instance_exists(obj_titlecard) || room == Mainmenu || room == rm_intro)
    exit;

draw_set_font(global.smallfont);
draw_set_color(c_white);
draw_set_halign(fa_left);
var _xx = (obj_screensizer.displayWidth - 128) + 16;
var _yy = obj_screensizer.displayHeight - 32;

if (global.level != -4)
    draw_text(_xx, _yy, timeString(global.level_timer));

draw_text(_xx, _yy - 16, timeString(global.save_timer));
