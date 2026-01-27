var _transfoPass = [states.snowball, states.snowball_jump, states.snowball_wall, states.skateboard, states.skateboardAim, states.skateboardhitwall, states.skateboardramp, states.skateboardwall, states.skateboardmove, states.coconut_gun, states.coconut_shoot, states.UNKNOWN_53];

if (!array_contains(_transfoPass, other.state))
    exit;

if (other.key_attack)
{
    other.state = states.mach2;
    other.sprite = spr_player_mach2;
}
else
{
    other.state = states.normal;
    other.sprite_index = spr_player_idle;
}

sprite_index = spr_priest_pray;
alarm[0] = 250;
