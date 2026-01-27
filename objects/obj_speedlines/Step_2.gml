depth = target.depth - 2;

if (target.movespeed > 13)
{
    x = target.x;
    y = target.y;
    image_angle = 0;
    image_xscale = target.xscale;
}
else
{
    instance_destroy();
}
