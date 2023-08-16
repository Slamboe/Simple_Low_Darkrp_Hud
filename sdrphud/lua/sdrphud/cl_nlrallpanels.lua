local nlrfont1 = "CloseCaption_Bold"
local nlrfont2 = "CenterPrintText"

local totaltimer = 300
local nlrStartTime = 0
local timerName = "totaltimer"

local nlrback
local nlrtime

local function removeDpanel()
    if IsValid(nlrback) then
        nlrback:Remove()
        nlrback = nil
    end

    if timer.Exists(timerName) then
        timer.Remove(timerName)
    end

    totaltimer = 302
    nlrStartTime = 0
end

local function showDpanel()
    removeDpanel()

    nlrStartTime = CurTime()

    nlrback = vgui.Create("DPanel")
    nlrback:SetPos(911, 5)
    nlrback:SetSize(120, 70)

    function nlrback:Paint(w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 0, 0)
        surface.DrawOutlinedRect(0, 0, w, h, 2)
    end

    nlrtime = vgui.Create("DLabel", nlrback)
    nlrtime:SetPos(30, -10)
    nlrtime:SetSize(100, 100)
    nlrtime:SetTextColor(Color(255, 255, 255))
    nlrtime:SetFont(nlrfont1)
    nlrtime:SetText("STOP")

    local nlrtext = vgui.Create("DLabel", nlrback)
    nlrtext:SetPos(48, -37)
    nlrtext:SetSize(100, 100)
    nlrtext:SetFont(nlrfont2)
    nlrtext:SetTextColor(Color(255, 255, 255))
    nlrtext:SetText("NLR")

    timer.Create(timerName, 1, totaltimer, function()
        local elapsedTime = CurTime() - nlrStartTime
        local remainingTime = totaltimer - elapsedTime

        if remainingTime > 0 then
            local minutes = math.floor(remainingTime / 60)
            local seconds = math.floor(remainingTime % 60)
            nlrtime:SetText(string.format("%02d:%02d", minutes, seconds))
            nlrtime:SetPos(29, -10)
        else
            notification.AddLegacy(lang.nlrrunoutmsg, NOTIFY_GENERIC, 5)
            removeDpanel()
        end
    end)
end

net.Receive("nlropen", function()
    if IsValid(nlrback) then
        removeDpanel()
    end

    showDpanel()
end)