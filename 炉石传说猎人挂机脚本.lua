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

function battle(fuzzy)
	if (math.random() < 0.8) then
		touchDown(1, 601, 410) -- 稳固射击
		mSleep(math.random(80, 200))
		touchUp(1, 601, 410)
		mSleep(math.random(800, 1200))
	end
	pickpoint = {1, 303, 2, 374, 3, 425, 4, 455, 5, 485, 6, 520, 7, 547, 8, 623, 9, 672}
	for i=1,20,1 do
		if (getState(fuzzy) == 3) then
			break
		end
		x = pickpoint[math.ceil(math.random()*9+1)]
		touchDown(1, x, 506)
		mSleep(math.random(80, 200))
		touchMove(1, 515, 371)
		mSleep(math.random(80, 200))
		if (isColor( 659,  342, 0xe3dacb, fuzzy) and isColor( 572,  332, 0xede5dc, fuzzy) and isColor( 597,  294, 0xdfd7c7, fuzzy) and isColor( 636,  294, 0xdbd3c3, fuzzy) and isColor( 581,  361, 0xeae0d2, fuzzy)) then
			touchUp(1, 515, 371)
			mSleep(math.random(100, 200))
		else
			touchMove(1, 516, 103)
			mSleep(math.random(80, 200))
			touchUp(1, 516, 103)
			mSleep(math.random(800, 1200))
		end
	end
	boardx = {1, 350, 2, 380, 3, 435, 4, 477, 5, 502, 6, 529, 7, 560, 8, 607, 9, 644, 10, 686}
	for i=1,20,1 do
		if (getState(fuzzy) == 3) then
			break
		end
		fromx = boardx[math.ceil(math.random()*10+1)]
		if (math.random() < 0.6) then
			touchDown(1, fromx, 290)
			mSleep(math.random(80, 200))
			touchMove(1, 516, 103)
			mSleep(math.random(80, 200))
			touchUp(1, 516, 103)
			mSleep(math.random(800, 1200))
		else
			tox = boardx[math.ceil(math.random()*10+1)]
			touchDown(1, fromx, 290)
			mSleep(math.random(80, 200))
			touchMove(1, tox, 199)
			mSleep(math.random(80, 200))
			touchUp(1, tox, 199)
			mSleep(math.random(800, 1200))
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