shake = lerp(shake, 0, 0.05);

if (shake <= 0.3)
    fall = true;

if (fall)
{
    y += vsp;
    vsp += 0.25;
    image_alpha -= 0.01;
}

if (y > (obj_screensizer.displayHeight + 100))
    instance_destroy();

shkea = shake;
