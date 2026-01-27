depth = obj_screensizer.depth + 200;
active = false;
graphBorderSize = 2;
graphBack = 
{
    alpha: 0,
    x: 0,
    y: 0
};
bacon = 
{
    index: 0,
    x: -224,
    y: 736,
    smokeIndex: 0
};
screenSprite = -4;
pauseMusic = FMODcreate_event("event:/Music/General/pause");
vinylSND = FMODcreate_event("event:/Sfx/vinyl");
selected = 0;
options = [];
hearts = [];
buffer = 0;
tipText = "";
playerPalSprite = spr_playerPal;
playerPalIndex = 0;
heartFind = 1;
isMilton = false;
character = chars.mildred;

function create_heart(arg0, arg1, arg2)
{
    var q = 
    {
        index: 0,
        sprite: arg2 ? spr_pauseHeart_full : spr_pauseHeart_empty,
        x: arg0,
        xstart: arg0,
        y: arg1,
        alpha: 0,
        fadeout: false,
        fadeoutTimer: 60
    };
    array_push(hearts, q);
}

alarm[0] = 60;

function doPause()
{
    fmod_studio_event_instance_set_parameter_by_name(pauseMusic, "state", obj_player.character == chars.milton);
    playeractiveState = obj_player.state;
    playerPalIndex = obj_player.palIndex;
    character = obj_player.character;
    isMilton = obj_player.character == chars.milton;
    active = true;
    FMODsetPauseAll(true);
    
    if (sprite_exists(screenSprite))
        sprite_delete(screenSprite);
    
    screenSprite = sprite_create_from_surface(obj_screensizer.gameSurface, 0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false, false, 0, 0);
    instance_deactivate_all(true);
    instance_activate_object(obj_inputController);
    instance_activate_object(obj_screensizer);
    instance_activate_object(obj_fmod);
    instance_activate_object(obj_shell);
    instance_activate_object(obj_rpc);
    instance_activate_object(obj_globaltimer);
    instance_activate_object(obj_savesystem);
    fmod_studio_event_instance_start(pauseMusic);
    fmod_studio_event_instance_set_paused(pauseMusic, false);
    fmod_studio_event_instance_start(vinylSND);
    fmod_studio_event_instance_set_paused(vinylSND, false);
    fmod_studio_system_set_parameter_by_name("musicfade", 0, false);
    graphBack.alpha = 0;
    selected = 0;
    
    switch (playeractiveState)
    {
        case states.ski:
            tipText = lang_get_phrase("tip_ski");
            break;
        
        case states.surfing:
            tipText = lang_get_phrase("tip_surf");
            break;
        
        default:
            tipText = "";
            break;
    }
}

function doUnpause()
{
    instance_activate_all();
    FMODsetPauseAll(false);
    fmod_studio_event_instance_stop(pauseMusic, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
    fmod_studio_event_instance_stop(vinylSND, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
    
    with (obj_music)
    {
        fmod_studio_event_instance_set_paused(escapeInst, isSecret);
        fmod_studio_event_instance_set_paused(musicInst, isSecret || FMODevent_isplaying(escapeInst));
        fmod_studio_event_instance_set_paused(secretInst, !isSecret);
    }
    
    active = false;
}

var _resume = 
{
    option: "pause_resume",
    
    func: function()
    {
        with (obj_pause)
            doUnpause();
    }
};
var _restart = 
{
    option: "pause_restart",
    
    func: function()
    {
        with (obj_pause)
        {
            if (global.resetRoom != -4)
            {
                if (instance_exists(obj_backtohub))
                    instance_destroy(obj_backtohub);
                
                doUnpause();
                
                with (obj_music)
                {
                    stop_music();
                    
                    if (FMODevent_isplaying(escapeInst))
                        fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
                }
                
                with (obj_player)
                {
                    generalReset();
                    door = "A";
                    movespeed = 0;
                    vsp = 0;
                    hsp = 0;
                    state = states.enterdoor;
                }
                
                room_goto(global.resetRoom);
            }
        }
    }
};
var _option = 
{
    option: "pause_options",
    
    func: function()
    {
        FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect");
        instance_create(0, 0, obj_option);
    }
};
var _exitlevel = 
{
    option: "pause_exit",
    
    func: function()
    {
        with (obj_pause)
        {
            doUnpause();
            
            if (instance_exists(obj_backtohub))
                instance_destroy(obj_backtohub);
            
            with (obj_player)
            {
                if (global.level == -4)
                {
                    with (obj_music)
                        stop_music();
                    
                    generalReset();
                    movespeed = 0;
                    vsp = 0;
                    hsp = 0;
                    state = -4;
                    door = "A";
                    room_goto(Mainmenu);
                }
                else
                {
                    with (obj_music)
                        stop_music();
                    
                    generalReset();
                    movespeed = 0;
                    vsp = 0;
                    hsp = 0;
                    state = -4;
                    door = "NONE";
                    room_goto(backtohubRoom);
                    instance_create(x, y, obj_backtohub);
                    global.level = -4;
                    global.resetRoom = -4;
                }
            }
        }
    }
};
_resume.offsetX = obj_screensizer.displayWidth;
_option.offsetX = obj_screensizer.displayWidth;
_restart.offsetX = obj_screensizer.displayWidth;
_exitlevel.offsetX = obj_screensizer.displayWidth;
array_push(options, _resume);
array_push(options, _option);
array_push(options, _restart);
array_push(options, _exitlevel);
timeUniform = shader_get_uniform(shd_wave, "time");
frequencyUniform = shader_get_uniform(shd_wave, "frequency");
amplitudeUniform = shader_get_uniform(shd_wave, "amplitude");
waveTime = 0;
freq = 0.01;
amp = 0.009;
