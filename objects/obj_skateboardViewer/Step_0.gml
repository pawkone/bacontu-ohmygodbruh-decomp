x = obj_player.x;
y = obj_player.y;
var _skateboard = [states.skateboard, states.skateboardhitwall, states.skateboardIntro, states.skateboardmove, states.skateboardramp, states.skateboardwall, states.skateboardAim];

if (!array_contains(_skateboard, obj_player.state))
    instance_destroy();
