function onCreatePost()
    makeLuaSprite("zoom", "", 0, 0)
    setProperty("zoom.x", getProperty("defaultCamZoom"))
end

function onEvent(ev, v1, v2)
	if ev == "Slow Zoom" then
		local zoom = tonumber(v1)
		local time = tonumber(v2)
		if time <= 0 then
			cancelTween("zoomx")
			setProperty("zoom.x", zoom)
		else
			doTweenX('zoomx', 'zoom', zoom, time)
		end
	end
end

function onUpdate(elapsed)
    setProperty("defaultCamZoom", getProperty("zoom.x"))
end