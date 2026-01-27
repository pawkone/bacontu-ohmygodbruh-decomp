alpha = 1;
active = true;

secret_tile_start = function()
{
    if (event_type == ev_draw)
    {
        if (event_number == 0)
        {
            al = shader_get_uniform(shd_secrettile, "alpha");
            shader_set(shd_secrettile);
            shader_set_uniform_f(al, alpha);
        }
    }
};

secret_tile_end = function()
{
    if (event_type == ev_draw)
    {
        if (event_number == 0)
            shader_reset();
    }
};

visible = false;
