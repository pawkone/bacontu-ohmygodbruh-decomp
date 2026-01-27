if (!ds_list_empty(afterimages))
{
    for (var i = 0; i < ds_list_size(afterimages); i++)
    {
        var q = ds_list_find_value(afterimages, i);
        
        with (q)
        {
            switch (type)
            {
                case afterimagetype.mach:
                case afterimagetype.buzzsaw:
                case afterimagetype.milton:
                case afterimagetype.normal:
                    for (var r = 0; r < array_length(alarm); r++)
                    {
                        if (alarm[r] >= 0)
                            alarm[r]--;
                    }
                    
                    visible = other.blink;
                    
                    if (alarm[0] == 0)
                        fadeout = true;
                    
                    alpha = clamp(alpha, 0, 0.65);
                    
                    if (fadeout == true)
                    {
                        fadeoutAlpha = approach(fadeoutAlpha, 0, 0.15);
                        
                        if (fadeoutAlpha == 0)
                        {
                            with (other)
                            {
                                q = undefined;
                                ds_list_delete(afterimages, i);
                                i--;
                            }
                        }
                    }
                    
                    break;
                
                case afterimagetype.blur:
                    image_alpha -= 0.15;
                    
                    if (image_alpha <= 0)
                    {
                        with (other)
                        {
                            q = undefined;
                            ds_list_delete(afterimages, i);
                            i--;
                        }
                    }
                    
                    break;
                
                case afterimagetype.UNKNOWN_3:
                case afterimagetype.UNKNOWN_2:
                case afterimagetype.selectcolor:
                    image_alpha -= 0.05;
                    
                    if (image_alpha <= 0)
                    {
                        with (other)
                        {
                            q = undefined;
                            ds_list_delete(afterimages, i);
                            i--;
                        }
                    }
                    
                    break;
            }
        }
    }
}
