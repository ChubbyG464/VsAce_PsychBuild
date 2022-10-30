local allowCountdown = false
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        setProperty('inCutscene', true)

if getProperty("bfVersion") == "bf-retro" then
        startDialogue('dialogue-retro', 'dialogueAmbience1')
elseif getProperty("bfVersion") == "bf-ace" then
startDialogue('dialogue-ace', 'dialogueAmbience1')
else
startDialogue('dialogue', 'dialogueAmbience1')
end
        allowCountdown = true
        return Function_Stop
    end
    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startDialogue' then -- Timer completed, play dialogue

    end
end

function onNextDialogue(count)

end

function onSkipDialogue(count)

end

local allowEndShit = false

function onEndSong()
	if not allowEndShit and isStoryMode then
 		setProperty('inCutscene', true);

if getProperty("bfVersion") == "bf-retro" then
        startDialogue('dialogue-retro2', 'dialogueAmbience1')
elseif getProperty("bfVersion") == "bf-ace" then
startDialogue('dialogue-ace2', 'dialogueAmbience1')
else
startDialogue('dialogue2', 'dialogueAmbience1')
end
        allowCountdown = true
        return Function_Stop
    end
    return Function_Continue
end