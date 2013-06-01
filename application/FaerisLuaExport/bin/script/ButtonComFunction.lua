

function PrintCoordTest(selfLayer, x, y)
	x, y = selfLayer:toLayerCoord(x, y)
	print("point(" .. x .. "," .. y .. ")")
	return ture
end

-- ����һ��Quad2D��button������ϸ��˵��,onPathĬ�������صĶ������ϲ�
function AddButton(layer, x, y, buttonID, offPath, onPath, rect)
	local quadButtonOff = Quad2D:create(offPath, rect)
	local quadButtonOn = Quad2D:create(onPath, rect)
	if layer.data == nil then
		layer.data = {}
	end
	if layer.data.onButList == nil then
		layer.data.offButList = {}
	end
	if layer.data.onButList == nil then
		layer.data.onButList = {}
	end
	
	layer.data.offButList[buttonID] = quadButtonOff
	layer.data.onButList[quadButtonOff] = quadButtonOn
	quadButtonOff:setPosition(x, y)
	quadButtonOn:setPosition(x, y)
	quadButtonOn:setZorder(1)
	quadButtonOn:setVisible(false)
	layer:add(quadButtonOff)
	layer:add(quadButtonOn)
end

function Press_OnTouchBegin(selfLayer, x, y)
	-- PrintCoordTest(selfLayer, x, y)
	x, y = selfLayer:toLayerCoord(x, y)
	local pressedButton = nil
	local offButList = selfLayer.data.offButList
	
	for key, value in pairs(offButList) do 
		if value:hit2D(x, y) then
			pressedButton = value
			break
		end
	end
	
	if pressedButton ~= nil then
		selfLayer.data.pressedButton = pressedButton
		selfLayer.data.onButList[pressedButton]:setVisible(true)
	end
	
	return false
end

function Press_OnTouchMove(selfLayer, x, y)
-- 	PrintCoordTest(selfLayer, x, y)
	x, y = selfLayer:toLayerCoord(x, y)
	if selfLayer.data.pressedButton ~= nil then
		local pressedButton = selfLayer.data.pressedButton
		if selfLayer.data.pressedButton:hit2D(x, y) then
			selfLayer.data.onButList[pressedButton]:setVisible(true)
		else
			selfLayer.data.onButList[pressedButton]:setVisible(false)
		end
	end
	return false
end

function Press_OnTouchEndFun(selfLayer, x, y, pfunc) -- pfunc(selfLayer, pressedButton) �Զ�
	local bSign = false
	PrintCoordTest(selfLayer, x, y)
	x, y = selfLayer:toLayerCoord(x, y)
	if selfLayer.data.pressedButton ~= nil then
		local pressedButton = selfLayer.data.pressedButton
		if pressedButton:hit2D(x, y) then
			-- ��ͬ�İ�ť��ͬ���¼�
			bSign = pfunc(selfLayer, pressedButton)
		end
	end 
	-- ���а�ť��Ҫ��ԭ
	if selfLayer.data.pressedButton ~= nil then
		local pressedButton = selfLayer.data.pressedButton
		selfLayer.data.onButList[pressedButton]:setVisible(false)
		selfLayer.data.pressedButton = nil
	end
	return bSign
end