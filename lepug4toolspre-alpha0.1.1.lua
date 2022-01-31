local imgui = require 'imgui'
local key = require 'vkeys'
local main_window_state = imgui.ImBool(false)
function imgui.OnDrawFrame()
  if main_window_state.v then
    imgui.SetNextWindowSize(imgui.ImVec2(150, 200), imgui.Cond.FirstUseEver)
    imgui.Begin('Tools by Lepug4', main_window_state)
	img = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\images\\pes.jpg")
imgui.Image(img, imgui.ImVec2(274, 184))
    if imgui.Button('Teleport') then
     result, posX, posY, posZ = getTargetBlipCoordinates()
		sampAddChatMessage('Teleport complete.Have a good day:)')
        if result then
            setCharCoordinates(PLAYER_PED, posX, posY, posZ)
        end
      printStringNow("You are cheater!!!Please don't use cheats on not your server!!!", 1000)
    end
	if imgui.Button('randomid') then
	math.randomseed(os.time())
	rand = math.random(0,1000)
	sampAddChatMessage(rand)
	end
	if imgui.Button('reload Scripts') then
	reloadScripts()
	end
	if imgui.Button('test') then
	sampDisconnectWithReason(0)
	end
    imgui.End()
  end
end

function main()
  while true do
    wait(0)
    if wasKeyPressed(key.VK_X) then
        main_window_state.v = not main_window_state.v
    end
    imgui.Process = main_window_state.v
  end
end
