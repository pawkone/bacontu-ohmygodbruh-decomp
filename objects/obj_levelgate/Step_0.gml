bgalpha = 1 - (distance_to_object(obj_player) / visibleradius);
ini_open(global.saveFile);
var _completed = ini_read_string(level, "Rank", "NONE") != "NONE";
ini_close();

if (scoreViewer == -4 && distance_to_object(obj_player) < 300 && level != "tutorial" && _completed)
{
    scoreViewer = instance_create(x + 12, camera_get_view_y(view_camera[0]) - 200, obj_scoreHub);
    
    with (scoreViewer)
    {
        targetY = other.y - 175;
        ini_open(global.saveFile);
        var _level = other.level;
        collect = ini_read_real(_level, "Highscore", 0);
        var _rank = ini_read_string(_level, "Rank", "D");
        
        if (_rank == "D")
            rankIndex = 0;
        
        if (_rank == "C")
            rankIndex = 1;
        
        if (_rank == "B")
            rankIndex = 2;
        
        if (_rank == "A")
            rankIndex = 3;
        
        if (_rank == "S")
            rankIndex = 4;
        
        if (_rank == "P")
            rankIndex = 5;
        
        ini_close();
    }
}
