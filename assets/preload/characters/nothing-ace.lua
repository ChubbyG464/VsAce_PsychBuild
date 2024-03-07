function onCreatePost()
	setPropertyFromClass("states.substates.GameOverSubstate", "characterName", "bf-retry");
	setPropertyFromClass("states.substates.GameOverSubstate", "deathSoundName", "ace_death");
	setPropertyFromClass("states.substates.GameOverSubstate", "loopSoundName", "GameOver");
	setPropertyFromClass("states.substates.GameOverSubstate", "endSoundName", "GameOverEnd");
	close(true)
end