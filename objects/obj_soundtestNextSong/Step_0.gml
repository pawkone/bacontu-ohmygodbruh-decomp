if (place_meeting(x, y, obj_player))
{
    with (obj_player)
    {
        if (key_up2)
        {
            with (obj_soundtestPlayer)
            {
                fmod_studio_event_instance_stop(songInst, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
                fmod_studio_event_instance_release(songInst);
                songInst = -4;
                currentSong++;
                currentSong = wrap(currentSong, 0, array_length(songs) - 1);
                playing = false;
            }
            
            with (other)
            {
                image_index = 1;
                alarm[0] = 5;
            }
        }
    }
}
