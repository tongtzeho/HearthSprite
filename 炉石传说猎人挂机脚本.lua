require "TSLib"

function getState(fuzzy)
	if (isColor( 535,  418, 0x7cc1ff, fuzzy) and isColor( 513,  431, 0x79bfff, fuzzy) and isColor( 489,  420, 0x7fc5ff, fuzzy) and isColor( 512,  410, 0x7ec3ff, fuzzy)) then
		return 1 -- 开局点确认
	elseif (isColor( 813,  250, 0xc59500, fuzzy) and isColor( 810,  235, 0xd19f02, fuzzy) and isColor( 794,  249, 0xcb9421, fuzzy) and isColor( 825,  250, 0xbe8e16, fuzzy)) then
		return 2 -- 开始战斗
	elseif (isColor( 807,  250, 0x2b8e07, fuzzy) and isColor( 810,  234, 0x239e05, fuzzy) and isColor( 847,  244, 0x7dff53, fuzzy) and isColor( 768,  240, 0x48ff2f, fuzzy)) then 
		return 3 -- 结束战斗
	else
		return 0 -- 未知状态
	end
end

function isSharpGreen(x, y)
	r ,g, b = getColorRGB(x, y)
	return g == 255 and b < 150
end

function battle(fuzzy)
	shot = false
	if (math.random() < 0.7) then
		touchDown(1, 601, 410) -- 稳固射击
		mSleep(math.random(80, 200))
		touchUp(1, 601, 410)
		mSleep(math.random(800, 1200))
		shot = true
	end
	pickpoint = {270, 300, 330, 380, 455, 485, 520, 557, 593, 642}
	i = 0
	while i <= 7 do
		if (getState(fuzzy) == 3) then
			break
		end
		findgreen = false
		for j = 266,689,1 do
			if (isSharpGreen(j, 530) and isSharpGreen(j, 529)) then
				findgreen = true
				break
			end
		end
		if (not findgreen) then
			break
		end
		x = pickpoint[math.ceil(math.random()*10)]
		isgreen = false
		while (x <= 690) do
			if (isSharpGreen(x, 530) and isSharpGreen(x, 529)) then
				isgreen = true
				x = x + 1
				break
			end
			x = x + 1
		end
		if (not isgreen) then
			i = i + 0.1
		else
			touchDown(1, x, 530)
			mSleep(math.random(80, 200))
			touchMove(1, x, 371)
			mSleep(math.random(80, 200))
			touchMove(1, 515, 371)
			mSleep(math.random(80, 200))
			if (isColor(513, 385, 0x4e5868, 95) or (isColor( 659,  342, 0xe3dacb, fuzzy) and isColor( 572,  332, 0xede5dc, fuzzy) and isColor( 597,  294, 0xdfd7c7, fuzzy) and isColor( 636,  294, 0xdbd3c3, fuzzy) and isColor( 581,  361, 0xeae0d2, fuzzy))) then
				touchUp(1, 515, 371)
				mSleep(math.random(100, 200))
				i = i + 0.4
			else
				touchMove(1, 516, 103)
				mSleep(math.random(80, 200))
				touchUp(1, 516, 103)
				mSleep(math.random(800, 1200))
				i = i + 1
			end
		end		
	end
	if (not shot) then
		touchDown(1, 601, 410) -- 稳固射击
		mSleep(math.random(80, 200))
		touchUp(1, 601, 410)
		mSleep(math.random(2800, 3200))
	end
	boardx = {307, 341, 375, 409, 443, 477, 511, 545, 579, 613, 647, 681, 715}
	i = 0
	while i <= 9 do
		if (getState(fuzzy) == 3) then
			break
		end
		findgreen = false
		for j = 266,770,1 do
			if (isSharpGreen(j, 252) and isSharpGreen(j, 251)) then
				findgreen = true
				break
			end
		end
		if (not findgreen) then
			break
		end
		fromx = boardx[math.ceil(math.random()*13)]
		isgreen = false
		while (fromx <= 740) do
			if (isSharpGreen(fromx, 252) and isSharpGreen(fromx, 251)) then
				isgreen = true
				break
			end
			fromx = fromx + 1
		end
		if (not isgreen) then
			i = i + 0.1
		else
			taunt = false
			if (math.random() < 0.7) then
				touchDown(1, fromx, 290)
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
			else
				tox = boardx[math.ceil(math.random()*13)]
				hit = false
				while (tox <= 740) do
					if (not isColor(tox, 213, 0xb29051, 60)) then
						hit = true
						break
					end
					tox = tox + 1
				end
				if (hit) then
					touchDown(1, fromx, 290)
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
					i = i + 0.1
				end
			end
			if taunt then
				tox = 307
				hit = false
				while (tox <= 740) do
					if (not isColor(tox, 213, 0xb29051, 60)) then
						touchDown(1, fromx, 290)
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
					i = i + 0.4
				end
			end
		end		
	end
	mSleep(math.random(800, 1200))
	touchDown(1, 810, 249)
	mSleep(math.random(80, 200))
	touchUp(1, 810, 249)
	mSleep(math.random(300, 700))
end

math.randomseed(os.time())

while (true) do
	state = getState(70)
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
	else
		mSleep(1000)
	end
end