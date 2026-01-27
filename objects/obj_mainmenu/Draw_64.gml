pal_swap_set(pal_mainmenu_room, roomPaletteIndex, false);
draw_sprite_ext(spr_mainmenu_tvBackground, 0, 0, 0, menuscale + 1, menuscale + 1, 0, c_white, 1);
draw_sprite_ext(TVsprite, TVindex, 768, 288, menuscale + 1, menuscale + 1, 0, c_white, 1);
draw_sprite_ext(spr_mainmenu_shelf, 0, 0, 0, menuscale + 1, menuscale + 1, 0, c_white, 1);
shader_reset();

for (var i = 0; i < array_length(saveFiles); i++)
{
    var q = saveFiles[i];
    draw_set_alpha(q.movie.alpha);
    pal_swap_set(pal_mainmenu_room, roomPaletteIndex, false);
    draw_sprite_ext(spr_mainmenu_movies, q.movie.index, q.movie.x, q.movie.y, q.movie.scale + menuscale, q.movie.scale + menuscale, 0, moviefadeC, q.movie.alpha);
    shader_reset();
    draw_set_alpha(1);
}

for (var i = 0; i < array_length(saveFiles); i++)
{
    if (scene != 2)
    {
        var q = saveFiles[i];
        draw_set_alpha(q.faceAlpha * hudAlpha);
        draw_sprite(spr_mainmenu_tomatoface, q.faceIndex, 100, 440);
        draw_set_alpha(1);
    }
}

draw_set_alpha(hudAlpha);

if (TVsprite != spr_mainmenu_tvStatic)
{
    draw_sprite(spr_tapestatus, 0, 732, 267);
    draw_set_halign(fa_center);
    draw_set_font(global.percentageFont);
    draw_text(732, 267, string("{0}%", round(percentageReal)));
}

draw_set_halign(fa_center);
draw_sprite(spr_controls, 0, 843, 77);
draw_sprite(spr_quitgame, 0, 0, 0);
draw_set_halign(fa_left);
draw_textEX(779, -45, "[S]");
draw_textEX(75, -5, "[G]");
draw_set_font(global.creditsfont);
draw_sprite(spr_deletefile, 0, 832, 448);
draw_textEX(768, 448, "[T]");
draw_set_font(global.smallfont);
draw_set_color(c_white);
draw_set_halign(fa_right);
var _xx = obj_screensizer.displayWidth - 32;
var _yy = obj_screensizer.displayHeight - 32;
draw_text(_xx, _yy, "v0.0.1dev");
draw_set_alpha(1);

if (dark)
    draw_sprite(spr_mainmenu_dark, 0, 0, 0);
