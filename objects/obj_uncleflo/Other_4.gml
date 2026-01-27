if (!place_meeting(x, y + 1, obj_solid))
{
    while (!place_meeting(x, y + 1, obj_solid))
        y++;
}

surf = -4;
borderY = borderTargetpos;
