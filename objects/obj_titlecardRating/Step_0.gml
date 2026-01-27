if (scene == 0)
{
    circleSize = approach(circleSize, obj_screensizer.displayWidth, circleSizeSpeed);
    circleSizeSpeed += 1;
    
    if (circleSize == obj_screensizer.displayWidth)
    {
        scene = 1;
        alarm[0] = 25;
    }
}

if (scene == 2)
{
    ratingAlpha = approach(ratingAlpha, 1, 0.1);
    
    if (ratingAlpha == 1 && alarm[0] <= 0)
        alarm[0] = 240;
}

if (scene == 3)
{
    ratingAlpha = approach(ratingAlpha, 0, 0.01);
    
    if (ratingAlpha == 0)
        instance_destroy();
}
