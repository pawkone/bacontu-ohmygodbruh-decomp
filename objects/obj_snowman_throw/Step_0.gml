snowballstates = [states.snowball, states.snowball_jump, states.snowball_wall];

if (place_meeting(x, y, obj_player) && array_contains(snowballstates, obj_player.state) && _throw <= 0)
{
    with (obj_player)
    {
        x = lerp(x, other.x, 0.2);
        y = lerp(y, other.y - 50, 0.2);
        state = states.snowball_jump;
        hsp = 0;
        vsp = 0;
        movespeed = 0;
        xscale = other.image_xscale;
    }
    
    if (sprite_index != spr_snowmanpickup_throw)
    {
        image_index = 0;
        sprite_index = spr_snowmanpickup_throw;
    }
    else if (floor(image_index) >= 15)
    {
        sprite_index = spr_snowmanpickup;
        _throw = 25;
        
        with (obj_player)
        {
            jumpstop = true;
            movespeed = 12;
            vsp = -14;
        }
    }
}

if (animation_end() && sprite_index == spr_snowmanpickup_throw)
    sprite_index = spr_snowmanpickup;

if (_throw > 0)
    _throw--;
