dofile("script/SceneStartWM.lua")
dofile("script/SceneAboutWM.lua")
dofile("script/ScenePlayWM.lua")

-- һ�Ѷ���������
local directorWM = share:director() -- һ����Ϸ��ֻ����һ�� director
local sceneWM = SceneMainMenu()
directorWM:run(sceneWM)