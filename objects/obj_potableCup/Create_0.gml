event_inherited();
global.collect += 1000;
global.combo.timer = 60;
global.toppins.cup = true;
create_smalltext(1000);
FMODevent_oneshot("event:/Sfx/General/Collects/toppinget", x, y);
tv_anim(spr_tv_happy, 180);

with (obj_player)
{
    if (chance(0.25))
        fmod_studio_event_instance_start(soundsLaugh);
}

spr_idle = spr_potablecup_idle;
spr_walk = spr_potablecup_move;
spr_panicidle = spr_potablecup_idlepanic;
spr_intro = spr_potablecup_intro;
spr_taunt = spr_potablecup_taunt;
sprite_index = spr_intro;
image_index = 0;
