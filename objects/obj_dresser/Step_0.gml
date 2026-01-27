if (place_meeting(x, y, obj_player))
{
    if (obj_player.key_up2)
    {
        selected++;
        selected = wrap(selected, 0, array_length(palettes) - 1);
        
        with (obj_player)
        {
            with (instance_create(x, y, obj_baddiedead))
            {
                sprite_index = spr_mildred_clothes;
                usePalette = true;
                spr_palette = spr_playerPal;
                paletteIndex = other.palIndex;
                spr_pattern = global.patternSpr;
                patColors = global.PlayerCharacters[other.character].patColors;
                hsp = random_range(-7, 7);
                vsp = random_range(-10, -14);
            }
            
            palIndex = other.palettes[other.selected].index;
            global.patternSpr = other.palettes[other.selected].sprite;
            create_particleStatic(spr_genericpoofeffect, x, y, 1, -1);
            FMODevent_oneshot("event:/Sfx/General/dresser", x, y);
        }
    }
}

textAlpha = approach(textAlpha, place_meeting(x, y, obj_player), 0.1);
indicatorAlpha = approach(indicatorAlpha, indicator, 0.1);
