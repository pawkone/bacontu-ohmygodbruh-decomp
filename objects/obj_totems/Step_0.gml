FMODSet3dPos(snd, x, y);
y = wave(ystart - 5, ystart + 5, 5, 5);

if (place_meeting(x, y, obj_player))
{
    instance_destroy();
    create_particleStatic(spr_genericpoofeffect, x, y, 1);
}

image_index = totem;
