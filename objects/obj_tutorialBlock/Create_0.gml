event_inherited();
ini_open(global.saveFile);

if (ini_read_string("tutorial", "Rank", "NONE") != "NONE")
{
    if (ini_read_real("Cutscenes", "TutorialBlock", false) == false)
    {
        alarm[0] = 90;
        ini_write_real("Cutscenes", "TutorialBlock", true);
    }
    else
    {
        instance_destroy();
    }
}

ini_close();
