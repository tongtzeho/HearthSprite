require "TSLib"

function isSharpGreenOrYellow(x, y)
	r ,g, b = getColorRGB(x, y)
	return (g == 255 and b < 130) or (r+g >= 480 and b <= 6)
end

function isSharpGreen(x, y)
	r ,g, b = getColorRGB(x, y)
	return (g == 255 and b < 130)
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
	elseif (isColor( 306, 94, 0xc18949, fuzzy) and isColor(279, 413, 0x3f221b, fuzzy) and isColor(671, 284, 0xaf7336, fuzzy) and isColor(591, 30, 0xbf8b40, fuzzy)) then
		return 7 -- 游戏主界面
	elseif (isColor( 513, 316, 0x000000, fuzzy) and isColor( 481, 317, 0xcf9c58, fuzzy) and isColor( 534, 328, 0xb68d4b, fuzzy) and isColor( 524, 319, 0xb3a392, fuzzy)) then
		return 8 -- 弹出对话框
	elseif (isColor( 872, 92, 0x198d7a, fuzzy) and isColor( 839, 493, 0x494947, fuzzy) and isColor( 268, 247, 0x11657d, fuzzy) and isColor( 129, 96, 0xeeeeee, fuzzy) and isColor( 589, 493, 0x11806e, fuzzy)) then
		return 9 -- 安卓模拟器桌面
	else
		return 0 -- 未知状态
	end
end

function battle(fuzzy)
	mSleep(math.random(800, 1200))
	i = 0
	while i <= 7 do
		curstate = getState(fuzzy)
		if (curstate == 3) then
			break
		end
		pickpoint = {}
		findgreen = false
		for j = 266,689,1 do
			if (isSharpGreenOrYellow(j, 524) and isSharpGreenOrYellow(j, 523)) then
				findgreen = true
				table.insert(pickpoint, j)
			end
		end
		if (not findgreen) then
			break
		end
		x = pickpoint[math.ceil(math.random()*(#pickpoint))]
		touchDown(1, x, 524) -- 选牌
		mSleep(math.random(120, 200))
		touchMove(1, x, 371)
		mSleep(math.random(120, 200))
		touchMove(1, 515, 371)
		mSleep(math.random(120, 200))
		if (isColor(511, 381, 0x7f6e49, 95) or (isColor(621, 333, 0x010101) and isColor(663, 309, 0x000000) and isColor(596, 330, 0x030302) and isColor(573, 311, 0x000000))) then
			 -- 法力值不够，但怕有错误
			touchMove(1, 516, 103)
			mSleep(math.random(120, 200))
			touchUp(1, 516, 103)  -- 成功出牌
			mSleep(math.random(500, 600))
			touchDown(1, 516, 103)
			mSleep(math.random(120, 200))
			touchUp(1, 516, 103) -- 战吼，攻击对方英雄
			mSleep(math.random(200, 300))
			i = i + 0.4 
		else -- 法力值够
			touchMove(1, 516, 103)
			mSleep(math.random(120, 200))
			touchUp(1, 516, 103)  -- 成功出牌
			mSleep(math.random(800, 1200))
			touchDown(1, 516, 103)
			mSleep(math.random(120, 200))
			touchUp(1, 516, 103) -- 战吼，攻击对方英雄
			mSleep(math.random(400, 600))
			i = i + 1
		end		
	end
	mSleep(math.random(800, 1200))
	touchDown(1, 601, 410) -- 英雄技能
	mSleep(math.random(120, 200))
	touchUp(1, 601, 410)
	mSleep(math.random(1800, 2200))
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
			mSleep(math.random(120, 200))
			touchMove(1, 516, 103)
			mSleep(math.random(120, 200))
			touchUp(1, 516, 103)
			mSleep(math.random(800, 1200))
			if (isColor( 574,  321, 0x000000, 85) and isColor( 621,  338, 0x000000, 85) and isColor( 621,  304, 0x000000, 85) and isColor( 588,  305, 0x000000, 85)) then
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
				tox = tox + 17
			end
			if (hit) then
				touchDown(1, fromx, 288)
				mSleep(math.random(120, 200))
				touchMove(1, tox, 199)
				mSleep(math.random(120, 200))
				touchUp(1, tox, 199)
				mSleep(math.random(800, 1200))
				if (isColor( 574,  321, 0x000000, 85) and isColor( 621,  338, 0x000000, 85) and isColor( 621,  304, 0x000000, 85) and isColor( 588,  305, 0x000000, 85)) then
					taunt = true
				else
					i = i + 1
				end
			else
				tox = boardx[math.ceil(math.random()*13)]
				touchDown(1, fromx, 288)
				mSleep(math.random(120, 200))
				touchMove(1, tox, 199)
				mSleep(math.random(120, 200))
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
					mSleep(math.random(120, 200))
					touchMove(1, tox, 199)
					mSleep(math.random(120, 200))
					touchUp(1, tox, 199)
					mSleep(math.random(800, 1200))
					if (isColor( 574,  321, 0x000000, 85) and isColor( 621,  338, 0x000000, 85) and isColor( 621,  304, 0x000000, 85) and isColor( 588,  305, 0x000000, 85)) then
						tox = tox + 34
					else
						hit = true
						break
					end
				end
				tox = tox + 17
			end
			if (hit) then
				i = i + 1
			else
				tox = boardx[math.ceil(math.random()*13)]
				touchDown(1, fromx, 288)
				mSleep(math.random(120, 200))
				touchMove(1, tox, 199)
				mSleep(math.random(120, 200))
				touchUp(1, tox, 199)
				i = i + 0.5
			end
		end		
	end
	touchDown(1, 513, 396) -- 英雄攻击（只攻击对方英雄）
	mSleep(math.random(80, 200))
	touchMove(1, 516, 103)
	mSleep(math.random(80, 200))
	touchUp(1, 516, 103)
	mSleep(math.random(800, 1200)) -- 结束回合
	touchDown(1, 810, 249)
	mSleep(math.random(120, 200))
	touchUp(1, 810, 249)
	mSleep(math.random(300, 700))
end

math.randomseed(os.time())

while (true) do
	state = getState(75)
	os.execute("input tap 273 50")
	if (state == 3) then
		touchDown(1, 810, 249)  -- 结束回合按钮
		mSleep(100)
		touchUp(1, 810, 249)
	elseif (state == 2) then
		battle(80)
	elseif (state == 1) then
		os.execute("input tap 514 423") -- 确认选牌
		mSleep(1000)
	elseif (state == 6) then -- 选卡组、选模式、开始
		os.execute("input tap 396 366") -- 选卡组（中下的卡组）
		mSleep(2500)		
	--	os.execute("input tap 683 82") -- 选休闲模式
	--	mSleep(2500)
		os.execute("input tap 773 82") -- 选排名模式
		mSleep(2500)
		os.execute("input tap 725 435") -- 开始对战（没有选择标准/狂野）
		mSleep(4000)
	elseif (state == 7) then -- 选对战模式
		os.execute("input tap 509 163")
		mSleep(4000)
	elseif (state == 8) then -- 弹出对话框点确定
		os.execute("input tap 511 319")
		mSleep(4000)
	elseif (state == 9) then -- 打开炉石传说
		os.execute("input tap 151 190")
		mSleep(4000)
	else
		mSleep(3000)
	end
end
