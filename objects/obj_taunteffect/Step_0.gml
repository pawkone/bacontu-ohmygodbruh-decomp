if (target.state != states.taunt)
    instance_destroy();

x = target.x;
y = target.y;

if (animation_end())
    image_speed = 0;
