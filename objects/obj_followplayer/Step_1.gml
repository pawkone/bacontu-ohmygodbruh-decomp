var pos = ds_list_find_index(global.followers, id) + 1;
var xx = obj_player.x;
var yy = obj_player.y;
var xscale = obj_player.xscale;

if (!obj_player.hitstun.is)
{
    ds_queue_enqueue(followqueue, xx);
    ds_queue_enqueue(followqueue, yy);
    
    if (ds_queue_size(followqueue) > (lag * pos))
    {
        gx = ds_queue_dequeue(followqueue);
        gy = ds_queue_dequeue(followqueue);
    }
    
    if (obj_player.x != x)
        image_xscale = sign(obj_player.x - x);
    
    space = approach(space, image_xscale, 0.1 / (pos / 4));
    image_alpha = obj_player.image_alpha;
    
    if (obj_player.state == states.ladder || obj_player.state == states.superjump || obj_player.state == states.groundpound || obj_player.state == states.groundpoundstart || obj_player.state == states.walkfront || obj_player.state == states.enterdoor)
        xoffset = approach(xoffset, 0, 3);
    else
        xoffset = approach(xoffset, 32, 5);
    
    gx -= (xoffset * pos * space);
    
    if (interp < 1)
    {
        x = lerp(x, gx, interp);
        y = lerp(y, gy, interp);
        interp = approach(interp, 1, 0.01);
    }
    else
    {
        x = gx;
        y = gy;
    }
}

if (ds_list_find_index(global.followers, id) == -1)
    instance_destroy();
