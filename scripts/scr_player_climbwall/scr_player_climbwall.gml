function scr_player_climbwall()
{
    get_input();
    hsp = 0;
    image_speed = 0.6;
    vsp = -verticalMovespeed;
    var move = key_right + key_left;
    
    if (character != chars.milton)
    {
        if (move == xscale)
            verticalMovespeed = approach(verticalMovespeed, 20, 0.15);
    }
    else
    {
        verticalMovespeed = approach(verticalMovespeed, -5, 0.2);
        
        if (sprite_index == spr_player_wallclimb)
            sprite_index = spr_milton_wallslide;
    }
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 4;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    buffers.step--;
    
    if (buffers.step <= 0)
    {
        buffers.step = 10;
        create_particleStatic(spr_cloudeffect, x, y, 1, 1);
    }
    
    if ((!key_attack && wallgrab <= 0) || (verticalMovespeed <= 0 && character != chars.milton))
    {
        vsp = 0;
        state = states.jump;
        movespeed = -5;
        sprite_index = spr_player_fall;
    }
    
    wallgrab--;
    
    if (!place_meeting(x + (32 * xscale), y, obj_solid))
    {
        wallgrab = 0;
        
        if (character == chars.mildred)
        {
            state = states.buzzsaw;
            image_index = 0;
            sprite_index = spr_player_buzzsawBump;
            
            if (verticalMovespeed < 14)
                verticalMovespeed = 14;
            
            movespeed = verticalMovespeed;
            vsp = -10;
            FMODevent_oneshot("event:/Sfx/Player/airspin", x, y);
        }
        else if (verticalMovespeed >= 12)
        {
            state = states.mach3;
            movespeed = verticalMovespeed;
            flash = true;
            sprite_index = sprites.mach3;
            vsp = 0;
        }
        else
        {
            state = states.mach2;
            movespeed = verticalMovespeed;
            sprite_index = spr_player_mach2;
            vsp = 0;
        }
        
        var o_y = y;
        var rep = 0;
        
        while (!place_meeting(x + xscale, y + 1, obj_solid))
        {
            y++;
            rep++;
            
            if (rep > 32)
            {
                y = o_y;
                break;
            }
        }
    }
    
    if (jumpBuffer > 8)
    {
        if (isMilton)
        {
            jumpBuffer = false;
            vsp = -16;
            xscale *= -1;
            movespeed = verticalMovespeed * xscale;
            state = states.hammerwirl;
            sprite_index = spr_milton_hammertwirl;
            image_index = 0;
            FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
            exit;
        }
        
        jumpBuffer = false;
        FMODevent_oneshot("event:/Sfx/Player/jump", x, y);
        vsp = -11;
        xscale *= -1;
        movespeed = 10;
        state = states.mach2;
        jumpstop = false;
        sprite_index = spr_player_walljumpstart;
        image_index = 0;
    }
    
    if (key_down2 && character == chars.mildred)
    {
        freefallsmash = 20;
        vsp = 10;
        state = states.groundpound;
        create_particleStatic(spr_cloudeffect, x, y, 1, 1);
        buffers.crazyothereffect = 0;
        sprite_index = spr_player_wallpoundstart;
        image_index = 0;
        squashX = 1.3;
        squashY = 0.8;
    }
    
    if (place_meeting(x, y - 1, obj_solid))
    {
        shake_camera(15);
        sprite_index = spr_player_hitceiling;
        image_index = 0;
        state = states.freefallland;
        FMODevent_oneshot("event:/Sfx/Player/slam", x, y);
    }
}
