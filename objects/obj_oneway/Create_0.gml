depth = 50;
image_speed = 0.35;
coll = instance_create(x, y, obj_solid);

with (coll)
{
    image_yscale = 2;
    image_xscale = other.image_xscale;
}

mask_index = spr_onewaymask;
