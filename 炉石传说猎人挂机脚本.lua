function nearcolor(c1, c2)
	r1 = math.ceil(c1/65536)
	r2 = math.ceil(c2/65536)
	g1 = math.ceil(c1/256)%256
	g2 = math.ceil(c2/256)%256
	b1 = c1%256
	b2 = c2%256
	return math.abs(r1-r2) <= 80 and math.abs(g1-g2) <= 80 and math.abs(b1-b2) <= 80
end

while (true) do
	color = getColor(810, 249) -- 结束回合按钮
	if (nearcolor(color, 0x24b705)) then
		touchDown(1, 810, 249)
		mSleep(50)
		touchUp(1, 810, 249)
	elseif (nearcolor(color, 0xb98c00)) then
		touchDown(1, 601, 410)
		mSleep(50)
		touchUp(1, 601, 410)
		mSleep(500)
		touchDown(1, 810, 249) -- 稳固射击
		mSleep(50)
		touchUp(1, 810, 249)
	else
		mSleep(1000)
	end
end
