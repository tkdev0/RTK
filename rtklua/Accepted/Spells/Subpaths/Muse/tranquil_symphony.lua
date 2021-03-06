tranquil_symphony = {
	-- long duration full room sanctuary
	cast = function(player)
		local duration = 300000
		local durationPK = 185000

		local magicCost = 60

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Your will is too weak.")
			return
		end

		player:sendAction(6, 30)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(5)
		player:sendMinitext("You cast Tranquil symphony.")

		local pcs = player:getObjectsInSameMap(BL_PC)

		for i = 1, #pcs do
			if not pcs[i]:checkIfCast(sanctuaries) then
				if player:canPK(pcs[i]) then
					pcs[i]:setDuration("tranquil_symphony", durationPK)
				else
					pcs[i]:setDuration("tranquil_symphony", duration)
				end
				pcs[i]:sendAnimation(11, 3)

				if pcs[i].id ~= player.ID then
					pcs[i]:sendMinitext("You have found Sanctuary.")
					pcs[i]:sendMinitext(player.name .. " casts Tranquil symphony on you.")
				end

				pcs[i]:calcStat()
			end
		end
	end,

	recast = function(target)
		target.deduction = target.deduction -.5
		target:sendStatus()
	end,
	uncast = function(target)
		target.deduction = target.deduction +.5
		target:sendStatus()
	end,

	requirements = function(player)
		local level = 30
		local items = {Item("scroll").id, Item("ink").id}
		local itemAmounts = {1, 1}
		local desc = "Reduces all damage taken by 1/2."
		return level, items, itemAmounts, desc
	end
}
