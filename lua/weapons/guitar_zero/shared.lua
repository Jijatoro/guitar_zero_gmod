----------------------------------------------------------------------------------------------|>
--[+] Основные данные :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
SWEP.PrintName = "Guitar Zero"
SWEP.Spawnable = true
SWEP.Category = "Guitar Zero"
SWEP.Author = "Jijatoro"
SWEP.ViewModel = "models/merry_world/swep/hero_guitar_view/hero_guitar_view.mdl"
SWEP.ViewModelFOV = 84
SWEP.UseHands = true
SWEP.WorldModel = "models/merry_world/swep/hero_guitar_world/hero_guitar_world.mdl"
SWEP.HoldType = "hero_guitar_default"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.Instructions = ""
SWEP.Slot = 1
SWEP.SlotPos = 2

----------------------------------------------------------------------------------------------|>
--[+] Авторизация оружия :--:--:--:--:--:--:--:--:--:--:--:}>                                 |>
----------------------------------------------------------------------------------------------|>
function SWEP:Initialize()
    self:SetHoldType("hero_guitar_default")
end

----------------------------------------------------------------------------------------------|>
--[+] Оружие убрано :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
----------------------------------------------------------------------------------------------|>
function SWEP:Holster()
    return true
end

----------------------------------------------------------------------------------------------|>
--[+] Оружие взято в руки :--:--:--:--:--:--:--:--:--:--:--:}>                                |>
----------------------------------------------------------------------------------------------|>
function SWEP:Deploy()
    return true
end

----------------------------------------------------------------------------------------------|>
--[+] Первичная атака :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime()+0.7)
end

----------------------------------------------------------------------------------------------|>
--[+] Вторичная атака :--:--:--:--:--:--:--:--:--:--:--:}>                                    |>
----------------------------------------------------------------------------------------------|>
function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime()+0.7)
end

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   