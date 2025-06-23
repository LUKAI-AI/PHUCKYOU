----- BIẾN
enableInfinityJump = false
enableTestToggle = false
fullbright = false
skyfog = false 
camzoom = false 
noclip = false
espnpc = false 

----- KHÔNG AUTO
local function FullBright(_, s) local l = game:GetService("Lighting") if s then l.Ambient=Color3.new(1,1,1) l.Brightness=5 l.OutdoorAmbient=Color3.new(1,1,1) l.ClockTime=12 l.FogEnd=1e10 else l.Ambient=Color3.fromRGB(128,128,128) l.Brightness=2 l.OutdoorAmbient=Color3.fromRGB(128,128,128) l.ClockTime=14 l.FogEnd=1000 end end
local _SkyFogBackup={skyProps={},fog={}} local function SkyFogToggle(_,s)local L=game:GetService("Lighting")if s then for _,v in pairs(L:GetChildren())do if v:IsA("Sky")then table.insert(_SkyFogBackup.skyProps,{props={SkyboxBk=v.SkyboxBk,SkyboxDn=v.SkyboxDn,SkyboxFt=v.SkyboxFt,SkyboxLf=v.SkyboxLf,SkyboxRt=v.SkyboxRt,SkyboxUp=v.SkyboxUp}})v:Destroy()end end _SkyFogBackup.fog.start=L.FogStart _SkyFogBackup.fog["end"]=L.FogEnd _SkyFogBackup.fog.color=L.FogColor L.FogStart=0 L.FogEnd=1e10 L.FogColor=Color3.new(1,1,1)else for _,d in pairs(_SkyFogBackup.skyProps)do local k=Instance.new("Sky")for p,v in pairs(d.props)do k[p]=v end k.Parent=L end L.FogStart=_SkyFogBackup.fog.start or 0 L.FogEnd=_SkyFogBackup.fog["end"] or 1000 L.FogColor=_SkyFogBackup.fog.color or Color3.fromRGB(192,192,192)end end
local function ZoomCamera(_,s)local p=game:GetService("Players").LocalPlayer if p then p.CameraMaxZoomDistance=s and 1000 or 128 end end


local function TestFunction()
	print("👉 Hàm TestFunction được GỌI - Trạng thái: " .. tostring(enableTestToggle))
end


----- AUTO LOOP
local function InfinityJump()local u=game:GetService("UserInputService")u.JumpRequest:Connect(function()if enableInfinityJump then local c=game.Players.LocalPlayer.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end end)end
local function NoClip(_,s)local RS=game:GetService("RunService")if s then _G._NoClipConn=RS.Stepped:Connect(function()local c=game.Players.LocalPlayer.Character if c then for _,v in pairs(c:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end end)else if _G._NoClipConn then _G._NoClipConn:Disconnect()_G._NoClipConn=nil end end end
local function ESPNPC(_,s)if _G._HLNPC then for _,v in pairs(_G._HLNPC)do v:Disconnect()end _G._HLNPC=nil end for _,m in pairs(workspace:GetDescendants())do if m:IsA("Model")and m:FindFirstChild("Humanoid")and not game.Players:GetPlayerFromCharacter(m)then local h=m:FindFirstChildOfClass("Highlight")if h then h:Destroy()end if not s then continue end local hl=Instance.new("Highlight",m)hl.FillTransparency=0.7 hl.OutlineTransparency=1 hl.FillColor=Color3.fromRGB(255,180,100)end end if not s then return end _G._HLNPC={}table.insert(_G._HLNPC,workspace.DescendantAdded:Connect(function(m)if m:IsA("Model")and m:FindFirstChild("Humanoid")and not game.Players:GetPlayerFromCharacter(m)then task.wait(0.1)local hl=Instance.new("Highlight",m)hl.FillTransparency=0.7 hl.OutlineTransparency=1 hl.FillColor=Color3.fromRGB(255,180,100)end end))end



----- TOOLS
local function GiveTpClickTool()local p=game.Players.LocalPlayer if not p then warn("❌ No Player")return end local t=Instance.new("Tool")t.Name="Tp Click"t.RequiresHandle=false t.Parent=p.Backpack t.Activated:Connect(function()local c=p.Character local h=c and c:FindFirstChildOfClass("Humanoid")local r=c and c:FindFirstChild("HumanoidRootPart")if not(c and h and r and h.Health>0)then warn("❌ Invalid Character")return end local m=p:GetMouse()local hit=m.Hit if not hit then warn("❌ No Hit")return end r.CFrame=CFrame.new(hit.Position+Vector3.new(0,3,0))print("✅ TP to: "..tostring(hit.Position))end)end
local function GiveNoclipObjectTool()local p=game.Players.LocalPlayer if not p then return end local t=Instance.new("Tool")t.Name="Noclip Object"t.RequiresHandle=false t.Parent=p.Backpack local s={}local f=function(o)if s[o]then o.Transparency=s[o].t o.CanCollide=s[o].c s[o]=nil else s[o]={t=o.Transparency,c=o.CanCollide}o.Transparency=0.7 o.CanCollide=false end end t.Activated:Connect(function()local m=p:GetMouse()local o=m.Target if not o or o.Locked then return end f(o)end)t.Unequipped:Connect(function()for o,d in pairs(s)do o.Transparency=d.t o.CanCollide=d.c end s={}end)end
local function GiveDeleteObjectTool()local p=game.Players.LocalPlayer if not p then return end local t=Instance.new("Tool")t.Name="Delete Object"t.RequiresHandle=false t.Parent=p.Backpack local h local f=function(o)if h then h:Destroy()h=nil end if o then local l=Instance.new("Highlight",o)l.FillColor=Color3.fromRGB(255,0,0)h=l end end t.Activated:Connect(function()local m=p:GetMouse()local o=m.Target if not o or o.Locked then return end if h and h.Parent==o then o:Destroy()h=nil else f(o)end end)t.Unequipped:Connect(function()if h then h:Destroy()h=nil end end)end


--------- FUNCTION📵
local function RainbowColor(t)
	local r = math.sin(t + 0) * 127 + 128
	local g = math.sin(t + 2) * 127 + 128
	local b = math.sin(t + 4) * 127 + 128
	return Color3.fromRGB(r, g, b)
end




-- 🛡️ Anti-Injector
local function _Secure()
	local t = { "getgenv", "identifyexecutor", "hookfunction", "getconnections", "getgc", "debug", "islclosure", "getreg", "getsenv", "getinfo" }
	for _, k in next, t do
		if rawget(getfenv(), k) or rawget(_G, k) then return true end
	end
	return false
end

if _Secure() then
	warn("🚨 AntiCheat Pybass: Injector detected 🥰 .")
	return
end

-- 💻 GUI inject trễ vào CoreGui
task.delay(2.5, function()
	if not game:IsLoaded() then return end
	local UIS = game:GetService("UserInputService")

	-- GUI setup
	local _SG = Instance.new("ScreenGui")
	_SG.Name = "G" .. math.random(1000, 9999)
	pcall(function() _SG.Parent = game:GetService("CoreGui") end)
	_SG.ResetOnSpawn = false

	local _MC = Instance.new("Frame")
	_MC.Size = UDim2.new(0, 400, 0, 300)
	_MC.Position = UDim2.new(0.5, -200, 0.5, -150)
	_MC.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	_MC.BorderSizePixel = 2
	_MC.BorderColor3 = Color3.fromRGB(60, 255, 110)
	_MC.ClipsDescendants = true
	_MC.Parent = _SG

	local _HD = Instance.new("Frame")
	_HD.Size = UDim2.new(1, 0, 0, 40)
	_HD.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	_HD.BorderSizePixel = 0
	_HD.Parent = _MC

	local _HL = Instance.new("TextLabel")
	_HL.Size = UDim2.new(1, 0, 1, 0)
	_HL.AnchorPoint = Vector2.new(0.5, 0.5)
	_HL.Position = UDim2.new(0.5, 0, 0.5, 0)
	_HL.BackgroundTransparency = 1
	_HL.Text = "LUKAI-HACKMENU"
	_HL.TextColor3 = Color3.fromRGB(140, 255, 170)
	_HL.TextSize = 16
	_HL.Font = Enum.Font.Code
	_HL.TextXAlignment = Enum.TextXAlignment.Center
	_HL.TextYAlignment = Enum.TextYAlignment.Center
	_HL.Parent = _HD

	local _BTN_Min = Instance.new("TextButton")
	_BTN_Min.Size = UDim2.new(0, 30, 0, 30)
	_BTN_Min.Position = UDim2.new(1, -35, 0, 5)
	_BTN_Min.BackgroundTransparency = 1
	_BTN_Min.Text = "-"
	_BTN_Min.TextColor3 = Color3.fromRGB(140, 255, 170)
	_BTN_Min.TextSize = 18
	_BTN_Min.Font = Enum.Font.Code
	_BTN_Min.Parent = _HD

	local _BTN_Restore = Instance.new("TextButton")
	_BTN_Restore.Size = UDim2.new(0, 50, 0, 50)
	_BTN_Restore.Position = UDim2.new(0, 20, 0.5, -25)
	_BTN_Restore.AnchorPoint = Vector2.new(0, 0.5)
	_BTN_Restore.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	_BTN_Restore.TextColor3 = Color3.fromRGB(140, 255, 170)
	_BTN_Restore.Text = "⌘"
	_BTN_Restore.TextSize = 20
	_BTN_Restore.Font = Enum.Font.Code
	_BTN_Restore.Visible = false
	_BTN_Restore.BorderSizePixel = 2
	_BTN_Restore.BorderColor3 = Color3.fromRGB(60, 255, 110)
	_BTN_Restore.Parent = _SG
	Instance.new("UICorner", _BTN_Restore).CornerRadius = UDim.new(1, 0)

	local _Body = Instance.new("Frame")
	_Body.Size = UDim2.new(1, 0, 1, -40)
	_Body.Position = UDim2.new(0, 0, 0, 40)
	_Body.BackgroundTransparency = 1
	_Body.Parent = _MC

	local _Side = Instance.new("ScrollingFrame")
	_Side.Size = UDim2.new(0, 140, 1, 0)
	_Side.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	_Side.BorderSizePixel = 0
	_Side.ScrollBarThickness = 0
	_Side.ScrollingDirection = Enum.ScrollingDirection.Y
	_Side.AutomaticCanvasSize = Enum.AutomaticSize.Y
	_Side.CanvasSize = UDim2.new(0, 0, 0, 0)
	_Side.Parent = _Body

	local _SideLayout = Instance.new("UIListLayout", _Side)
	_SideLayout.Padding = UDim.new(0, 6)
	_SideLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local _SidePadding = Instance.new("UIPadding", _Side)
	_SidePadding.PaddingTop = UDim.new(0, 6)
	_SidePadding.PaddingLeft = UDim.new(0, 6)
	_SidePadding.PaddingRight = UDim.new(0, 6)

	local _Content = Instance.new("Frame")
	_Content.Size = UDim2.new(1, -140, 1, 0)
	_Content.Position = UDim2.new(0, 140, 0, 0)
	_Content.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	_Content.BorderSizePixel = 0
	_Content.Parent = _Body

	local _Menus, _State, _MenuCount = {}, {}, 0

	local function _Callback(k, v)
		print(k .. " đã " .. (v and "BẬT" or "TẮT"))
	end

	local function _Show(id)
		for _, m in pairs(_Menus) do
			m.frame.Visible = false
			if m.button then
				m.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				m.button.TextColor3 = Color3.fromRGB(90, 180, 130)
			end
		end
		local m = _Menus[id]
		if m then
			m.frame.Visible = true
			if m.button then
				m.button.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
				m.button.TextColor3 = Color3.fromRGB(10, 10, 10)
			end
		end
	end

	local function _AddMenu(lbl, id)
		_MenuCount += 1
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1, 0, 0, 30)
		b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		b.Text = lbl
		b.TextColor3 = Color3.fromRGB(90, 180, 130)
		b.TextSize = 13
		b.Font = Enum.Font.Code
		b.BorderSizePixel = 1
		b.BorderColor3 = Color3.fromRGB(60, 255, 110)
		b.Parent = _Side

		local f = Instance.new("ScrollingFrame")
		f.Size = UDim2.new(1, 0, 1, 0)
		f.BackgroundTransparency = 1
		f.Visible = false
		f.ScrollBarThickness = 6
		f.ScrollingDirection = Enum.ScrollingDirection.Y
		f.AutomaticCanvasSize = Enum.AutomaticSize.Y
		f.CanvasSize = UDim2.new(0, 0, 0, 0)
		f.Parent = _Content

		local l = Instance.new("UIListLayout")
		l.Padding = UDim.new(0, 10)
		l.SortOrder = Enum.SortOrder.LayoutOrder
		l.Parent = f

		local p = Instance.new("UIPadding")
		p.PaddingTop = UDim.new(0, 6)
		p.PaddingLeft = UDim.new(0, 6)
		p.PaddingRight = UDim.new(0, 6)
		p.Parent = f

		_Menus[id] = { frame = f, button = b }
		b.MouseButton1Click:Connect(function()
			_Show(id)
		end)
		if _MenuCount == 1 then _Show(id) end
	end

-- 🎨 Mặc định cho toggle và button
local ToggleDefaults = {
    Size = UDim2.new(1, -4, 0, 24),
    Font = Enum.Font.Code,
    TextSize = 12,
    BorderSizePixel = 2,
    CornerRadius = UDim.new(0, 4),
    BackgroundColorOn = Color3.fromRGB(60, 180, 100),
    BackgroundColorOff = Color3.fromRGB(35, 35, 35),
    TextColorOn = Color3.fromRGB(10, 10, 10),
    TextColorOff = Color3.fromRGB(90, 180, 130)
}

-- Hàm log lỗi
local function logError(func, err)
    warn(string.format("❌ %s: %s\n%s", func, tostring(err), debug.traceback("", 2)))
end

-- Hàm creative
local function creative(opt)
    if typeof(opt) ~= "table" then return logError("creative", "opt không phải table") end

    local t, lb = opt.type, opt.label or "Không tên"
    local id, v = opt.menu, opt.var or "_anon_" .. math.random(1e5, 9e5)
    local cb, on, off = opt.callback, opt.borderOn or Color3.fromRGB(60, 255, 110), opt.borderOff or Color3.fromRGB(80, 80, 80)
    local loop, delay, sync = opt.loop or false, opt.delay or 0, opt.syncGlobal ~= false

    local errs = {}
    if not t then errs[#errs+1] = "Thiếu 'type'" end
    if not id then errs[#errs+1] = "Thiếu 'menu'" end
    if not _Menus then errs[#errs+1] = "_Menus chưa khởi tạo" end
    if _Menus and not _Menus[id] then errs[#errs+1] = "Menu id không tồn tại: " .. tostring(id) end
    if cb and typeof(cb) ~= "function" then errs[#errs+1] = "Callback không hợp lệ" end

    if #errs > 0 then
        warn("⚠️ [creative] Lỗi nút: " .. lb)
        for _, e in ipairs(errs) do warn("  ⛔ " .. e) end
        return
    end

    _State[v] = _State[v] or false
    local loopKey, menu = "_Loop_" .. v, _Menus[id]

    if t == "toggle" then
        local success, b = pcall(function()
            local b = Instance.new("TextButton", menu.frame)
            b.Size, b.Font, b.TextSize, b.BorderSizePixel = ToggleDefaults.Size, ToggleDefaults.Font, ToggleDefaults.TextSize, ToggleDefaults.BorderSizePixel
            Instance.new("UICorner", b).CornerRadius = ToggleDefaults.CornerRadius

            local function updateUI()
                local st = _State[v]
                b.Text = lb .. ": " .. (st and "BẬT" or "TẮT")
                b.BackgroundColor3 = st and ToggleDefaults.BackgroundColorOn or ToggleDefaults.BackgroundColorOff
                b.TextColor3 = st and ToggleDefaults.TextColorOn or ToggleDefaults.TextColorOff
                b.BorderColor3 = st and on or off
            end

            updateUI()

            b.MouseButton1Click:Connect(function()
                _State[v] = not _State[v]
                if sync then
                    if rawget(_G, v) ~= nil then _G[v] = _State[v]
                    elseif rawget(getfenv(), v) ~= nil then getfenv()[v] = _State[v] end
                end

                updateUI()

                if loop then
                    if _State[loopKey] then
                        coroutine.close(_State[loopKey])
                        _State[loopKey] = nil
                        if not _State[v] and cb then
                            local s, e = pcall(cb, v, false)
                            if not s then logError("ToggleCallback", e) end
                        end
                    end
                    if _State[v] then
                        _State[loopKey] = coroutine.create(function()
                            while _State[v] do
                                if cb then
                                    local s, e = pcall(cb, v, true)
                                    if not s then logError("ToggleLoopCallback", e) end
                                end
                                task.wait(delay)
                            end
                        end)
                        coroutine.resume(_State[loopKey])
                    end
                else
                    if cb then
                        local s, e = pcall(cb, v, _State[v])
                        if not s then logError("ToggleCallback", e) end
                    end
                end
            end)
            return b
        end)
        if not success then logError("creative_toggle", b) end

    elseif t == "button" then
        local success, b = pcall(function()
            local b = Instance.new("TextButton", menu.frame)
            b.Size, b.Font, b.TextSize, b.BorderSizePixel = ToggleDefaults.Size, ToggleDefaults.Font, ToggleDefaults.TextSize, ToggleDefaults.BorderSizePixel
            b.BackgroundColor3, b.TextColor3, b.BorderColor3, b.Text = ToggleDefaults.BackgroundColorOff, ToggleDefaults.TextColorOff, off, lb
            Instance.new("UICorner", b).CornerRadius = ToggleDefaults.CornerRadius

            b.MouseButton1Click:Connect(function()
                if cb then
                    local s, e = pcall(cb, v)
                    if not s then logError("ButtonCallback", e) end
                end
            end)
            return b
        end)
        if not success then logError("creative_button", b) end

    else
        logError("creative", "Type không hỗ trợ: " .. tostring(t))
    end
end



	-- ⚙️ Tabs
	_AddMenu("Thế Giới 🌐", 5)
	_AddMenu("Tools 🔧", 4)
	_AddMenu("Player 🦸", 3)
	_AddMenu("Lấy Dữ Liệu Game 📵", 2)
	_AddMenu("Cài đặt ⚙️", 1)
	_AddMenu("Giao diện 🔲", 6)
	
	-- THẾ GIỚI 
    creative({
	type = "toggle",
	label = "☁️ Auto Xóa Sky + Fog",
	var = "skyfog",
	menu = 5,
	callback = SkyFogToggle,
	loop = true,
	delay = 0.5
})



	-- CÀI ĐẶT
	creative({
		type = "toggle",
		label = "Anti Afk",
		var = "EnableAntiAFK",
		callback = _Callback,
		menu = 1
	})
	creative({
		type = "toggle",
		label = "Full Bright",
		var = "fullbright",
		callback = FullBright,
		menu = 1
	})
	creative({
		type = "toggle",
		label = "Esp Npc",
		var = "espnpc",
		callback = ESPNPC,
		menu = 1
	})
	

	
	
	
	-- TOOLS
	creative({
    type = "button",
    label = "Tp Click",
    callback = GiveTpClickTool,
    menu = 4
})
	creative({
    type = "button",
    label = "Delete Object",
    callback = GiveDeleteObjectTool,
    menu = 4
})
	creative({
    type = "button",
    label = "Noclip Object",
    callback = GiveNoclipObjectTool,
    menu = 4
})



-- Player Features (Menu 3)
creative({
    type = "toggle",
    label = "Camera Zoom",
    var = "camzoom",
    menu = 3,
    callback = ZoomCamera,
})
creative({
    type = "toggle",
    label = "Infinity Jump",
    var = "enableInfinityJump",
    menu = 3,
    callback = InfinityJump,
})
creative({
    type = "toggle",
    label = "No clip",
    var = "noclip",
    menu = 3,
    callback = NoClip,
})



 -- 🌐🌐
creative({
	type = "toggle",
	label = "Tên Menu Rainbow",
	var = "RainbowTitle",
	menu = 6,
	callback = function(_, state)
		if state then
			_State._RainbowTitleConn = game:GetService("RunService").RenderStepped:Connect(function()
				_HL.TextColor3 = RainbowColor(tick() * 2)
			end)
		else
			if _State._RainbowTitleConn then _State._RainbowTitleConn:Disconnect() end
			_HL.TextColor3 = Color3.fromRGB(140, 255, 170)
		end
	end
})

creative({
	type = "toggle",
	label = "Viền Rainbow",
	var = "RainbowBorder",
	menu = 6,
	callback = function(_, state)
		if state then
			_State._RainbowBorderConn = game:GetService("RunService").RenderStepped:Connect(function()
				local color = RainbowColor(tick() * 2)
				_MC.BorderColor3 = color
				_BTN_Restore.BorderColor3 = color
			end)
		else
			if _State._RainbowBorderConn then _State._RainbowBorderConn:Disconnect() end
			_MC.BorderColor3 = Color3.fromRGB(60, 255, 110)
			_BTN_Restore.BorderColor3 = Color3.fromRGB(60, 255, 110)
		end
	end
})

creative({
	type = "toggle",
	label = "Nút Đóng Mở Rainbow",
	var = "RainbowMinRestore",
	menu = 6,
	callback = function(_, state)
		if state then
			_State._RainbowBtnConn = game:GetService("RunService").RenderStepped:Connect(function()
				local c = RainbowColor(tick() * 2)
				_BTN_Min.TextColor3 = c
				_BTN_Restore.TextColor3 = c
			end)
		else
			if _State._RainbowBtnConn then _State._RainbowBtnConn:Disconnect() end
			_BTN_Min.TextColor3 = Color3.fromRGB(140, 255, 170)
			_BTN_Restore.TextColor3 = Color3.fromRGB(140, 255, 170)
		end
	end
})

creative({
	type = "toggle",
	label = "Giao Diện Matrix/Alert",
	var = "ThemeMatrixRed",
	menu = 6,
	callback = function(_, state)
		local border = state and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(60, 255, 110)
		local title  = state and Color3.fromRGB(255, 120, 120) or Color3.fromRGB(140, 255, 170)
		local header = state and Color3.fromRGB(30, 10, 10) or Color3.fromRGB(18, 18, 18)
		local body   = state and Color3.fromRGB(25, 10, 10) or Color3.fromRGB(12, 12, 12)
		local side   = state and Color3.fromRGB(35, 10, 10) or Color3.fromRGB(20, 20, 20)
		local content= state and Color3.fromRGB(45, 10, 10) or Color3.fromRGB(15, 15, 15)
		local btn    = state and Color3.fromRGB(255, 150, 150) or Color3.fromRGB(140, 255, 170)

		_MC.BorderColor3 = border
		_HL.TextColor3 = title
		_HD.BackgroundColor3 = header
		_Body.BackgroundColor3 = body
		_Side.BackgroundColor3 = side
		_Content.BackgroundColor3 = content
		_BTN_Min.TextColor3 = btn
		_BTN_Restore.TextColor3 = btn
		_BTN_Restore.BorderColor3 = border
	end
})

	-- 🟧 Minimize
	_BTN_Min.MouseButton1Click:Connect(function()
		_MC.Visible = false
		_BTN_Restore.Visible = true
	end)
	_BTN_Restore.MouseButton1Click:Connect(function()
		_MC.Visible = true
		_BTN_Restore.Visible = false
	end)
end)


-------⚠️⚠️⚠️ĐÂY LÀ CODE MẪU CỦA LUKAI KO ĐƯỢC PHÉP LẤY⚠️⚠️⚠️
