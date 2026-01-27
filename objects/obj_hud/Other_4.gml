switch (global.level)
{
    case "forest":
        global.Srank = 22000;
        tv.backindex = 0;
        break;
    
    case "shell":
        global.Srank = 30000;
        tv.backindex = 1;
        break;
    
    default:
        global.Srank = 0;
        tv.backindex = 0;
        break;
}
