----------------------------------------------------------------------------------------------|>
--[+] Прогрузка файлов :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

----------------------------------------------------------------------------------------------|>
--[+] Урон :--:--:--:--:--:--:--:--:--:--:--:}>                                               |>
----------------------------------------------------------------------------------------------|>
local function Damage(own, wep)
    timer.Simple(0.6, function()
        if not (IsValid(own)) or not (IsValid(wep)) then return end
        local trace = own:GetEyeTrace()
        if (trace.HitPos:DistToSqr(own:GetShootPos()) <= 10000) then
            local bullet = {}
            bullet.Num = 1
            bullet.Src = own:GetShootPos()
            bullet.Dir = own:GetAimVector()
            bullet.Spread = Vector(0, 0, 0)
            bullet.Force = 15
            bullet.Damage = math.random(10, 35)
            bullet.Distance = 110
            bullet.AmmoType = "Gravity"
            own:FireBullets(bullet)
       end 
    end)
end

----------------------------------------------------------------------------------------------|>
--[+] Возвращение к цикличной анимации :--:--:--:--:--:--:--:--:--:--:--:}>                   |>
----------------------------------------------------------------------------------------------|>
local function ReturnIdle(own, wep, start)
    local idle

    if not (wep.viewMode) then 
        idle = ACT_VM_IDLE_TO_LOWERED
        wep:SetHoldType("hero_guitar_attack")
    else
        idle = ACT_VM_IDLE
        wep:SetHoldType("hero_guitar_default")
    end

    if (start) then idle = ACT_DIEFORWARD end

    timer.Create("Merry.HG.ReturnIdle_" .. own:SteamID(), 1.3, 1, function()
        if (IsValid(wep)) then
            wep:SendWeaponAnim(idle)
        end
    end)    
end

----------------------------------------------------------------------------------------------|>
--[+] Обновление анимации от 1-го лица  :--:--:--:--:--:--:--:--:--:--:--:}>                  |>
----------------------------------------------------------------------------------------------|>
local function ViewMode(own, wep, bool)
    wep:SetNextPrimaryFire(CurTime()+2)
    if (own.GH_Play) then
        Guitar_Hero.StopPlay(own, "unknow", "hide_guitar")
    end

    if (bool) then 
        wep:SendWeaponAnim(ACT_TRANSITION)
        wep.viewMode = false
    else
        wep:SendWeaponAnim(ACT_RESET)
        wep.viewMode = true
    end

    ReturnIdle(own, wep)   
end


----------------------------------------------------------------------------------------------|>
--[+] Первичная атака :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    self:SetNextPrimaryFire(CurTime()+0.7)

    if not (self.viewMode) then
        timer.Create("Merry.HG.Attack_" .. owner:SteamID(), 0.1, 1, function()
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            owner:SetAnimation(PLAYER_ATTACK1)
            Damage(owner, self)
            ReturnIdle(owner, self)
        end)
    end
end

----------------------------------------------------------------------------------------------|>
--[+] Смена режима :--:--:--:--:--:--:--:--:--:--:--:}>                                       |>
----------------------------------------------------------------------------------------------|>
function SWEP:Reload()
    local owner = self:GetOwner()
    timer.Create("Merry.HG.Reload_" .. owner:SteamID(), 0.1, 1, function()
        local owner = self:GetOwner()
        ViewMode(owner, self, self.viewMode)
    end)
end


----------------------------------------------------------------------------------------------|>
--[+] Игрок достал оружие :--:--:--:--:--:--:--:--:--:--:--:}>                                |>
----------------------------------------------------------------------------------------------|>
function SWEP:Deploy()
    self:SendWeaponAnim(ACT_VM_DRAW)
    self.viewMode = true

    timer.Simple(1, function()
        if (IsValid(self)) then
            self:SendWeaponAnim(ACT_VM_IDLE)
        end
    end)    

    return true
end

----------------------------------------------------------------------------------------------|>
--[+] Оружие убрано :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
----------------------------------------------------------------------------------------------|>
function SWEP:Holster()
    local owner = self:GetOwner()
    if (owner.GH_Play) then
        Guitar_Hero.StopPlay(owner, "unknow", "hide_guitar")
    end
    
    return true
end

----------------------------------------------------------------------------------------------|>
--[+] Оружие удалено :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
----------------------------------------------------------------------------------------------|>
function SWEP:OnRemove()
    local owner = self:GetOwner()
    if (owner.GH_Play) then
        Guitar_Hero.StopPlay(owner, "unknow", "hide_guitar")
    end
    
    return true
end

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   