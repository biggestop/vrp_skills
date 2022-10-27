local uSkills = {}
local MinExperience = 100

function SkillLevelUp(user_id,skill)
    if user_id then
        local UserLevel = vRP.GetPlayerSkill(user_id,skill)
        if UserLevel == 0 then
            uSkills[user_id][skill] = {Nivel = 1 , xp = 0}
        else
            if UserLevel == 1 then
                uSkills[user_id][skill] = {Nivel = 2 , xp = 0}
            else
                if UserLevel == 2 then
                    uSkills[user_id][skill] = {Nivel = 3 , xp = 0}
                end
            end
        end
    end
end

function vRP.GiveSkillExperience(user_id,skill,exp)
    if user_id then
        local level = vRP.GetPlayerSkill(user_id,skill)
        if level < 3 then
            if uSkills[user_id][skill] then
                uSkills[user_id][skill].xp = uSkills[user_id][skill].xp + exp
                if uSkills[user_id][skill].xp >= MinExperience then
                    SkillLevelUp(user_id,skill)
                end
            end
        end
    end
end

function vRP.GetPlayerSkill(user_id,skill)
    if user_id then
        if not uSkills[user_id][skill] then
            uSkills[user_id][skill] = {Nivel = 0 , xp = 0}
        end
        return uSkills[user_id][skill].Nivel
    end
end

AddEventHandler('vRP:playerSpawn', function(user_id,source,first_spawn)
    if first_spawn then
        uSkills[user_id] = {}
        exports.ghmattimysql:execute('SELECT PlayerSkills FROM vrp_users WHERE id = ?',{user_id},function(result)
            if result[1].PlayerSkills then
                uSkills[user_id] = json.decode(result[1].PlayerSkills) or {}
            end
        end)
    end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
    if uSkills[user_id] ~= nil then
      exports.ghmattimysql:execute("UPDATE vrp_users SET PlayerSkills = ? WHERE id = ?",{json.encode(uSkills[user_id]),user_id})
      uSkills[user_id] = nil
    end
end)

