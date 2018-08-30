﻿local battleuser = require("battleuser")
local M = {}

local AiMgr = {}
AiMgr.__index = AiMgr

function M.new(battle,aiCount)
	local o = {}
	o = setmetatable(o,AiMgr)  --把一张表弹出栈，并将其设为给定索引处的值的元表。
	o.battle = battle
	o.robots = {}
	for i = 1,aiCount do
		local robot = {}
		robot.user = battleuser.new(nil,i)
		robot.user.battle = battle
		robot.user:Relive()
		battle.users[i] = robot.user
		robot.nextMove = battle.tickCount
		o.robots[i] = robot
	end
	return o
end

--更新AI的移动信息
function AiMgr:Update()
	for k,v in pairs(self.robots) do
		if self.battle.tickCount > v.nextMove then
			v.user:Move({dir=math.random(0,359)})
			v.nextMove = self.battle.tickCount + math.random(4000,6000)
		end
	end
end


return M
