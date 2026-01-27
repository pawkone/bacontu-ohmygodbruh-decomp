tiles = [];
collectables = [];
alarm[0] = 10;
layers = layer_get_all();

for (var i = 0; i < array_length(layers); i++)
{
    var tileId = layer_tilemap_get_id(layers[i]);
    
    if (tileId != -1)
        array_push(tiles, tileId);
}

tiles = array_reverse(tiles);
patternPos = 0;
patternAlpha = 0;
fadein = true;
stateTimer = 90;
patternIndex = irandom_range(0, sprite_get_number(spr_tileDoodles));
tileSurf = surface_create(obj_screensizer.displayWidth, obj_screensizer.displayHeight);
depth = 50;
need_mask_update = false;

if (array_length(tiles) == 0)
    instance_destroy();

global.secretCount++;
text_clear(lang_get_phrase("secret_get"));
scr_transfotip(lang_get_phrase("secret_get"));
