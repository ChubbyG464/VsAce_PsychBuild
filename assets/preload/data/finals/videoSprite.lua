--bbpanzu
--[[

you could call it like

addLuaScript('videoSprite')

and it'll pop up right then and there




]]

function onCreate()

	makeLuaSprite('videoSprite','',0,0)
	addLuaSprite('videoSprite')
	scaleObject('videoSprite', 1, 1);
	-- makes the video sprite

	addHaxeLibrary('MP4Handler','vlc')
	addHaxeLibrary('Event','openfl.events')
	--add needed haxe libraries for video and openfl events

	--run the main haxe code
	runHaxeCode([[

		var filepath = Paths.video('finals');
		//get the video path
		
		var video = new MP4Handler();
		//create the video object

		video.playVideo(filepath);
		//play the video file

		video.visible = false;
		//make the video object overlay invisible

		setVar('video',video);
		//set global variable

		FlxG.stage.removeEventListener('enterFrame', video.update); 
		//removes the native update event the video has (disables skipping pressing enter)
	]])


end

function onUpdatePost()


	--run the main haxe code
	runHaxeCode([[
		var video = getVar('video');
		//get video object variable

		game.getLuaObject('videoSprite').loadGraphic(video.bitmapData);
		//set video sprite's graphic as the video's bitmap data
		
		if(game.paused)video.pause();
		//pause video if the game is paused

	]])

end


function onResume()

	--run the main haxe code
	runHaxeCode([[
		var video = getVar('video');
		//get video object variable

		video.resume();
		//resume video when game is resumed
	]])

end