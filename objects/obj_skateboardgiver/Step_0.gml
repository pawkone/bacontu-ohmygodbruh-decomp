if (animation_end() && sprite_index == spr_stickcollect_billlargestack_open)
{
    image_index = 0;
    sprite_index = spr_stickcollect_billlargestack_end;
}
else if (animation_end() && sprite_index == spr_stickcollect_billlargestack_end)
{
    image_speed = 0;
    image_index = image_number - 1;
}

var _transfoPass = [states.skateboardIntro, states.skateboard, states.skateboardAim, states.skateboardhitwall, states.skateboardramp, states.skateboardwall, states.skateboardmove];

if (array_contains(_transfoPass, obj_player.state))
    canGive = false;
else
    canGive = true;
