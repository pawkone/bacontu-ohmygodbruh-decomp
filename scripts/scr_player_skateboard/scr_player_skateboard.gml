function scr_player_skateboardIntro()
{
    hsp = 0;
    vsp = 0;
    image_speed = 0.35;
    
    if (animation_end())
    {
        sprite_index = spr_player_skate_idle;
        state = states.skateboard;
        prevOnSlope = false;
        onSlope = false;
        slopeObj = -4;
        wasRamp = false;
        sprayCans = 4;
        instance_create(x, y, obj_skateboardViewer);
    }
}

function scr_player_skateboardAim()
{
    get_input();
    sprite_index = spr_player_fall;
    image_speed = 0.35;
    vsp = verticalMovespeed;
    hsp = movespeed;
    movespeed = lerp(movespeed, 0, 0.15);
    verticalMovespeed = lerp(verticalMovespeed, 0, 0.15);
    aimTime--;
    
    if ((hsp == 0 && vsp == 0) || !key_slap)
    {
        FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/release", x, y);
        var move = key_right + key_left;
        
        if (move != 0)
            xscale = move;
        
        if (!key_up)
        {
            movespeed = 16;
            vsp = -8;
            sprite_index = spr_player_skate_rampjump;
            image_index = 0;
            state = states.skateboardramp;
        }
        else if (move == 0)
        {
            movespeed = 0;
            hsp = 0;
            vsp = -20;
            state = states.skateboardwall;
            movespeed = 0;
            sprite_index = spr_playerN_knightdoublejump;
        }
        else
        {
            vsp = -20;
            movespeed = 16;
            sprite_index = spr_player_skate_rampjump;
            image_index = 0;
            state = states.skateboardramp;
        }
        
        create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1).image_speed = 0.5;
    }
}

function scr_player_skateboardwall()
{
    image_speed = 0.35;
    get_input();
    
    if (grounded)
    {
        sprite_index = spr_player_skate_idle;
        state = states.skateboard;
    }
    
    if (key_slap2 && sprayCans >= 1)
    {
        sprayCans--;
        aimTime = 15;
        state = states.skateboardAim;
        verticalMovespeed = vsp;
        movespeed = hsp;
    }
    
    if (grounded)
        sprayCans = 4;
}

function scr_player_skateboardhitwall()
{
    image_speed = 0.35;
    get_input();
    hsp = movespeed * xscale;
    
    if (grounded)
        movespeed = approach(movespeed, 0, 0.5);
    
    if (movespeed == 0)
    {
        sprite_index = spr_player_skate_idle;
        image_index = 0;
        state = states.skateboard;
    }
    
    if (grounded)
        sprayCans = 4;
}

function scr_player_skateboardramp()
{
    get_input();
    hsp = movespeed * xscale;
    movespeed = approach(movespeed, 13, 1);
    image_speed = 0.4;
    
    if (grounded)
    {
        sprite_index = spr_player_skate_walk;
        image_index = 0;
        state = states.skateboardmove;
    }
    
    if (grounded)
        sprayCans = 4;
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    if (key_slap2 && sprayCans >= 1)
    {
        sprayCans--;
        aimTime = 15;
        state = states.skateboardAim;
        verticalMovespeed = vsp;
        movespeed = hsp;
    }
    
    if (key_down2)
        vsp = 12;
}

function scr_player_skateboardmove()
{
    get_input();
    hsp = movespeed * xscale;
    image_speed = 0.4;
    
    if (grounded)
        sprayCans = 4;
    
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    if (jumpstop == false && !key_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    slope_momentum(0.25);
    
    if (jumpBuffer > 5 && grounded)
    {
        jumpBuffer = false;
        jumpStop = false;
        image_index = 0;
        sprite_index = spr_player_skate_jump;
        vsp = -10;
        FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/jump", x, y);
    }
    
    if (animation_end() && sprite_index == spr_player_skate_jump)
        sprite_index = spr_player_skate_walk;
    
    prevOnSlope = scr_slope(x, y + 1);
    
    if (prevOnSlope == true)
    {
        slopeObj = instance_place(x, y + 1, obj_slope);
        
        if (sign(slopeObj.image_xscale) == xscale)
            wasRamp = true;
        else
            wasRamp = false;
    }
    
    if (onSlope != prevOnSlope)
    {
        if (onSlope == true && prevOnSlope == false && wasRamp)
        {
            show_debug_message("Ramp Jumped!");
            onSlope = prevOnSlope;
            vsp = -12;
            movespeed = 13;
            sprite_index = spr_player_skate_rampjump;
            image_index = 0;
            state = states.skateboardramp;
            FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/ramp", x, y);
            exit;
        }
        else
        {
            onSlope = prevOnSlope;
        }
    }
    
    if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_stupidcabbit))
    {
        var _hitwall = doBump(40, abs(hsp) + 1);
        
        if (_hitwall)
        {
            vsp = -6;
            movespeed = -6;
            sprite_index = spr_player_skate_stun;
            image_index = 0;
            state = states.skateboardhitwall;
            FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/bump", x, y);
            exit;
        }
    }
    
    if (key_slap2 && sprayCans >= 1)
    {
        sprayCans--;
        aimTime = 15;
        state = states.skateboardAim;
        verticalMovespeed = vsp;
        movespeed = hsp;
    }
}

function scr_player_skateboard()
{
    get_input();
    hsp = movespeed * xscale;
    var move = key_right + key_left;
    image_speed = 0.4;
    
    if (grounded)
        sprayCans = 4;
    
    if (sprite_index != spr_player_skate_startup)
    {
        if (key_slap && sprayCans >= 1)
        {
            sprayCans--;
            aimTime = 15;
            state = states.skateboardAim;
            verticalMovespeed = vsp;
            movespeed = -3 * move;
        }
    }
}
