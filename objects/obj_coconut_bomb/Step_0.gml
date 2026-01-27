scr_collision();
hsp = movespeed * xscale;
var _objKillshit = [obj_baddie, obj_stupidcabbit, obj_destructibles];

for (var i = 0; i < array_length(_objKillshit); i++)
{
    var _killThing = _objKillshit[i];
    
    if (place_meeting(x + hsp, y + vsp, _killThing))
    {
        instance_destroy(instance_place(x + hsp, y + vsp, _killThing));
        instance_destroy();
    }
}

if (place_meeting(x + hsp, y, obj_solid))
    xscale *= -1;

if (grounded)
    instance_destroy();
