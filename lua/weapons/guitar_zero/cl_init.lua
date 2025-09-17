----------------------------------------------------------------------------------------------|>
--[+] Прогрузка файлов :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
include("shared.lua")

----------------------------------------------------------------------------------------------|>
--[+] Открытие UI-меню :--:--:--:--:--:--:--:--:--:--:--:}>                                   |>
----------------------------------------------------------------------------------------------|>
function SWEP:Think()
    local ply = LocalPlayer()

    if (ply:KeyDown(IN_ATTACK)) and (self:GetHoldType() == "hero_guitar_default") then
        timer.Create("Merry.HG.Attack", 0.3, 1, function()
            Guitar_Hero.UI_Start()
        end)
    end     
end

----------------------------------------------------------------------------------------------|>
--[+] Оружие удалено :--:--:--:--:--:--:--:--:--:--:--:}>                                      |>
----------------------------------------------------------------------------------------------|>
function SWEP:OnRemove()
    if (IsValid(Guitar_Hero.Panel_Play)) then Guitar_Hero.Panel_Play:Remove() end

    
    return true
end

----------------------------------------------------------------------------------------------|>
--[+] Прорисовка модели от 3-го лица :--:--:--:--:--:--:--:--:--:--:--:}>                     |>
----------------------------------------------------------------------------------------------|>
local w_model = ClientsideModel(SWEP.WorldModel)
w_model:SetNoDraw(true)

function SWEP:DrawWorldModel()
    local _Owner = self:GetOwner()
    local holdtype = self:GetHoldType()

    if (IsValid(_Owner)) then
        local boneid = _Owner:LookupBone("ValveBiped.Bip01_L_Hand")
        if !boneid then return end

        local matrix = _Owner:GetBoneMatrix(boneid)
        if !matrix then return end

        local bonePos = matrix:GetTranslation()
        local boneAng = matrix:GetAngles()
        
        local offsetVec = Vector(3, -2, -30)
        local offsetAng = Angle(180, 160, 180) 

        if (holdtype == "hero_guitar_attack") then
            offsetVec = Vector(3, -1, 30) 
            offsetAng = Angle(0, -90, 180)  
        end
        
        local newPos, newAng = LocalToWorld(offsetVec, offsetAng, bonePos, boneAng)
        
        w_model:SetPos(newPos)
        w_model:SetAngles(newAng)
        w_model:SetParent(_Owner, boneid)
        w_model:AddEffects(EF_BONEMERGE)
        w_model:SetupBones()
        w_model:SetModelScale(1)
    else
        w_model:SetPos(self:GetPos())
        w_model:SetAngles(self:GetAngles())
        w_model:SetParent(nil)
    end

    w_model:DrawModel()
end

-->                      _M_                                                   
-- [*] Кто ты, Воин?    (0-0)                     
-->                      -w-   