if (show == false)
    textY = approach(textY, -64, 2);
else
    textY = approach(textY, 27, 10);

visible = text != "";

switch (room)
{
    default:
        text = "";
        break;
    
    case hotel_receptionentrance:
    case hotel_1:
        text = lang_get_phrase(string("roomname_{0}", room_get_name(room)));
        break;
}
