if (y > 240 && !(lostcombo && global.combo.amt != 0))
{
    y = obj_hud.combometer.y + 110;
}
else if (lostcombo && global.combo.amt != 0)
{
    x = lerp(x, obj_screensizer.displayWidth - 310, 0.25);
    y = lerp(y, 240, 0.25);
}

scale = lerp(scale, 1, 0.2);

if (fade == true)
{
    image_alpha = lerp(image_alpha, 0, 0.2);
    
    if (image_alpha < 0.1)
        instance_destroy();
}

image_index += 0.25;
combo = wrap(combo, 0, 14);
frame = self.getProper(combo);
maxframe = frame + 1;

if (image_index >= (maxframe + 1))
    image_index = frame;

if (lostcombo && points > 0 && alarm[1] <= 0)
    alarm[1] = 2;
