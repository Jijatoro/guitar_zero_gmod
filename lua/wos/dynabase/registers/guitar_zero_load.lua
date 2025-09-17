wOS.DynaBase:RegisterSource({
    Name = "Guitar Zero",
    Type =  WOS_DYNABASE.EXTENSION,
    Shared = "models/player/wiltos/anim_hero_guitar.mdl",
})

hook.Add( "PreLoadAnimations", "wOS.DynaBase.MountCustomTaunt", function( gender )
    if (gender != WOS_DYNABASE.SHARED) then return end
    IncludeModel( "models/player/wiltos/anim_hero_guitar.mdl" )
end )