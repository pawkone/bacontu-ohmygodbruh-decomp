if (target == -4)
{
    var _found = false;
    var _objPl = -4;
    
    for (var i = 0; i < instance_number(obj_onlinePlayer); i++)
    {
        var obj = instance_find(obj_onlinePlayer, i);
        
        if (obj.onlineID == onlineID)
        {
            _found = true;
            _objPl = obj;
        }
    }
    
    if (_found)
        target = _objPl;
}
else if (target.state != states.taunt)
{
    instance_destroy();
}
