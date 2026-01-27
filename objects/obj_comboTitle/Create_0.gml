scale = 1;
fade = false;
depth = obj_hud.depth - 5;
alarm[0] = 120;
lostcombo = false;
x = obj_screensizer.displayWidth - 149;
very = false;
combo = 0;
frame = combo;
maxframe = frame + 1;
image_speed = 0;

getProper = function(arg0)
{
    var _frame = 0;
    
    switch (arg0)
    {
        case 0:
            _frame = 0;
            break;
        
        case 1:
            _frame = 2;
            break;
        
        case 2:
            _frame = 4;
            break;
        
        case 3:
            _frame = 6;
            break;
        
        case 4:
            _frame = 8;
            break;
        
        case 5:
            _frame = 10;
            break;
        
        case 6:
            _frame = 12;
            break;
        
        case 7:
            _frame = 14;
            break;
        
        case 8:
            _frame = 16;
            break;
        
        case 9:
            _frame = 18;
            break;
        
        case 10:
            _frame = 20;
            break;
        
        case 11:
            _frame = 22;
            break;
        
        case 12:
            _frame = 24;
            break;
        
        case 13:
            _frame = 26;
            break;
        
        case 14:
            _frame = 28;
            break;
    }
    
    return _frame;
};

points = 0;
