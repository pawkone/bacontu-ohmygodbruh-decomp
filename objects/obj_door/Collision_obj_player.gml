var _transfoPass = [states.snowball, states.snowball_jump, states.snowball_wall, states.skateboard, states.skateboardAim, states.skateboardhitwall, states.skateboardramp, states.skateboardwall, states.skateboardmove, states.coconut_gun, states.coconut_shoot, states.UNKNOWN_53];

if (array_contains(_transfoPass, other.state))
    exit;

if (other.grounded && other.key_up && other.state != states.enterdoor && other.state != states.walkfront && other.state != states.snowball)
{
    with (other)
    {
        targetRoom = other.targetRoom;
        door = other.targetDoor;
        hallway = false;
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = states.enterdoor;
        sprite_index = spr_player_lookdoor;
        image_index = 0;
    }
}
