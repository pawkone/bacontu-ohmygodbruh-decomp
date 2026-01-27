instance_destroy();
global.pumpkins.count++;
create_particleStatic(spr_genericpoofeffect, x, y, 1, -60);
scr_transfotip(string("[wave]There are {0} Pumpkins Left...", global.pumpkins.amount - global.pumpkins.count));
