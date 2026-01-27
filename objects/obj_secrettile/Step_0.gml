var _placeMeeting;

with (obj_player)
{
    var _list = ds_list_create();
    var _num = instance_place_list(x, y, obj_secrettile, _list, false);
    _placeMeeting = false;
    
    if (_num > 0)
    {
        for (var i = 0; i < _num; i++)
        {
            if (place_meeting(x, y, ds_list_find_value(_list, i)))
                _placeMeeting = true;
        }
    }
    
    ds_list_destroy(_list);
}

alpha = approach(alpha, !_placeMeeting, 0.1);
active = _placeMeeting;
var layers = layer_get_all();

for (var i = 0; i < array_length(layers); i++)
{
    var lay = layers[i];
    var layer_name = layer_get_name(lay);
    
    if (layer_name == "Tiles_secret" && active)
    {
        var ID = layer_get_id(layer_name);
        layer_script_begin(ID, secret_tile_start);
        layer_script_end(ID, secret_tile_end);
    }
}
