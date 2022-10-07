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

local icyStage = false
function update()
    if curBeat >= 128 and not icyStage then
        cameraFlash("hud", "0xFFffffff", 0.3)
        setProperty("snowbridge1.alpha", 1)
        setProperty(".alpha", 0)
        icyStage = true
    end
end

function onBeatHit()
    debugPrint(curBeat)
end