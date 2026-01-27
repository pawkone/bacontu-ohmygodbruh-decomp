FMODevent_oneshot("event:/Sfx/General/Enemy/killenemy", x, y);
global.combo.timer = 60;
shake_camera(5, 10);

with (instance_create(x, y, obj_baddiedead))
    sprite_index = other.spr_dead;

repeat (8)
{
    create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
    create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
    create_particleStatic(spr_genericpoofeffect, x, y, 1, -2);
}
