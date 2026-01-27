titlecardSprite = lang_get_asset("spr_titlecardMonolith");
titlecardName = 
{
    sprite: lang_get_asset("spr_titlecardMonolithTitle1"),
    x: 0,
    y: 0,
    alpha: 0,
    fadeIn: false
};
fadeAlpha = 0;
fadeIn = true;
scene = 0;
depth = -600;
fadeSurface = surface_create(obj_screensizer.displayWidth, obj_screensizer.displayHeight);
circleSize = 0;
circleSizeSpeed = 0;
titlecardMilton = spr_titlecardMilton_wayback;
titlecardMiltonIndex = 0;
isMilton = obj_player.character == chars.milton;
