fmod_studio_event_instance_stop(snd, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
fmod_studio_event_instance_release(snd);
ini_open(global.saveFile);

if (ini_read_real("General", string("Totem{0}", totem), false) == false)
{
    obj_savesystem.saveiconTimer = 60;
    obj_totemViewer.goawayTimer = 180;
    obj_totemViewer.totemIndex = totem;
    ini_write_real("General", string("Totem{0}", totem), true);
}

ini_close();
