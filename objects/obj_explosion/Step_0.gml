var _objKillshit = [obj_baddie, obj_destructibles];

for (var i = 0; i < array_length(_objKillshit); i++)
{
    var _killThing = _objKillshit[i];
    
    if (place_meeting(x, y, _killThing))
        instance_destroy(instance_place(x, y, _killThing));
}

if (animation_end())
    instance_destroy();
