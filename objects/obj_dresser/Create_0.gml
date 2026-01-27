depth = 20;
palettes = [];
selected = 0;
textAlpha = 0;
indicatorAlpha = 0;
indicator = false;

addPalette = function(arg0, arg1, arg2, arg3 = true, arg4 = global.PlayerCharacters[obj_player.character].patternSpr)
{
    var q = 
    {
        pName: arg0,
        desc: arg1,
        index: arg2,
        sprite: arg4
    };
    
    if (arg3)
    {
        array_push(palettes, q);
        return q;
    }
};

ini_open(global.saveFile);
addPalette("Retail Wears", "Unlocked by being Tu", 1, true);
addPalette("Mint Wears", "A Housewarming Gift", 10, true);
addPalette("Red Wears", "Unlocked by ???", 2, true);
addPalette("Orange Wears", "Unlocked by ???", 3, true);
addPalette("Blue Wears", "Unlocked by ???", 4, true);
addPalette("Yellow Wears", "Unlocked by ???", 5, true);
addPalette("Teal Wears", "Unlocked by ???", 6, true);
addPalette("Purple Wears", "Unlocked by ???", 7, true);
addPalette("Pristine Wears", "Unlocked by ???", 8, true);
addPalette("Darker Wears", "Unlocked by ???", 9, true);
ini_close();

for (var i = 0; i < array_length(palettes); i++)
{
    var q = palettes[i].index;
    var p = palettes[i].sprite;
    
    if (q == obj_player.palIndex && p == global.patternSpr)
    {
        selected = i;
        break;
    }
}
