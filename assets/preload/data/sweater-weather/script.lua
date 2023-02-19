function onCreate()
    setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-retry');
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx');
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

    --setProperty("boyfriendCameraOffset", {-285, 30})
    setProperty("opponentCameraOffset", {350, 0})
    close(true)
end