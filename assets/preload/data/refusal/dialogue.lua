local dialogues = {
    -- Background, file, music
    {"bg1", "dialogue1", "news"},
    {"bg", "dialogue", "amb"},
}
local dialogueI = 0
local currentDialogue = nil
local lineCount = 0
function onStartCountdown()
    -- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
    if dialogueI ~= #dialogues and isStoryMode and not seenCutscene then
        currentDialogue = dialogues[dialogueI+1]
        removeLuaSprite('dialoguebg', true);
        makeLuaSprite('dialoguebg', currentDialogue[1], 0, 0)
        setGraphicSize('dialoguebg', 1280);
        screenCenter('dialoguebg');
        addLuaSprite('dialoguebg', true);
        setProperty('inCutscene', true);
        runTimer('startDialogue', 0.8);
        setScrollFactor("dialoguebg", 0, 0)
        setObjectCamera("dialoguebg", "hud")
        dialogueI = dialogueI + 1;
        return Function_Stop;
    end
    removeLuaSprite('dialoguebg', true);
    return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startDialogue' then -- Timer completed, play dialogue
        startDialogue(currentDialogue[2], currentDialogue[3]);
    end
end