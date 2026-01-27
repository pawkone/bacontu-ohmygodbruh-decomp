var transtates = [states.skateboard, states.skateboardhitwall, states.skateboardIntro, states.skateboardmove, states.skateboardramp, states.skateboardwall];

if (place_meeting(x, y, obj_player) && array_contains(transtates, obj_player.state))
{
    if (!sprayed)
    {
        FMODevent_oneshot("event:/Sfx/General/Shell City/spray", x, y);
        sprayed = true;
        alarm[0] = 4;
        sprite_index = spr_sprayMildred;
        image_index = irandom_range(0, image_number);
        image_yscale = 0;
        image_xscale = 0;
        create_particleStatic(spr_sprayeffect, x, y, 1, -100);
        ds_list_add(global.saveroom, id);
    }
}

image_xscale = approach(image_xscale, 1, 0.05);
image_yscale = approach(image_yscale, 1, 0.05);
