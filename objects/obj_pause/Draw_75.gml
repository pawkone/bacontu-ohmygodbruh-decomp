if (!instance_exists(obj_option))
{
    if (active)
    {
        shader_set(shd_wave);
        shader_set_uniform_f(timeUniform, waveTime);
        waveTime++;
        shader_set_uniform_f(frequencyUniform, freq);
        shader_set_uniform_f(amplitudeUniform, amp);
        draw_sprite(screenSprite, 0, 0, 0);
        shader_reset();
        draw_set_alpha(graphBack.alpha);
        draw_set_color(c_white);
        draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);
        draw_set_color(c_white);
        draw_set_alpha(1);
    }
    
    var xx = obj_screensizer.displayWidth - 300;
    var yy = (obj_screensizer.displayHeight / 2) - (80 * ((array_length(options) - 1) / 2));
    
    for (var i = 0; i < array_length(options); i++)
    {
        var q = options[i];
        
        if (!active)
            q.offsetX = lerp(q.offsetX, obj_screensizer.displayWidth, 0.15);
        else if (selected == i)
            q.offsetX = lerp(q.offsetX, -15, 0.15);
        else
            q.offsetX = lerp(q.offsetX, 0, 0.15);
        
        if (is_struct(q))
        {
            draw_sprite(spr_pauseSelectBacon, selected != i, xx + q.offsetX, yy + (80 * i));
            draw_set_font(global.bigfont);
            draw_set_color((selected == i) ? c_white : c_gray);
            draw_set_halign(fa_center);
            draw_textEX(xx + q.offsetX, (yy + (80 * i)) - 24, lang_get_phrase(q.option));
        }
    }
    
    draw_sprite_ext(spr_pauseBorder, 0, obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2, graphBorderSize, graphBorderSize, 0, c_white, 1);
    
    if (global.level != -4)
    {
        for (var i = 0; i < array_length(hearts); i++)
        {
            var q = hearts[i];
            draw_set_alpha(q.alpha);
            
            if (active)
                draw_sprite(q.sprite, q.index, q.x, q.y);
            
            draw_set_alpha(1);
            q.index += 0.05;
            q.y -= 0.35;
            q.x = wave(q.xstart - 5, q.xstart + 5, 5, 60);
            
            if (!q.fadeout)
            {
                q.alpha = approach(q.alpha, 1, 0.05);
                q.fadeoutTimer = approach(q.fadeoutTimer, 0, 1);
                
                if (q.fadeoutTimer == 0)
                    q.fadeout = true;
            }
            else if (q.fadeout)
            {
                q.alpha = approach(q.alpha, 0, 0.005);
                
                if (q.alpha == 0)
                {
                    array_delete(hearts, i, 1);
                    i--;
                }
            }
        }
    }
    
    with (bacon)
    {
        draw_sprite(spr_pauseTable, smokeIndex, x, y);
        var _sprite = spr_pauseBacon;
        
        if (other.isMilton)
            _sprite = spr_pauseMilton;
        
        pal_swap_set(global.PlayerCharacters[other.character].playerPal, other.playerPalIndex, false);
        draw_sprite(_sprite, 0, round(x), round(y));
        shader_reset();
        
        if (global.level != -4)
            draw_sprite(spr_pauseTreasure, global.treasure ? 0 : 1, round(x) + 134, round(y) + 56);
        
        pattern_draw(_sprite, 0, round(x), round(y), 1, 1, 0, 16777215, 1, global.patternSpr, global.PlayerCharacters[other.character].patColors, global.PlayerCharacters[other.character].playerPal, other.playerPalIndex);
        var _interpX = 0.2;
        var _interpY = 0.2;
        
        if (other.active)
            _interpY = 0.1;
        
        if (other.active)
            _interpX = 0.05;
        
        x = lerp(x, other.active ? (303 + wave(0, -3, 3, 3)) : -96, _interpX);
        y = lerp(y, other.active ? (344 + wave(0, 3, 4, 60)) : (obj_screensizer.displayHeight + 264), _interpY);
        smokeIndex += 0.1;
    }
    
    graphBorderSize = lerp(graphBorderSize, active ? 1 : 2, 0.15);
    
    if (active)
    {
        if (tipText != "")
        {
            draw_set_font(global.creditsfont);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_textEX(obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight - 64, tipText);
            draw_set_alpha(1);
        }
    }
}
