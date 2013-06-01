-- ���鼯�ϵ�״̬
local BLOCKUNIT_STATE_LIST = 
{
BLOCKUNIT_STATE_NOT = 0,
BLOCKUNIT_STATE_ENABEL = 1
}
-- ��Χ������Ҫ�ı���
local BLOCKMOVE_MOMENT = 60 -- 60 -- ���鼯������ļ��
local BLOCKUNIT_WH = 32 -- �����������Σ����ĳ���
local BLOCK_RECT = Rect2D(-BLOCKUNIT_WH / 2, -BLOCKUNIT_WH / 2, BLOCKUNIT_WH, BLOCKUNIT_WH) -- �����С����
local BLOCK_X_NUM = 10 -- ��Ļ��ˮƽ����ֱ�ķ������
local BLOCK_Y_NUM = 20 -- ��Ļ��ˮƽ����ֱ�ķ������
local BLOCKAREA_OFFSETX = 8 -- �ѷ��������������Ļ��ƫ��
local BLOCKAREA_OFFSETY = 102 -- �ѷ��������������Ļ��ƫ��
-- ������ť����С�����x �� y
local QUADSCROLL_MINX = 26
local QUADSCROLL_MAXX = 313
local QUADSCROLL_Y = 62
-- �仯���鼯�ϵİ�ť������
local RECT_QUADCHANGE = Rect2D(344, 10, 120, 120)
-- ���Կ��Ʒ�������Ų��������
local RECT_BLOCKMOVE = Rect2D(0, 0, 338, 94)
-- ������Դ·����
local BLOCK_QUAD_RES = {
	{res = "textures/game/blockBlue.png"},
	{res = "textures/game/blockCyan.png"},
	{res = "textures/game/blockGreen.png"},
	{res = "textures/game/blockOrange.png"},
	{res = "textures/game/blockPurple.png"},
	{res = "textures/game/blockRed.png"},
	{res = "textures/game/blockYellow.png"},
}
-- ����ƫ�Ʊ�
local N3P3 = {indexX = -3, indexY = 3}
local N2P3 = {indexX = -2, indexY = 3}
local N1P3 = {indexX = -1, indexY = 3}
local P0P3 = {indexX = 0, indexY = 3}
local P1P3 = {indexX = 1, indexY = 3}
local P2P3 = {indexX = 2, indexY = 3}
local P3P3 = {indexX = 3, indexY = 3}

local N3P2 = {indexX = -3, indexY = 2}
local N2P2 = {indexX = -2, indexY = 2}
local N1P2 = {indexX = -1, indexY = 2}
local P0P2 = {indexX = 0, indexY = 2}
local P1P2 = {indexX = 1, indexY = 2}
local P2P2 = {indexX = 2, indexY = 2}
local P3P2 = {indexX = 3, indexY = 2}

local N3P1 = {indexX = -3, indexY = 1}
local N2P1 = {indexX = -2, indexY = 1}
local N1P1 = {indexX = -1, indexY = 1}
local P0P1 = {indexX = 0, indexY = 1}
local P1P1 = {indexX = 1, indexY = 1}
local P2P1 = {indexX = 2, indexY = 1}
local P3P1 = {indexX = 3, indexY = 1}

local N3P0 = {indexX = -3, indexY = 0}
local N2P0 = {indexX = -2, indexY = 0}
local N1P0 = {indexX = -1, indexY = 0}
local P0P0 = {indexX = 0, indexY = 0}
local P1P0 = {indexX = 1, indexY = 0}
local P2P0 = {indexX = 2, indexY = 0}
local P3P0 = {indexX = 3, indexY = 0}

local N3N1 = {indexX = -3, indexY = -1}
local N2N1 = {indexX = -2, indexY = -1}
local N1N1 = {indexX = -1, indexY = -1}
local P0N1 = {indexX = 0, indexY = -1}
local P1N1 = {indexX = 1, indexY = -1}
local P2N1 = {indexX = 2, indexY = -1}
local P3N1 = {indexX = 3, indexY = -1}

local N3N2 = {indexX = -3, indexY = -2}
local N2N2 = {indexX = -2, indexY = -2}
local N1N2 = {indexX = -1, indexY = -2}
local P0N2 = {indexX = 0, indexY = -2}
local P1N2 = {indexX = 1, indexY = -2}
local P2N2 = {indexX = 2, indexY = -2}
local P3N2 = {indexX = 3, indexY = -2}

local N3N3 = {indexX = -3, indexY = -3}
local N2N3 = {indexX = -2, indexY = -3}
local N1N3 = {indexX = -1, indexY = -3}
local P0N3 = {indexX = 0, indexY = -3}
local P1N3 = {indexX = 1, indexY = -3}
local P2N3 = {indexX = 2, indexY = -3}
local P3N3 = {indexX = 3, indexY = -3}
-- ������״��
local SHAPE_BLOCK_LIST = { -- ����Ϊtype �仯������ ��������ĸ��� �仯�� (Ĭ�ϰ���ʱ�뷽����ת,����¼��״����Ҫ������ײ�ж�)
	{ changeNum = 4, blockNum = 4, changeList = {{P0N1, P0P0, P1P0, P2P0}, {P1P0, P0P0, P0P1, P0P2}, {P0P1, P0P0, N1P0, N2P0}, {N1P0, P0P0, P0N1, P0N2}} }, -- done ��ͨ����
	{ changeNum = 4, blockNum = 4, changeList = {{N2P0, N1P0, P0P0, P0N1}, {P1P0, P0P0, P0N1, P0N2}, {P0P1, P0P0, P1P0, P2P0}, {N1P0, P0P0, P0P1, P0P2}} }, -- done ��ͨ����
	{ changeNum = 1, blockNum = 4, changeList = {{P0P0, P1P0, P1P1, P0P1}} }, -- done ��ͨ����
	{ changeNum = 4, blockNum = 4, changeList = {{N1P0, P0P0, P1P0, P0P1}, {P0N1, P0P0, N1P0, P0P1}, {P0N1, N1P0, P0P0, P1P0}, {P0N1, P1P0, P0P0, P0P1}} }, -- done ��ͨ����
	{ changeNum = 2, blockNum = 4, changeList = {{P0N1, P0P0, N1P0, N1P1}, {N1P0, P0P0, P1P1, P0P1}} }, -- done ��ͨ����
	{ changeNum = 2, blockNum = 4, changeList = {{P0N1, P0P0, P1P0, P1P1}, {P1P0, P0P0, P0P1, N1P1}} }, -- done ��ͨ����
	{ changeNum = 2, blockNum = 4, changeList = {{N1P0, P0P0, P1P0, P2P0}, {P0N2, P0N1, P0P0, P0P1}} }, -- done ��ͨ����
	{ changeNum = 1, blockNum = 6, changeList = {{P0P0, N1P0, N2P2, P1P2, N1P1, P0P1}} }, -- done ը��
	{ changeNum = 4, blockNum = 4, changeList = {{P0N1, N1P1, P1P1, P0P0}, {N1N1, P0P0, P1P0, N1P1}, {N1N1, P1N1, P0P0, P0P1}, {P1N1, P0P0, N1P0, P1P1}} }, -- done �仯����1
	{ changeNum = 4, blockNum = 5, changeList = {{N1N1, P0N1, P1N1, P0P0, P0P1}, {P1N1, N1P0, P0P0, P1P0, P1P1}, {P0N1, N1P1, P1P1, P0P0, P0P1}, {N1N1, P0P0, P1P0, N1P0, N1P1}} }, -- done
	{ changeNum = 4, blockNum = 5, changeList = {{N1N1, N1P0, N1P1, P0P1, P1P1}, {P1N1, P0N1, N1N1, N1P0, N1P1}, {N1N1, P0N1, P1N1, P1P0, P1P1}, {P1N1, P1P0, P1P1, P0P1, N1P1}} }, -- done �仯����4
	{ changeNum = 4, blockNum = 5, changeList = {{N1N1, P1N1, P0P0, N1P0, P1P0}, {P1N1, P0N1, P0P0, P0P1, P1P1}, {N1P0, P0P0, P1P0, N1P1, P1P1}, {N1N1, P0N1, P0P0, P0P1, N1P1}} }, -- done �仯����5
	{ changeNum = 4, blockNum = 5, changeList = {{N1N2, N1N1, N1P0, P0P0, P0P1}, {N1P1, P0P1, P0P0, P1P0, P2P0}, {N1P0, N1P1, P0P1, P0P2, P0P3}, {P0P0, N1P0, N1P1, N2P1, N3P1}} }, -- done �仯����6
	{ changeNum = 2, blockNum = 5, changeList = {{P0N2, P0N1, P0P0, P0P1, P0P2}, {N2P0, N1P0, P0P0, P1P0, P2P0}} }, -- done
	{ changeNum = 2, blockNum = 6, changeList = {{N1P0, P0P0, P1P0, N1P1, P0P1, P1P1}, {P0P0, P1P0, P0P1, P1P1, P0P2, P1P2}} }, -- done
	{ changeNum = 1, blockNum = 5, changeList = {{N1P0, P0N1, P1P0, P0P0, P0P1}} }, -- done ʮ�ּ�
	{ changeNum = 4, blockNum = 6, changeList = {{P0N1, N1P0, P1P0, P0P0, N1P1, P1P1}, {P1P0, P0N1, N1N1, P0P0, P0P1, N1P1}, {N1N1, P1N1, N1P0, P0P0, P1P0, P0P1}, {P1N1, P0N1, P0P0, N1P0, P0P1, P1P1}} }, -- done
	{ changeNum = 4, blockNum = 5, changeList = {{P1N1, P1P0, P0P0, P1P1, P0P1}, {P0P0, P1P0, P2P1, P1P1, P0P1}, {P0P0, P1P0, P1P1, P0P1, P0P2}, {N1P0, P0P0, P1P0, P0P1, P1P1}} }, -- done �仯����11
	{ changeNum = 4, blockNum = 5, changeList = {{P0N1, P1N1, P0P0, P0P1, P0P2}, {N2P0, N1P0, P0P0, P1P0, P1P1}, {N1P1, P0P1, P0P0, P0N1, P0N2}, {N1N1, N1P0, P0P0, P1P0, P2P0}} }, -- done
	{ changeNum = 4, blockNum = 3, changeList = {{N1P0, P0P1, P1P0}, {P0N1, N1P0, P0P1}, {P0N1, N1P0, P1P0}, {P0N1, P1P0, P0P1}} }, -- done
	{ changeNum = 2, blockNum = 3, changeList = {{P0N1, P0P0, P0P1}, {N1P0, P0P0, P1P0}} },	
	{ changeNum = 1, blockNum = 1, changeList = {{P0P0}} },
	{ changeNum = 1, blockNum = 2, changeList = {{P0P0, P1P0}} },
	{ changeNum = 1, blockNum = 1, changeList = {{P1P0}} },
}

local function IndexXtoX(indexX) -- ���������Χ������
	local x = BLOCKAREA_OFFSETX + indexX * BLOCKUNIT_WH + BLOCKUNIT_WH * 0.5
	return x
end

local function IndexYtoY(indexY) -- ���������Χ������
	local y = BLOCKAREA_OFFSETY + indexY * BLOCKUNIT_WH + BLOCKUNIT_WH * 0.5
	return y
end

local function IndexToIndexX(index) -- ͨ�� BLOCK_X_NUM �����ȷ��Χ��ֵ
	local indexX = math.modf(index % BLOCK_X_NUM)
	return indexX
end

local function IndexToIndexY(index) -- ͨ�� BLOCK_X_NUM �����ȷ��Χ��ֵ
	local indexY = math.modf(index / BLOCK_X_NUM)
	return indexY
end

local function IndexXYToIndex(indexX, indexY) -- ����ȷ��Χ�� indexX �� indexY ��ת�� -100 �� index
	if indexX >= 0 and indexX < BLOCK_X_NUM and indexY >= 0 and indexY < BLOCK_Y_NUM then
		local index = indexY * BLOCK_X_NUM + indexX
		return index
	else
		return -15 -- ��Ū�� -15 �ù۲����
	end
end

local function XToIndexX(x)
	local indexX = math.modf((x - BLOCKAREA_OFFSETX) / BLOCKUNIT_WH)
	
	if indexX < 0 then
		indexX = indexX - 1
	end
	return indexX
end

local function YToIndexY(y)
	local indexY = math.modf((y - BLOCKAREA_OFFSETY) / BLOCKUNIT_WH)
	
	if indexY < 0 then
		indexY = indexY - 1
	end
	return indexY
end

local function CreatePlayLayerStruct(selfLayer)
	if selfLayer.data == nil then
		selfLayer.data = {}
	end
	
	selfLayer.blockMoveMoment = BLOCKMOVE_MOMENT / 2
	selfLayer.quadScroll = nil
	selfLayer.rectQuadChange = RECT_QUADCHANGE
	selfLayer.rectBlockMove = RECT_BLOCKMOVE
	selfLayer.targetIndexX = BLOCK_X_NUM / 2
	selfLayer.targetIndexY = BLOCK_Y_NUM + 1
	selfLayer.pressMoveSign = false
	selfLayer.pressBlockUnitSign = false
	selfLayer.chechMapRaseSign = false
	selfLayer.chechMapMoveSign = false
	selfLayer.nextBlockUnit = nil
	selfLayer.blockUnit = nil
	selfLayer.blockMap = nil
end

local function BlockMapData_Create()
	local blockMap = {}
	for i = 0, BLOCK_X_NUM * BLOCK_Y_NUM - 1 do
		blockMap[i] = {}
		blockMap[i].index = i
		blockMap[i].quadRes = nil
	end
	return blockMap
end

local function BlockMapData_Delete(selfLayer, blockMap)
	for i = 0, BLOCK_X_NUM * BLOCK_Y_NUM - 1 do
		blockMap[i].quadRes:detach()
		blockMap[i].quadRes = nil
	end
end

local function BlockUnitData_Create()
	local blockUnit = {}
	blockUnit.state = BLOCKUNIT_STATE_LIST.BLOCKUNIT_STATE_NOT
	blockUnit.indexX = 0
	blockUnit.indexY = 0
	blockUnit.shapeType = 1 -- ��1��ʼ
	blockUnit.changeNum = 1 -- ��1��ʼ
	local shapeType = blockUnit.shapeType
	local changeNum = blockUnit.changeNum
	blockUnit.blockNum = SHAPE_BLOCK_LIST[blockUnit.shapeType].blockNum
	local blockXYOffset = SHAPE_BLOCK_LIST[shapeType].changeList[changeNum]
	blockUnit.quadEntitys = {}
	for i = 1, blockUnit.blockNum do
		blockUnit.quadEntitys[i] = {}
		blockUnit.quadEntitys[i].indexX = blockUnit.indexX + blockXYOffset[i].indexX
		blockUnit.quadEntitys[i].indexY = blockUnit.indexY + blockXYOffset[i].indexY
		blockUnit.quadEntitys[i].quadRes = nil 
	end
	return blockUnit
end

local function BlockUnitData_DeleteRes(blockUnit)
	for i = 1, blockUnit.blockNum do
		if blockUnit.quadEntitys[i].quadRes ~= nil then
			blockUnit.quadEntitys[i].quadRes:detach()
			blockUnit.quadEntitys[i].quadRes = nil
		end
	end
end

local function BlockUnitData_Set(blockUnit, indexX, indexY, shapeType, changeNum) -- ���������ɾ����Դ
	-- print("run function BlockUnitData_Set(blockUnit, indexX, indexY, shapeType, changeNum)")
	local changeNum = ((changeNum - 1) % SHAPE_BLOCK_LIST[shapeType].changeNum) + 1
	BlockUnitData_DeleteRes(blockUnit) -- ɾ����Դ
	blockUnit.indexX = indexX
	blockUnit.indexY = indexY
	blockUnit.shapeType = shapeType -- ��1��ʼ
	blockUnit.changeNum = changeNum -- ��1��ʼ
	local shapeType = blockUnit.shapeType
	local changeNum = blockUnit.changeNum
	blockUnit.blockNum = SHAPE_BLOCK_LIST[blockUnit.shapeType].blockNum
	local blockXYOffset = SHAPE_BLOCK_LIST[shapeType].changeList[changeNum]
	blockUnit.quadEntitys = {}
	for i = 1, blockUnit.blockNum do
		blockUnit.quadEntitys[i] = {}
		blockUnit.quadEntitys[i].indexX = blockUnit.indexX + blockXYOffset[i].indexX
		blockUnit.quadEntitys[i].indexY = blockUnit.indexY + blockXYOffset[i].indexY
		blockUnit.quadEntitys[i].quadRes = nil 
	end
end

local function BlockUnitData_StateSet(blockUnit, state)
	blockUnit.state = state
end

local function BlockUnitData_AddRes(selfLayer, blockUnit, resPath)
	local shapeType = blockUnit.shapeType
	local changeNum = blockUnit.changeNum
	local blockXYOffset = SHAPE_BLOCK_LIST[shapeType].changeList[changeNum]
	for i = 1, blockUnit.blockNum do
		local indexX = blockUnit.quadEntitys[i].indexX
		local indexY = blockUnit.quadEntitys[i].indexY
		local quadRes = Quad2D:create(resPath, BLOCK_RECT)
		blockUnit.quadEntitys[i].quadRes = quadRes
		quadRes:setPosition(IndexXtoX(indexX), IndexYtoY(indexY))
		selfLayer:add(quadRes)
	end
end

local function BlockUnitData_Delete(blockUnit)
	BlockUnitData_DeleteRes(blockUnit)
	-- BlockUnitData_StateSet(BLOCKUNIT_STATE_LIST.BLOCKUNIT_STATE_NOT)
end

local function BlockUnitDataToMap_MoveRes(blockMap, blockUnit)
	local quadEntitys = blockUnit.quadEntitys
	for i = 1, blockUnit.blockNum do
		local index = IndexXYToIndex(quadEntitys[i].indexX, quadEntitys[i].indexY)
		-- print("���indexΪ " .. quadEntitys[i].indexX .. " XXX " .. quadEntitys[i].indexY .. " XXX " .. index)
		if index >= 0 then
			if quadEntitys[i].quadRes ~= nil then
				if blockMap[index].quadRes ~=nil then
					blockMap[index].quadRes:detach()
					blockMap[index].quadRes = nil
				end
				blockMap[index].quadRes = quadEntitys[i].quadRes
				quadEntitys[i].quadRes = nil
			end
		else
			-- ���鲻�ںϷ���Χ��
		end
	end
end

local function IsHitMap(blockMap, indexX, indexY) -- �������ж��Ƿ����� blockMap �еķ���
	local index = IndexXYToIndex(indexX, indexY)
	if index < 0 or index > BLOCK_X_NUM * BLOCK_Y_NUM - 1 then
		return false
	end
	if blockMap[index].quadRes == nil then
		return false
	end
	return true
end

local function IsHitLeft(indexX, indexY)
	if indexX < 0 then
		return true
	end
	return false
end

local function IsHitRight(indexX, indexY)
	if indexX > BLOCK_X_NUM - 1 then
		return true
	end
	return false
end

local function IsHitUp(indexX, indexY)
	if indexY > BLOCK_Y_NUM - 1 then
		return true
	end
	return false
end

local function IsHitDown(indexX, indexY)
	if indexY < 0 then
		return true
	end
	return false
end

local function BlockUnit_GetCurChangeNum(blockUnit)
	return blockUnit.changeNum
end

local function BlockUnit_GetChangeNum(blockUnit)
	return SHAPE_BLOCK_LIST[blockUnit.shapeType].changeNum
end

local function BlockUnit_GetShapeType(blockUnit)
	return blockUnit.shapeType
end

local function SetQuadScrollPostion(quadScroll, x)
	if x < QUADSCROLL_MINX then
		x = QUADSCROLL_MINX
	elseif x > QUADSCROLL_MAXX then
		x = QUADSCROLL_MAXX
	end
	quadScroll:setPosition(x, QUADSCROLL_Y)
end

local function PointIsInRect(x, y, rect)
	if x >= rect.x and x <= rect.x + rect.width and y >= rect.y and y <= rect.y + rect.height then
		return true
	end
	return false
end

-- -------------------------- ��չ���� --------------------------------------

local function BlockUnitData_DataCreate(indexX, indexY, shapeType, changeNum) -- ��������Դ
	local blockUnit = BlockUnitData_Create()
	BlockUnitData_Set(blockUnit, indexX, indexY, shapeType, changeNum) -- ���������ɾ����Դ
	return blockUnit
end

local function BlockUnitData_DataSet(blockUnit, indexX, indexY, changeNum) -- ��Ϊû�� shapeType ���Բ��漰��Դ�Ĵ�����ɾ��
	-- print("run function BlockUnitData_DataSet(blockUnit, indexX, indexY, changeNum)")
	local changeNum = ((changeNum - 1) % SHAPE_BLOCK_LIST[blockUnit.shapeType].changeNum) + 1
	blockUnit.indexX = indexX
	blockUnit.indexY = indexY
	blockUnit.changeNum = changeNum -- �� 1 ��ʼ
	local shapeType = blockUnit.shapeType
	local changeNum = blockUnit.changeNum
	local blockXYOffset = SHAPE_BLOCK_LIST[shapeType].changeList[changeNum]
	for i = 1, blockUnit.blockNum do
		local indexX = blockUnit.indexX + blockXYOffset[i].indexX
		local indexY = blockUnit.indexY + blockXYOffset[i].indexY
		blockUnit.quadEntitys[i].indexX = indexX
		blockUnit.quadEntitys[i].indexY = indexY
		if blockUnit.quadEntitys[i].quadRes ~= nil then
			local quadRes = blockUnit.quadEntitys[i].quadRes
			quadRes:setPosition(IndexXtoX(indexX), IndexYtoY(indexY))
		end
	end
end 

local function BlockUnitIsHitMap(blockUnit, blockMap) -- ���鼯���Ƿ�ײ��Map�� blockUnit ֻ������� blockMap �뿴��Դ���ж���ײ
	for i = 1, blockUnit.blockNum do
		local indexX = blockUnit.quadEntitys[i].indexX
		local indexY = blockUnit.quadEntitys[i].indexY
		if IsHitMap(blockMap, indexX, indexY) then
			return true
		end
	end
	return false
end

local function BlockUnitIsHitLeft(blockUnit) -- ���鼯���Ƿ�ײ�����ǽ��
	for i = 1, blockUnit.blockNum do
		local indexX = blockUnit.quadEntitys[i].indexX
		local indexY = blockUnit.quadEntitys[i].indexY
		if IsHitLeft(indexX, indexY) then
			return true
		end
	end
	return false
end

local function BlockUnitIsHitRight(blockUnit) -- ���鼯���Ƿ�ײ���ұ�ǽ��
	for i = 1, blockUnit.blockNum do
		local indexX = blockUnit.quadEntitys[i].indexX
		local indexY = blockUnit.quadEntitys[i].indexY
		if IsHitRight(indexX, indexY) then
			return true
		end
	end
	return false
end

local function BlockUnitIsHitUp(blockUnit) -- ���鼯���Ƿ�ײ���ϱ�ǽ��
	for i = 1, blockUnit.blockNum do
		local indexX = blockUnit.quadEntitys[i].indexX
		local indexY = blockUnit.quadEntitys[i].indexY
		if IsHitUp(indexX, indexY) then
			return true
		end
	end
	return false
end

local function BlockUnitIsHitDown(blockUnit) -- ���鼯���Ƿ�ײ���±�ǽ��
	for i = 1, blockUnit.blockNum do
		local indexX = blockUnit.quadEntitys[i].indexX
		local indexY = blockUnit.quadEntitys[i].indexY
		if IsHitDown(indexX, indexY) then
			return true
		end
	end
	return false
end

local function GetScrollIndexX(quadScroll)
	local indexX = XToIndexX(quadScroll:getPositionX() - BLOCKAREA_OFFSETX)
	return indexX
end

local function BlockUnitIsHited(blockUnit, x, y) -- ����������鼯����û��quad������
	for i = 1, blockUnit.blockNum do
		local indexX = blockUnit.quadEntitys[i].indexX
		local indexY = blockUnit.quadEntitys[i].indexY
		if indexX == XToIndexX(x) and indexY == YToIndexY(y) then
			return true
		end
	end
	return false
end

local function BlockMapIsLineEmpty(blockMap, indexY)
	if indexY > BLOCK_Y_NUM - 1 or indexY < 0 then
		return true
	end
	for i = 0, BLOCK_X_NUM - 1 do
		local index = IndexXYToIndex(i, indexY)
		if blockMap[index].quadRes ~= nil then
			return false
		end
	end
	return true
end

local function BlockMapIsLineFull(blockMap, indexY)
	if indexY > BLOCK_Y_NUM - 1 or indexY < 0 then
		return false
	end
	for i = 0, BLOCK_X_NUM - 1 do
		local index = IndexXYToIndex(i, indexY)
		if blockMap[index].quadRes == nil then
			-- print("��������")
			return false
		end
	end
	-- print("������")
	return true
end

local function BlockMapDeleteLine(blockMap, indexY)
	if indexY < 0 or indexY > BLOCK_Y_NUM - 1 then
		return
	end
	for i = 0, BLOCK_X_NUM - 1 do
		local targetIndex = IndexXYToIndex(i, indexY)
		if blockMap[targetIndex].quadRes ~= nil then
			blockMap[targetIndex].quadRes:detach()
			blockMap[targetIndex].quadRes = nil
		end
	end
end

local function BlockMapMoveLineToLine(blockMap, targetIndexY, srcIndexY) -- �����ƶ���ǿ�Ƹ���
	-- ��������������ֱ���˳�
	if targetIndexY == srcIndexY then
		return
	end
	if targetIndexY < 0 or targetIndexY > BLOCK_Y_NUM - 1 then
		return
	end
	if srcIndexY < 0 or srcIndexY > BLOCK_Y_NUM - 1 then
		return
	end
	BlockMapDeleteLine(blockMap, targetIndexY)
	for i = 0, BLOCK_X_NUM - 1 do
		local targetIndex = IndexXYToIndex(i, targetIndexY)
		local srcIndex = IndexXYToIndex(i, srcIndexY)
		blockMap[targetIndex].quadRes = blockMap[srcIndex].quadRes
		blockMap[srcIndex].quadRes = nil
		if blockMap[targetIndex].quadRes ~= nil then
			local indexX = IndexToIndexX(targetIndex)
			local indexY = IndexToIndexY(targetIndex)
			local x = IndexXtoX(indexX)
			local y = IndexYtoY(indexY)
			blockMap[targetIndex].quadRes:setPosition(x, y)
		end
	end
	-- �������뿪������дû���ֳ�ģ����
-- 	for i = 0, i < BLOCK_X_NUM do
-- 		local targetIndex = IndexXYToIndex(i, targetIndexY)
-- 		if blockMap[targetIndex].quadRes ~= nil then
-- 			blockMap[targetIndex].quadRes:detach()
-- 			blockMap[targetIndex].quadRes = nil
-- 		end
-- 		local srcIndex = IndexXYToIndex(i, srcIndexY)
-- 		blockMap[targetIndex].quadRes = blockMap[srcIndex].quadRes
-- 		blockMap[srcIndex].quadRes = nil
-- 		if blockMap[targetIndex].quadRes ~= nil then
-- 			local indexX = IndexToIndexX(targetIndex)
-- 			local indexY = IndexToIndexY(targetIndex)
-- 			local x = IndexXtoX(indexX)
-- 			local y = IndexXtoY(indexY)
-- 			blockMap[targetIndex].quadRes:setPosition(x, y)
-- 		end
-- 	end
end

-- ---------------------------- ��Ϸ�߼����� ----------------------------------

local function UIRes_Load(selfLayer)
	local quadScroll = Quad2D:create("textures/game/valueHScrollBar.png")
	quadScroll:setPosition(IndexXtoX(BLOCK_X_NUM / 2), QUADSCROLL_Y)
	selfLayer:add(quadScroll)
	selfLayer.quadScroll = quadScroll
end

local function LayerPlay_GameMainLogic(selfLayer, dt)
	if selfLayer.nextBlockUnit == nil then -- ��һ������Ϊ��˵����Ϸ�տ�ʼ
		selfLayer.nextBlockUnit = BlockUnitData_Create()
		local shapeType = math.random(1, #SHAPE_BLOCK_LIST)
		BlockUnitData_Set(selfLayer.nextBlockUnit, 12, 17, shapeType, math.random(1, SHAPE_BLOCK_LIST[shapeType].changeNum))
		BlockUnitData_AddRes(selfLayer, selfLayer.nextBlockUnit, BLOCK_QUAD_RES[math.random(1, #BLOCK_QUAD_RES)].res)
		BlockUnitData_Delete(selfLayer.blockUnit)
		selfLayer.targetIndexY = BLOCK_Y_NUM
		selfLayer.chechMapRaseSign = true
		local shapeType = math.random(1, #SHAPE_BLOCK_LIST)
		BlockUnitData_Set(selfLayer.blockUnit, BLOCK_X_NUM / 2, selfLayer.targetIndexY, shapeType, math.random(1, SHAPE_BLOCK_LIST[shapeType].changeNum))
		BlockUnitData_AddRes(selfLayer, selfLayer.blockUnit, BLOCK_QUAD_RES[math.random(1, #BLOCK_QUAD_RES)].res)
	end
	
	if selfLayer.blockMoveMoment <= 0 then
		selfLayer.blockMoveMoment = BLOCKMOVE_MOMENT -- �̶���
		-- ��ʼ��һЩ����
		-- ���ж��ܲ��ܶ��ٶ�
		-- function BlockUnitData_DataCreate(indexX, indexY, shapeType, changeNum)
		local blockUnit = BlockUnitData_DataCreate(selfLayer.blockUnit.indexX, selfLayer.blockUnit.indexY - 1, BlockUnit_GetShapeType(selfLayer.blockUnit), BlockUnit_GetCurChangeNum(selfLayer.blockUnit))
		local bSign = false
		if BlockUnitIsHitMap(blockUnit, selfLayer.blockMap) then
			bSign = true -- ���ﻹҪ�ж���ײ������ķ��黹��ײ���Աߵķ���,ò���ں����ƶ��в�Ҫ�ж�
		elseif BlockUnitIsHitDown(blockUnit) then
			bSign = true
		end
		-- ��ײ����̶��������µķ��鼯�ϣ�����ײ������Ų
		if bSign then
			-- function BlockUnitDataToMap_MoveRes(blockMap, blockUnit)
			BlockUnitDataToMap_MoveRes(selfLayer.blockMap, selfLayer.blockUnit)
			-- �����µķ��� -- ˳�㻹Ҫ����һЩ����
			BlockUnitData_Delete(selfLayer.blockUnit) -- ��仰������Ҫ��Ҫ
			selfLayer.blockUnit = selfLayer.nextBlockUnit
			selfLayer.targetIndexY = BLOCK_Y_NUM
			selfLayer.chechMapRaseSign = true
			BlockUnitData_DataSet(selfLayer.blockUnit, BLOCK_X_NUM / 2, selfLayer.targetIndexY,  BlockUnit_GetCurChangeNum(selfLayer.blockUnit))
			-- ������һ������
			selfLayer.nextBlockUnit = BlockUnitData_Create()
			local shapeType = math.random(1, #SHAPE_BLOCK_LIST)
			BlockUnitData_Set(selfLayer.nextBlockUnit, 12, 17, shapeType, math.random(1, SHAPE_BLOCK_LIST[shapeType].changeNum))
			BlockUnitData_AddRes(selfLayer, selfLayer.nextBlockUnit, BLOCK_QUAD_RES[math.random(1, #BLOCK_QUAD_RES)].res)
		else
			-- function BlockUnitData_DataSet(blockUnit, indexX, indexY, changeNum)
			BlockUnitData_DataSet(selfLayer.blockUnit, selfLayer.blockUnit.indexX, selfLayer.blockUnit.indexY - 1, BlockUnit_GetCurChangeNum(selfLayer.blockUnit))
		end
	else
		selfLayer.blockMoveMoment = selfLayer.blockMoveMoment - 1 -- �̶���
		-- ����Ų��
		if selfLayer.targetIndexX > selfLayer.blockUnit.indexX then
			-- ��ʼ��һЩ����
			-- ���ж��ܲ��ܶ��ٶ�
			-- BlockUnitData_DataCreate(indexX, indexY, shapeType, changeNum)
			local blockUnit = BlockUnitData_DataCreate(selfLayer.blockUnit.indexX + 1, selfLayer.blockUnit.indexY, BlockUnit_GetShapeType(selfLayer.blockUnit), BlockUnit_GetCurChangeNum(selfLayer.blockUnit))
			local bSign = false
			if BlockUnitIsHitMap(blockUnit, selfLayer.blockMap) then
				bSign = true
			elseif BlockUnitIsHitRight(blockUnit) then
				bSign = true
			elseif BlockUnitIsHitDown(blockUnit) then
				bSign = true
			end
			if not bSign then
				BlockUnitData_DataSet(selfLayer.blockUnit, selfLayer.blockUnit.indexX + 1, selfLayer.blockUnit.indexY, BlockUnit_GetCurChangeNum(selfLayer.blockUnit))
			end
		elseif selfLayer.targetIndexX < selfLayer.blockUnit.indexX then
			-- ��ʼ��һЩ����
			-- ���ж��ܲ��ܶ��ٶ�
			-- BlockUnitData_DataCreate(indexX, indexY, shapeType, changeNum)
			local blockUnit = BlockUnitData_DataCreate(selfLayer.blockUnit.indexX - 1, selfLayer.blockUnit.indexY, BlockUnit_GetShapeType(selfLayer.blockUnit), BlockUnit_GetCurChangeNum(selfLayer.blockUnit))
			local bSign = false
			if BlockUnitIsHitMap(blockUnit, selfLayer.blockMap) then
				bSign = true
			elseif BlockUnitIsHitLeft(blockUnit) then
				bSign = true
			elseif BlockUnitIsHitDown(blockUnit) then
				bSign = true
			end
			if not bSign then
				BlockUnitData_DataSet(selfLayer.blockUnit, selfLayer.blockUnit.indexX - 1, selfLayer.blockUnit.indexY, BlockUnit_GetCurChangeNum(selfLayer.blockUnit))
			end
		end
		-- �����ƶ�
		if selfLayer.targetIndexY < selfLayer.blockUnit.indexY then
			if selfLayer.blockMoveMoment > 2 then -- ����Ҹ�������ƶ��Ļ���
				selfLayer.blockMoveMoment = 2
			end
		end
		-- �������ڻ�û���޶�״̬��������Ϸ ������Ĺ�����ʱ�ŵ�����
		local blockMap = selfLayer.blockMap
		if selfLayer.chechMapRaseSign then
			for i = 0, BLOCK_Y_NUM - 1 do
				if BlockMapIsLineFull(blockMap, i) then
					print("��һ��")
					BlockMapDeleteLine(blockMap, i)
					selfLayer.chechMapMoveSign = true
				end
			end
			selfLayer.chechMapRaseSign = false
		end
		if selfLayer.chechMapMoveSign then
			local bSign = true
			for i = 0, BLOCK_Y_NUM - 1 do
				if BlockMapIsLineEmpty(blockMap, i) then
					for j = i, BLOCK_Y_NUM - 2 do
						BlockMapMoveLineToLine(blockMap, j, j + 1)
						if not BlockMapIsLineEmpty(blockMap, j) then
							bSign = false
						end
					end
					break
				end
			end
			if bSign then -- ˵���������
				print("�������")
				selfLayer.chechMapMoveSign = false
			end
		end
	end
end

local function LayerPlay_OnUpdate(selfLayer, dt)
	selfLayer:update(dt)
	LayerPlay_GameMainLogic(selfLayer, dt)
end

local function TestFunction(selfLayer, x, y) -- 0 �� 1 ������
	if y > 0.96 then 
		g_testNumA = g_testNumA + 1
		if g_testNumA > #SHAPE_BLOCK_LIST then
			g_testNumA = 1
		end
		BlockUnitData_Set(selfLayer.blockUnit, selfLayer.blockUnit.indexX, selfLayer.blockUnit.indexY, g_testNumA, g_testNumB)
		BlockUnitData_AddRes(selfLayer, selfLayer.blockUnit, BLOCK_QUAD_RES[math.random(1, #BLOCK_QUAD_RES)].res)
	end
end

local function RotateBlockUnit_OnTouchBegin(selfLayer, x, y) -- x, y Ϊͼ������
	-- �ж��ܲ�����ת -- ֻ����X���Ͻ��иı�
 	local bSign = false
	local offsetX = 0
	-- ����һ��ԭ����ת�ķ���
 	local blockUnit = BlockUnitData_DataCreate(selfLayer.blockUnit.indexX, selfLayer.blockUnit.indexY, BlockUnit_GetShapeType(selfLayer.blockUnit), BlockUnit_GetCurChangeNum(selfLayer.blockUnit) + 1) 
	if BlockUnitIsHitMap(blockUnit, selfLayer.blockMap) or BlockUnitIsHitLeft(blockUnit, selfLayer.blockMap) or BlockUnitIsHitRight(blockUnit, selfLayer.blockMap) or BlockUnitIsHitDown(blockUnit, selfLayer.blockMap) then
		bSign = true
	end
	-- ��ײ��������Ų 3 ����λ���Ƚ�
	if bSign then
		bSign = false
		for i = 1, 3, 1 do
			local blockUnit = BlockUnitData_DataCreate(selfLayer.blockUnit.indexX + i, selfLayer.blockUnit.indexY, BlockUnit_GetShapeType(selfLayer.blockUnit), BlockUnit_GetCurChangeNum(selfLayer.blockUnit) + 1)
			if BlockUnitIsHitMap(blockUnit, selfLayer.blockMap) or BlockUnitIsHitLeft(blockUnit, selfLayer.blockMap) or BlockUnitIsHitRight(blockUnit, selfLayer.blockMap) or BlockUnitIsHitDown(blockUnit, selfLayer.blockMap) then
				bSign = true
			else
				bSign = false
				offsetX = i
				break
			end
		end
	end
	-- ��ײ��������Ų 3 ����λ���Ƚ�
	if bSign then
		bSign = false
		for i = -1, -3, -1 do
			local blockUnit = BlockUnitData_DataCreate(selfLayer.blockUnit.indexX + i, selfLayer.blockUnit.indexY, BlockUnit_GetShapeType(selfLayer.blockUnit), BlockUnit_GetCurChangeNum(selfLayer.blockUnit) + 1)
			if BlockUnitIsHitMap(blockUnit, selfLayer.blockMap) or BlockUnitIsHitLeft(blockUnit, selfLayer.blockMap) or BlockUnitIsHitRight(blockUnit, selfLayer.blockMap) or BlockUnitIsHitDown(blockUnit, selfLayer.blockMap) then
				bSign = true
			else
				bSign = false
				offsetX = i
				break
			end
		end
	end
	if not bSign then -- ûײ�ϲ��ܸı�
		BlockUnitData_DataSet(selfLayer.blockUnit, selfLayer.blockUnit.indexX + offsetX, selfLayer.blockUnit.indexY, BlockUnit_GetCurChangeNum(selfLayer.blockUnit) + 1)
	end
end

local function ChangeBlockUnitX_OnTouchBegin(selfLayer, x, y) -- x, y Ϊͼ������
	SetQuadScrollPostion(selfLayer.quadScroll, x)
 	selfLayer.targetIndexX = GetScrollIndexX(selfLayer.quadScroll)
 	selfLayer.pressedButton = true
end

local function LayerPlay_OnTouchBegin(selfLayer, x, y)  -- x, y Ϊ 0 �� 1
	-- һ�����Թ���
	TestFunction(selfLayer, x, y)
	-- ת����ͼ����
 	x, y = selfLayer:toLayerCoord(x, y)
 	print("indexX = " .. XToIndexX(x) .. " indexY = " .. YToIndexY(y))
 	-- �ж��Ƿ���б仯����İ�ť
 	if PointIsInRect(x, y, selfLayer.rectQuadChange) then
 		RotateBlockUnit_OnTouchBegin(selfLayer, x, y) -- ��ʱ��Ҫ���ǲ���ը�����仯����
 	elseif PointIsInRect(x, y, selfLayer.rectBlockMove) then -- ��� targetIndexX ���ж��ڲ��ڷ���������
 		ChangeBlockUnitX_OnTouchBegin(selfLayer, x, y)
 	elseif BlockUnitIsHited(selfLayer.blockUnit, x, y) then -- �Ƿ�������˶��еķ���
 		selfLayer.pressBlockUnitSign = true
 	end
	return false
end

local function LayerPlay_OnTouchMove(selfLayer, x, y)
	x, y = selfLayer:toLayerCoord(x, y)
	-- ��� targetIndexX ���ж��ڲ��ڷ���������
 	local rectBlockMove = selfLayer.rectBlockMove
 	if selfLayer.pressedButton then -- ������ģ����������Ƴ���Ļ������ onTouchEnd() �����ֻ����У�����ģ�����ϳ����bug���ù�
 		SetQuadScrollPostion(selfLayer.quadScroll, x)
 		selfLayer.targetIndexX = GetScrollIndexX(selfLayer.quadScroll)
 	end
	return false
end

local function LayerPlay_OnTouchEnd(selfLayer, x, y)
	x, y = selfLayer:toLayerCoord(x, y)
	selfLayer.pressedButton = false -- �����̶�
	if selfLayer.pressBlockUnitSign then
		selfLayer.pressBlockUnitSign = false -- �����̶�
		if BlockUnitIsHited(selfLayer.blockUnit, x, y) then
			selfLayer.targetIndexY = 0
		end
	end
	
	-- print("indexY = " .. YToIndexY(y))
	return false
end

-- ------------------- LayerPlay_Create() ------------------------------------------

g_testNumA = 1
g_testNumB = 1
g_testNumC = 0

function LayerPlay_Create()
	-- init
	local layerPlay = Layer2D:create()
	layerPlay:setSortMode(Layer2D.SORT_ORDER_Z)
	layerPlay:setViewArea(0, 0, 480, 800)
	layerPlay:setTouchEnabled(true)
	layerPlay.data = {}
	-- end init
	CreatePlayLayerStruct(layerPlay)
	UIRes_Load(layerPlay)
	layerPlay.blockMap = BlockMapData_Create()
	
	-- ����һ������
	layerPlay.blockUnit = BlockUnitData_Create()
	-- local shapeType = math.random(1, #SHAPE_BLOCK_LIST)
	-- BlockUnitData_Set(layerPlay.blockUnit, 5, 20, shapeType, math.random(1, SHAPE_BLOCK_LIST[shapeType].changeNum))
	-- BlockUnitData_AddRes(layerPlay, layerPlay.blockUnit, BLOCK_QUAD_RES[math.random(1, #BLOCK_QUAD_RES)].res)
	
	-- ����һЩȫ�ֱ���
	g_testNumA = 1
	g_testNumB = 1
	g_testNumC = 0
	
	layerPlay.onUpdate = LayerPlay_OnUpdate
	layerPlay.onTouchBegin = LayerPlay_OnTouchBegin
	layerPlay.onTouchMove = LayerPlay_OnTouchMove
	layerPlay.onTouchEnd = LayerPlay_OnTouchEnd
	
	return layerPlay
end