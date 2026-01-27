x = 0;
y = 0;
depth = 15;
ds_list_clear(global.saveroom);
ds_list_clear(global.escaperoom);
ds_list_clear(global.followers);
canContinue = false;
fadeAlpha = 0;
cutscenePart = 0;
obj_player.state = -4;
global.combo.timer = 0;
showRank = false;
showRankText = false;
rankIndex = 0;
tutorial = global.level == "tutorial";

if (tutorial && global.level_timer < 60)
{
    ini_open(global.saveFile);
    
    if (ini_read_real("General", "Lap", false) == false)
    {
        scr_transfotip("[wave]All lap 2 portals unlocked!");
        ini_write_real("General", "Lap", true);
    }
    
    ini_close();
}

whitefade = 0;
blackfade = 0;
showWhite = false;
showBlack = false;

with (obj_music)
{
    stop_music();
    
    if (FMODevent_isplaying(escapeInst))
        fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
}

global.escape.active = false;
global.escape.timer = 7200;
FMODstopAll();
var _rankIndex = 0;

if (global.collect >= global.Crank)
    _rankIndex = 1;

if (global.collect >= global.Brank)
    _rankIndex = 2;

if (global.collect >= global.Arank)
    _rankIndex = 3;

if (global.collect >= global.Srank)
    _rankIndex = 4;

if (scr_Prank())
    _rankIndex = 5;

music = FMODcreate_event("event:/Music/General/ranks");

if (!tutorial)
{
    fmod_studio_event_instance_set_parameter_by_name(music, "state", _rankIndex);
    fmod_studio_event_instance_start(music);
}

rankspr = spr_rankD;
ranktextSpr = lang_get_asset("spr_rankD_text");
var _col = 7884848;
var _col2 = 4729105;
gotoBackground = 0;

switch (_rankIndex)
{
    case 0:
        gotoBackground = 1;
        rankspr = spr_rankD;
        ranktextSpr = lang_get_asset("spr_rankD_text");
        _col = 7884848;
        _col2 = 4729105;
        break;
    
    case 1:
        gotoBackground = 2;
        rankspr = spr_rankC;
        ranktextSpr = lang_get_asset("spr_rankC_text");
        _col = 4771936;
        _col2 = 28672;
        break;
    
    case 2:
        gotoBackground = 3;
        rankspr = spr_rankB;
        ranktextSpr = lang_get_asset("spr_rankB_text");
        _col = 16295984;
        _col2 = 11030568;
        break;
    
    case 3:
        gotoBackground = 4;
        rankspr = spr_rankA;
        ranktextSpr = lang_get_asset("spr_rankA_text");
        _col = 248;
        _col2 = 80;
        break;
    
    case 4:
        gotoBackground = 5;
        rankspr = spr_rankS;
        ranktextSpr = lang_get_asset("spr_rankS_text");
        _col = 37088;
        _col2 = 10392;
        break;
    
    case 5:
        rankspr = spr_rankP;
        ranktextSpr = -4;
        _col = 10423551;
        _col2 = 5179331;
        break;
}

uniform1 = shader_get_uniform(shd_fullshade, "lightest");
uniform2 = shader_get_uniform(shd_fullshade, "darkest");
rankSurf = -4;
col = [color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255];
col2 = [color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255];
colorAlpha = 0;
ranktimer = tutorial ? 60 : 180;
shake = 0;
textPos = 0;
text = [];
array_push(text, [false, string("SCORE: {0}", global.collect)]);
array_push(text, [false, string("TIME: {0}", timeString(global.level_timer))]);
array_push(text, [false, "DAMAGE: DUMMY"]);
array_push(text, [false, string("HIGHEST COMBO: {0}", global.combo.highest)]);
toppinPos = 0;
toppins = [];
array_push(toppins, [false, global.toppins.bean, obj_screensizer.displayHeight, 0]);
array_push(toppins, [false, global.toppins.cup, obj_screensizer.displayHeight, 1]);
array_push(toppins, [false, global.toppins.lime, obj_screensizer.displayHeight, 2]);
array_push(toppins, [false, global.toppins.bag, obj_screensizer.displayHeight, 3]);
array_push(toppins, [false, global.toppins.orange, obj_screensizer.displayHeight, 4]);
backgroundX = 0;
backgroundY = 0;
backgroundAlpha = 0;
backgroundIndex = 0;
showBackground = false;

if (!tutorial)
    alarm[3] = 35;

destroy = false;
