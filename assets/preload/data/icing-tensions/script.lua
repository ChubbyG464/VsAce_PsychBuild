local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true)
		startDialogue('dialogue', 'minusAmbience')
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