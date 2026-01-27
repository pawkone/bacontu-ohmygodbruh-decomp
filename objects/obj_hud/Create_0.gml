kettle = {};
kettle.x = 124;
kettle.y = 54;
kettle.kx = kettle.x;
kettle.ky = kettle.y;
kettle.rankScale = 0;
kettle.previousRank = 0;
kettle.cloudIndex = 0;
kettle.offset = 0;
kettle.shake = 0;
depth = -500;
collectVis = ds_list_create();
tv = {};
tv.state = states.normal;
tv.sprite_index = spr_tv_off;
tv.image_index = 0;
tv.image_speed = 0.35;
tv.x = obj_screensizer.displayWidth - 132;
tv.y = 73;
tv.expressionSprite = spr_tv_idle;
tv.expressionTimer = 0;
tv.switchindex = 0;
tv.offset = 0;
tv.backindex = 0;
combometer = {};
combometer.x = 811;
combometer.y = 237;
combometer.arrowx = combometer.x;
combometer.vsp = 0;
combometer.state = -1;
combometer.lights = [];

repeat (4)
{
    array_push(combometer.lights, 
    {
        on: true,
        sprite: spr_comboLights,
        x: 0,
        y: 0,
        index: 0
    });
}

bar = {};
bar.x = obj_screensizer.displayWidth / 2;
bar.y = obj_screensizer.displayHeight - 100;
bar.sparkIndex = 0;
bar.spacePos = 0;
bar.chunkMax = 1;

hudVisible = function()
{
    var _rooms = room == rm_intro || room == hotel_soundtest || room == rank_room || room == Levelselect || room == Mainmenu || room == serverMenuShit || room == hotel_receptionentrance || room == hotel_1 || room == timesup_room || global.level == "tutorial";
    return !_rooms;
};

global.Srank = 22000;
global.magician = false;
