# vrp_skills


Salut , acesta este un sistem foarte simplu de Skill-uri si foarte usor de folosit o sa va las mai jos un exemplu de folosire.

1 . Inainte de toate adaugati aceasta chestie in Database: ALTER TABLE vrp_users ADD IF NOT EXISTS PlayerSkills text;

2. Exemplu de folosire:

RegisterNetEvent("$legend:PayJob",function()
    local user_id = vRP.getUserId(source);
    if user_id then
        local actSkill = vRP.GetPlayerSkill(user_id,'Padurar')
        if actSkill == 1 then
            vRP.giveMoney(user_id,100)
        end
        -- ETC DE AICI VA DATI SEAMA SINGURI CUM PUTETI SA IL FOLOSITI.
    end
end)
