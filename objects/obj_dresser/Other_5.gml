var _save = save_to_ini("Game", "Palette", obj_player.palIndex, global.saveFile) + save_to_ini("Game", "Pattern", sprite_get_name(global.patternSpr), global.saveFile);

if (_save > 0)
    obj_savesystem.saveiconTimer = 60;
