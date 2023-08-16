util.AddNetworkString("opendrphud")
util.AddNetworkString("nlropen")
util.AddNetworkString("speedo")
util.AddNetworkString("Openscm")

AddCSLuaFile("sdrphud.lua")

AddCSLuaFile("sdrphud/cl_sdrpallpanels.lua")
AddCSLuaFile("sdrphud/cl_nlrallpanels.lua")
AddCSLuaFile("sdrphud/cl_scarmenu.lua")
AddCSLuaFile("sdrphud/sdrpconfig.lua")

AddCSLuaFile("lang/sdrphud/dk.lua")
AddCSLuaFile("lang/sdrphud/en.lua")

include("sdrphud/sdrpconfig.lua")

if CONFIG_LANGUAGE_sdrphud == "en" then
    include("lang/sdrphud/en.lua")
elseif CONFIG_LANGUAGE_sdrphud == "dk" then
    include("lang/sdrphud/dk.lua")
end

hook.Add("PlayerInitialSpawn", "ShowHudOnSpawn", function(ply)
	net.Start("opendrphud")
	net.Send(ply)
end)

hook.Add("PlayerDeath", "NlrOpen", function(ply)
	net.Start("nlropen")
	net.Send(ply)
end)

local prevSpeed = {}
hook.Add("Think", "speedospeed", function()
if SpeedMode == "kmh" then
   	for _, ply in ipairs(player.GetAll()) do
    	if ply:InVehicle() then
    	    local veh = ply:GetVehicle()
            local vehspeed = veh:GetSpeed() * 1.6093440006147
           	if prevSpeed[ply] ~= vehspeed then
            	net.Start("speedo")
            	net.WriteFloat(vehspeed)
                net.Send(ply)
                prevSpeed[ply] = vehspeed
           	end
       	else
           	prevSpeed[ply] = nil
        end
    end
	elseif SpeedMode == "mph" then
    	for _, ply in ipairs(player.GetAll()) do
    		if ply:InVehicle() then
    	    	local veh = ply:GetVehicle()
        		local vehspeed = veh:GetSpeed()
            	if prevSpeed[ply] ~= vehspeed then
            		net.Start("speedo")
            		net.WriteFloat(vehspeed)
            		net.Send(ply)
            		prevSpeed[ply] = vehspeed
            	end
       		else
            	prevSpeed[ply] = nil
       	 	end
    	end
    end
end)


hook.Add("PlayerButtonDown", "OpenHudscm", function(ply, button)
    if button == KEY_F6 and ply:InVehicle() then
        local vehicle = ply:GetVehicle()
        if IsValid(vehicle) and vehicle:GetClass() == "prop_vehicle_jeep" then
            net.Start("Openscm")
            net.Send(ply)
        end
    end
end)