global.language = "english";
global.langMapWord = ds_map_create();
global.langMapArt = ds_map_create();

function get_file_extension(arg0)
{
    var dot_pos = string_last_pos(".", arg0);
    
    if (dot_pos > 0)
        return string_lower(string_copy(arg0, dot_pos + 1, string_length(arg0) - dot_pos));
    
    return "";
}

function lang_init()
{
    var _generalPath = "lang/";
    var _textFile = string("{0}/{1}/text.txt", _generalPath, global.language);
    var _json = json_parse(loadString(_textFile));
    var _jsonNames = variable_struct_get_names(_json);
    
    for (var i = 0; i < array_length(_jsonNames); i++)
        ds_map_add(global.langMapWord, _jsonNames[i], variable_struct_get(_json, _jsonNames[i]));
    
    _textFile = string("{0}/{1}/art.txt", _generalPath, global.language);
    _json = json_parse(loadString(_textFile));
    _jsonNames = variable_struct_get_names(_json);
    
    for (var i = 0; i < array_length(_jsonNames); i++)
    {
        var q = variable_struct_get(_json, _jsonNames[i]);
        var _spritePath = string("{0}/{1}/{2}", _generalPath, global.language, q.path);
        
        if (get_file_extension(_spritePath) == "png")
            ds_map_add(global.langMapArt, _jsonNames[i], sprite_add(_spritePath, 0, false, false, q.xorigin, q.yorigin));
        else
            ds_map_add(global.langMapArt, _jsonNames[i], sprite_add_gif(_spritePath, q.xorigin, q.yorigin));
    }
}

function lang_get_phrase(arg0)
{
    if (ds_map_exists(global.langMapWord, arg0))
        return ds_map_find_value(global.langMapWord, arg0);
    else
        return arg0;
}

function lang_get_asset(arg0)
{
    if (ds_map_exists(global.langMapArt, arg0))
        return ds_map_find_value(global.langMapArt, arg0);
    else
        return -1;
}
