include("sdrphud/sdrpconfig.lua")

if CONFIG_LANGUAGE_scarmenu == "en" then
    include("lang/sdrphud/en.lua")
elseif CONFIG_LANGUAGE_scarmenu == "dk" then
    include("lang/sdrphud/dk.lua")
end

local scmbackmain = nil -- Global variable to keep track of the panel

local function showCarMenu()
    -- If the panel is already visible, return to prevent creating another one
    if IsValid(scmbackmain) then
        return
    end

    scmbackmain = vgui.Create("DPanel")
    scmbackmain:SetSize(400, 600)
    scmbackmain:Center()
    scmbackmain:MakePopup() -- Make the panel accept input and prevent closing it on click outside

    function scmbackmain:Paint(w, h)
        surface.SetDrawColor(63, 63, 63, 255)
        surface.DrawRect(0, 0, w, h)
    end

    local scmclosebutton = vgui.Create("DButton", scmbackmain)
    scmclosebutton:SetSize(50, 30)
    scmclosebutton:SetPos(345, 5)
    scmclosebutton:SetText("")

    function scmclosebutton:Paint(w, h)
        surface.SetDrawColor(255, 56, 56, 255)
        surface.DrawRect(0, 0, w, h)
    end

    scmclosebutton.DoClick = function()
        scmbackmain:Remove()
        scmbackmain = nil -- Reset the variable when the panel is closed
    end

    local scmclosebuttontext = vgui.Create("DLabel", scmclosebutton)
    scmclosebuttontext:Dock(FILL)
    scmclosebuttontext:SetContentAlignment(5)
    scmclosebuttontext:SetTextColor(Color(0, 0, 0))
    scmclosebuttontext:SetFont("CloseCaption_Bold")
    scmclosebuttontext:SetText("X")
end

net.Receive("Openscm", function()
    if IsValid(scmbackmain) then
        return
    end

    showCarMenu()
end)
