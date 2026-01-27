if (!in_camera())
{
    var _x = x - camera_get_view_x(view_camera[0]);
    _x = clamp(_x, 100, obj_screensizer.displayWidth - 100);
    var _y = y - camera_get_view_y(view_camera[0]);
    _y = clamp(_y, 100, obj_screensizer.displayHeight - 100);
    draw_sprite(spr_hipnatueseLocator, locatorIndex, _x, _y);
}
