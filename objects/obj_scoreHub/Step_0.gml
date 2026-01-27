if (state == 0)
{
    vsp += 1;
    y += vsp;
    
    if (y > targetY)
    {
        y = targetY;
        state++;
        alarm[0] = 20;
        exit;
    }
}

rankScale = approach(rankScale, 1, 0.2);
