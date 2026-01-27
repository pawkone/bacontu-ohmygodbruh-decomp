draw_self();
draw_set_font(global.kettleFont);
draw_set_halign(fa_center);
draw_text(x + 16, y + 12, collect);

if (showRank)
    draw_sprite_ext(spr_hudRanks, rankIndex, x - 15, y + 79, rankScale, rankScale, 0, c_white, 1);
