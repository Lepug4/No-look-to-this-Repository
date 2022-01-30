local imgui = require 'imgui'
local key = require 'vkeys'

-- одно из основных отличий от оригинального апи
-- все переменные, значения которых записываются в ImGui по указателю, могут использоваться только через специальные типы
local main_window_state = imgui.ImBool(false)
function imgui.OnDrawFrame()
  if main_window_state.v then -- чтение и запись значения такой переменной осуществляется через поле v (или Value)
    imgui.SetNextWindowSize(imgui.ImVec2(150, 200), imgui.Cond.FirstUseEver) -- меняем размер
    -- но для передачи значения по указателю - обязательно напрямую
    -- тут main_window_state передаётся функции imgui.Begin, чтобы можно было отследить закрытие окна нажатием на крестик
    imgui.Begin('Админ-Панель от Adauqa', main_window_state)
	img = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\images\\pes.jpg")
imgui.Image(img, imgui.ImVec2(274, 184))
imgui.Text('Панель')
    if imgui.Button('Телепорт') then -- а вот и кнопка с действием
     result, posX, posY, posZ = getTargetBlipCoordinates()
		sampAddChatMessage('Teleport complete.Have a good day:)')
        if result then
            setCharCoordinates(PLAYER_PED, posX, posY, posZ)
        else
            sampAddChatMessage('Teleport not completed:(.Please place mark on map!!!')
        end-- условие будет выполнено при нажатии на неё
      printStringNow("You are cheater!!!Please don't use cheats on not your server!!!", 1000)
    end
	if imgui.Button('рандомный ид') then
	math.randomseed(os.time())
	rand = math.random(0,1000)
	sampSendChat(rand, -1)
	end
	if imgui.Button('Как использовать телепорт') then
	printStringNow("please mark place to map for teleport button", 5000)
	end
	if imgui.Button('Перезагрузить скрипты') then
	reloadScripts()
	end
    imgui.End()
  end
end

function main()
  while true do
    wait(0)
    if wasKeyPressed(key.VK_X) then -- активация по нажатию клавиши X
        main_window_state.v = not main_window_state.v -- переключаем статус активности окна, не забываем про .v
    end
    imgui.Process = main_window_state.v -- теперь значение imgui.Process всегда будет задаваться в зависимости от активности основного окна
  end
end
