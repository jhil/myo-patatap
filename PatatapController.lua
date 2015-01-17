scriptId = 'com.bgoti.patatap'
scriptTitle = "Patatap Controller"
scriptDetailsUrl = ""

function onForegroundWindowChange(app, title)
    -- myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    appTitle = title
    if appTitle == "Patatap" then
    	myo.setLockingPolicy("none")
    	-- myo.debug("UNLOCKED")
    else
    	myo.setLockingPolicy("standard")
    	-- myo.debug("LOCKED")
    end
    return true
end

function activeAppName()
	return appTitle
end

function onPoseEdge(pose, edge)
	-- myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
	
	pose = conditionallySwapWave(pose)
	
    -- if (pose ~= "rest" and pose ~= "unknown") then
    --     -- hold if edge is on, timed if edge is off
    --     myo.unlock(edge == "off" and "timed" or "hold")
    -- end
    
    -- local keyEdge = edge == "off" and "up" or "down"
    
	if (pose == "waveOut") then
		onWaveOut(keyEdge)		
	elseif (pose == "waveIn") then
		onWaveIn(keyEdge)
	elseif (pose == "fist") then
		onFist(keyEdge)
    elseif (pose == "fingersSpread") then
		onFingersSpread(keyEdge)			
	end
end
 
function onWaveOut(keyEdge)
	myo.debug("Glitch")
	myo.vibrate("short")
	myo.keyboard("u",keyEdge)
	myo.keyboard("x",keyEdge)
end
 
function onWaveIn(keyEdge)
	myo.debug("Snare")
    myo.vibrate("short")
    myo.keyboard("a", keyEdge)
    myo.keyboard("o", keyEdge)
end

 
function onFist(keyEdge)
    myo.debug("Bass")    
    myo.vibrate("short")
    myo.keyboard("c",keyEdge)
    myo.keyboard("j",keyEdge)
end
 
function onFingersSpread(keyEdge)
    myo.debug("Bell")
    myo.vibrate("short")
    myo.keyboard("k", keyEdge)
    myo.keyboard("m", keyEdge)
end

function conditionallySwapWave(pose)
	if myo.getArm() == "left" then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end
    end
    return pose
end