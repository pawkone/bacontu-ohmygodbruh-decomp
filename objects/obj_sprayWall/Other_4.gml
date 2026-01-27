if (ds_list_find_index(global.saveroom, id) != -1)
{
    sprayed = true;
    sprite_index = spr_sprayMildred;
    image_index = irandom_range(0, image_number);
    image_yscale = 1;
    image_xscale = 1;
}
