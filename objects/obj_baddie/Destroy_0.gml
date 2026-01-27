var _saveroom = escape ? global.escaperoom : global.saveroom;

if (ds_list_find_index(_saveroom, id) == -1)
{
    FMODevent_oneshot("event:/Sfx/General/Enemy/killenemy", x, y);
    ds_list_add(_saveroom, id);
    global.combo.timer = 60;
    
    if (!spawned)
    {
        global.combo.amt += 1;
        
        if (!supertauntKill)
            obj_player.supertaunt++;
    }
    
    shake_camera(5, 10);
    
    with (instance_create(x, y, obj_baddiedead))
        sprite_index = other.spr_dead;
    
    repeat (8)
    {
        create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
        create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
        create_particleStatic(spr_genericpoofeffect, x, y, 1, -2);
    }
}
