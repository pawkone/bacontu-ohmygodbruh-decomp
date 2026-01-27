draw_set_font(global.npcfont);
draw_set_colour(c_black);
draw_rectangle(64, 64, obj_screensizer.displayWidth - 64, 204, false);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_text(obj_screensizer.displayWidth / 2, 96, songs[currentSong].text);
