venom_mage = {
	cast = function(player)
		local castable = {}
		local maxX = 8
		local maxY = 7
		local magicCost = player.baseMagic * 0.05

		if player.magic < magicCost then
			return;
		end

		if player.x < 8 then
			maxX = maxX + (8 - player.x)
		end

		if player.y < 8 then
			maxY = maxY + (8 - player.y)
		end

		if player.x > getMapXMax(player.m) - 8 then
			maxX = maxX + 9 - (getMapXMax(player.m) - player.x)
		end

		if player.y > getMapYMax(player.m) - 8 then
			maxY = maxY + 9 - (getMapYMax(player.m) - player.y)
		end

		for x = 0, maxX do
			for y = 0, maxY do
				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end
			end

			if #castable > 0 then
				break
			end
		end

		if #castable > 0 then
			player:sendAction(6, 35)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(24)
			player:sendMinitext("You cast Venom.")
	
			if (castable[1].blType == BL_MOB) then
				castable[1]:setDuration("venom_mage", 1 + math.random(3000, 30000))
				castable[1]:sendAnimation(1)
				castable[1].attacker = player.ID
			end
        else
            player:sendMinitext("No targets available.")
		end
	end,

	while_cast_1500 = function(target)
		local damage = target.baseHealth *.015

		if (damage < 1) then
			damage = 1
		end

		if (target.blType == BL_PC) then
			local player = Player(target.attacker)
			if (player:canPK(target)) then
				target:sendAnimation(84)
				target.attacker = player.ID
				if (target.health > damage) then
					target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
				else
					target.health = 1
				end
			end
		else
			target:sendAnimation(84)
			if (target.health > damage) then
				target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
			else
				target.health = 1
			end
		end
	end,
	recast = function(target)
	end,
	uncast = function(player, target)
	end,

	requirements = function(player)
		local level = 59
		local items = {
			Item("snake_meat").id,
			Item("fine_snake_meat").id,
			Item("mountain_ginseng").id,
			0
		}
		local itemAmounts = {10, 3, 1, 500}
		local description = "Poisons target for random amount of time. Does 1.5% damage a second."
		return level, items, itemAmounts, description
	end
}

spirits_leech_mage = {
	cast = function(player)
		local castable = {}
		local maxX = 8
		local maxY = 7
		local magicCost = player.baseMana * 0.05

		if player.magic < magicCost then
			return;
		end

		if player.x < 8 then
			maxX = maxX + (8 - player.x)
		end

		if player.y < 8 then
			maxY = maxY + (8 - player.y)
		end

		if player.x > getMapXMax(player.m) - 8 then
			maxX = maxX + 9 - (getMapXMax(player.m) - player.x)
		end

		if player.y > getMapYMax(player.m) - 8 then
			maxY = maxY + 9 - (getMapYMax(player.m) - player.y)
		end

		for x = 0, maxX do
			for y = 0, maxY do
				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end
			end

			if #castable > 0 then
				break
			end
		end

		if #castable > 0 then
			player:sendAction(6, 35)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(24)
			player:sendMinitext("You cast Spirit's Leech.")
	
			if (mob[1].blType == BL_MOB) then
				mob[1]:setDuration("spirits_leech_mage", 1 + math.random(3000, 30000))
				mob[1]:sendAnimation(1)
				mob[1].attacker = player.ID
			end
        else
            player:sendMinitext("No targets available.")
		end
	end,

	while_cast_1500 = function(target)
		local damage = target.baseHealth *.015

		if (damage < 1) then
			damage = 1
		end

		if (target.blType == BL_PC) then
			local player = Player(target.attacker)
			if (player:canPK(target)) then
				target:sendAnimation(84)
				target.attacker = player.ID
				if (target.health > damage) then
					target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
				else
					target.health = 1
				end
			end
		else
			target:sendAnimation(84)

			if (target.health > damage) then
				target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
			else
				target.health = 1
			end
		end
	end,
	recast = function(target)
	end,
	uncast = function(player, target)
	end,

	requirements = function(player)
		local level = 59
		local items = {
			Item("snake_meat").id,
			Item("fine_snake_meat").id,
			Item("mountain_ginseng").id,
			0
		}
		local itemAmounts = {10, 3, 1, 500}
		local description = "Poisons target for random amount of time. Does 1.5% damage a second."
		return level, items, itemAmounts, description
	end
}

snake_bite_mage = {
	cast = function(player)
		local castable = {}
		local maxX = 8
		local maxY = 7
		local magicCost = player.baseMana * 0.05

		if player.magic < magicCost then
			return;
		end

		if player.x < 8 then
			maxX = maxX + (8 - player.x)
		end

		if player.y < 8 then
			maxY = maxY + (8 - player.y)
		end

		if player.x > getMapXMax(player.m) - 8 then
			maxX = maxX + 9 - (getMapXMax(player.m) - player.x)
		end

		if player.y > getMapYMax(player.m) - 8 then
			maxY = maxY + 9 - (getMapYMax(player.m) - player.y)
		end

		for x = 0, maxX do
			for y = 0, maxY do
				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end
			end

			if #castable > 0 then
				break
			end
		end

		if #castable > 0 then
			player:sendAction(6, 35)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(24)
			player:sendMinitext("You cast Snake Bite.")
	
			if (mob[1].blType == BL_MOB) then
				mob[1]:setDuration("snake_bite_mage", 1 + math.random(3000, 30000))
				mob[1]:sendAnimation(1)
				mob[1].attacker = player.ID
			end
        else
            player:sendMinitext("No targets available.")
		end
	end,

	while_cast_1500 = function(target)
		local damage = target.baseHealth *.015

		if (damage < 1) then
			damage = 1
		end

		if (target.blType == BL_PC) then
			local player = Player(target.attacker)
			if (player:canPK(target)) then
				target:sendAnimation(84)
				target.attacker = player.ID
				if (target.health > damage) then
					target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
				else
					target.health = 1
				end
			end
		else
			target:sendAnimation(84)

			if (target.health > damage) then
				target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
			else
				target.health = 1
			end
		end
	end,
	recast = function(target)
	end,
	uncast = function(player, target)
	end,

	requirements = function(player)
		local level = 59
		local items = {
			Item("snake_meat").id,
			Item("fine_snake_meat").id,
			Item("mountain_ginseng").id,
			0
		}
		local itemAmounts = {10, 3, 1, 500}
		local description = "Poisons target for random amount of time. Does 1.5% damage a second."
		return level, items, itemAmounts, description
	end
}

corruption_mage = {
	cast = function(player)
		local castable = {}
		local maxX = 8
		local maxY = 7
		local magicCost = player.baseMana * 0.05

		if player.magic < magicCost then
			return;
		end

		if player.x < 8 then
			maxX = maxX + (8 - player.x)
		end

		if player.y < 8 then
			maxY = maxY + (8 - player.y)
		end

		if player.x > getMapXMax(player.m) - 8 then
			maxX = maxX + 9 - (getMapXMax(player.m) - player.x)
		end

		if player.y > getMapYMax(player.m) - 8 then
			maxY = maxY + 9 - (getMapYMax(player.m) - player.y)
		end

		for x = 0, maxX do
			for y = 0, maxY do
				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms) then
						table.insert(castable, mob[1])
						break
					end
				end
			end

			if #castable > 0 then
				break
			end
		end

		if #castable > 0 then
			player:sendAction(6, 35)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(24)
			player:sendMinitext("You cast Corruption.")
	
			if (mob[1].blType == BL_MOB) then
				mob[1]:setDuration("corruption_mage", 1 + math.random(3000, 30000))
				mob[1]:sendAnimation(1)
				mob[1].attacker = player.ID
			end
        else
            player:sendMinitext("No targets available.")
		end
	end,

	while_cast_1500 = function(target)
		local damage = target.baseHealth *.015

		if (damage < 1) then
			damage = 1
		end

		if (target.blType == BL_PC) then
			local player = Player(target.attacker)
			if (player:canPK(target)) then
				target:sendAnimation(84)
				target.attacker = player.ID
				if (target.health > damage) then
					target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
				else
					target.health = 1
				end
			end
		else
			target:sendAnimation(84)

			if (target.health > damage) then
				target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
			else
				target.health = 1
			end
		end
	end,
	recast = function(target)
	end,
	uncast = function(player, target)
	end,

	requirements = function(player)
		local level = 59
		local items = {
			Item("snake_meat").id,
			Item("fine_snake_meat").id,
			Item("mountain_ginseng").id,
			0
		}
		local itemAmounts = {10, 3, 1, 500}
		local description = "Poisons target for random amount of time. Does 1.5% damage a second."
		return level, items, itemAmounts, description
	end
}
