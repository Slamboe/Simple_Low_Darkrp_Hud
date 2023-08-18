local hideHUDElements = {
    -- if you DarkRP_HUD this to true, ALL of DarkRP's HUD will be disabled. That is the health bar and stuff,
    -- but also the agenda, the voice chat icons, lockdown text, player arrested text and the names above players' heads
    ["DarkRP_HUD"] = true,

    -- DarkRP_EntityDisplay is the text that is drawn above a player when you look at them.
    -- This also draws the information on doors and vehicles
    ["DarkRP_EntityDisplay"] = true,

    -- This is the one you're most likely to replace first
    -- DarkRP_LocalPlayerHUD is the default HUD you see on the bottom left of the screen
    -- It shows your health, job, salary and wallet, but NOT hunger (if you have hungermod enabled)
    ["DarkRP_LocalPlayerHUD"] = true,

    -- If you have hungermod enabled, you will see a hunger bar in the DarkRP_LocalPlayerHUD
    -- This does not get disabled with DarkRP_LocalPlayerHUD so you will need to disable DarkRP_Hungermod too
    ["DarkRP_Hungermod"] = true,

    -- Drawing the DarkRP agenda
    ["DarkRP_Agenda"] = true,

    -- Lockdown info on the HUD
    ["DarkRP_LockdownHUD"] = true,

    -- Arrested HUD
    ["DarkRP_ArrestedHUD"] = true,

    -- Chat receivers box when you open chat or speak over the microphone
    ["DarkRP_ChatReceivers"] = true,
	
	-- Defeult Ammo Hud
	["CHudAmmo"] = true,
}

hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
    if hideHUDElements[name] then return false end
end)

include("sdrphud/sdrpconfig.lua")

if CONFIG_LANGUAGE_sdrphud == "en" then
    include("lang/sdrphud/en.lua")
elseif CONFIG_LANGUAGE_sdrphud == "dk" then
    include("lang/sdrphud/dk.lua")
end

local function showHud()
	local playerHealth = 100
	local playerArmor = 0

	local DrpServerNameBack = vgui.Create("DPanel")
	DrpServerNameBack:SetSize(20, 20)
	DrpServerNameBack:SetPos(5, 1050)
	function DrpServerNameBack:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local DrpServerNameBackUnder = vgui.Create("DPanel")
	DrpServerNameBackUnder:SetSize(20, 5)
	DrpServerNameBackUnder:SetPos(5, 1070)
	function DrpServerNameBackUnder:Paint(w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local DrpServerNameText = vgui.Create("DLabel", DrpServerNameBack)
	DrpServerNameText:Dock(FILL)
	DrpServerNameText:SetContentAlignment(5)
	DrpServerNameText:SetTextColor(Color(255, 255, 255))

	hook.Add("Think", "updateServerName", function()
    	DrpServerNameText:SetText(SERVERNAME)
    	local labelText = DrpServerNameText:GetText()

    	local labelFont = DrpServerNameText:GetFont()
    	surface.SetFont(labelFont)
    	local textWidth, textHeight = surface.GetTextSize(labelText)

	    local newBackWidthsn = textWidth + 10
    	local newUnderWidthsn = textWidth + 10

    	local currentBackWidthsn = DrpServerNameBack:GetWide()
    	local currentUnderWidthsn = DrpServerNameBackUnder:GetWide()

    	DrpServerNameBack:SetWide(newBackWidthsn)
    	DrpServerNameBackUnder:SetWide(newUnderWidthsn)

	    DrpServerNameText:SetContentAlignment(5)
	end) -- End of Server Name

	local HealthBarBack = vgui.Create("DPanel")
	HealthBarBack:SetPos(90, 1050)
	HealthBarBack:SetSize(0, 0)
	function HealthBarBack:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local HealthBackUnder = vgui.Create("DPanel")
	HealthBackUnder:SetPos(90, 1070)
	HealthBackUnder:SetSize(0, 0)
	function HealthBackUnder:Paint(w, h)
		surface.SetDrawColor(173, 0, 0, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local HealthBarText = vgui.Create("DLabel", HealthBarBack)
	HealthBarText:Dock(FILL)
	HealthBarBack:SetContentAlignment(5)
	HealthBarText:SetTextColor(Color(255, 255, 255))
	HealthBarText:SetText(lang.health .. playerHealth .. "")

	hook.Add("Think", "updatehealthwhengaining", function()
		local ply = LocalPlayer()
		local playerHealth = ply:Health()
		HealthBarText:SetText(lang.health .. playerHealth .. "")
		HealthBarText:SetContentAlignment(5)
	end) -- end of health


	local ArmorBarBack = vgui.Create("DPanel")
	ArmorBarBack:SetPos(175, 1050)
	ArmorBarBack:SetSize(0, 0)
	function ArmorBarBack:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local ArmorBackUnder = vgui.Create("DPanel")
	ArmorBackUnder:SetPos(175, 1070)
	ArmorBackUnder:SetSize(0, 0)
	function ArmorBackUnder:Paint(w, h)
		surface.SetDrawColor(0, 19, 145, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local ArmorBarText = vgui.Create("DLabel", ArmorBarBack)
	ArmorBarText:Dock(FILL)
	ArmorBarText:SetContentAlignment(5)
	ArmorBarText:SetTextColor(Color(255, 255, 255))
	ArmorBarText:SetText(lang.armor .. playerArmor .. "")

	hook.Add("Think", "updatearmorwhengaining", function()
		local ply = LocalPlayer()
		local playerArmor = ply:Armor()
		ArmorBarText:SetText(lang.armor  .. playerArmor .. "")
		ArmorBarText:SetContentAlignment(5)

		if playerArmor == 0 then
            ArmorBarBack:SetVisible(false)
            ArmorBackUnder:SetVisible(false)
        else
            ArmorBarBack:SetVisible(true)
            ArmorBackUnder:SetVisible(true)
        end
	end) -- end of Armor

	local DrpMoneyBack = vgui.Create("DPanel")
	DrpMoneyBack:SetPos(260, 1050)
	DrpMoneyBack:SetSize(0, 20)
	function DrpMoneyBack:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local DrpMoneyBackUnder = vgui.Create("DPanel")
	DrpMoneyBackUnder:SetPos(260, 1070)
	DrpMoneyBackUnder:SetSize(0, 5)
	function DrpMoneyBackUnder:Paint(w, h)
		surface.SetDrawColor(23, 156, 0, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local DrpMoneyText = vgui.Create("DLabel", DrpMoneyBack)
	DrpMoneyText:Dock(FILL)
	DrpMoneyText:SetContentAlignment(5)
	DrpMoneyText:SetTextColor(Color(255, 255, 255))

	hook.Add("Think", "updatewallet", function()
    	local ply = LocalPlayer()
    	if not IsValid(ply) then return end
    	local darkrpmoney = ply:getDarkRPVar("money")
    	local formattedMoney = string.format("%0.0f", darkrpmoney)
    	formattedMoney = string.reverse(formattedMoney)
    	formattedMoney = string.gsub(formattedMoney, "(%d%d%d)", "%1.")
    	formattedMoney = string.reverse(formattedMoney)
    	DrpMoneyText:SetText(lang.wallet .. formattedMoney .. ",-")
    	local labelText = DrpMoneyText:GetText()

    	local labelFont = DrpMoneyText:GetFont()
    	surface.SetFont(labelFont)
    	local textWidth, textHeight = surface.GetTextSize(labelText)

	    local newBackWidthdrpm = textWidth + 10
    	local newUnderWidthdrpm = textWidth + 10

    	local currentBackWidthdrpm = DrpMoneyBack:GetWide()
    	local currentUnderWidthdrpm = DrpMoneyBackUnder:GetWide()

    	DrpMoneyBack:SetWide(newBackWidthdrpm)
    	DrpMoneyBackUnder:SetWide(newUnderWidthdrpm)

	    DrpMoneyText:SetContentAlignment(5)
	end) -- End of money

	local drpsalaryback = vgui.Create("DPanel")
	drpsalaryback:SetPos(280, 1050)
	drpsalaryback:SetSize(0, 20)
	function drpsalaryback:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpsalaryunder = vgui.Create("DPanel")
	drpsalaryunder:SetPos(280, 1070)
	drpsalaryunder:SetSize(0, 5)
	function drpsalaryunder:Paint(w, h)
		surface.SetDrawColor(150, 248, 255, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpsalarytext = vgui.Create("DLabel", drpsalaryback)
	drpsalarytext:Dock(FILL)
	drpsalarytext:SetContentAlignment(5)
	drpsalarytext:SetTextColor(Color(255, 255, 255))

	hook.Add("Think", "updatesalary", function()
    	local ply = LocalPlayer()
    	if not IsValid(ply) then return end
    	local darkrpsalary = ply:getDarkRPVar("salary")
    	drpsalarytext:SetText(lang.salary .. darkrpsalary .. ",-")
    	local labelText = drpsalarytext:GetText()

    	local labelFont = drpsalarytext:GetFont()
    	surface.SetFont(labelFont)
    	local textWidth, textHeight = surface.GetTextSize(labelText)

	    local newBackWidthdrps = textWidth + 25
    	local newUnderWidthdrps = textWidth + 25

    	local currentBackWidthdrps = drpsalaryback:GetWide()
    	local currentUnderWidthdrps = drpsalaryunder:GetWide()

    	drpsalaryback:SetWide(newBackWidthdrps)
    	drpsalaryunder:SetWide(newUnderWidthdrps)

	    drpsalarytext:SetContentAlignment(5)
	end) -- End of salary

	local drpjobback = vgui.Create("DPanel")
	drpjobback:SetPos(280, 1050)
	drpjobback:SetSize(0, 20)
	function drpjobback:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpjobunder = vgui.Create("DPanel")
	drpjobunder:SetPos(280, 1070)
	drpjobunder:SetSize(0, 5)
	function drpjobunder:Paint(w, h)
		surface.SetDrawColor(181, 255, 77, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpjobtext = vgui.Create("DLabel", drpjobback)
	drpjobtext:Dock(FILL)
	drpjobtext:SetContentAlignment(5)
	drpjobtext:SetTextColor(Color(255, 255, 255))

	hook.Add("Think", "updatejob", function()
    	local ply = LocalPlayer()
    	if not IsValid(ply) then return end
    	local darkrpjob = ply:getDarkRPVar("job")
    	drpjobtext:SetText(lang.job .. darkrpjob)
    	local labelText = drpjobtext:GetText()

    	local labelFont = drpjobtext:GetFont()
    	surface.SetFont(labelFont)
    	local textWidth, textHeight = surface.GetTextSize(labelText)

	    local newBackWidthdrpj = textWidth + 25
    	local newUnderWidthdrpj = textWidth + 25

    	local currentBackWidthdrpj = drpjobback:GetWide()
    	local currentUnderWidthdrpj = drpjobunder:GetWide()

    	drpjobback:SetWide(newBackWidthdrpj)
    	drpjobunder:SetWide(newUnderWidthdrpj)

	    drpjobtext:SetContentAlignment(5)
	end) -- End of job

	local drplicenseback = vgui.Create("DPanel")
	drplicenseback:SetPos(280, 1050)
	drplicenseback:SetSize(0, 20)
	function drplicenseback:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drplicenseunder = vgui.Create("DPanel")
	drplicenseunder:SetPos(280, 1070)
	drplicenseunder:SetSize(0, 5)
	function drplicenseunder:Paint(w, h)
		surface.SetDrawColor(199, 225, 255, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drplicensetext = vgui.Create("DLabel", drplicenseback)
	drplicensetext:Dock(FILL)
	drplicensetext:SetContentAlignment(5)
	drplicensetext:SetTextColor(Color(255, 255, 255))

	hook.Add("Think", "updatelicense", function()
    	local ply = LocalPlayer()
    	if not IsValid(ply) then return end
    	drplicensetext:SetText(lang.license)
    	local labelText = drplicensetext:GetText()

    	local labelFont = drplicensetext:GetFont()
    	surface.SetFont(labelFont)
    	local textWidth, textHeight = surface.GetTextSize(labelText)

	    local newBackWidthdrple = textWidth + 25
    	local newUnderWidthdrple = textWidth + 25

    	local currentBackWidthdrple = drplicenseback:GetWide()
    	local currentUnderWidthdrple = drplicenseunder:GetWide()

    	drplicenseback:SetWide(newBackWidthdrple)
    	drplicenseunder:SetWide(newUnderWidthdrple)

	    drplicensetext:SetContentAlignment(5)

	    if not ply:getDarkRPVar("HasGunlicense") then
	   		drplicenseback:SetVisible(false)
	   		drplicenseunder:SetVisible(false)
	   	else
	   		drplicenseback:SetVisible(true)
	   		drplicenseunder:SetVisible(true)
	   	end
	end) -- End of License

	local drpwantedback = vgui.Create("DPanel")
	drpwantedback:SetPos(280, 1050)
	drpwantedback:SetSize(0, 20)
	function drpwantedback:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpwantedunder = vgui.Create("DPanel")
	drpwantedunder:SetPos(280, 1070)
	drpwantedunder:SetSize(0, 5)
	function drpwantedunder:Paint(w, h)
		surface.SetDrawColor(150, 0, 0, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpwantedtext = vgui.Create("DLabel", drpwantedback)
	drpwantedtext:Dock(FILL)
	drpwantedtext:SetContentAlignment(5)
	drpwantedtext:SetTextColor(Color(255, 255, 255))

	hook.Add("Think", "updatewanted", function()
    	local ply = LocalPlayer()
    	if not IsValid(ply) then return end
    	drpwantedtext:SetText(lang.wanted)
    	local labelText = drpwantedtext:GetText()

    	local labelFont = drpwantedtext:GetFont()
    	surface.SetFont(labelFont)
    	local textWidth, textHeight = surface.GetTextSize(labelText)

	    local newBackWidthdrpwd = textWidth + 25
    	local newUnderWidthdrpwd = textWidth + 25

    	local currentBackWidthdrpwd = drpwantedback:GetWide()
    	local currentUnderWidthdrpwd = drpwantedunder:GetWide()

    	drpwantedback:SetWide(newBackWidthdrpwd)
    	drpwantedunder:SetWide(newUnderWidthdrpwd)

	    drpwantedtext:SetContentAlignment(5)

	    if not ply:getDarkRPVar("wanted") then
	   		drpwantedback:SetVisible(false)
	   		drpwantedunder:SetVisible(false)
	   	else
	   		drpwantedback:SetVisible(true)
	   		drpwantedunder:SetVisible(true)
	   	end
	end) -- End of wanted

	local drpammoback = vgui.Create("DPanel")
	drpammoback:SetPos(280, 1050)
	drpammoback:SetSize(0, 20)
	function drpammoback:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpammounder = vgui.Create("DPanel")
	drpammounder:SetPos(280, 1070)
	drpammounder:SetSize(0, 5)
	function drpammounder:Paint(w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpammotext = vgui.Create("DLabel", drpammoback)
	drpammotext:Dock(FILL)
	drpammotext:SetContentAlignment(5)
	drpammotext:SetTextColor(Color(255, 255, 255))

	hook.Add("Think", "updateammo", function()
    	local ply = LocalPlayer()
    	if not IsValid(ply) or not ply:Alive() then return end
    	local weapon = ply:GetActiveWeapon()
    	if not IsValid(weapon) then return end

    	local ammoType = weapon:GetPrimaryAmmoType()
    	local clipAmmo = weapon:Clip1()
    	local reserveAmmo = ply:GetAmmoCount(ammoType)

    	drpammotext:SetText(lang.ammo .. clipAmmo .. "/" .. reserveAmmo)
    	local labelText = drpammotext:GetText()

    	local labelFont = drpammotext:GetFont()
    	surface.SetFont(labelFont)
    	local textWidth, textHeight = surface.GetTextSize(labelText)

	    local newBackWidthdrpa = textWidth + 25
    	local newUnderWidthdrpa = textWidth + 25

    	local currentBackWidthdrpa = drpammoback:GetWide()
    	local currentUnderWidthdrpa = drpammounder:GetWide()

    	drpammoback:SetWide(newBackWidthdrpa)
    	drpammounder:SetWide(newUnderWidthdrpa)

	    drpammotext:SetContentAlignment(5)

	    if clipAmmo < 0 then
	    	drpammoback:SetVisible(false)
	    	drpammounder:SetVisible(false)
	    else
	    	drpammoback:SetVisible(true)
	    	drpammounder:SetVisible(true)	
	   	end
	end) -- End of ammo

	local drpspeedoback = vgui.Create("DPanel")
	drpspeedoback:SetPos(280, 1050)
	drpspeedoback:SetSize(0, 20)
	function drpspeedoback:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpspeedounder = vgui.Create("DPanel")
	drpspeedounder:SetPos(280, 1070)
	drpspeedounder:SetSize(0, 5)
	function drpspeedounder:Paint(w, h)
		surface.SetDrawColor(252, 115, 3, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local drpspeedotext = vgui.Create("DLabel", drpspeedoback)
	drpspeedotext:Dock(FILL)
	drpspeedotext:SetContentAlignment(5)
	drpspeedotext:SetTextColor(Color(255, 255, 255))
	hook.Add("Think", "seeifplyinveh", function ()
		local ply = LocalPlayer()
		if ply:InVehicle() then
	   		drpspeedoback:SetVisible(true)
	    	drpspeedounder:SetVisible(true)
		elseif not ply:InVehicle() then
	   		drpspeedoback:SetVisible(false)
	    	drpspeedounder:SetVisible(false)
		 end
	end)
	net.Receive("speedo", function()
		playervehspeed = math.ceil(net.ReadFloat(vehspeed))

		if SpeedMode == "kmh" then
    		drpspeedotext:SetText("km/h: " .. playervehspeed)
   		elseif SpeedMode == "mph" then
   			drpspeedotext:SetText("mp/h: " .. playervehspeed)
   		end
   		
    	local labelText = drpspeedotext:GetText()

    	local labelFont = drpspeedotext:GetFont()
    	surface.SetFont(labelFont)
    	local textWidth, textHeight = surface.GetTextSize(labelText)

	    local newBackWidthdrpsp = textWidth + 25
    	local newUnderWidthdrpsp = textWidth + 25

    	local currentBackWidthdrpsp = drpspeedoback:GetWide()
    	local currentUnderWidthdrpsp = drpspeedounder:GetWide()

    	drpspeedoback:SetWide(newBackWidthdrpsp)
    	drpspeedounder:SetWide(newUnderWidthdrpsp)

	    drpspeedotext:SetContentAlignment(5)
	end) -- end of speedo

	local HealthvehBack = vgui.Create("DPanel")
	HealthvehBack:SetPos(90, 1050)
	HealthvehBack:SetSize(0, 20)
	function HealthvehBack:Paint(w, h)
		surface.SetDrawColor(63, 63, 63, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local HealthvehBackUnder = vgui.Create("DPanel")
	HealthvehBackUnder:SetPos(90, 1070)
	HealthvehBackUnder:SetSize(0, 5)
	function HealthvehBackUnder:Paint(w, h)
		surface.SetDrawColor(173, 0, 0, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local HealthvehText = vgui.Create("DLabel", HealthvehBack)
	HealthvehText:Dock(FILL)
	HealthvehBack:SetContentAlignment(5)
	HealthvehText:SetTextColor(Color(255, 255, 255))
	HealthvehText:SetText(lang.health)
	hook.Add("Think", "seeifplyinveh2", function ()
		local ply = LocalPlayer()
		if ply:InVehicle() then
	   		HealthvehBack:SetVisible(true)
	    		HealthvehBackUnder:SetVisible(true)
		elseif not ply:InVehicle() then
	   		HealthvehBack:SetVisible(false)
	    	HealthvehBackUnder:SetVisible(false)
		 end
	end)

	hook.Add("Think", "updatevehhealthwhengaining", function()
		if Vcmod == "true" then
			HealthvehBack:SetVisible(true)
			HealthvehBackUnder:SetVisible(true)
			HealthvehText:SetVisible(true)

			for _, ply in ipairs(player.GetAll()) do
				if ply:InVehicle() then
					local veh = ply:GetVehicle()
					local vehHealth = veh:VC_getHealth(true)
					HealthvehText:SetText(lang.vcmodhealth .. math.floor(vehHealth))
					HealthvehText:SetContentAlignment(5)

					local labelText = HealthvehText:GetText()

    				local labelFont = HealthvehText:GetFont()
    				surface.SetFont(labelFont)
    				local textWidth, textHeight = surface.GetTextSize(labelText)

	   	 			local newBackWidthdrpsvh = textWidth + 25
    				local newUnderWidthdrpsvh = textWidth + 25

    				local currentBackWidthdrpsvh = HealthvehBack:GetWide()
    				local currentUnderWidthdrpsvh = HealthvehBackUnder:GetWide()

    				HealthvehBack:SetWide(newBackWidthdrpsvh)
    				HealthvehBackUnder:SetWide(newUnderWidthdrpsvh)

	    			HealthvehText:SetContentAlignment(5)
	    		end
			end
		elseif Vcmod == "false" then
			HealthvehBack:SetVisible(false)
			HealthvehBackUnder:SetVisible(false)
			HealthvehText:SetVisible(false)
			return
		end
	end) -- end of vcmodhealth

local function UpdatePanelPositions()
    local serverNameWidth = DrpServerNameBack:GetWide()

    local healthBarX = 10 + serverNameWidth + 10
    HealthBarBack:SetPos(healthBarX, 1050)
    HealthBarBack:SetSize(70, 20)
    HealthBackUnder:SetPos(healthBarX, 1070)
    HealthBackUnder:SetSize(70, 5)

    local armorBarX = 95 + serverNameWidth + 10
    ArmorBarBack:SetPos(armorBarX, 1050)
    ArmorBarBack:SetSize(70, 20)
    ArmorBackUnder:SetPos(armorBarX, 1070)
    ArmorBackUnder:SetSize(70, 5)
	
	local moneyBackX
    if not ArmorBarBack:IsVisible() then
    	moneyBackX = 180 + serverNameWidth + 10 - 85
    	DrpMoneyBack:SetPos(moneyBackX, 1050)
    	DrpMoneyBackUnder:SetPos(moneyBackX, 1070)
    else
    	moneyBackX = 180 + serverNameWidth + 10
    	DrpMoneyBack:SetPos(moneyBackX, 1050)
    	DrpMoneyBackUnder:SetPos(moneyBackX, 1070)
    end

    local salaryX = moneyBackX + DrpMoneyBack:GetWide() + 15
    drpsalaryback:SetPos(salaryX, 1050)
    drpsalaryunder:SetPos(salaryX, 1070)

    local jobX = salaryX + drpsalaryback:GetWide() + 15
    drpjobback:SetPos(jobX, 1050)
    drpjobunder:SetPos(jobX, 1070)

    local licenseX
    licenseX = jobX + drpjobback:GetWide() + 15
    drplicenseback:SetPos(licenseX, 1050)
    drplicenseunder:SetPos(licenseX, 1070)

    local wantedX
    if not drplicenseback:IsVisible() then
    	wantedX = jobX + drpjobback:GetWide() + 15
   		drpwantedback:SetPos(wantedX, 1050)
    	drpwantedunder:SetPos(wantedX, 1070)
    else
   		wantedX = licenseX + drplicenseback:GetWide() + 15
    	drpwantedback:SetPos(wantedX, 1050)
    	drpwantedunder:SetPos(wantedX, 1070)
    end

local ammoX
    if drpwantedback:IsVisible() then
    	ammoX = wantedX + drpwantedback:GetWide() + 15
    	drpammoback:SetPos(ammoX, 1050)
    	drpammounder:SetPos(ammoX, 1070)
	elseif not drpwantedback:IsVisible() and drplicenseback:IsVisible() then
		ammoX = licenseX + drplicenseback:GetWide() + 15
    	drpammoback:SetPos(ammoX, 1050)
    	drpammounder:SetPos(ammoX, 1070)
    else
		ammoX = jobX + drpjobback:GetWide() + 15
    	drpammoback:SetPos(ammoX, 1050)
    	drpammounder:SetPos(ammoX, 1070)
    end


    if drpammoback:IsVisible() and not drpwantedback:IsVisible() then
		local speedoX = ammoX + drpjobback:GetWide() + 15
    	drpspeedoback:SetPos(speedoX, 1050)
    	drpspeedounder:SetPos(speedoX, 1070)

    	local vehhealthX = speedoX + drpspeedoback:GetWide() + 15
    	HealthvehBack:SetPos(vehhealthX, 1050)
    	HealthvehBackUnder:SetPos(vehhealthX, 1070)

	elseif drpwantedback:IsVisible() and not drpammoback:IsVisible() then
		local speedoX = wantedX + drpjobback:GetWide() + 15
    	drpspeedoback:SetPos(speedoX, 1050)
    	drpspeedounder:SetPos(speedoX, 1070)

    	local vehhealthX = speedoX + drpspeedoback:GetWide() + 15
    	HealthvehBack:SetPos(vehhealthX, 1050)
    	HealthvehBackUnder:SetPos(vehhealthX, 1070)

    elseif drpammoback:IsVisible() and drpwantedback:IsVisible() then
    	local speedoX = ammoX + drpjobback:GetWide() + 15
    	drpspeedoback:SetPos(speedoX, 1050)
    	drpspeedounder:SetPos(speedoX, 1070)

    	local vehhealthX = speedoX + drpspeedoback:GetWide() + 15
    	HealthvehBack:SetPos(vehhealthX, 1050)
    	HealthvehBackUnder:SetPos(vehhealthX, 1070)
	else
    	local speedoX = jobX + drpammoback:GetWide() + 15
    	drpspeedoback:SetPos(speedoX, 1050)
    	drpspeedounder:SetPos(speedoX, 1070)

    	local vehhealthX = speedoX + drpspeedoback:GetWide() + 15
    	HealthvehBack:SetPos(vehhealthX, 1050)
    	HealthvehBackUnder:SetPos(vehhealthX, 1070)
	end
end

	hook.Add("Think", "updatepanelpossonotgoovereachother", function()
        UpdatePanelPositions()
    end)
end -- end of showhud

net.Receive("opendrphud", function()
	showHud()
end)
