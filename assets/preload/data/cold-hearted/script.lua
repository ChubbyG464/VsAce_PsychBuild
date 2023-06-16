function onCreatePost()
	setProperty("camFollowPos.x", getProperty("camFollow.x") - 5)
	setProperty("camFollowPos.y", getProperty("camFollow.y") - 50)
end

local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not isStoryMode and not seenCutscene then
		setProperty('inCutscene', true)

		startDialogue('dialogue', 'dialogueAmbience1')

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