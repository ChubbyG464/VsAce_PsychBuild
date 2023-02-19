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
	runTimer("closeScript", 0.1)
	return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'closeScript' then -- Timer completed, play dialogue
		close(true)
	end
end

function onNextDialogue(count)

end

function onSkipDialogue(count)

end