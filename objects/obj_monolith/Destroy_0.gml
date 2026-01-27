if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    FMODevent_oneshot("event:/Sfx/General/Enemy/Monolith/cupdead", x, y);
    
    with (instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_baddiedead))
    {
        sprite_index = spr_mugmonolith_dead;
        hsp = random_range(5, 7) * sign(x - obj_player.x);
        image_xscale = other.image_xscale;
    }
    
    repeat (8)
    {
        create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
        create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
    }
    
    instance_create(x, y, obj_goodmourning);
    instance_create(x, y, obj_whiteflash);
    global.escape.active = true;
    
    switch (global.level)
    {
        default:
            global.escape.timer = 10800;
            break;
        
        case "forest":
            global.escape.timer = 12600;
            break;
    }
    
    obj_hud.bar.chunkMax = global.escape.timer;
    global.combo.amt += 1;
    obj_player.supertaunt++;
    global.combo.timer = 60;
}
