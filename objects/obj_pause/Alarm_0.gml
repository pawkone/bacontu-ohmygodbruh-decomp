alarm[0] = 120;

if (active)
{
    heartFind++;
    heartFind = wrap(heartFind, 1, 3);
    var _found = global.secretCount >= heartFind;
    create_heart(bacon.x + 50 + random_range(-50, 20), (bacon.y - 150) + random_range(50, 20), _found);
}
