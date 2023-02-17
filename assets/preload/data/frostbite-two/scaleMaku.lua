function onUpdatePost() runHaxeCode([[
for(c in[game.dad, game.dadMap.get("maku")])if(c!=null&&c.curCharacter=="maku"){
c.scale.set(1.3, 1.3);
c.scaledOffset = true;
}]]) end