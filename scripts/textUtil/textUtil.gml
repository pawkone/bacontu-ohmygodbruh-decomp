function scr_compileIconText(arg0)
{
    var _keyFunc = function(arg0, arg1, arg2 = spr_tutorialkeyspecial) constructor
    {
        isKey = arg0;
        value = arg1;
        sprite = arg2;
    };
    
    var _inputFind = "";
    var _prioritizeInput = global.gamepadConnected;
    
    switch (arg0)
    {
        case "U":
            _inputFind = "up";
            break;
        
        case "D":
            _inputFind = "down";
            break;
        
        case "L":
            _inputFind = "left";
            break;
        
        case "R":
            _inputFind = "right";
            break;
        
        case "Q":
            _inputFind = "attack";
            break;
        
        case "J":
            _inputFind = "jump";
            break;
        
        case "G":
            _inputFind = "slap";
            break;
        
        case "T":
            _inputFind = "taunt";
            break;
        
        case "S":
            _inputFind = "start";
            break;
    }
    
    if (array_length(variable_struct_get(global.inputMap, string("Inputs_Player1_{0}Key", _inputFind))) <= 0)
        return new _keyFunc(false, " ");
    
    var _inputKey = [array_get(variable_struct_get(global.inputMap, string("Inputs_Player1_{0}Key", _inputFind)), 0), array_get(variable_struct_get(global.inputMap, string("Inputs_Player1_{0}Pad", _inputFind)), 0)];
    var _inputKeystring = chr(_inputKey[_prioritizeInput]);
    var _key = -4;
    
    if (_prioritizeInput == 0)
    {
        switch (_inputKey[0])
        {
            case 37:
                _key = new _keyFunc(true, 6);
                break;
            
            case 40:
                _key = new _keyFunc(true, 4);
                break;
            
            case 38:
                _key = new _keyFunc(true, 3);
                break;
            
            case 39:
                _key = new _keyFunc(true, 5);
                break;
            
            case 32:
                _key = new _keyFunc(true, 2);
                break;
            
            case 17:
                _key = new _keyFunc(true, 1);
                break;
            
            case 27:
                _key = new _keyFunc(true, 7);
                break;
            
            case 16:
                _key = new _keyFunc(true, 0);
                break;
            
            default:
                _key = new _keyFunc(false, _inputKeystring);
                break;
        }
    }
    
    if (_prioritizeInput == 1)
    {
        switch (_inputKey[1])
        {
            case 32769:
                _key = new _keyFunc(true, 0, global.buttonSpr);
                break;
            
            case 32770:
                _key = new _keyFunc(true, 1, global.buttonSpr);
                break;
            
            case 32771:
                _key = new _keyFunc(true, 2, global.buttonSpr);
                break;
            
            case 32772:
                _key = new _keyFunc(true, 3, global.buttonSpr);
                break;
            
            case 32773:
                _key = new _keyFunc(true, 4, global.buttonSpr);
                break;
            
            case 32774:
                _key = new _keyFunc(true, 5, global.buttonSpr);
                break;
            
            case 32776:
                _key = new _keyFunc(true, 6, global.buttonSpr);
                break;
            
            case 32775:
                _key = new _keyFunc(true, 7, global.buttonSpr);
                break;
            
            case 32779:
                _key = new _keyFunc(true, 8, global.buttonSpr);
                break;
            
            case 32780:
                _key = new _keyFunc(true, 9, global.buttonSpr);
                break;
            
            case 32781:
                _key = new _keyFunc(true, 10, global.buttonSpr);
                break;
            
            case 32784:
                _key = new _keyFunc(true, 11, global.buttonSpr);
                break;
            
            case 32782:
                _key = new _keyFunc(true, 12, global.buttonSpr);
                break;
            
            case 32783:
                _key = new _keyFunc(true, 13, global.buttonSpr);
                break;
            
            case 32778:
                _key = new _keyFunc(true, 14, global.buttonSpr);
                break;
            
            case 32777:
                _key = new _keyFunc(true, 15, global.buttonSpr);
                break;
            
            case "joyLL":
                _key = new _keyFunc(true, 0, global.joystickSpr);
                break;
            
            case "joyLR":
                _key = new _keyFunc(true, 1, global.joystickSpr);
                break;
            
            case "joyLU":
                _key = new _keyFunc(true, 2, global.joystickSpr);
                break;
            
            case "joyLD":
                _key = new _keyFunc(true, 3, global.joystickSpr);
                break;
            
            case "joyRL":
                _key = new _keyFunc(true, 4, global.joystickSpr);
                break;
            
            case "joyRR":
                _key = new _keyFunc(true, 5, global.joystickSpr);
                break;
            
            case "joyRU":
                _key = new _keyFunc(true, 6, global.joystickSpr);
                break;
            
            case "joyRD":
                _key = new _keyFunc(true, 7, global.joystickSpr);
                break;
        }
    }
    
    return _key;
}

global.textCache = ds_map_create();
global.textFunc = ds_map_create();

function parse_textEX(arg0, arg1)
{
    var _stringArr = [];
    var _lines = [];
    var _line = 0;
    var _lX = 0;
    var _lY = 0;
    var _effect = -4;
    var newWord = false;
    
    for (var i = 1; i <= string_length(arg0); i++)
    {
        var _letter = string_char_at(arg0, i);
        var _word = "";
        
        if (_letter == " ")
        {
            newWord = true;
        }
        else if (newWord == true && _letter != " ")
        {
            for (var c = i; true; c++)
            {
                var _lt = string_char_at(arg0, c);
                
                if (_lt == " " || c >= string_length(arg0))
                {
                    newWord = false;
                    break;
                }
                
                _word += _lt;
            }
        }
        
        if ((_lX + string_width(_word)) >= arg1)
        {
            _line += 1;
            _lX = 0;
            _lY += string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
            array_push(_lines, 
            {
                w: _lX
            });
        }
        
        var _str = 
        {
            specialType: -4,
            letter: _letter,
            ogx: _lX,
            ogy: _lY,
            x: _lX,
            y: _lY,
            effect: _effect,
            line: _line
        };
        
        switch (_letter)
        {
            case "#":
                array_push(_lines, 
                {
                    w: _lX
                });
                _line += 1;
                _lX = 0;
                _lY += string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
                break;
            
            case "[":
                var containedStr = "";
                var c = i + 1;
                
                while (true)
                {
                    var _lt = string_char_at(arg0, c);
                    
                    if (_lt == "]")
                    {
                        i = c;
                        break;
                    }
                    
                    containedStr += _lt;
                    c++;
                }
                
                if (string_pos("global.", containedStr) > 0)
                {
                    var _gl = string_split(containedStr, "global.", true, 1);
                    _str.letter = variable_global_get(_gl[0]);
                    _lX += (string_width(_str.letter) + 1);
                    array_push(_stringArr, _str);
                }
                else
                {
                    switch (containedStr)
                    {
                        case "L":
                        case "R":
                        case "U":
                        case "D":
                        case "G":
                        case "Q":
                        case "J":
                        case "T":
                        case "S":
                            _str.specialType = "controlKey";
                            var q = scr_compileIconText(containedStr);
                            _str.keyDet = q;
                            _lX += sprite_get_width(q.sprite);
                            array_push(_stringArr, _str);
                            break;
                        
                        case "wave":
                        case "shake":
                            _effect = containedStr;
                            break;
                        
                        case "clear":
                            _effect = -4;
                            break;
                        
                        case "Bacontu":
                            _str.specialType = "Bacontu";
                            _lX += sprite_get_width(spr_ico);
                            array_push(_stringArr, _str);
                            break;
                    }
                }
                
                break;
            
            default:
                if (!(_lX == 0 && _letter == " "))
                    _lX += string_width(_letter);
                
                array_push(_stringArr, _str);
                break;
        }
    }
    
    array_push(_lines, 
    {
        w: _lX
    });
    return [_stringArr, _lines, _lY];
}

function draw_textEX(arg0, arg1, arg2, arg3 = string_width(arg2))
{
    var exists = ds_map_exists(global.textFunc, arg2);
    
    if (!ds_map_exists(global.textCache, arg2))
    {
        ds_map_add(global.textCache, arg2, parse_textEX(arg2, arg3));
        show_debug_message(string("Added {0} to cache", arg2));
    }
    
    var func = function(arg0, arg1, arg2, arg3 = string_width(arg2))
    {
        var _stringArr = array_get(ds_map_find_value(global.textCache, arg2), 0);
        var _lines = array_get(ds_map_find_value(global.textCache, arg2), 1);
        var _pHAlign = draw_get_halign();
        var _pVAlign = draw_get_valign();
        var _pFont = draw_get_font();
        var _pColor = draw_get_color();
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        
        for (var i = 0; i < array_length(_stringArr); i++)
        {
            var _lDat = _stringArr[i];
            var _lType = _lDat.specialType;
            var _XX = arg0 + _lDat.x;
            var _YY = arg1 + _lDat.y;
            
            switch (_pHAlign)
            {
                case 1:
                    _lDat.x = _lDat.ogx - (_lines[_lDat.line].w / 2);
                    break;
                
                case 2:
                    _lDat.x = _lDat.ogx - _lines[_lDat.line].w;
                    break;
            }
            
            switch (_pVAlign)
            {
                case 1:
                    _lDat.y = _lDat.ogy / 2;
                    break;
                
                case 2:
                    _lDat.y = _lDat.ogy - _lDat.ogy;
                    break;
            }
            
            switch (_lDat.effect)
            {
                default:
                    _XX = arg0 + _lDat.x;
                    _YY = arg1 + _lDat.y;
                    break;
                
                case "shake":
                    _XX = arg0 + _lDat.x + irandom_range(-1, 1);
                    _YY = arg1 + _lDat.y + irandom_range(-1, 1);
                    break;
                
                case "wave":
                    _XX = arg0 + _lDat.x;
                    _YY = arg1 + _lDat.y + irandom_range(-1, 1);
                    break;
            }
            
            _XX = floor(_XX);
            _YY = floor(_YY);
            
            switch (_lType)
            {
                case -4:
                    draw_text(_XX, _YY, _lDat.letter);
                    break;
                
                case "Bacontu":
                    draw_sprite(spr_ico, 0, _XX - 2, _YY - 7);
                    break;
                
                case "controlKey":
                    if (_lDat.keyDet.isKey)
                    {
                        draw_sprite(_lDat.keyDet.sprite, _lDat.keyDet.value, _XX - 8, _YY + 2);
                    }
                    else
                    {
                        draw_sprite(spr_tutorialkey, 0, _XX - 8, _YY + 2);
                        draw_set_color(c_black);
                        draw_set_font(global.npcfont);
                        draw_text(_XX, _YY - 6, _lDat.keyDet.value);
                        draw_set_color(_pColor);
                        draw_set_font(_pFont);
                    }
                    
                    break;
            }
        }
        
        draw_set_halign(_pHAlign);
        draw_set_valign(_pVAlign);
    };
    
    if (!exists)
    {
        func(arg0, arg1, arg2, arg3 == string_width(arg2));
        ds_map_add(global.textFunc, arg2, func);
    }
    else
    {
        var draw = ds_map_find_value(global.textFunc, arg2);
        draw(arg0, arg1, arg2, arg3 == string_width(arg2));
    }
    
    return false;
}

function text_clear(arg0 = "")
{
    if (arg0 != "")
        ds_map_delete(global.textCache, arg0);
    else
        ds_map_clear(global.textCache);
}
