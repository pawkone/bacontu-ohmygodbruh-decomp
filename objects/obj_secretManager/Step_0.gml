patternPos += 0.1;
stateTimer--;
var targetAlpha = fadein ? 1 : 0;
patternAlpha = approach(patternAlpha, targetAlpha, 1/30);

if (stateTimer <= 0)
{
    stateTimer = fadein ? 60 : 180;
    fadein = !fadein;
    
    if (fadein)
        patternIndex = irandom_range(0, sprite_get_number(spr_tileDoodles));
}
