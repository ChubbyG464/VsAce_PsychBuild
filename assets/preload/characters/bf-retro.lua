function onCreatePost()
	setPropertyFromClass("states.substates.GameOverSubstate", "characterName", "bf-retro");
	setPropertyFromClass("states.substates.GameOverSubstate", "deathSoundName", "fnf_loss_sfx");
	setPropertyFromClass("states.substates.GameOverSubstate", "loopSoundName", "GameOver");
	setPropertyFromClass("states.substates.GameOverSubstate", "endSoundName", "GameOverEnd");
	close(true)
end