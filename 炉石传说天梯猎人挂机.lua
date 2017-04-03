require "TSLib"

function isSharpGreen(x, y)
	r ,g, b = getColorRGB(x, y)
	return g == 255 and b < 150
end

function getState(fuzzy)
	if (isColor( 535,  418, 0x7cc1ff, fuzzy) and isColor( 513,  431, 0x79bfff, fuzzy) and isColor( 489,  420, 0x7fc5ff, fuzzy) and isColor( 512,  410, 0x7ec3ff, fuzzy)) then
		return 1 -- 开局点确认
	elseif (isColor( 813,  250, 0xc59500, fuzzy) and isColor( 810,  235, 0xd19f02, fuzzy) and isColor( 794,  249, 0xcb9421, fuzzy) and isColor( 825,  250, 0xbe8e16, fuzzy)) then
		return 2 -- 开始战斗
	elseif (isSharpGreen(770, 236) and isSharpGreen(813, 264) and isSharpGreen(846, 238) and isSharpGreen(823, 222)) then 
		return 3 -- 结束战斗
	elseif (isColor(240, 81, 0x4f1515, fuzzy) and isColor(545, 83, 0x8c2615, fuzzy) and isColor(773, 435, 0x36d9ff, fuzzy) and isColor(799, 161, 0x7f2417, fuzzy)) then
		return 6 -- 对战模式主界面
	else
		return 0 -- 未知状态
	end
end

function battle(fuzzy)
	if (math.random() < 0.5) then -- 打招呼
		touchDown(1, 510, 403) 
		mSleep(math.random(80, 200))
		touchUp(1, 510, 403)
		mSleep(math.random(800, 1200))
		hix = {439, 582, 414, 613, 425, 606}
		hiy = {337, 335, 382, 382, 422, 430}
		hirandom = math.ceil(math.random()*6)
		touchDown(1, hix[hirandom], hiy[hirandom]) 
		mSleep(math.random(80, 200))
		touchUp(1, hix[hirandom], hiy[hirandom])
		mSleep(math.random(800, 1200))
	end
	shot = false
	if (math.random() < 0.7) then
		touchDown(1, 601, 410) -- 稳固射击
		mSleep(math.random(80, 200))
		touchUp(1, 601, 410)
		mSleep(math.random(800, 1200))
		shot = true
	end
	i = 0
	while i <= 7 do
		curstate = getState(fuzzy)
		if (curstate == 3) then
			break
		end
		pickpoint = {}
		findgreen = false
		for j = 266,689,1 do
			if (isSharpGreen(j, 530) and isSharpGreen(j, 529)) then
				findgreen = true
				table.insert(pickpoint, j)
			end
		end
		if (not findgreen) then
			break
		end
		x = pickpoint[math.ceil(math.random()*(#pickpoint))]+1
		touchDown(1, x, 530) -- 选牌
		mSleep(math.random(80, 200))
		touchMove(1, x, 371)
		mSleep(math.random(80, 200))
		touchMove(1, 515, 371)
		mSleep(math.random(80, 200))
		if (isColor(513, 385, 0x4e5868, 95) or (isColor( 659,  342, 0xe3dacb, fuzzy) and isColor( 572,  332, 0xede5dc, fuzzy) and isColor( 597,  294, 0xdfd7c7, fuzzy) and isColor( 636,  294, 0xdbd3c3, fuzzy) and isColor( 581,  361, 0xeae0d2, fuzzy))) then
			touchUp(1, 515, 371)
			mSleep(math.random(100, 200)) -- 法力值不够
			i = i + 0.4
		else
			touchMove(1, 516, 103)
			mSleep(math.random(80, 200))
			touchUp(1, 516, 103)  -- 成功出牌
			mSleep(math.random(400, 600))
			i = i + 1
		end		
	end
	mSleep(math.random(400, 600))
	if (isSharpGreen(635, 400) and isSharpGreen(562, 408) and isSharpGreen(586, 370) and isSharpGreen(616, 374)) then
		touchDown(1, 601, 410) -- 稳固射击
		mSleep(math.random(80, 200))
		touchUp(1, 601, 410)
		mSleep(math.random(2800, 3200))
	end
	boardx = {307, 341, 375, 409, 443, 477, 511, 545, 579, 613, 647, 681, 715}
	i = 0
	while i <= 9 do
		curstate = getState(fuzzy)
		if (curstate == 3) then
			break
		end
		fromxarr = {}
		findgreen = false
		for j = 266,754,1 do
			if (isSharpGreen(j, 300) and isSharpGreen(j, 301)) then
				findgreen = true
				table.insert(fromxarr, j)
			end
		end
		if (not findgreen) then
			break
		end
		fromx = fromxarr[math.ceil(math.random()*(#fromxarr))]-13
		taunt = false
		if (math.random() < 0.9) then -- 攻击对方英雄
			touchDown(1, fromx, 288)
			mSleep(math.random(80, 200))
			touchMove(1, 516, 103)
			mSleep(math.random(80, 200))
			touchUp(1, 516, 103)
			mSleep(math.random(800, 1200))
			if (isColor( 616,  328, 0x000000) and isColor( 631, 322, 0x000000) and isColor( 608, 320, 0x000000) and isColor( 644, 327, 0x000000)) then
				taunt = true
			else
				i = i + 1
			end
		else -- 攻击对方随从
			tox = boardx[math.ceil(math.random()*13)]
			hit = false
			while (tox <= 740) do
				if (not isColor(tox, 213, 0xb29051, 70)) then
					hit = true
					break
				end
				tox = tox + 34
			end
			if (hit) then
				touchDown(1, fromx, 288)
				mSleep(math.random(80, 200))
				touchMove(1, tox, 199)
				mSleep(math.random(80, 200))
				touchUp(1, tox, 199)
				mSleep(math.random(800, 1200))
				if (isColor( 616,  328, 0x000000) and isColor( 631, 322, 0x000000) and isColor( 608, 320, 0x000000) and isColor( 644, 327, 0x000000)) then
					taunt = true
				else
					i = i + 1
				end
			else
				tox = boardx[math.ceil(math.random()*13)]
				touchDown(1, fromx, 288)
				mSleep(math.random(80, 200))
				touchMove(1, tox, 199)
				mSleep(math.random(80, 200))
				touchUp(1, tox, 199)
				i = i + 0.5
			end
		end
		if taunt then -- 对方有随从嘲讽
			tox = 307
			hit = false
			while (tox <= 740) do
				if (not isColor(tox, 213, 0xb29051, 70)) then
					touchDown(1, fromx, 288)
					mSleep(math.random(80, 200))
					touchMove(1, tox, 199)
					mSleep(math.random(80, 200))
					touchUp(1, tox, 199)
					mSleep(math.random(800, 1200))
					if (isColor( 616,  328, 0x000000) and isColor( 631, 322, 0x000000) and isColor( 608, 320, 0x000000) and isColor( 644, 327, 0x000000)) then
						tox = tox + 34
					else
						hit = true
						break
					end
				end
				tox = tox + 34
			end
			if (hit) then
				i = i + 1
			else
				tox = boardx[math.ceil(math.random()*13)]
				touchDown(1, fromx, 288)
				mSleep(math.random(80, 200))
				touchMove(1, tox, 199)
				mSleep(math.random(80, 200))
				touchUp(1, tox, 199)
				i = i + 0.5
			end
		end		
	end
	mSleep(math.random(800, 1200)) -- 结束回合
	touchDown(1, 810, 249)
	mSleep(math.random(80, 200))
	touchUp(1, 810, 249)
	mSleep(math.random(300, 700))
end

math.randomseed(os.time())

while (true) do
	state = getState(75)
	touchDown(1, 273, 50)
	mSleep(100)
	touchUp(1, 273, 50)
	if (state == 3) then
		touchDown(1, 810, 249)  -- 结束回合按钮
		mSleep(100)
		touchUp(1, 810, 249)
	elseif (state == 2) then
		battle(80)
	elseif (state == 1) then
		touchDown(1, 514, 423) -- 确认选牌
		mSleep(100)
		touchUp(1, 514, 423)
	elseif (state == 6) then -- 选卡组、选模式、开始
		touchDown(1, 512, 141) -- 选卡组（右上角的卡组）
		mSleep(100)
		touchUp(1, 512, 141)
		mSleep(2500)
	--	touchDown(1, 683, 82) -- 选休闲模式
	--	mSleep(100)
	--	touchUp(1, 683, 82)
	--	mSleep(2500)
		touchDown(1, 773, 82) -- 选排名模式
		mSleep(100)
		touchUp(1, 773, 82)
		mSleep(2500)
		touchDown(1, 725, 435) -- 开始对战（没有选择标准/狂野）
		mSleep(100)
		touchUp(1, 725, 435)
		mSleep(4000)
	else
		mSleep(3000)
	end
end
