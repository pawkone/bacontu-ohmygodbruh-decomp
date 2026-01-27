if (!surface_exists(fadeSurface))
    fadeSurface = surface_create(obj_screensizer.displayWidth, obj_screensizer.displayHeight);

surface_set_target(fadeSurface);
draw_clear_alpha(c_black, 0);
draw_set_color(c_black);
draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);
draw_set_color(c_white);
gpu_set_blendmode(bm_subtract);
draw_circle(obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2, circleSize, false);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_set_alpha(1);
draw_surface(fadeSurface, 0, 0);
draw_set_alpha(1);
draw_set_alpha(ratingAlpha);
draw_sprite(spr_ratingLabel, eForEveryone, 32, 32);
draw_set_alpha(1);
