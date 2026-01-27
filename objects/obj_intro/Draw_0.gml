draw_set_color(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_color(c_white);

if (showFmod)
    draw_sprite(spr_intro_fmod, 0, obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2);

if (showHeart)
    draw_sprite(spr_intro_logo_heart, 0, obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2);

draw_set_alpha(blackAlpha);
draw_set_color(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_color(c_white);
draw_set_alpha(1);
