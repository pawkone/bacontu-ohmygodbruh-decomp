if (down)
{
    y = approach(y, 96, 2);
    
    if (y == 96 && alarm[0] <= 0)
        alarm[0] = 100;
}
else
{
    y = approach(y, -64, 2);
    
    if (y == -128)
        instance_destroy();
}

x = obj_screensizer.displayWidth / 2;
