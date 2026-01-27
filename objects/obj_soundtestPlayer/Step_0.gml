if (place_meeting(x, y, obj_player))
{
    with (obj_player)
    {
        if (key_up2)
        {
            with (other)
            {
                if (songInst == -4)
                {
                    var _song = songs[currentSong];
                    songInst = FMODcreate_event(_song.event);
                    fmod_studio_event_instance_start(songInst);
                }
                
                playing = (playing == true) ? false : true;
                show_debug_message(string("Playing? {0}", playing));
                image_index = 1;
                alarm[0] = 5;
            }
        }
    }
}

if (songInst != -4)
    fmod_studio_event_instance_set_paused(songInst, !playing);
