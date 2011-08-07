local condition = createConditionObject(CONDITION_OTHER)
setConditionParam(condition, CONDITION_PARAM_TICKS, 6 * 60 * 60 * 1000)

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local food = SPECIAL_FOODS[item.itemid]
	if(food == nil) then
		return false
	end

	if(not doAddCondition(cid, condition)) then
		return true
	end

	doRemoveItem(item.uid, 1)
	doCreatureSay(cid, food, TALKTYPE_MONSTER)
	return true
end
