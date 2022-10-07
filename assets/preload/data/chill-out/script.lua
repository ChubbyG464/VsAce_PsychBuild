local allowCountdown = false
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        setProperty('inCutscene', true)
        startDialogue('dialogue', 'dialogueAmbience1')
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
 		startDialogue('dialogue2', 'dialogueAmbience1'); 
  		allowEndShit = true;
	return Function_Stop;
end
	return Function_Continue;
end