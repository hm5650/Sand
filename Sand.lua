do
print([[
                                                                           
                                                                           
                              #############                                
                      #############################                        
                   ######+--.....       .....--+######+                    
                  ###+.                          ..-###-                   
                  ###-                              ###-                   
                  ########                      #######-                   
                   ###+############################-+#+                    
                   ###-   ...-+++++++++++++++...   -##+                    
                    ##+.          --               ###-                    
                   ####.         ###.             ###+                     
                   ####+        ###-              ###.                     
                  ######.      ###+               ###.                     
                 ###+.##-      ###-              ###-                      
                 ###+.##+     ###-               ##+.                      
                 ###+ +##-  ####-               ###+                       
                 ###+  ##- -###-                ###-                       
                  ####-######+                 ###+                        
                   ########-                   ###-                        
                      ..-#+.                   ###.                        
                        ###-                  ###-                         
                         ##+                  ###.                         
                         #######################-                          
                           --############+...                              
                                                                           
                                                                           
                                 "am i just bloxstrap in luau :o"                                  
                                                                           
                                                    - Gpssickle                       
]])
--[[
    Author: Gpssickle! (hm5650)
    GithHub: https://github.com/hm5650/Sand/tree/main
    README: https://github.com/hm5650/Sand/blob/main/README.md
    License: MIT
]]
-- if u used a snippet pweaty pwease credit me 3;

--i think I cooked....... myabe :0
local env = (getgenv and getgenv()) or _G
if env.Saaaaaaaaaaaaaaaaaaaaaaand_ then
    return
end
env.Saaaaaaaaaaaaaaaaaaaaaaand_ = true

--uhh btw this script is pairable with gravel.cc :3
local cloneref = cloneref or clonereference or function(inst) return inst end
local UNIQ = string.format("%d_%d_%d_%d_%d",
    math.random(100000000, 999999999),
    math.random(100, 999),
    math.random(10, 99),
    math.random(10000, 99999),
    math.random(100, 999))
local SKY_NAME  = UNIQ .. "_sky"
local FPS_NAME  = UNIQ .. "_fps"
local PING_NAME = UNIQ .. "_ping"
local passed = ...
local cfg = (type(passed) == "table" and passed) or (type(env.cfg) == "table" and env.cfg) or {}
if cfg.createwindui == nil then cfg.createwindui = true end
if cfg.autoload == nil then cfg.autoload = true end
if cfg.autosave == nil then cfg.autosave = true end
cfg.folder = cfg.folder or "Sand.cc"
cfg.file = cfg.file or "autosave.json"
if type(env.__SandCC) == "table" and type(env.__SandCC.unload) == "function" then
    pcall(env.__SandCC.unload)
end
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = cloneref(game:GetService("Players"))
local Lighting = cloneref(game:GetService("Lighting"))
local RunService = cloneref(game:GetService("RunService"))
local HttpService = cloneref(game:GetService("HttpService"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local TextChatService = cloneref(game:GetService("TextChatService"))
local Workspace = cloneref(game:GetService("Workspace"))
local SoundService = cloneref(game:GetService("SoundService"))
local LocalPlayer = Players.LocalPlayer

--state
local alive = true
local State = {}
local Runtime = { penalty = 0, quality = nil, pausedAutoload = nil }
local OwnGuis = setmetatable({}, { __mode = "k" })
local warned = {}
local Threads = {}

local function warnf(msg) warn("[Sand.cc] " .. tostring(msg)) end
local function warnOnce(msg)
    if not warned[msg] then
        warned[msg] = true
        warnf(msg)
    end
end

local function task_(key, fn)
    if Threads[key] then
        pcall(task.cancel, Threads[key])
        Threads[key] = nil
    end
    local thread = task.spawn(function(...)
        local ok, err = pcall(fn, ...)
        if not ok and not string.find(tostring(err), "cancel") then
            warnf("[thread '" .. key .. "'] " .. tostring(err))
        end
    end)
    Threads[key] = thread
    return thread
end

local function killthreads()
    for key, thread in pairs(Threads) do
        pcall(task.cancel, thread)
        Threads[key] = nil
    end
end

--lder
do
    local loaderGui = Instance.new("ScreenGui")
    loaderGui.Name = "392828837_828_88_38828_83"
    loaderGui.ResetOnSpawn = false
    loaderGui.IgnoreGuiInset = true
    loaderGui.DisplayOrder = 2147483647
    local parented = pcall(function() loaderGui.Parent = CoreGui end)
    if not parented or not loaderGui.Parent then
        loaderGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 300, 0, 40)
    container.Position = UDim2.new(0.5, 0, 1, -70)
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    container.BackgroundTransparency = 0.4
    container.BorderSizePixel = 0
    container.Parent = loaderGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = container
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.Code
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Text = "[ / ] loading... :p"
    label.Parent = container
    local startupSound = Instance.new("Sound")
    startupSound.SoundId = "rbxassetid://120092757126147"
    startupSound.Volume = 0.5
    startupSound.Parent = SoundService
    pcall(function() startupSound:Play() end)
    local spinnerFrames = { "[ / ]", "[ | ]", "[ \\ ]", "[ — ]", "[ / ]", }
    local currentFrame = 1
    local isDone = false
    local spinAccum = 0
    local fidgetspinner = 0.1
    local spinConn
    spinConn = RunService.Heartbeat:Connect(function(dt)
        if isDone then return end
        spinAccum = spinAccum + dt
        if spinAccum >= fidgetspinner then
            spinAccum = 0
            currentFrame = currentFrame + 1
            if currentFrame > #spinnerFrames then currentFrame = 1 end
            label.Text = spinnerFrames[currentFrame] .. " loading... :p"
        end
    end)
    local function checkExecutor()
        local missing = {}
        if type(hookmetamethod) ~= "function" then table.insert(missing, "hookmetamethod") end
        if type(hookfunction) ~= "function" then table.insert(missing, "hookfunction") end
        if type(isfolder) ~= "function" then table.insert(missing, "isfolder") end
        if type(makefolder) ~= "function" then table.insert(missing, "makefolder") end
        if type(listfiles) ~= "function" then table.insert(missing, "listfiles") end
        if type(writefile) ~= "function" then table.insert(missing, "writefile") end
        if type(readfile) ~= "function" then table.insert(missing, "readfile") end
        if type(isfile) ~= "function" then table.insert(missing, "isfile") end
        if type(getgenv) ~= "function" then table.insert(missing, "getgenv") end
        return #missing == 0, missing
    end
    task_("loader", function()
        task.wait(0.5)
        local supported, missing = checkExecutor()
        task.wait(1.5)
        isDone = true
        if spinConn then spinConn:Disconnect() spinConn = nil end
        if supported then
            label.Text = "it's donne :3"
            label.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            label.Text = "it's donne? <:3 (missing: " .. table.concat(missing, ", ") .. ")"
            label.TextColor3 = Color3.fromRGB(255, 200, 100)
            label.TextSize = 11
        end
        task.wait(2)
        local TweenService = game:GetService("TweenService")
        local fadeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(container, fadeInfo, { BackgroundTransparency = 1 }):Play()
        TweenService:Create(stroke, fadeInfo, { Transparency = 1 }):Play()
        TweenService:Create(label, fadeInfo, { TextTransparency = 1 }):Play()
        task.wait(0.6)
        pcall(function() loaderGui:Destroy() end)
        task.wait(1)
        pcall(function() startupSound:Destroy() end)
    end)
end

local function clamp(v, lo, hi) return math.max(lo, math.min(hi, v)) end
local function parseKeywords(text)
    local list = {}
    for word in string.gmatch(tostring(text or ""), "[^,;\n]+") do
        word = string.lower((word:gsub("^%s+", ""):gsub("%s+$", "")))
        if word ~= "" then list[#list + 1] = word end
    end
    return list
end
local function matchesAny(name, list)
    if type(list) ~= "table" then return false end
    name = string.lower(tostring(name or ""))
    for i = 1, #list do
        if string.find(name, list[i], 1, true) then return true end
    end
    return false
end
local function inCharacter(inst)
    local p = inst and inst.Parent
    while p and p ~= Workspace do
        if p:IsA("Model") and Players:GetPlayerFromCharacter(p) then return true end
        p = p.Parent
    end
    return false
end
local function isLocalCharacter(inst)
    local char = LocalPlayer.Character
    if not char then return false end
    local p = inst
    while p and p ~= Workspace do
        if p == char then return true end
        p = p.Parent
    end
    return false
end

local function guiParent(gui)
    local ok = pcall(function() gui.Parent = (gethui and gethui()) or CoreGui end)
    if not ok or not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end
local istg = { "sand", "gravel", "windui", "window", }
local totallynotfromgravel = {
    ":l",
    ":u",
    "owo",
    ":3",
    ">:3",
    ";3",
    ":D",
    ">:D",
    ":p",
    ":P",
    "^w^",
    "^_^",
    "o_o",
    "o.0",
    "O.o",
    "n_n",
    ":o",
    ":O",
    ":0",
    ":l",
    ":7",
    ":1",
    ":v",
    ":c",
    ":s",
    "c:",
    ":b",
    ":x",
    ":9",
    ";_;",
    ":^",
    ":/",
    "=_=",
    ">_>",
    "<_<",
    ">:1",
    ">:2",
    "gravel?",
    "uwu",
}
local typesheet = "________________________________"
local buttonTitleIndex = nil
local function actasgravel()
    if #totallynotfromgravel == 0 then return ":3" end
    local idx = math.random(1, #totallynotfromgravel)
    if #totallynotfromgravel > 1 and idx == buttonTitleIndex then
        idx = (idx % #totallynotfromgravel) + 1
    end
    buttonTitleIndex = idx
    return totallynotfromgravel[idx]
end
local donthurtgravelplz = {
    "48621826482727",
    "37276227227277",
    "2918736637167",
    "9373632872636482",
    "8472627274737273",
    "927172638798",
    "391716637363627", 
    "392727384883828",
    "392828837_828_88_38828_83",
}

local function isNumericUnderscoreName(name)
    if name:match("^%d+_%d+_%d+_%d+_%d+$") then return true end
    if name:match("^%d+_%d+_%d+_%d+$") then return true end
    if name:match("^%d+_%d+_%d+$") then return true end
    return false
end

local function isProtectedName(name)
    local n = string.lower(tostring(name or ""))
    for i = 1, #istg do
        if string.find(n, istg[i], 1, true) then return true end
    end
    for i = 1, #donthurtgravelplz do
        if string.find(n, donthurtgravelplz[i], 1, true) then return true end
    end
    if isNumericUnderscoreName(n) then return true end
    return false
end

local function isProtectedGui(inst)
    if not inst then return false end
    local p = inst
    while p do
        if p:IsA("ScreenGui") or p:IsA("LayerCollector") then
            return isProtectedName(p.Name)
        end
        p = p.Parent
    end
    return false
end

local function effectiveDistance() return math.max(20, State.maxDistance - Runtime.penalty) end
local Features, FeatureByKey, InstFeatures, ParamIndex = {}, {}, {}, {}
local Orig = {}
local function weakKeys() return setmetatable({}, { __mode = "k" }) end
local function strongKeys() return {} end
local function setProp(inst, prop, value) inst[prop] = value end

local function touch(f, inst, prop, value)
    local ok, cur = pcall(function() return inst[prop] end)
    if not ok then return end
    local ot = Orig[prop]
    local alreadyOwned = ot and ot[inst] ~= nil
    if not alreadyOwned and cur == value then
        return
    end
    if not ot then
        ot = strongKeys()
        Orig[prop] = ot
    end
    if ot[inst] == nil then ot[inst] = cur end
    local set = f.touched[prop]
    if not set then
        set = strongKeys()
        f.touched[prop] = set
    end
    set[inst] = true
    pcall(setProp, inst, prop, value)
end
local function stouch(f, inst, prop, value) pcall(touch, f, inst, prop, value) end

local function untouchOne(f, inst, prop)
    local set = f.touched and f.touched[prop]
    if not (set and set[inst]) then return end
    set[inst] = nil
    local ot = Orig[prop]
    local orig = ot and ot[inst]
    if orig ~= nil then pcall(setProp, inst, prop, orig) end
    for _, h in ipairs(Features) do
        if h ~= f and h.active and h.touched[prop] and h.touched[prop][inst] then return end
    end
    if ot then ot[inst] = nil end
end

local function untouchAll(f)
    local log = f.touched or {}
    f.touched = {}
    local shared, n = false, 0
    for prop, set in pairs(log) do
        local ot = Orig[prop]
        local rivals = {}
        for _, h in ipairs(Features) do
            if h ~= f and h.active and h.touched[prop] then
                rivals[#rivals + 1] = h.touched[prop]
            end
        end
        for inst in pairs(set) do
            local orig = ot and ot[inst]
            if orig ~= nil then
                pcall(function()
                    if inst.Parent ~= nil then setProp(inst, prop, orig) end
                end)
            end
            local claimed = false
            for i = 1, #rivals do
                if rivals[i][inst] then claimed = true break end
            end
            if claimed then
                shared = true
            elseif ot then
                ot[inst] = nil
            end
            n = n + 1
            if n % 2000 == 0 then task.wait() end
        end
    end
    return shared
end

local function pruneDead()
    local n = 0
    local stashed = {}
    for _, f in ipairs(Features) do
        for _, st in ipairs(f.stash or {}) do stashed[st.obj] = true end
    end
    for _, ot in pairs(Orig) do
        for inst in pairs(ot) do
            local ok, parent = pcall(function() return inst.Parent end)
            if (not ok or parent == nil) and not stashed[inst] then ot[inst] = nil end
            n = n + 1
            if n % 2000 == 0 then task.wait() end
        end
    end
    for _, f in ipairs(Features) do
        for _, set in pairs(f.touched or {}) do
            for inst in pairs(set) do
                local ok, parent = pcall(function() return inst.Parent end)
                if (not ok or parent == nil) and not stashed[inst] then set[inst] = nil end
            end
        end
    end
end

local function cos(input)
    if not input then return nil end
    local function proc(data)
        local result = ""
        for part in data:gmatch("[^%s]+") do
            if part:match("^[01]+$") then
                local num = 0
                for i = 1, #part do
                    num = num * 2 + tonumber(part:sub(i, i))
                end
                result = result .. string.char(num)
            elseif part:match("^[0-9A-Fa-f]+$") and #part % 2 == 0 then
                for i = 1, #part, 2 do
                    local hex = part:sub(i, i+1)
                    result = result .. string.char(tonumber(hex, 16))
                end
            else
                result = result .. part
            end
        end
        return result
    end
    if type(input) == "number" and input > 0 then
        return proc("01010011 01100001 01101110 01100100 00101110 01100011 01100011 20 4C 6F 61 64 65 64 21 20 3A 33 20 28 6D 61 64 65 20 62 79 20 01000111 01110000 01110011 01110011 01101001 01100011 01101011 01101100 01100101 29")
    end
    return "Invalid input"
end
_ = print

local Jobs, Working = {}, false
local function enqueue(fn)
    Jobs[#Jobs + 1] = fn
    if Working then return end
    Working = true
    task_("jobWorker", function()
        while #Jobs > 0 do
            local job = table.remove(Jobs, 1)
            local ok, err = pcall(job)
            if not ok then warnf(err) end
        end
        Working = false
    end)
end
local PartCache = {
    parts = {},
    set = setmetatable({}, { __mode = "k" }),
    conns = {},
    scanning = false,
}
local function isPartCandidate(inst)
    return inst:IsA("BasePart") and inst.ClassName ~= "Terrain"
end
local function startPartCache()
    if PartCache.conns.add then return end
    PartCache.conns.add = Workspace.DescendantAdded:Connect(function(inst)
        if isPartCandidate(inst) and not PartCache.set[inst] then
            PartCache.set[inst] = true
            PartCache.parts[#PartCache.parts + 1] = inst
        end
    end)
    PartCache.conns.remove = Workspace.DescendantRemoving:Connect(function(inst)
        if PartCache.set[inst] then
            PartCache.set[inst] = nil
        end
    end)
    if not PartCache.scanning then
        PartCache.scanning = true
        task_("partCacheScan", function()
            local all = Workspace:GetDescendants()
            for i = 1, #all do
                local inst = all[i]
                if isPartCandidate(inst) and not PartCache.set[inst] then
                    PartCache.set[inst] = true
                    PartCache.parts[#PartCache.parts + 1] = inst
                end
                if i % 2000 == 0 then task.wait() end
            end
            PartCache.scanning = false
        end)
    end
end
local function stopPartCache()
    if PartCache.conns.add then pcall(function() PartCache.conns.add:Disconnect() end) PartCache.conns.add = nil end
    if PartCache.conns.remove then pcall(function() PartCache.conns.remove:Disconnect() end) PartCache.conns.remove = nil end
    PartCache.parts = {}
    PartCache.set = setmetatable({}, { __mode = "k" })
    PartCache.scanning = false
end
local function eachCachedPart(fn)
    local parts = PartCache.parts
    local keep = 1
    local n = #parts
    for i = 1, n do
        local inst = parts[i]
        if inst and inst.Parent ~= nil then
            parts[keep] = inst
            keep = keep + 1
            if not fn(inst) then
                for j = i + 1, n do
                    if parts[j] and parts[j].Parent ~= nil then
                        parts[keep] = parts[j]
                        keep = keep + 1
                    end
                end
                for j = keep, n do parts[j] = nil end
                return
            end
        end
        if i % 2000 == 0 then task.wait() end
    end
    for j = keep, n do parts[j] = nil end
end

local function scan(list)
    local all = Workspace:GetDescendants()
    for i = 1, #all do
        local inst = all[i]
        for j = 1, #list do
            local f = list[j]
            if f.active then pcall(f.onInstance, f, inst) end
        end
        if i % 2500 == 0 then task.wait() end
    end
end

local addedConn
local function refreshHook()
    local need = false
    for _, f in ipairs(InstFeatures) do
        if f.active then need = true break end
    end
    if need and not addedConn then
        addedConn = Workspace.DescendantAdded:Connect(function(inst)
            for _, f in ipairs(InstFeatures) do
                if f.active then pcall(f.onInstance, f, inst) end
            end
        end)
    elseif not need and addedConn then
        addedConn:Disconnect()
        addedConn = nil
    end
end

local function runActivate(list)
    local toScan = {}
    for _, f in ipairs(list) do
        if alive and not f.active then
            f.active = true
            f.touched = {}
            if f.apply then
                local ok, err = pcall(f.apply, f)
                if not ok then warnf(f.title .. ": " .. tostring(err)) end
            end
            if f.onInstance then toScan[#toScan + 1] = f end
        end
    end
    refreshHook()
    if #toScan > 0 then scan(toScan) end
end

local function runDeactivate(f)
    if not f.active then return end
    f.active = false
    if f.cleanup then
        local ok, err = pcall(f.cleanup, f)
        if not ok then warnf(f.title .. ": " .. tostring(err)) end
    end
    local shared = untouchAll(f)
    refreshHook()
    if shared then
        local toScan = {}
        for _, h in ipairs(Features) do
            if h.active then
                if h.apply then pcall(h.apply, h) end
                if h.onInstance then toScan[#toScan + 1] = h end
            end
        end
        if #toScan > 0 then scan(toScan) end
    end
end

local reconcilePending = false
local function reconcile()
    if reconcilePending then return end
    reconcilePending = true
    enqueue(function()
        reconcilePending = false
        local on, off = {}, {}
        for _, f in ipairs(Features) do
            if State[f.key] and not f.active then
                on[#on + 1] = f
            elseif not State[f.key] and f.active then
                off[#off + 1] = f
            end
        end
        for _, f in ipairs(off) do runDeactivate(f) end
        if #on > 0 then runActivate(on) end
    end)
end

local function paramChanged(key)
    for _, g in ipairs(ParamIndex[key] or {}) do
        if g.active then
            enqueue(function()
                if not g.active then return end
                if g.reactivate then
                    runDeactivate(g)
                    if State[g.key] then runActivate({ g }) end
                elseif g.apply then
                    pcall(g.apply, g)
                end
            end)
        end
    end
end

local GREY = Color3.fromRGB(163, 162, 165)
local SURFACES = { "TopSurface", "BottomSurface", "LeftSurface", "RightSurface", "FrontSurface", "BackSurface" }

local function defineFeature(def)
    def.active = false
    def.touched = {}
    Features[#Features + 1] = def
    FeatureByKey[def.key] = def
    if def.onInstance then InstFeatures[#InstFeatures + 1] = def end
    for _, p in ipairs(def.params or {}) do
        ParamIndex[p] = ParamIndex[p] or {}
        table.insert(ParamIndex[p], def)
    end
    return def
end

local function reassert(f) if f.apply then f.apply(f) end end
local function refreshDependents()
    for _, key in ipairs({ "coreSettings", "freezePlayers", "throttleSounds", "anchorDistant", "renderDistance" }) do
        local g = FeatureByKey[key]
        if g and g.active and g.apply then pcall(g.apply, g) end
    end
end
local function soundPosition(snd)
    local p = snd.Parent
    if not p then return nil end
    if p:IsA("BasePart") then return p.Position end
    if p:IsA("Attachment") then return p.WorldPosition end
    return nil
end

local function stashAndDetach(f, inst, parent)
    f.stash = f.stash or {}
    f.stash[#f.stash + 1] = { obj = inst, parent = parent or inst.Parent }
    inst.Parent = nil
end
local function restoreStash(f)
    for _, s in ipairs(f.stash or {}) do
        if s.obj and s.obj.Parent == nil and s.parent then
            pcall(setProp, s.obj, "Parent", s.parent)
        end
    end
    f.stash = {}
end

local function otherCharacters()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then list[#list + 1] = plr.Character end
    end
    return list
end
local function watchCharacters(f, fn)
    if f.charConns then return end
    f.charConns = {}
    local function hook(plr)
        if plr == LocalPlayer then return end
        f.charConns[#f.charConns + 1] = plr.CharacterAdded:Connect(function(char)
            task.spawn(function()
                char:WaitForChild("Humanoid", 10)
                task.wait(0.3)
                if alive and f.active and char.Parent then pcall(fn, char, plr) end
            end)
        end)
    end
    for _, plr in ipairs(Players:GetPlayers()) do hook(plr) end
    f.charConns[#f.charConns + 1] = Players.PlayerAdded:Connect(hook)
end
local function unwatchCharacters(f)
    for _, c in ipairs(f.charConns or {}) do pcall(function() c:Disconnect() end) end
    f.charConns = nil
end
local function animContainer(char)
    return char:FindFirstChildOfClass("Humanoid") or char:FindFirstChildOfClass("AnimationController")
end
local function freezeContainer(f, container)
    f.frozen = f.frozen or {}
    f.frozenConns = f.frozenConns or {}
    local list = f.frozen[container]
    if not list then
        list = {}
        f.frozen[container] = list
        f.frozenConns[container] = container.ChildAdded:Connect(function(child)
            if alive and f.active and f.frozen and f.frozen[container] and child:IsA("Animator") then
                task.defer(function()
                    if alive and f.active and f.frozen and f.frozen[container] then
                        pcall(freezeContainer, f, container)
                    end
                end)
            end
        end)
    end
    for _, animator in ipairs(container:GetChildren()) do
        if animator:IsA("Animator") then
            for _, t in ipairs(animator:GetPlayingAnimationTracks()) do pcall(function() t:Stop(0) end) end
            list[#list + 1] = animator
            animator.Parent = nil
        end
    end
end
local function thawContainer(f, container)
    local list = f.frozen and f.frozen[container]
    if f.frozenConns and f.frozenConns[container] then
        pcall(function() f.frozenConns[container]:Disconnect() end)
        f.frozenConns[container] = nil
    end
    if f.frozen then f.frozen[container] = nil end
    if not list or not container.Parent then return end
    if container:FindFirstChildOfClass("Animator") then return end
    local animator = list[1]
    if animator and animator.Parent == nil then pcall(setProp, animator, "Parent", container) end
end
local function thawAll(f)
    local conts = {}
    for container in pairs(f.frozen or {}) do conts[#conts + 1] = container end
    for _, container in ipairs(conts) do thawContainer(f, container) end
    f.frozen, f.frozenConns = nil, nil
end
local function pruneFrozen(f)
    local dead = {}
    for container in pairs(f.frozen or {}) do
        if not container.Parent then dead[#dead + 1] = container end
    end
    for _, container in ipairs(dead) do
        if f.frozenConns and f.frozenConns[container] then
            pcall(function() f.frozenConns[container]:Disconnect() end)
            f.frozenConns[container] = nil
        end
        f.frozen[container] = nil
    end
end

--defined feats
defineFeature({
    key = "graySky", title = "Gray Sky",
    desc = "Doesn't use fastflags for this btw :>",
    params = { "graySkyl" },
    apply = function(f)
        f.stash = f.stash or {}
        local function stashFrom(parent)
            if not parent then return end
            for _, o in ipairs(parent:GetChildren()) do
                if o ~= f.sky and (o:IsA("Sky") or o:IsA("Atmosphere") or o:IsA("Clouds")) then
                    stashAndDetach(f, o, parent)
                end
            end
        end
        stashFrom(Lighting)
        stashFrom(Workspace:FindFirstChildOfClass("Terrain"))
        local skyOk = f.sky and (pcall(function() return f.sky.Parent end))
        if not skyOk then
            if f.sky then pcall(function() f.sky:Destroy() end) end
            f.sky = Instance.new("Sky")
            f.sky.Name = "SandSky"
        end
        local id = "rbxassetid://114666145996289"
        f.sky.SunAngularSize = 0
        f.sky.MoonAngularSize = 0
        f.sky.StarCount = 0
        f.sky.SkyboxBk, f.sky.SkyboxDn, f.sky.SkyboxFt = id, id, id
        f.sky.SkyboxLf, f.sky.SkyboxRt, f.sky.SkyboxUp = id, id, id
        if f.sky.Parent ~= Lighting then f.sky.Parent = Lighting end
        if not f.removedConn then
            f.removedConn = Lighting.ChildRemoved:Connect(function(child)
                if not alive or not f.active then return end
                if child == f.sky and f.sky and f.sky.Parent ~= Lighting then
                    task.defer(function()
                        if alive and f.active and f.sky then
                            pcall(function() f.sky.Parent = Lighting end)
                        end
                    end)
                end
            end)
        end
    end,
    onInstance = function(f, inst)
        if inst == f.sky then return end
        if inst:IsA("Sky") or inst:IsA("Atmosphere") or inst:IsA("Clouds") then
            stashAndDetach(f, inst)
        end
    end,
    tick = reassert,
    cleanup = function(f)
        if f.removedConn then
            pcall(function() f.removedConn:Disconnect() end)
            f.removedConn = nil
        end
        if f.sky then
            pcall(function() f.sky:Destroy() end)
            f.sky = nil
        end
        restoreStash(f)
    end,
})

defineFeature({
    key = "fullBright", title = "Full Bright",
    desc = "Bright, flat lighting with global shadows off.",
    apply = function(f)
        stouch(f, Lighting, "Brightness", 2)
        stouch(f, Lighting, "GlobalShadows", false)
        stouch(f, Lighting, "OutdoorAmbient", Color3.new(1, 1, 1))
        stouch(f, Lighting, "Ambient", Color3.new(1, 1, 1))
        stouch(f, Lighting, "ExposureCompensation", 0)
    end,
    tick = reassert,
})

defineFeature({
    key = "simplifyLighting", title = "Simplify Lighting",
    desc = "Soft shadows, environment lighting, fog and post-processing effects off.",
    apply = function(f)
        stouch(f, Lighting, "GlobalShadows", false)
        stouch(f, Lighting, "ShadowSoftness", 0)
        stouch(f, Lighting, "EnvironmentDiffuseScale", 0)
        stouch(f, Lighting, "EnvironmentSpecularScale", 0)
        stouch(f, Lighting, "FogEnd", 1000000)
        stouch(f, Lighting, "FogStart", 0)
        for _, holder in ipairs({ Lighting, Workspace.CurrentCamera }) do
            if holder then
                for _, o in ipairs(holder:GetChildren()) do
                    if o:IsA("PostEffect") then stouch(f, o, "Enabled", false) end
                end
            end
        end
    end,
    tick = reassert,
})

defineFeature({
    key = "removeFog", title = "Remove Fog",
    desc = "Pushes fog far away so it never shows.",
    apply = function(f)
        stouch(f, Lighting, "FogEnd", 1000000)
        stouch(f, Lighting, "FogStart", 1000000)
        stouch(f, Lighting, "FogColor", Color3.new(1,1,1))
    end,
    tick = reassert,
})

defineFeature({
    key = "killPostFX", title = "Kill Post Effects",
    desc = "Force-disables every PostEffect (bloom, DOF, sun rays, color correction...).",
    onInstance = function(f, inst)
        if inst:IsA("PostEffect") then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "killBlur", title = "Kill Blur Only",
    desc = "Force-disables only BlurEffect instances (keeps other post effects intact).",
    onInstance = function(f, inst)
        if inst.ClassName == "BlurEffect" then
            touch(f, inst, "Enabled", false)
            touch(f, inst, "Size", 0)
        end
    end,
})

defineFeature({
    key = "killLighting", title = "Kill Lighting",
    desc = "Strips lighting down to the bare minimum: no fog, no shadows, no post effects",
    apply = function(f)
        f.stash = f.stash or {}
        stouch(f, Lighting, "FogEnd", 1e9)
        stouch(f, Lighting, "EnvironmentDiffuseScale", 0)
        stouch(f, Lighting, "EnvironmentSpecularScale", 0)
        stouch(f, Lighting, "GlobalShadows", false)
        stouch(f, Lighting, "ShadowSoftness", 0)
        stouch(f, Lighting, "Brightness", math.max(Lighting.Brightness, 2))
        stouch(f, Lighting, "Ambient", Color3.fromRGB(110, 110, 110))
        stouch(f, Lighting, "OutdoorAmbient", Color3.fromRGB(140, 140, 140))
        local function stashFrom(parent)
            if not parent then return end
            for _, o in ipairs(parent:GetChildren()) do
                if o:IsA("Sky") or o:IsA("Atmosphere") then
                    stashAndDetach(f, o, parent)
                end
            end
        end
        stashFrom(Lighting)
        stashFrom(Workspace:FindFirstChildOfClass("Terrain"))
        for _, holder in ipairs({ Lighting, Workspace.CurrentCamera }) do
            if holder then
                for _, o in ipairs(holder:GetChildren()) do
                    if o:IsA("PostEffect") then stouch(f, o, "Enabled", false) end
                end
            end
        end
    end,
    onInstance = function(f, inst)
        if inst:IsA("PostEffect") then
            touch(f, inst, "Enabled", false)
        elseif inst:IsA("Sky") or inst:IsA("Atmosphere") then
            stashAndDetach(f, inst)
        end
    end,
    tick = reassert,
    cleanup = function(f)
        restoreStash(f)
    end,
})

defineFeature({
    key = "freezeTime", title = "Freeze Time of Day",
    desc = "Locks the game's clock to a fixed hour and blocks server changes.",
    params = { "frozenTime" },
    apply = function(f)
        stouch(f, Lighting, "ClockTime", State.frozenTime)
        stouch(f, Lighting, "GeographicLatitude", 0)
        if not f.conn then
            f.conn = Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
                if alive and f.active and Lighting.ClockTime ~= State.frozenTime then
                    pcall(setProp, Lighting, "ClockTime", State.frozenTime)
                end
            end)
        end
    end,
    tick = reassert,
    cleanup = function(f)
        if f.conn then
            pcall(function() f.conn:Disconnect() end)
            f.conn = nil
        end
    end,
})

defineFeature({
    key = "removeAtmosphere", title = "Remove Atmosphere",
    desc = "Detaches Atmosphere objects from Lighting and Terrain",
    onInstance = function(f, inst)
        if inst:IsA("Atmosphere") then stashAndDetach(f, inst) end
    end,
    apply = function(f)
        for _, holder in ipairs({ Lighting, Workspace:FindFirstChildOfClass("Terrain") }) do
            if holder then
                for _, o in ipairs(holder:GetChildren()) do
                    if o:IsA("Atmosphere") then stashAndDetach(f, o, holder) end
                end
            end
        end
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "removeGrass", title = "Remove Grass",
    desc = "Turns terrain decoration (grass) off.",
    apply = function(f)
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if not terrain then return end
        if f.origDecoration == nil then
            local ok, v = false, nil
            if gethiddenproperty then ok, v = pcall(gethiddenproperty, terrain, "Decoration") end
            if not ok then ok, v = pcall(function() return terrain.Decoration end) end
            if ok and type(v) == "boolean" then f.origDecoration = v else f.origDecoration = true end
        end
        if sethiddenproperty then
            pcall(sethiddenproperty, terrain, "Decoration", false)
        else
            pcall(setProp, terrain, "Decoration", false)
        end
    end,
    tick = reassert,
    cleanup = function(f)
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain and f.origDecoration ~= nil then
            if sethiddenproperty then
                pcall(sethiddenproperty, terrain, "Decoration", f.origDecoration)
            else
                pcall(setProp, terrain, "Decoration", f.origDecoration)
            end
        end
        f.origDecoration = nil
    end,
})

defineFeature({
    key = "simplifyWater", title = "Simplify Water",
    desc = "Flattens water waves and removes reflections.",
    apply = function(f)
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if not terrain then return end
        stouch(f, terrain, "WaterWaveSize", 0)
        stouch(f, terrain, "WaterWaveSpeed", 0)
        stouch(f, terrain, "WaterReflectance", 0)
        stouch(f, terrain, "WaterTransparency", 1)
    end,
    tick = reassert,
})

defineFeature({
    key = "removeTerrainDetail", title = "Low Detail Models",
    desc = "Forces every Model to the cheapest LevelOfDetail (StreamingMesh).",
    onInstance = function(f, inst)
        if inst:IsA("Model") then
            local ok = pcall(function() inst.LevelOfDetail = Enum.ModelLevelOfDetail.StreamingMesh end)
            if not ok then
                for _, d in ipairs(inst:GetDescendants()) do
                    if d.ClassName == "MeshPart" and not inCharacter(d) then
                        touch(f, d, "RenderFidelity", Enum.RenderFidelity.Performance)
                    end
                end
            end
        end
    end,
})

defineFeature({
    key = "smoothPlastic", title = "Smooth Plastic",
    desc = "Every part (except characters) becomes SmoothPlastic with no reflectance.",
    onInstance = function(f, inst)
        if inst:IsA("BasePart") and inst.ClassName ~= "Terrain" and not inCharacter(inst) then
            touch(f, inst, "Material", Enum.Material.SmoothPlastic)
            touch(f, inst, "Reflectance", 0)
        end
    end,
})

defineFeature({
    key = "greybox", title = "Grey-box Props",
    desc = "Parts whose name matches the keywords below turn flat grey and lose their decals.",
    params = { "greyboxKeywords" }, reactivate = true,
    apply = function(f) f.kw = parseKeywords(State.greyboxKeywords) or {} end,
    onInstance = function(f, inst)
        local kw = f.kw or {}
        if #kw == 0 then return end
        if inst:IsA("BasePart") then
            if inst.ClassName ~= "Terrain" and not inCharacter(inst) and matchesAny(inst.Name, kw) then
                touch(f, inst, "Material", Enum.Material.Plastic)
                touch(f, inst, "Color", GREY)
                if inst.ClassName == "Part" then
                    for _, s in ipairs(SURFACES) do touch(f, inst, s, Enum.SurfaceType.Smooth) end
                end
            end
        elseif inst:IsA("Decal") then
            local p = inst.Parent
            if p and p:IsA("BasePart") and not inCharacter(p) and matchesAny(p.Name, kw) then
                touch(f, inst, "Transparency", 1)
            end
        end
    end,
    cleanup = function(f)
        local log = f.touched or {}
        for prop, set in pairs(log) do
            local ot = Orig[prop]
            if ot then
                for inst in pairs(set) do
                    local orig = ot[inst]
                    if orig ~= nil and inst.Parent ~= nil then
                        pcall(setProp, inst, prop, orig)
                    end
                end
            end
        end
    end,
})

defineFeature({
    key = "lowPolyMeshes", title = "Low Poly Meshes",
    desc = "Forces the lowest mesh detail (RenderFidelity: Performance) on every MeshPart.",
    onInstance = function(f, inst)
        if inst.ClassName == "MeshPart" and not inCharacter(inst) then
            touch(f, inst, "RenderFidelity", Enum.RenderFidelity.Performance)
        end
    end,
})

defineFeature({
    key = "hideTextures", title = "Hide Textures",
    desc = "Makes decals and textures invisible",
    params = { "keepImportantTextures", "textureKeywords" }, reactivate = true,
    apply = function(f)
        f.kw = parseKeywords(State.textureKeywords) or {}
        f.backup = f.backup or {}
    end,
    onInstance = function(f, inst)
        if inst:IsA("Decal") and not inCharacter(inst) then
            if State.keepImportantTextures then
                local p = inst.Parent
                if matchesAny(inst.Name, f.kw or {}) or (p and matchesAny(p.Name, f.kw or {})) then return end
            end
            f.backup = f.backup or {}
            if f.backup[inst] == nil then
                local ok, cur = pcall(function() return inst.Transparency end)
                if ok and cur ~= 1 then f.backup[inst] = cur end
            end
            touch(f, inst, "Transparency", 1)
        end
    end,
    cleanup = function(f)
        for inst, orig in pairs(f.backup or {}) do
            pcall(function()
                if inst.Parent ~= nil then inst.Transparency = orig end
            end)
        end
        f.backup = nil
    end,
})

defineFeature({
    key = "removeSurfaceAppearance", title = "Remove SurfaceAppearance",
    desc = "Detaches PBR texture maps from parts and meshes",
    onInstance = function(f, inst)
        if inst.ClassName == "SurfaceAppearance" and not inCharacter(inst) then
            stashAndDetach(f, inst)
        end
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "throttleParticles", title = "Throttle Particles",
    desc = "Switches particle emitters off",
    onInstance = function(f, inst)
        if inst.ClassName == "ParticleEmitter" and not inCharacter(inst) then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "destroyEmitters", title = "Remove Emitters",
    desc = "Detaches particle emitters, trails, fire, smoke and sparkles",
    onInstance = function(f, inst)
        local c = inst.ClassName
        if c == "ParticleEmitter" or c == "Trail" or c == "Fire" or c == "Smoke" or c == "Sparkles" then
            stashAndDetach(f, inst)
        end
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "removeBeams", title = "Remove Beams",
    desc = "Detaches Beam objects (lasers, chains of light, etc)",
    onInstance = function(f, inst)
        if inst.ClassName == "Beam" and not inCharacter(inst) then
            stashAndDetach(f, inst)
        end
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "killLights", title = "Disable Lights",
    desc = "Turns off PointLight, SpotLight and SurfaceLight (characters included).",
    onInstance = function(f, inst)
        local c = inst.ClassName
        if c == "PointLight" or c == "SpotLight" or c == "SurfaceLight" then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "noShadows", title = "Disable Part Shadows",
    desc = "Parts stop casting shadows.",
    onInstance = function(f, inst)
        if inst:IsA("BasePart") and inst.ClassName ~= "Terrain" then
            touch(f, inst, "CastShadow", false)
        end
    end,
})

defineFeature({
    key = "disableConstraints", title = "Disable Constraints",
    desc = "Turns off align, hinge, rod and motor constraints in the world.",
    onInstance = function(f, inst)
        local c = inst.ClassName
        if (c == "AlignPosition" or c == "AlignOrientation" or c == "HingeConstraint"
            or c == "RodConstraint" or c == "Motor") and not inCharacter(inst) then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "disableHighlights", title = "Disable Highlights",
    desc = "Detaches Highlight instances from the world",
    onInstance = function(f, inst)
        if inst.ClassName == "Highlight" and not inCharacter(inst) then
            stashAndDetach(f, inst)
        end
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "disableSelectionBoxes", title = "Disable Selection Boxes",
    desc = "Detaches SelectionBox and SelectionSphere instances",
    onInstance = function(f, inst)
        local c = inst.ClassName
        if c == "SelectionBox" or c == "SelectionSphere" then
            stashAndDetach(f, inst)
        end
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "disableLegacyEffects", title = "Disable Fire/Smoke/Sparkles",
    desc = "Turns off the old Fire, Smoke and Sparkles effects.",
    onInstance = function(f, inst)
        local c = inst.ClassName
        if c == "Fire" or c == "Smoke" or c == "Sparkles" then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "disableForceFields", title = "Hide ForceField Bubbles",
    desc = "Makes spawn ForceField bubbles invisible.",
    onInstance = function(f, inst)
        if inst.ClassName == "ForceField" then
            touch(f, inst, "Visible", false)
        end
    end,
})

defineFeature({
    key = "removeGuiEffects", title = "Remove GUI Effects",
    desc = "Removes UIGradient, UIStroke and UIShadow from other ScreenGuis. Sand/Gravel/WindUI preserved.",
    onInstance = function(f, inst)
        local c = inst.ClassName
        if c ~= "UIGradient" and c ~= "UIStroke" and c ~= "UIShadow" then return end
        if isProtectedGui(inst) then return end
        stashAndDetach(f, inst)
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "hideOtherPlayers", title = "Hide Other Players",
    desc = "Hides every other player's character parts from your view.",
    apply = function(f)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                for _, d in ipairs(plr.Character:GetDescendants()) do
                    if d:IsA("BasePart") or d:IsA("Decal") then
                        touch(f, d, "Transparency", 1)
                    elseif d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
                        touch(f, d, "Enabled", false)
                    end
                end
            end
        end
        watchCharacters(f, function() f.apply(f) end)
    end,
    tick = reassert,
    cleanup = function(f) unwatchCharacters(f) end,
})

defineFeature({
    key = "hideNametags", title = "Hide Nametags",
    desc = "Hides name/health displays above other players (default overhead names + custom billboards).",
    apply = function(f)
        for _, char in ipairs(otherCharacters()) do
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                stouch(f, hum, "DisplayDistanceType", Enum.HumanoidDisplayDistanceType.None)
                stouch(f, hum, "HealthDisplayType", Enum.HumanoidHealthDisplayType.AlwaysOff)
            end
            for _, d in ipairs(char:GetDescendants()) do
                if d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
                    stouch(f, d, "Enabled", false)
                end
            end
        end
        watchCharacters(f, function() f.apply(f) end)
    end,
    onInstance = function(f, inst)
        if inst:IsA("BillboardGui") or inst:IsA("SurfaceGui") then
            if inCharacter(inst) and not isLocalCharacter(inst) then
                touch(f, inst, "Enabled", false)
            elseif inst:IsA("BillboardGui") then
                local a = inst.Adornee
                if a and inCharacter(a) and not isLocalCharacter(a) then
                    touch(f, inst, "Enabled", false)
                end
            end
        elseif inst:IsA("Humanoid") then
            local char = inst.Parent
            if char and Players:GetPlayerFromCharacter(char) and not isLocalCharacter(char) then
                touch(f, inst, "DisplayDistanceType", Enum.HumanoidDisplayDistanceType.None)
                touch(f, inst, "HealthDisplayType", Enum.HumanoidHealthDisplayType.AlwaysOff)
            end
        end
    end,
    tick = reassert,
    cleanup = function(f) unwatchCharacters(f) end,
})

defineFeature({
    key = "removeAccessories", title = "Remove Player Accessories",
    desc = "Detaches hats and accessories from other players",
    apply = function(f)
        for _, char in ipairs(otherCharacters()) do
            for _, o in ipairs(char:GetChildren()) do
                if o:IsA("Accessory") then stashAndDetach(f, o, char) end
            end
        end
        watchCharacters(f, function() f.apply(f) end)
    end,
    onInstance = function(f, inst)
        if not inst:IsA("Accessory") then return end
        if inCharacter(inst) and not isLocalCharacter(inst) then
            stashAndDetach(f, inst)
        end
    end,
    tick = reassert,
    cleanup = function(f)
        unwatchCharacters(f)
        restoreStash(f)
    end,
})

defineFeature({
    key = "freezeAllAnimations", title = "Freeze Other Animations",
    desc = "Stops other players' animations entirely",
    apply = function(f)
        f.frozen = f.frozen or {}
        pruneFrozen(f)
        for _, char in ipairs(otherCharacters()) do
            local c = animContainer(char)
            if c then pcall(freezeContainer, f, c) end
        end
        watchCharacters(f, function(char)
            local c = animContainer(char)
            if c then freezeContainer(f, c) end
        end)
    end,
    tick = reassert,
    cleanup = function(f)
        unwatchCharacters(f)
        thawAll(f)
    end,
})

defineFeature({
    key = "disableExplosions", title = "Disable Explosions",
    desc = "Detaches Explosion instances on spawn.",
    onInstance = function(f, inst)
        if inst.ClassName == "Explosion" then
            stashAndDetach(f, inst)
        end
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "silenceAmbientSound", title = "Mute Ambient Sounds",
    desc = "Mutes ambient SoundGroups and effects from SoundService.",
    apply = function(f)
        stouch(f, SoundService, "AmbientReverb", Enum.ReverbType.NoReverb)
        for _, d in ipairs(SoundService:GetDescendants()) do
            if d:IsA("Sound") then touch(f, d, "Volume", 0) end
            if d:IsA("SoundGroup") then touch(f, d, "Volume", 0) end
        end
    end,
    onInstance = function(f, inst)
        if inst:IsA("Sound") or inst:IsA("SoundGroup") then
            touch(f, inst, "Volume", 0)
        end
    end,
    tick = reassert,
})

defineFeature({
    key = "muteSounds", title = "Mute All Sounds",
    desc = "Mutes every Sound in the world (characters included).",
    apply = function(f)
        f.sounds = f.sounds or weakKeys()
        for _, d in ipairs(Workspace:GetDescendants()) do
            if d:IsA("Sound") then
                f.sounds[d] = true
                touch(f, d, "Volume", 0)
            end
        end
    end,
    onInstance = function(f, inst)
        if inst:IsA("Sound") then
            f.sounds = f.sounds or weakKeys()
            f.sounds[inst] = true
            touch(f, inst, "Volume", 0)
        end
    end,
    tick = function(f)
        for snd in pairs(f.sounds or {}) do
            if snd.Parent and snd.Volume ~= 0 then
                touch(f, snd, "Volume", 0)
            end
        end
    end,
    cleanup = function(f) f.sounds = nil end,
})

defineFeature({
    key = "muteSoundGroups", title = "Mute Sound Groups",
    desc = "Sets every SoundGroup volume to 0.",
    apply = function(f)
        for _, d in ipairs(SoundService:GetDescendants()) do
            if d:IsA("SoundGroup") then touch(f, d, "Volume", 0) end
        end
    end,
    onInstance = function(f, inst)
        if inst:IsA("SoundGroup") then touch(f, inst, "Volume", 0) end
    end,
    tick = reassert,
})

defineFeature({
    key = "noCharacterSounds", title = "Mute Character Sounds",
    desc = "Mutes footsteps and other sounds inside other players' characters.",
    apply = function(f)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                for _, d in ipairs(plr.Character:GetDescendants()) do
                    if d:IsA("Sound") then touch(f, d, "Volume", 0) end
                end
            end
        end
        watchCharacters(f, function() f.apply(f) end)
    end,
    onInstance = function(f, inst)
        if not inst:IsA("Sound") then return end
        if inCharacter(inst) and not isLocalCharacter(inst) then
            touch(f, inst, "Volume", 0)
        end
    end,
    tick = reassert,
    cleanup = function(f) unwatchCharacters(f) end,
})

defineFeature({
    key = "disableTrails", title = "Disable Trails",
    desc = "Turns off Trail objects instead of destroying them.",
    onInstance = function(f, inst)
        if inst.ClassName == "Trail" and not inCharacter(inst) then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "disableBeams", title = "Disable Beams",
    desc = "Turns off Beam objects instead of destroying them.",
    onInstance = function(f, inst)
        if inst.ClassName == "Beam" and not inCharacter(inst) then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "reducedReflections", title = "No Reflections",
    desc = "Sets Reflectance to 0 on every base part.",
    onInstance = function(f, inst)
        if inst:IsA("BasePart") and inst.ClassName ~= "Terrain" and not inCharacter(inst) then
            if inst.Reflectance ~= 0 then touch(f, inst, "Reflectance", 0) end
        end
    end,
})

defineFeature({
    key = "clearSurfaceGui", title = "Hide SurfaceGuis",
    desc = "Hides SurfaceGui elements in the world.",
    onInstance = function(f, inst)
        if inst:IsA("SurfaceGui") and not inCharacter(inst) then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "hideBillboards", title = "Hide BillboardGuis",
    desc = "Hides BillboardGui elements in the world (not on characters).",
    onInstance = function(f, inst)
        if inst:IsA("BillboardGui") and not inCharacter(inst) then
            touch(f, inst, "Enabled", false)
        end
    end,
})

defineFeature({
    key = "skipParticleRate", title = "Throttle Emitter Rate",
    desc = "Clamps high particle emission rates to a small value.",
    params = { "maxEmitRate" },
    onInstance = function(f, inst)
        if inst.ClassName == "ParticleEmitter" and not inCharacter(inst) then
            if inst.Rate > State.maxEmitRate then
                touch(f, inst, "Rate", State.maxEmitRate)
            end
        end
    end,
    tick = reassert,
})

defineFeature({
    key = "coreSettings",
    title = "Core Settings",
    desc = "Lowest quality level, mesh and texture detail.",
    params = { "qualityLevel" },
    apply = function(f)
        local level = Runtime.quality or State.qualityLevel
        local okR, rendering = pcall(function()
            return settings().Rendering
        end)
        if okR and rendering then
            local ql = level
            local okE, item = pcall(function()
                return Enum.QualityLevel:FromValue(level)
            end)
            if okE and item then
                ql = item
            end
            stouch(f, rendering, "QualityLevel", ql)
            pcall(function()
                stouch(f, rendering, "MeshPartDetailLevel",
                    Enum.MeshPartDetailLevel.Level01)
            end)
            pcall(function()
                stouch(f, rendering, "TextureQuality",
                    Enum.TextureQuality.Low)
            end)
        end
        local okP, physics = pcall(function()
            return settings().Physics
        end)
        if okP and physics then
            stouch(f, physics, "AllowSleep", true)
        end
    end,
})

local function fflagReady()
    return type(setfflag) == "function" and type(getfflag) == "function"
end

local function fflagprefix(flag)
    if type(flag) ~= "string" then return nil end
    return (flag
        :gsub("^DFInt", "")
        :gsub("^DFFlag", "")
        :gsub("^DFString", "")
        :gsub("^DFLog", "")
        :gsub("^DFDouble", "")
        :gsub("^DFBool", "")
        :gsub("^FFlag", "")
        :gsub("^FInt", "")
        :gsub("^FString", "")
        :gsub("^FLog", "")
        :gsub("^FDouble", "")
        :gsub("^FBool", "")
        :gsub("^FValue", "")
        :gsub("^DFValue", "")
        :gsub("^FLua", "")
        :gsub("^DFLua", "")
        :gsub("^FNet", "")
        :gsub("^DFNet", "")
        :gsub("^FStringArray", "")
        :gsub("^DFStringArray", "")
        :gsub("^FIntArray", "")
        :gsub("^DFIntArray", ""))
end

local function parseFlagJSON(text)
    if type(text) ~= "string" then return nil, "input is not a string" end
    local trimmed = text:gsub("^%s+", ""):gsub("%s+$", "")
    if trimmed == "" then return nil, "empty" end
    local ok, data = pcall(function() return HttpService:JSONDecode(trimmed) end)
    if not ok or type(data) ~= "table" then
        return nil, "invalid JSON"
    end
    return data
end

local FFState = {
    appliedTable = {},
    prevValues  = {},
    unknownPrev = {},
    prevNames = {},
    busy = false,
    failedList = {},
    refreshFailed = nil,
}

local ffOrigPath = cfg.folder .. "/fflag_originals.json"
local function ffFsOk()
    return type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function"
end

local function saveFFOriginals()
    if not ffFsOk() then return end
    if makefolder and not (isfolder and isfolder(cfg.folder)) then pcall(makefolder, cfg.folder) end
    local data, any = {}, false
    for k, v in pairs(FFState.prevValues) do
        data[k] = { v = v, n = FFState.prevNames[k] }
        any = true
    end
    if not any then
        if isfile(ffOrigPath) then
            if type(delfile) == "function" then
                pcall(delfile, ffOrigPath)
            else
                pcall(writefile, ffOrigPath, "{}")
            end
        end
        return
    end
    local okV, ver = pcall(function() return version() end)
    if okV and type(ver) == "string" then data.__ver = ver end
    local ok, err = pcall(function() writefile(ffOrigPath, HttpService:JSONEncode(data)) end)
    if not ok then warnOnce("couldn't save flag originals: " .. tostring(err)) end
end

local function loadFFOriginals()
    if not (ffFsOk() and isfile(ffOrigPath)) then return end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(ffOrigPath)) end)
    if not ok or type(data) ~= "table" then return end
    local okV, ver = pcall(function() return version() end)
    if okV and type(ver) == "string" and type(data.__ver) == "string" and data.__ver ~= ver then
        return
    end
    for k, e in pairs(data) do
        if type(k) == "string" and type(e) == "table" and e.v ~= nil and FFState.prevValues[k] == nil then
            FFState.prevValues[k] = tostring(e.v)
            if type(e.n) == "string" then FFState.prevNames[k] = e.n end
        end
    end
end
loadFFOriginals()

local function setFailedFlags(list)
    FFState.failedList = list or {}
    if FFState.refreshFailed then pcall(FFState.refreshFailed) end
end

local function ffNotify(content, duration)
    if WindUI and WindUI.Notify then
        pcall(function()
            WindUI:Notify({ Title = "Sand", Content = content, Duration = duration or 4 })
        end)
    end
end

local ffslice = 0.006
local function newSlicer()
    local last = os.clock()
    return function()
        if os.clock() - last >= ffslice then
            task.wait()
            last = os.clock()
        end
    end
end

local function readFlag(full, bare)
    local tries = { bare }
    if type(full) == "string" and full ~= bare then tries[#tries + 1] = full end
    for _, name in ipairs(tries) do
        local ok, v = pcall(getfflag, name)
        if ok and v ~= nil and tostring(v) ~= "" then
            return tostring(v), name
        end
    end
    return nil
end

local function ensurePruned(slice)
    if FFState.pruned then return end
    FFState.pruned = true
    local drop = {}
    for bare, prev in pairs(FFState.prevValues) do
        local name = FFState.prevNames[bare] or bare
        local ok, now = pcall(getfflag, name)
        if ok and now ~= nil and tostring(now) ~= ""
            and tostring(now):lower() == tostring(prev):lower() then
            drop[#drop + 1] = bare
        end
        slice()
    end
    for _, bare in ipairs(drop) do
        FFState.prevValues[bare] = nil
        FFState.prevNames[bare] = nil
    end
    if #drop > 0 then saveFFOriginals() end
end

local function applyFFlagTable(tbl)
    if not fflagReady() then
        warnOnce("setfflag/getfflag aren't available in this executor")
        return 0, 0
    end
    FFState.prevValues = FFState.prevValues or {}
    local slice = newSlicer()
    ensurePruned(slice)
    local applied, failed = 0, 0
    local failedNames = {}
    for flag, value in pairs(tbl) do
        local bare = fflagprefix(flag)
        if not bare then
            failed = failed + 1
            failedNames[#failedNames + 1] = tostring(flag)
        else
            if FFState.prevValues[bare] == nil and not FFState.unknownPrev[bare] then
                local cur, usedName = readFlag(flag, bare)
                if cur ~= nil then
                    FFState.prevValues[bare] = cur
                    FFState.prevNames[bare] = usedName
                else
                    FFState.unknownPrev[bare] = true
                end
            end
            local ok = pcall(setfflag, bare, tostring(value))
            if ok then
                applied = applied + 1
            else
                failed = failed + 1
                failedNames[#failedNames + 1] = tostring(flag)
            end
        end
        slice()
    end
    table.sort(failedNames)
    return applied, failed, failedNames
end

local function runFFlagJob(tbl, done)
    if FFState.busy then
        ffNotify("Still chewing on the last batch, give it a sec :o", 3)
        return false
    end
    FFState.busy = true
    setFailedFlags({})
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    if count > 100 then
        ffNotify(string.format("Applying %d flags in chunks.. wait a sec :p", count), 4)
    end
    task.spawn(function()
        local ok, applied, failed, failedNames = pcall(applyFFlagTable, tbl)
        FFState.busy = false
        saveFFOriginals()
        if not ok then
            ffNotify("Flag injection errored: " .. tostring(applied), 5)
            return
        end
        setFailedFlags(failedNames)
        FFState.appliedTable = tbl
        if done then done(applied, failed) end
    end)
    return true
end

defineFeature({
    key = "fastFlags", title = "Fast Flags",
    desc = "Inject custom Roblox fast flags from a JSON dictionary. Requires setfflag.",
    params = { "fflagJSON" },
    supported = function() return fflagReady() end,
    apply = function(f)
        if not fflagReady() then
            warnOnce("Fast Flags needs setfflag/getfflag")
            return
        end
        local tbl, err = parseFlagJSON(State.fflagJSON)
        if not tbl then
            warnOnce("Fast Flags: " .. tostring(err))
            return
        end
        runFFlagJob(tbl, function(applied, failed)
            f.lastCount = applied
            ffNotify(string.format("Injected %d fastflag%s%s", applied, applied == 1 and "" or "s",
                failed > 0 and (" (" .. failed .. " failed)") or ""))
            if applied > 0 then
                print(string.format("[Sand.cc] Fast Flags: injected %d fastflag(s)", applied))
            end
        end)
    end,
    cleanup = function(f)
        f.lastCount = nil
    end,
})

defineFeature({
    key = "fpsUnlock", title = "FPS Cap",
    desc = "Sets the frame rate cap with setfpscap.",
    params = { "fpsCap" },
    supported = function() return setfpscap ~= nil end,
    apply = function(f)
        if not setfpscap then
            warnOnce("setfpscap isn't available in this executor")
            return
        end
        pcall(setfpscap, State.fpsCap)
    end,
    tick = reassert,
    cleanup = function() if setfpscap then pcall(setfpscap, 60) end end,
})

defineFeature({
    key = "memoryCleanup", title = "Memory Cleanup",
    desc = "Runs a garbage collection whenever script memory passes the threshold.",
    params = { "memoryThresholdMB" },
    tick = function(f)
        if collectgarbage("count") > State.memoryThresholdMB * 1024 then
            if not pcall(collectgarbage, "collect") then
                warnOnce("collectgarbage('collect') isn't allowed here")
            end
        end
    end,
})

defineFeature({
    key = "adaptive", title = "Adaptive Performance",
    desc = "When FPS drops below the threshold, forces quality level 1 and shrinks the max distance.",
    params = { "fpsThreshold" },
    apply = function(f)
        if not f.conn then
            f.frames, f.t0 = 0, os.clock()
            f.conn = RunService.Heartbeat:Connect(function() f.frames = f.frames + 1 end)
        end
    end,
    tick = function(f)
        local now = os.clock()
        local fps = f.frames / math.max(now - f.t0, 0.001)
        f.frames, f.t0 = 0, now
        if fps < State.fpsThreshold then
            Runtime.penalty = math.min(Runtime.penalty + 10, math.max(State.maxDistance - 20, 0))
            Runtime.quality = 1
            refreshDependents()
        elseif Runtime.penalty > 0 and fps > State.fpsThreshold + 10 then
            Runtime.penalty = math.max(Runtime.penalty - 10, 0)
            if Runtime.penalty == 0 then Runtime.quality = nil end
            refreshDependents()
        end
    end,
    cleanup = function(f)
        if f.conn then
            f.conn:Disconnect()
            f.conn = nil
        end
        Runtime.penalty, Runtime.quality = 0, nil
        refreshDependents()
    end,
})

defineFeature({
    key = "antiAFK", title = "Anti-AFK",
    desc = "Prevents the 20-minute idle disconnect by simulating activity.",
    apply = function(f)
        if f.conn then return end
        f.last = os.clock()
        f.conn = RunService.Heartbeat:Connect(function()
            if not alive or not f.active then return end
            local now = os.clock()
            if now - f.last > 60 then
                f.last = now
                pcall(function()
                    local vu = game:GetService("VirtualUser")
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new(0, 0))
                end)
            end
        end)
    end,
    cleanup = function(f)
        if f.conn then
            f.conn:Disconnect()
            f.conn = nil
        end
    end,
})

defineFeature({
    key = "fpsCounter", title = "FPS Counter",
    desc = "Small FPS label in the top-left corner.",
    apply = function(f)
        if f.gui then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = FPS_NAME
        gui.ResetOnSpawn = false
        gui.DisplayOrder = 999999
        local label = Instance.new("TextLabel")
        label.Name = "FPSLabel"
        label.Size = UDim2.fromOffset(86, 22)
        label.Position = UDim2.fromOffset(8, 8)
        label.BackgroundColor3 = Color3.new(0, 0, 0)
        label.BackgroundTransparency = 0.4
        label.TextColor3 = Color3.fromRGB(80, 255, 120)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.Text = "FPS: ?"
        label.Parent = gui
        guiParent(gui)
        f.gui = gui
        local acc, frames = 0, 0
        f.conn = RunService.Heartbeat:Connect(function(dt)
            if not alive then return end
            acc = acc + dt
            frames = frames + 1
            if acc >= 0.5 then
                pcall(function()
                    label.Text = string.format("FPS: %d", math.floor(frames / acc + 0.5))
                end)
                acc, frames = 0, 0
            end
        end)
    end,
    cleanup = function(f)
        if f.conn then
            f.conn:Disconnect()
            f.conn = nil
        end
        if f.gui then
            pcall(function() f.gui:Destroy() end)
            f.gui = nil
        end
    end,
})

defineFeature({
    key = "pingCounter", title = "Ping Counter",
    desc = "Shows current ping below the FPS label.",
    apply = function(f)
        if f.gui then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = PING_NAME
        gui.ResetOnSpawn = false
        gui.DisplayOrder = 999998
        local label = Instance.new("TextLabel")
        label.Name = "PingLabel"
        label.Size = UDim2.fromOffset(86, 22)
        label.Position = UDim2.fromOffset(8, 32)
        label.BackgroundColor3 = Color3.new(0, 0, 0)
        label.BackgroundTransparency = 0.4
        label.TextColor3 = Color3.fromRGB(120, 200, 255)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.Text = "Ping: ?"
        label.Parent = gui
        guiParent(gui)
        f.gui = gui
        f.acc = 0
        f.conn = RunService.Heartbeat:Connect(function(dt)
            if not alive then return end
            f.acc = f.acc + dt
            if f.acc >= 0.5 then
                f.acc = 0
                local ok, ping = pcall(function()
                    return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                end)
                if ok and ping then
                    pcall(function()
                        label.Text = string.format("Ping: %d ms", math.floor(ping + 0.5))
                    end)
                end
            end
        end)
    end,
    cleanup = function(f)
        if f.conn then f.conn:Disconnect() f.conn = nil end
        if f.gui then pcall(function() f.gui:Destroy() end) f.gui = nil end
    end,
})

defineFeature({
    key = "freezePlayers", title = "Freeze Distant Players",
    desc = "Stops animations of other players beyond the max distance (rechecked every fraction of a second).",
    params = { "maxDistance", "freezeBehindCamera", "freezeCheckRate" },
    apply = function(f)
        f.frozen = f.frozen or {}
        pruneFrozen(f)
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return end
        local cam = Workspace.CurrentCamera
        local limit = effectiveDistance()
        for _, char in ipairs(otherCharacters()) do
            local container = animContainer(char)
            local root = char:FindFirstChild("HumanoidRootPart")
            if container and root then
                local isFrozen = f.frozen[container] ~= nil
                local lim = isFrozen and limit * 0.95 or limit
                local freeze = (root.Position - myRoot.Position).Magnitude > lim
                if not freeze and State.freezeBehindCamera and cam then
                    local dir = root.Position - cam.CFrame.Position
                    if dir.Magnitude > 0.01 and dir.Unit:Dot(cam.CFrame.LookVector) < 0 then freeze = true end
                end
                if freeze then
                    pcall(freezeContainer, f, container)
                elseif isFrozen then
                    thawContainer(f, container)
                end
            end
        end
        if not f.conn then
            f.acc = 0
            f.conn = RunService.Heartbeat:Connect(function(dt)
                if not alive or not f.active then return end
                f.acc = f.acc + dt
                if f.acc >= clamp(State.freezeCheckRate or 0.5, 0.1, 5) then
                    f.acc = 0
                    local ok, err = pcall(f.apply, f)
                    if not ok then warnOnce("Freeze Distant Players: " .. tostring(err)) end
                end
            end)
        end
    end,
    tick = reassert,
    cleanup = function(f)
        if f.conn then f.conn:Disconnect() f.conn = nil end
        thawAll(f)
    end,
})

defineFeature({
    key = "removeClothing", title = "Remove Player Clothing",
    desc = "Detaches shirts, pants and graphic shirts from other players\n \n(ik what your thinking o///o)",
    apply = function(f)
        for _, char in ipairs(otherCharacters()) do
            for _, o in ipairs(char:GetChildren()) do
                if o:IsA("Shirt") or o:IsA("Pants") or o:IsA("ShirtGraphic") or o:IsA("CharacterMesh") then
                    stashAndDetach(f, o, char)
                end
            end
        end
        watchCharacters(f, function() f.apply(f) end)
    end,
    onInstance = function(f, inst)
        if inst:IsA("Shirt") or inst:IsA("Pants") or inst:IsA("ShirtGraphic") or inst:IsA("CharacterMesh") then
            if inCharacter(inst) and not isLocalCharacter(inst) then stashAndDetach(f, inst) end
        end
    end,
    tick = reassert,
    cleanup = function(f)
        unwatchCharacters(f)
        restoreStash(f)
    end,
})

defineFeature({
    key = "hideTools", title = "Hide Held Tools",
    desc = "Detaches tools other players are holding from their characters",
    apply = function(f)
        for _, char in ipairs(otherCharacters()) do
            for _, o in ipairs(char:GetChildren()) do
                if o:IsA("Tool") then stashAndDetach(f, o, char) end
            end
        end
    end,
    onInstance = function(f, inst)
        if inst:IsA("Tool") and inCharacter(inst) and not isLocalCharacter(inst) then
            stashAndDetach(f, inst)
        end
    end,
    tick = reassert,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "anchorDistant", title = "Anchor Distant Objects",
    desc = "Anchors unanchored parts beyond the max distance.",
    params = { "maxDistance", "anchorBehindCamera" },
    apply = function(f)
        f.anchored = f.anchored or weakKeys()
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return end
        local cam = Workspace.CurrentCamera
        local limit = effectiveDistance()
        local origin = myRoot.Position
        local seen = {}
        eachCachedPart(function(inst)
            if not alive or not f.active then return false end
            if not inst.Anchored and not inCharacter(inst) then
                local okPos, pos = pcall(function() return inst.Position end)
                if okPos then
                    local d = (pos - origin).Magnitude
                    local shouldAnchor = d > limit
                    if not shouldAnchor and State.anchorBehindCamera and cam then
                        local dir = pos - cam.CFrame.Position
                        if dir.Magnitude > 0.01 and dir.Unit:Dot(cam.CFrame.LookVector) < 0 then
                            shouldAnchor = true
                        end
                    end
                    if shouldAnchor then
                        if not f.anchored[inst] then
                            f.anchored[inst] = true
                            pcall(setProp, inst, "Anchored", true)
                        end
                        seen[inst] = true
                    end
                end
            end
            return true
        end)
        for inst in pairs(f.anchored) do
            if not seen[inst] or not inst.Parent then
                if inst.Parent then pcall(setProp, inst, "Anchored", false) end
                f.anchored[inst] = nil
            end
        end
    end,
    tick = reassert,
    cleanup = function(f)
        for inst in pairs(f.anchored or {}) do
            if inst.Parent then pcall(setProp, inst, "Anchored", false) end
        end
        f.anchored = nil
    end,
})

defineFeature({
    key = "renderDistance", title = "Render Distance",
    desc = "Hides parts beyond the render distance slider. StreamingEnabled games are skipped.",
    params = { "renderDistance" },
    apply = function(f)
        if Workspace.StreamingEnabled then return end
        f.hidden = f.hidden or weakKeys()
        f:_run()
    end,
    _run = function(f)
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return end
        local origin = myRoot.Position
        local limit = State.renderDistance
        local seen = {}
        eachCachedPart(function(inst)
            if not alive or not f.active then return false end
            if not inCharacter(inst) then
                local okPos, pos = pcall(function() return inst.Position end)
                if okPos then
                    local d = (pos - origin).Magnitude
                    if d > limit then
                        if not f.hidden[inst] then
                            f.hidden[inst] = true
                            touch(f, inst, "Transparency", 1)
                        end
                        seen[inst] = true
                    end
                end
            end
            return true
        end)
        for inst in pairs(f.hidden) do
            if not seen[inst] or not inst.Parent then
                if inst.Parent then untouchOne(f, inst, "Transparency") end
                f.hidden[inst] = nil
            end
        end
    end,
    tick = function(f)
        if Workspace.StreamingEnabled then return end
        f:_run()
    end,
    cleanup = function(f)
        if f.hidden then
            for inst in pairs(f.hidden) do
                if inst.Parent then untouchOne(f, inst, "Transparency") end
            end
        end
        f.hidden = nil
    end,
})

defineFeature({
    key = "throttleSounds", title = "Throttle Sounds",
    desc = "Pauses sounds beyond the max distance and turns them down past half of it.",
    params = { "maxDistance" },
    apply = function(f)
        f.sounds = f.sounds or weakKeys()
        f.paused = f.paused or weakKeys()
    end,
    onInstance = function(f, inst)
        if inst.ClassName == "Sound" and f.sounds then f.sounds[inst] = true end
    end,
    tick = function(f)
        local myChar = LocalPlayer.Character
        local root = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not (root and f.sounds) then return end
        local limit = effectiveDistance()
        for snd in pairs(f.sounds) do
            local pos = soundPosition(snd)
            if pos then
                local d = (pos - root.Position).Magnitude
                if d > limit then
                    if snd.Playing and not f.paused[snd] then
                        f.paused[snd] = true
                        pcall(function() snd:Pause() end)
                    end
                else
                    if f.paused[snd] then
                        f.paused[snd] = nil
                        pcall(function() if snd.IsPaused then snd:Resume() end end)
                    end
                    if d > limit / 2 then
                        local ot = Orig.Volume
                        local base = (ot and ot[snd]) or snd.Volume
                        touch(f, snd, "Volume", base * 0.3)
                    else
                        untouchOne(f, snd, "Volume")
                    end
                end
            end
        end
    end,
    cleanup = function(f)
        for snd in pairs(f.paused or {}) do
            pcall(function() if snd.IsPaused then snd:Resume() end end)
        end
        f.sounds, f.paused = nil, nil
    end,
})

defineFeature({
    key = "throttleRemotes", title = "Throttle Remote Events",
    desc = "Drops FireServer calls from game scripts above the limit per remote.",
    params = { "remoteLimit" },
    supported = function() return hookmetamethod ~= nil and getnamecallmethod ~= nil end,
    apply = function(f)
        if f.hooked then return end
        if not (hookmetamethod and getnamecallmethod) then
            warnOnce("Throttle Remote Events needs hookmetamethod")
            return
        end
        local windows = weakKeys()
        local wrap = newcclosure or function(fn) return fn end
        local old
        old = hookmetamethod(game, "__namecall", wrap(function(self, ...)
            local method = getnamecallmethod()
            if f.active and method == "FireServer" and typeof(self) == "Instance" then
                local cn = self.ClassName
                if (cn == "RemoteEvent" or cn == "UnreliableRemoteEvent") and not (checkcaller and checkcaller()) then
                    local now = os.clock()
                    local w = windows[self]
                    if not w or now - w.t >= 1 then
                        w = { t = now, n = 0 }
                        windows[self] = w
                    end
                    w.n = w.n + 1
                    if w.n > State.remoteLimit then return end
                end
            end
            return old(self, ...)
        end))
        f.hooked = true
        f.oldHook = old
    end,
    cleanup = function(f)
        if f.hooked and f.oldHook and hookmetamethod then
            pcall(hookmetamethod, game, "__namecall", f.oldHook)
        end
        f.hooked = nil
        f.oldHook = nil
    end,
})

defineFeature({
    key = "disableCoreGui", title = "Disable Core GUI",
    desc = "Hides the player list, emotes menu and health bar.",
    apply = function(f)
        f.orig = f.orig or {}
        for _, name in ipairs({ "PlayerList", "EmotesMenu", "Health" }) do
            local okC, ct = pcall(function() return Enum.CoreGuiType[name] end)
            if okC and ct then
                if f.orig[name] == nil then
                    local ok, v = pcall(function() return StarterGui:GetCoreGuiEnabled(ct) end)
                    if ok and type(v) == "boolean" then f.orig[name] = v else f.orig[name] = true end
                end
                pcall(function() StarterGui:SetCoreGuiEnabled(ct, false) end)
            end
        end
    end,
    tick = reassert,
    cleanup = function(f)
        for name, was in pairs(f.orig or {}) do
            local okC, ct = pcall(function() return Enum.CoreGuiType[name] end)
            if okC and ct then
                pcall(function() StarterGui:SetCoreGuiEnabled(ct, was) end)
            end
        end
        f.orig = {}
    end,
})

defineFeature({
    key = "disableBubbleChat", title = "Disable Bubble Chat",
    desc = "Turns chat bubbles above heads off.",
    apply = function(f)
        local bubble = TextChatService:FindFirstChildOfClass("BubbleChatConfiguration")
        if bubble then stouch(f, bubble, "Enabled", false) end
    end,
    tick = reassert,
})

defineFeature({
    key = "hideChat", title = "Hide Chat Window",
    desc = "Hides the Roblox chat window (TextChatService only).",
    apply = function(f)
        local win = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
        if win then stouch(f, win, "Enabled", false) end
    end,
    tick = reassert,
})

defineFeature({
    key = "skipDebrisScan", title = "Instant Debris Cleanup",
    desc = "Detaches transient explosion effects as soon as they appear.",
    onInstance = function(f, inst)
        if inst.ClassName == "Explosion" then
            stashAndDetach(f, inst)
        end
    end,
    cleanup = function(f) restoreStash(f) end,
})

defineFeature({
    key = "disableTouchTransparency", title = "Force No Transparency",
    desc = "Forces full opacity on every base part (removes ghosting effects).",
    onInstance = function(f, inst)
        if inst:IsA("BasePart") and inst.ClassName ~= "Terrain" and not inCharacter(inst) then
            if inst.Transparency > 0 then touch(f, inst, "Transparency", 0) end
        end
    end,
})

defineFeature({
    key = "hideFloatingUI", title = "Hide Floating UIs",
    desc = "Disables all ScreenGuis except Sand.cc, Gravel.cc and WindUI.",
    onInstance = function(f, inst)
        if inst:IsA("ScreenGui") then
            if isProtectedName(inst.Name) then return end
            touch(f, inst, "Enabled", false)
        end
    end,
})

local gkeyword = "chair, seat, stool, bench, coffee, fruit, paper, document, note, cup, mug, photo, "
    .. "monitor, screen, display, pistol, rifle, plate, computer, laptop, desktop, bedframe, table, desk, plank, "
    .. "cloud, furniture, bottle, cardboard, chest, book, pillow, magazine, poster, sign, billboard, keyboard, "
    .. "picture, frame, painting, pipe, wires, fridge, glass, leaf, window, pane, shelf, phone, tree, bush, plant, "
    .. "foliage, boxes, decor, ornament, detail, knob, handle, wall, prop, object, tool, weapon, food, drink, "
    .. "bloxy, cola, container, box, bag, case, stand, rack, holder, support, leg, arm, back, top, base, cover, "
    .. "lid, door, drawer, button, switch, lever, wheel, chain, rope, wire, cable, tube, hose, vent, fan, motor, "
    .. "engine, machine, equipment, device, closet, potplant, balloons"

local fb = { "Dark", "Light" }
local function themeList()
    local list = {}
    if WindUI and WindUI.Themes then
        for name in pairs(WindUI.Themes) do
            if type(name) == "string" then list[#list + 1] = name end
        end
    end
    if #list == 0 then
        for _, name in ipairs(fb) do list[#list + 1] = name end
    end
    table.sort(list)
    return list
end
local function themeValid(name)
    if type(name) ~= "string" or name == "" then return false end
    for _, n in ipairs(themeList()) do
        if n == name then return true end
    end
    return false
end

--feat controls
local Controls = {
    greyboxKeywords = { kind = "input", multiline = true, default = gkeyword, title = "Grey-box keywords",
        desc = "Comma separated. Part names containing any of these get flattened.", placeholder = "chair, table, ..." },
    textureKeywords = { kind = "input", default = "sign, ui, hud, menu, button, fence", title = "Important texture keywords",
        desc = "Comma separated. Used when \"Keep important textures\" is on.", placeholder = "sign, ui, ..." },
    keepImportantTextures = { kind = "toggle", default = false, title = "Keep important textures",
        desc = "Hide Textures skips decals whose name (or parent's name) matches the keywords." },
    freezeBehindCamera = { kind = "toggle", default = false, title = "Also freeze players behind the camera",
        desc = "Used by Freeze Distant Players." },
    freezeCheckRate = { kind = "slider", default = 0.5, min = 0.1, max = 5, step = 0.1, title = "Freeze check rate (seconds)",
        desc = "Used by Freeze Distant Players. How often distances are rechecked." },
    anchorBehindCamera = { kind = "toggle", default = false, title = "Also anchor objects behind the camera",
        desc = "Used by Anchor Distant Objects." },
    qualityLevel = { kind = "slider", default = 1, min = 1, max = 21, step = 1, title = "Quality level",
        desc = "Used by Core Settings." },
    fpsCap = { kind = "slider", default = 1000, min = 30, max = 1000, step = 10, title = "FPS cap value",
        desc = "Used by FPS Cap." },
    memoryThresholdMB = { kind = "slider", default = 100, min = 25, max = 1000, step = 25, title = "Cleanup threshold (MB)",
        desc = "Used by Memory Cleanup." },
    fpsThreshold = { kind = "slider", default = 30, min = 10, max = 120, step = 5, title = "Low FPS threshold",
        desc = "Used by Adaptive Performance." },
    maxDistance = { kind = "slider", default = 50, min = 20, max = 500, step = 10, title = "Max distance",
        desc = "Used by Freeze Distant Players, Throttle Sounds and Adaptive Performance." },
    renderDistance = { kind = "slider", default = 500, min = 100, max = 5000, step = 50, title = "Render distance",
        desc = "Parts beyond this are hidden while Render Distance is on." },
    interval = { kind = "slider", default = 10, min = 3, max = 60, step = 1, title = "Update interval (seconds)",
        desc = "How often the periodic checks run." },
    remoteLimit = { kind = "slider", default = 10, min = 1, max = 60, step = 1, title = "Remote calls per second",
        desc = "Used by Throttle Remote Events." },
    maxEmitRate = { kind = "slider", default = 5, min = 0, max = 100, step = 1, title = "Max particle emit rate",
        desc = "Used by Throttle Emitter Rate." },
    frozenTime = { kind = "slider", default = 14, min = 0, max = 24, step = 0.5, title = "Frozen hour",
        desc = "Used by Freeze Time of Day. 0-24, in hours." },
    uiTheme = { kind = "theme", default = "Dark", title = "UI theme",
        desc = "Pick a WindUI theme. Saved and applied automatically." },
    uiTransparency = { kind = "slider", default = 0.15, min = 0, max = 1, step = 0.05, title = "UI transparency",
        desc = "How transparent the window is." },
    textCursor = { kind = "input", default = "_", title = "Text cursor",
        desc = "idk it's a text cursor rng4 :v" },
    textCursor2 = { kind = "input", default = "  ", title = "Text cursor2",
        desc = "who needs ts 🥀" },
    bgMusic = { kind = "toggle", default = true, title = "Background music",
        desc = "Just plays Sugary Spire OST called ''Results!'' ig... :p" },
    fflagJSON = { kind = "input", multiline = true,
        default = '{\n  "FFlagDebugSkyGray": "True"\n}',
        title = "Fast Flags (JSON)",
        desc = "JSON dictionary of fast flags to inject when Apply is pressed.",
        placeholder = '{\n  "FFlagDebugSkyGray": "True"\n}' },
}

local Defs = {}
for _, f in ipairs(Features) do Defs[f.key] = { kind = "toggle", default = false } end
for key, c in pairs(Controls) do Defs[key] = c end
for key, def in pairs(Defs) do State[key] = def.default end

local function coerce(key, value)
    local def = Defs[key]
    if not def then return nil end
    if def.kind == "toggle" then
        if type(value) == "boolean" then return value end
    elseif def.kind == "slider" then
        local n = tonumber(value)
        if n then
            n = clamp(n, def.min, def.max)
            if def.step then n = math.floor(n / def.step + 0.5) * def.step end
            return clamp(n, def.min, def.max)
        end
    elseif def.kind == "theme" then
        if type(value) == "string" and themeValid(value) then return value end
    elseif def.kind == "input" then
        if type(value) == "string" then return value end
    end
    return nil
end

local function fsReady()
    return type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function"
end
local function savePath() return cfg.folder .. "/" .. cfg.file end
local function jsonScalar(v) return HttpService:JSONEncode({ v }):sub(2, -2) end

local function encodeState()
    local keys = {}
    for k in pairs(Defs) do keys[#keys + 1] = k end
    table.sort(keys)
    local lines = {}
    for i, k in ipairs(keys) do
        lines[i] = string.format("    %s: %s", jsonScalar(k), jsonScalar(State[k]))
    end
    return "{\n" .. table.concat(lines, ",\n") .. "\n}\n"
end

local function saveNow()
    if not fsReady() then return false end
    if makefolder and not (isfolder and isfolder(cfg.folder)) then pcall(makefolder, cfg.folder) end
    local ok, err = pcall(writefile, savePath(), encodeState())
    if not ok then warnOnce("couldn't write " .. savePath() .. ": " .. tostring(err)) end
    return ok
end

local saveToken = 0
local function scheduleSave()
    if cfg.autosave == false or not alive then return end
    saveToken = saveToken + 1
    local mine = saveToken
    task.delay(1, function()
        if mine == saveToken then saveNow() end
    end)
end

local function readSaved()
    if not (fsReady() and isfile(savePath())) then return nil end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(savePath())) end)
    if ok and type(data) == "table" then return data end
    warnOnce("the autosave file is unreadable, ignoring it")
    return nil
end

local WindUI, PolyWindow
local Elements = {}

local function syncUI(key)
    local el = Elements[key]
    if el and el.Set then pcall(function() el:Set(State[key]) end) end
end

local function applyTheme(name)
    if not WindUI or not themeValid(name) then return end
    pcall(function() WindUI:SetTheme(name) end)
end
local function applyTransparency(value)
    if not WindUI then return end
    pcall(function()
        if WindUI.TransparencyValue ~= nil then
            WindUI.TransparencyValue = value
        end
        if WindUI.Transparent ~= nil and WindUI.Window and WindUI.Window.ToggleTransparency then
            WindUI.Window:ToggleTransparency(value > 0)
        elseif WindUI.Window and WindUI.Window.ToggleTransparency then
            WindUI.Window:ToggleTransparency(true)
        end
    end)
end

local function setState(key, value, silent)
    local v = coerce(key, value)
    if v == nil or State[key] == v then return end
    State[key] = v
    if key == "uiTheme" then
        applyTheme(v)
    elseif key == "uiTransparency" then
        applyTransparency(v)
    elseif FeatureByKey[key] then
        reconcile()
    else
        paramChanged(key)
    end
    if not silent then scheduleSave() end
end

local function loadSaved(live)
    local data = readSaved()
    if not data then return 0 end
    local n = 0
    for key, value in pairs(data) do
        local v = coerce(key, value)
        if v ~= nil then
            n = n + 1
            if live then setState(key, v, true) else State[key] = v end
        end
    end
    return n
end

local function syncAllUI()
    for key in pairs(Defs) do
        syncUI(key)
    end
end

local ignorethesebsplz = {
    uiTheme = true,
    uiTransparency = true,
    textCursor = true,
    textCursor2 = true,
    bgMusic = true,
}

local function disableAll()
    for _, f in ipairs(Features) do
        if f.key ~= "fastFlags" then
            State[f.key] = false
        end
    end
    for key, def in pairs(Defs) do
        if def.kind ~= "toggle" and not ignorethesebsplz[key] then
            State[key] = def.default
        end
    end
    reconcile()
    syncAllUI()
end

local function enableAll()
    for _, f in ipairs(Features) do
        if f.key ~= "fastFlags" then
            State[f.key] = true
        end
    end
    reconcile()
    syncAllUI()
end
local function notify(title, content, duration)
    if WindUI then
        pcall(function() WindUI:Notify({ Title = title, Content = content, Duration = duration or 3 }) end)
    end
end

local function restoreFFlags()
    if not fflagReady() then
        notify("Sand", "setfflag isn't available in this executor :(")
        return
    end
    if FFState.busy then
        notify("Sand", "Still chewing on the last batch, give it a sec :o")
        return
    end
    if not FFState.pruned then
        FFState.busy = true
        task.spawn(function()
            pcall(ensurePruned, newSlicer())
            FFState.busy = false
            restoreFFlags()
        end)
        return
    end
    local prevs = FFState.prevValues or {}
    local names = {}
    for bare in pairs(prevs) do names[#names + 1] = bare end
    table.sort(names)
    local unknown = 0
    for _ in pairs(FFState.unknownPrev or {}) do unknown = unknown + 1 end
    if #names == 0 then
        if unknown > 0 then
            notify("Sand", string.format(
                "%d flag%s had no readable original value (getfflag gave nothing), so there's nothing to put back. Rejoin to reset %s :p",
                unknown, unknown == 1 and "" or "s", unknown == 1 and "it" or "them"), 6)
            FFState.unknownPrev = {}
            FFState.appliedTable = {}
        else
            notify("Sand", "Nothing to restore, no flags were injected yet :p")
        end
        return
    end
    FFState.busy = true
    task.spawn(function()
        local slice = newSlicer()
        local restored, unverified = 0, 0
        local pending = names
        local function sameValue(a, b)
            return tostring(a):lower() == tostring(b):lower()
        end
        local function trySet(bare, prev)
            local cands = { bare }
            local alt = FFState.prevNames[bare]
            if alt and alt ~= bare then cands[#cands + 1] = alt end
            local setWorked = false
            for _, name in ipairs(cands) do
                local okS = pcall(setfflag, name, tostring(prev))
                if okS then
                    setWorked = true
                    local rok, now = pcall(getfflag, name)
                    if not rok or now == nil or sameValue(now, prev) then
                        return "ok"
                    end
                end
            end
            return setWorked and "unverified" or "fail"
        end

        local pass = 0
        local okRun, errRun = pcall(function()
            for p = 1, 2 do
                pass = p
                local stillBad = {}
                for _, bare in ipairs(pending) do
                    local prev = prevs[bare]
                    local res = trySet(bare, prev)
                    if res == "unverified" and p == 1 then
                        stillBad[#stillBad + 1] = bare
                    elseif res == "ok" then
                        restored = restored + 1
                        prevs[bare] = nil
                        FFState.prevNames[bare] = nil
                    elseif res == "unverified" then
                        unverified = unverified + 1
                        prevs[bare] = nil
                        FFState.prevNames[bare] = nil
                        print(string.format("[Sand.cc] restore %s -> %s: set ok but read-back differs", bare, tostring(prev)))
                    else
                        stillBad[#stillBad + 1] = bare
                        if p == 2 then
                            print(string.format("[Sand.cc] restore %s -> %s: setfflag errored", bare, tostring(prev)))
                        end
                    end
                    slice()
                end
                pending = stillBad
                if #pending == 0 then break end
                if p == 1 then task.wait(0.15) end
            end
        end)
        if not okRun then
            print("[Sand.cc] restore errored: " .. tostring(errRun))
        end

        local failed = #pending
        FFState.unknownPrev = {}
        saveFFOriginals()
        if failed == 0 then
            FFState.appliedTable = {}
        end
        FFState.busy = false
        pcall(function()
            if State.fastFlags then
                setState("fastFlags", false, true)
                syncUI("fastFlags")
            end
        end)
        local extra = ""
        if failed > 0 then
            extra = extra .. " (" .. failed .. " refused to budge, press again to retry)"
        end
        if unverified > 0 then
            extra = extra .. " (" .. unverified .. " set but didn't read back the same, rejoin to be sure)"
        end
        if unknown > 0 then
            extra = extra .. " + " .. unknown .. " had no readable original so rejoin for those"
        end
        if not okRun then
            extra = extra .. " (hit an error, check console)"
        end
        notify("Sand",
            string.format("Restored %d fastflag%s to their original values%s. Rejoin if some look stuck :3",
                restored, restored == 1 and "" or "s", extra), 7)
    end)
end
local Presets = {}
local presetQuery = ""
local presetFile = cfg.folder .. "/presets.json"

local function trimStr(v) return (tostring(v or ""):gsub("^%s+", ""):gsub("%s+$", "")) end

local function loadPresetFile()
    Presets = {}
    if not (fsReady() and isfile(presetFile)) then return end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(presetFile)) end)
    if ok and type(data) == "table" then
        for name, json in pairs(data) do
            if type(name) == "string" and type(json) == "string" then Presets[name] = json end
        end
    end
end

local function savePresetFile()
    if not fsReady() then return false end
    if makefolder and not (isfolder and isfolder(cfg.folder)) then pcall(makefolder, cfg.folder) end
    local ok, err = pcall(writefile, presetFile, HttpService:JSONEncode(Presets))
    if not ok then warnOnce("couldn't write " .. presetFile .. ": " .. tostring(err)) end
    return ok
end

local function levenshtein(a, b)
    local la, lb = #a, #b
    if la == 0 then return lb end
    if lb == 0 then return la end
    local prev, cur = {}, {}
    for j = 0, lb do prev[j] = j end
    for i = 1, la do
        cur[0] = i
        for j = 1, lb do
            local cost = (a:byte(i) == b:byte(j)) and 0 or 1
            cur[j] = math.min(prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + cost)
        end
        prev, cur = cur, prev
    end
    return prev[lb]
end
local function fuzzyScore(query, name)
    local q, n = string.lower(trimStr(query)), string.lower(name)
    if q == "" then return 1 end
    if q == n then return 1000 end
    if n:sub(1, #q) == q then return 800 - (#n - #q) end
    local at = n:find(q, 1, true)
    if at then return 600 - at - (#n - #q) end
    local qi = 1
    for i = 1, #n do
        if qi <= #q and n:sub(i, i) == q:sub(qi, qi) then qi = qi + 1 end
    end
    if qi > #q then return 300 - (#n - #q) end
    local d = levenshtein(q, n)
    if d <= math.max(1, math.floor(#q / 3)) then return 200 - d * 20 end
    return nil
end

local function searchPresets(query)
    local out = {}
    for name in pairs(Presets) do
        local sc = fuzzyScore(query, name)
        if sc then out[#out + 1] = { name = name, score = sc } end
    end
    table.sort(out, function(a, b)
        if a.score ~= b.score then return a.score > b.score end
        return a.name:lower() < b.name:lower()
    end)
    return out
end

local function presetFlagCount(json)
    local tbl = parseFlagJSON(json)
    local n = 0
    if tbl then for _ in pairs(tbl) do n = n + 1 end end
    return n
end

local function exactPresetName(name)
    local low = string.lower(trimStr(name))
    for k in pairs(Presets) do
        if string.lower(k) == low then return k end
    end
end

local function presetListText()
    local q = trimStr(presetQuery)
    local hits = searchPresets(q)
    local total = 0
    for _ in pairs(Presets) do total = total + 1 end
    if total == 0 then
        return "the sand pile is empty :( type a name, then hit\nSave/Overwrite"
    end
    if #hits == 0 then
        return "no matches for \"" .. q .. "\" :o (" .. total .. " preset" .. (total == 1 and "" or "s") .. " total)"
    end
    local lines = {}
    for i, h in ipairs(hits) do
        if i > 15 then
            lines[#lines + 1] = "...and " .. (#hits - 15) .. " more grains"
            break
        end
        local c = presetFlagCount(Presets[h.name])
        lines[#lines + 1] = string.format("%s%s  (%d flag%s)", i == 1 and q ~= "" and "> " or "- ", h.name, c, c == 1 and "" or "s")
    end
    return table.concat(lines, "\n")
end

local function failedListText()
    local list = FFState.failedList or {}
    if #list == 0 then
        return "Nothing failed :3 (this clears itself every time flags get applied)"
    end
    local maxShown = 60
    local lines = {}
    for i = 1, math.min(#list, maxShown) do
        lines[i] = "- " .. list[i]
    end
    if #list > maxShown then
        lines[#lines + 1] = "..and " .. (#list - maxShown) .. " more"
    end
    return #list .. " failed:\n" .. table.concat(lines, "\n")
end

FFState.refreshFailed = function()
    local el = Elements.failedFlagList
    if not el then return end
    local text = failedListText()
    if not pcall(function() el:SetDesc(text) end) then
        pcall(function() el:Set(text) end)
    end
end

local function refreshPresetList()
    local el = Elements.presetList
    if not el then return end
    local text = presetListText()
    if not pcall(function() el:SetDesc(text) end) then
        pcall(function() el:Set(text) end)
    end
end

local function presetSave()
    local name = trimStr(presetQuery):sub(1, 40)
    if name == "" then
        notify("Sand", "Type a name in the box first, silly :p")
        return
    end
    if not fsReady() then
        notify("Sand", "This executor has no file functions, can't save presets :(")
        return
    end
    local tbl, err = parseFlagJSON(State.fflagJSON)
    if not tbl then
        notify("Sand", "Your flag JSON is " .. tostring(err) .. ", fix it before saving :o")
        return
    end
    local existing = exactPresetName(name)
    local key = existing or name
    Presets[key] = State.fflagJSON
    if savePresetFile() then
        notify("Sand", (existing and "Overwrote " or "Stashed ") .. "\"" .. key .. "\" (" .. presetFlagCount(State.fflagJSON) .. " flags) in the sand pile :3")
    else
        notify("Sand", "Couldn't write the preset file (see console) :c")
    end
    refreshPresetList()
end

local function presetLoad()
    local q = trimStr(presetQuery)
    if q == "" then
        notify("Sand", "Type (part of) a preset name first :p")
        return
    end
    local hits = searchPresets(q)
    if #hits == 0 then
        notify("Sand", "No preset looks like \"" .. q .. "\" :o")
        return
    end
    local name = hits[1].name
    State.fflagJSON = Presets[name]
    syncUI("fflagJSON")
    scheduleSave()
    local msg = "Loaded \"" .. name .. "\" into the JSON box"
    local score = hits[1].score
    local function finish(m)
        if score < 1000 then m = m .. " [fuzzy match for \"" .. q .. "\"]" end
        notify("Sand", m .. " :3", 5)
    end
    if fflagReady() then
        local tbl = parseFlagJSON(Presets[name])
        if tbl then
            if not runFFlagJob(tbl, function(applied, failed)
                finish(msg .. string.format(" and injected %d flag%s%s", applied, applied == 1 and "" or "s",
                    failed > 0 and (" (" .. failed .. " failed)") or ""))
            end) then
                finish(msg .. " (busy, press Apply when the current batch finishes)")
            end
            return
        end
    else
        msg = msg .. " (setfflag missing, so nothing was injected)"
    end
    finish(msg)
end

local function presetDelete()
    local q = trimStr(presetQuery)
    if q == "" then
        notify("Sand", "Type (part of) a preset name first :p")
        return
    end
    local hits = searchPresets(q)
    if #hits == 0 then
        notify("Sand", "No preset looks like \"" .. q .. "\" :o")
        return
    end
    if hits[1].score < 600 then
        notify("Sand", "Not sure enough to delete. Did you mean \"" .. hits[1].name .. "\"? Type it out properly :v")
        return
    end
    local name = hits[1].name
    Presets[name] = nil
    savePresetFile()
    notify("Sand", "Yeeted \"" .. name .. "\" into the void :3")
    refreshPresetList()
end

local function resetDefaults()
    for key, def in pairs(Defs) do
        setState(key, def.default, true)
        syncUI(key)
    end
    scheduleSave()
end

--feat layout
local Layout = {
    visuals = {
        { "f", "graySky" },
        { "f", "fullBright" }, { "f", "simplifyLighting" },
        { "f", "removeFog" }, { "f", "removeAtmosphere" },
        { "f", "killPostFX" },
        { "f", "killBlur" },
        { "f", "killLighting" },
        { "f", "freezeTime" }, { "c", "frozenTime" },
        { "f", "removeGrass" }, { "f", "simplifyWater" }, { "f", "removeTerrainDetail" },
        { "f", "smoothPlastic" }, { "f", "reducedReflections" },
        { "f", "greybox" }, { "c", "greyboxKeywords" },
        { "f", "lowPolyMeshes" },
    },
    fx = {
        { "f", "hideTextures" }, { "c", "keepImportantTextures" }, { "c", "textureKeywords" },
        { "f", "removeSurfaceAppearance" },
        { "f", "throttleParticles" }, { "c", "maxEmitRate" },
        { "f", "destroyEmitters" },
        { "f", "disableTrails" }, { "f", "disableBeams" }, { "f", "removeBeams" },
        { "f", "killLights" }, { "f", "noShadows" },
        { "f", "clearSurfaceGui" }, { "f", "hideBillboards" },
        { "f", "disableConstraints" },
        { "f", "disableHighlights" }, { "f", "disableSelectionBoxes" },
        { "f", "removeGuiEffects" },
        { "f", "disableLegacyEffects" }, { "f", "disableForceFields" },
    },
    performance = {
        { "f", "coreSettings" }, { "c", "qualityLevel" },
        { "f", "fpsUnlock" }, { "c", "fpsCap" },
        { "f", "memoryCleanup" }, { "c", "memoryThresholdMB" },
        { "f", "adaptive" }, { "c", "fpsThreshold" },
        { "f", "fpsCounter" }, { "f", "pingCounter" },
        { "c", "interval" },
    },
    players = {
        { "f", "freezePlayers" }, { "c", "freezeBehindCamera" }, { "c", "freezeCheckRate" },
        { "f", "anchorDistant" }, { "c", "anchorBehindCamera" },
        { "f", "renderDistance" }, { "c", "renderDistance" },
        { "f", "throttleSounds" },
        { "c", "maxDistance" },
        { "f", "hideOtherPlayers" },
        { "f", "hideNametags" },
        { "f", "removeAccessories" }, { "f", "removeClothing" }, { "f", "hideTools" },
        { "f", "freezeAllAnimations" },
    },
    network = {
        { "f", "throttleRemotes" }, { "c", "remoteLimit" },
        { "f", "disableCoreGui" }, { "f", "disableBubbleChat" }, { "f", "hideChat" },
        { "f", "hideFloatingUI" },
        { "f", "disableExplosions" }, { "f", "skipDebrisScan" },
        { "f", "muteSounds" }, { "f", "muteSoundGroups" },
        { "f", "silenceAmbientSound" },
        { "f", "noCharacterSounds" },
        { "f", "antiAFK" },
        { "f", "disableTouchTransparency" },
    },
}

Runtime.rng4 = {
    cursorVisible = true,
    currentText = "",
    usedConversations = {},
    availableIndices = {},
    tag = nil,
    conversationMessages = {},
    activeConversation = nil,
    typingSpeed = 1,
    isTyping = false,
    shouldContinue = true,
    cursorBlinkRate = 0.45,
    eraseSpeed = 1,
    messageDelay = 1,
    convoDelay = 2,
    typingMode = "1",
    processedText = "",
    typed = "",
    charIndex = 1,
    speedMultiplier = 1,
    currentMessage = "",
    messageIndex = 1,
    isErasing = false,
}

Runtime.rng4Convo = {
    { typesp = "1.5", "HEY", "{displayname} HEY", "CAN YOU HEAR ME???", "Ok Ive got ur attention",
      "this is Sand.cc btw :3", "the lighter cousin of Gravel.cc", },
    { "Sand and Gravel are friends", "both are just crushed rocks", "but Sand is the lazier one :p", "but happens to have better code :v", },
    { "u ever just", "open a script", "and it works", "first try?", "yea me neither", },
    { typesp = "0.6", mode = "2", "BEST. DAY. EV-...", "", "BEST. DAY. EV-", "", "BEST. DAY. EV-", "", },
    { typesp = "5", mode = "3", "IM TYPING SUPER DUPER FAST", "IM TYPING SO FAST U CANT EVEN",
      "READ ALL OF IT >:D", "MWAHAHAHAHAHAHAH", "EUGEAUYIQHIFU82-2;1866646649", },
    { "67", "87", "89", "61", "69", "55", "420", "1337", "41", "42", "21", "19", "23", "31", "429", "301", "711",
      "911.", "I'm not a numberphile :v", },
    { "if u close Sand.cc", "I will be sad", "very sad :c", "so pls don't", },
    { typesp = "1.5", "r u hacking??", "I think u hackin", "yea ur def hackin", "I respect it >:3", },
    { "u know what's underrated?", "the sound of sand", "swoosh swoosh", "satisfying as heck",
      "u can't change my mind", },
    { "if u see a syntax error", "just run it again", "it'll fix itself", "trust me bro", },
    { typesp = "3", mode = "2", ":3", ">:3", ":3", ">:3", ":3", ">:3", "^w^", },
    { "Sand.cc motto:", "be sandy", "be smooth", "be low-poly", "and don't get kicked", },
    { "me when the sand", "the sand when me", "it's a cycle", },
    { typesp = "2.5", "My bread was", "burnt to a crisp", "It's not like it's inedible",
      "I guess there's no use in wishing now...", },
    { typesp = "1.5", "again & again & again & again.", "Do it again, do it again",
      "again & again & again & again.", "Do it again, do it again", "Again & again.", },
    { "is gravel just crushed rocks?", "like genuinely???", "gravel could be js crushed rocks",
      "and sand is even smaller gravel", "so sand is crushed crushed rocks", "mind blown :o", },
    { typesp = "3.5", "dustin lucas will mike me-", "adrian christian hernandez",
      "or the locals call me 'A'", "dustin lucas will mike STO-", "adrian christian hernandez", },
    { "the file size is 100kb..", "I'm fr", "D:", },
    { typesp = "2", "I AM A SURGEON", "I AM A SURGEON", "I AM- IAM A SURGEON", "IAM A SURGEON", },
    { "u ever just", "open a script", "and it works", "first try?", "yea me neither",
      "this is like my 50th version", },
    { "Sand.cc has 0 calories 2 burn", "so yeh {displayname} dis is", "why Sand can do dis", },
    { typesp = "1.5", "wait this isn't a virus", "i was told it was a virus", "it's open source",
      "you can literally read it", },
    { "if u enjoy this script", "tell a friend", "if u don't enjoy it", "tell roblox support",
      "either way", "Sand supports u", },
    { typesp = "2", "u ever try to explain", "what Sand.cc is", "to someone?", " 'it's a script' ",
      " 'for roblox' ", " 'with optimization' ", "they never understand", "sadge :(", },
    { typesp = "1.5", "warning:", "this script may cause", "excessive fps", "smoother gameplay",
      "and accusations", "of having a good pc", "u have been warned >:D", },
    { "what do u call", "a sad grain of sand?", "a crying pebble :(", "what do u call",
      "a happy grain of sand?", "a sandy boy :D", },
    { typesp = "1.5", "u ever think about", "how i'm talking to u", "through text", "on a screen",
      "in a game", "about sand", "life is weird man", },
    { "if u read this far", "u deserve a medal", "or a grain of sand", "here's a virtual grain",
      "🏖", "wait that's a beach", "close enough :p", },
    { "Sand.cc pairs well with Gravel.cc", "like peanut butter & jelly", "or sand & gravel",
      "or roblox & lag", },
    { typesp = "2", "u know what's underrated?", "the sound of sand", "crunch crunch",
      "satisfying as heck", "u can't change my mind", },
    { "me: 'i'll make a clean script'", "also me:", "*4000+ lines later*", "what is organization?",
      "i don't know her", ":s", },
    { typesp = "1.5", "this script contains:", " - 100% pure sand", " - premium fps",
      " - secret sauce", " - questionable code", " - the tears of ur gpu",
      "read the ingredients", "u won't :P", },
    { "HOA is just legal mafias :p", "and if u don't want", "ur house to be stolen",
      "don't live in hoa c:", "or have a lawyer and a gun :3", },
    { "some people use", "expensive scripts", "we use free ones", "and they work better",
      "take that capitalism", ":v", },
    { typesp = "3", "i'm not a robot", "i'm a sand", "robots are metal", "sand is rock",
      "big difference", "checkmate atheists", ":v", },
    { "u ever get so bored", "u read script messages", "like these?", "same tbh", "i wrote them",
      "i have no life", "respect the grind", },
    { typesp = "2", "u ever just", "optimize ur game", "and they go", " '??? how' ",
      "and then u say", " 'i have good taste' ", "well i do that", },
    { "i'm not saying", "Sand.cc is the best optimizer", "but i'm also not saying",
      "it's NOT the best", "so it's the best but not", "the best-est", "does that make sense?", },
    { typesp = "1.5", "u ever just", "accidentally write", "a really good feature",
      "and not know how", "u did it?", "that's most of Sand.cc", "happy accidents", ":D", },
    { "i should probably", "document this code", "but that's future me's", "problem",
      "present me wants", "to add more jokes", "priorities :v", },
    { typesp = "1.5", "if u see me in game", "no u didn't", "if u see me optimizing",
      "no u didn't", "if u see me with good fps", "that's just skill", "sand skill", ";D", },
    { "bro ts code is 4000+ lines long :(", "I ''can't'' do dis shi :[", "plz heseelepp me {displayname}", },
    { typesp = "1.5", "ur probably using this", "to optimize some game", "that runs at 15 fps",
      "i respect that", "get smooth nerd >:D", "haha i'm just joking", "or am i?", ";)", },
    { typesp = "1.5", "psst", "hey", "over here", "yea u", "wanna know a secret?",
      "sand is made of", "crushed rocks", "mind blown :o", },
    { typesp = "1.5", "r u a hacker?", "cuz u seem sus", "wait i'm the script",
      "i'm literally optimizing", "for u", "i'm the sus one", "my bad :p", },
    { "why is http 429 my enemy", "I SWEAR TO GOD", "everytime i load Sand.cc", "it hits me with 429",
      "like bro chill out", },
    { "renderstepped is for chuds", "heartbeat gang where u at", "renderstepped makes me lag",
      "heartbeat smooth like butter", },
    { "did someone say spaghetti", "my code is pasta", "al dente and tangled", "bon appetit", },
    { "200 variable limit", "is my sleep paralysis demon", "i wake up screaming",
      "at 3am thinking about it", },
    { "when the ui library updates", "and everything breaks", "i ''love'' rewriting code",
      "said no one ever", },
    { typesp = "2", "u think ur ready", "for the Sand experience?", "u think ur ready",
      "for the OPTIMIZATION??", "u think ur ready", "for the FPS??", "probably not :P", },
    { "sand gets everywhere", "even in ur scripts", "especially in ur scripts", ":s", },
    { typesp = "1.5", "i'm not like gravel", "gravel is just", "big sand", "i'm the refined stuff", ":3", },
    { "if u squeeze sand", "does it become", "a sandcastle?", "or just", "sad sand", ":c", },
    { typesp = "2", "Sand.cc v1 was", "just a print statement", "and it was", "the best version", "don't @ me", },
    { "u ever just", "watch sand fall", "through an hourglass", "and think", "'that's me'", "same", },
    { "the beach called", "they want their", "sand back", "i said no", ":v", },
    { typesp = "1.5", "sand is just", "really small rocks", "and rocks are just", "big sand", "circular logic", "my brain hurts", },
    { "why did the sand", "cross the road?", "to get to the", "other beach", "i'll see myself out", },
    { "if u put sand", "in ur shoes", "that's just", "gravel with extra steps", ":7", },
    { typesp = "3", mode = "2", "SAND", "SAND", "SAND", "SAND", "SAND", "SAND", "BEACH", "BEACH", "BEACH", },
    { "sand + water", "= sandcastle", "sand + fire", "= glass", "sand + me", "= script", "science :o", },
    { typesp = "2", "i'm not a beach", "i'm a lifestyle", "a sandy lifestyle", "join me :3", },
    { "what's a sand's", "favorite music?", "heavy metal", "because rocks :p", },
    { typesp = "1.5", "i was gonna make", "a gravel joke", "but i'm not", "that kind of script", "i have standards", },
    { "sandbox mode", "is literally", "named after me", "i'm famous :D", },
    { typesp = "2.5", "If u pour sand", "into a computer", "it becomes", "a sandbox", "i don't make the rules", },
    { "i dream of", "a world", "where all scripts", "are free", "and all sand", "is soft", "utopia :3", },
    { "gravel: i'm rough", "sand: i'm smooth", "brick: i'm brick", "we're all", "just rocks", "at the end of the day", },
    { typesp = "1.5", "u know ur", "a sand person", "when u", "find sand", "in ur bed", "and u accept it", },
    { "sand puns", "are easy", "they just", "slip through", "ur fingers", ":p", },
    { typesp = "2", "the sand", "the myth", "the legend", "Sand.cc", "coming to", "a game near u", },
    { "if ur reading this", "ur officially", "a grain of sand", "welcome to", "the beach", ":D", },
    { typesp = "1.5", "I once tried", "to count sand", "I got to", "like 3", "then gave up", "respect the grind", },
    { "sand is just", "the earth's", "dandruff", "and i'm", "the shampoo", ":v", },
    { typesp = "2", "no sand", "no life", "sand life", "sand forever", "sandy vibes", ":3", },
}

Runtime.rng4Defaults = {
    minDelay = 25, maxDelay = 85, spaceExtraMin = 40, spaceExtraMax = 90,
    punctExtraMin = 120, punctExtraMax = 250, breakChance = 0.05,
    breakExtraMin = 100, breakExtraMax = 300, messageWaitMin = 10, messageWaitMax = 30,
    convoWaitMin = 15, convoWaitMax = 35, eraseWaitMin = 2, eraseWaitMax = 6,
    eraseDelayMin = 15, eraseDelayMax = 40, cursorBlink = 0.45,
    shuffleWaitMin = 20, shuffleWaitMax = 40,
}

local PolyWindowRef = nil
local function subside_I_I_I_I_I_()
    if not PolyWindowRef then return true end
    local ok, ui = pcall(function() return PolyWindowRef.UIElements end)
    if not ok or not ui or not ui.Main then return true end
    local ok2, sizeY = pcall(function() return ui.Main.Size.Y.Offset end)
    if not ok2 or type(sizeY) ~= "number" then return true end
    if sizeY < 50 then return true end
    return false
end

local BGM = {
    sound = nil,
    pauseSound = nil,
    playSound = nil,
    holder = nil,
    isActive = false,
    initialized = false,
    bgmurl = "https://raw.githubusercontent.com/hm5650/Sand/main/assets/Music/RESULTS.mp3",
}

local function ensureBGMAsset()
    if not fsReady() then return nil end
    if type(getcustomasset) ~= "function" then return nil end
    local baseFolder  = cfg.folder .. "/assets"
    local musicFolder = baseFolder .. "/Music"
    local filePath    = musicFolder .. "/RESULTS.mp3"
    if makefolder then
        if not (isfolder and isfolder(baseFolder))  then pcall(makefolder, baseFolder)  end
        if not (isfolder and isfolder(musicFolder)) then pcall(makefolder, musicFolder) end
    end
    if not (isfile and isfile(filePath)) then
        local ok, data = pcall(function() return game:HttpGet(BGM.bgmurl) end)
        if not ok or type(data) ~= "string" or #data == 0 then
            warnOnce("couldn't download background music")
            return nil
        end
        local okW = pcall(writefile, filePath, data)
        if not okW then
            warnOnce("couldn't save background music to " .. filePath)
            return nil
        end
    end
    local okA, asset = pcall(getcustomasset, filePath)
    if not okA or type(asset) ~= "string" then
        warnOnce("getcustomasset failed for background music")
        return nil
    end
    return asset
end

local function initBGM()
    if BGM.initialized then return end
    BGM.initialized = true
    local asset = ensureBGMAsset()
    if not asset then return end
    local holder = Instance.new("Folder")
    holder.Name = "SandBGM"
    holder.Parent = LocalPlayer
    BGM.holder = holder

    local music = Instance.new("Sound")
    music.Name = "SandBGMTrack"
    music.SoundId = asset
    music.Looped = true
    music.Volume = 0.35
    music.Parent = holder
    BGM.sound = music

    local pauseSnd = Instance.new("Sound")
    pauseSnd.Name = "SandBGMPause"
    pauseSnd.SoundId = "rbxassetid://12221944"
    pauseSnd.Volume = 0.5
    pauseSnd.Parent = holder
    BGM.pauseSound = pauseSnd

    local playSnd = Instance.new("Sound")
    playSnd.Name = "SandBGMPlay"
    playSnd.SoundId = "rbxassetid://12221976"
    playSnd.Volume = 0.5
    playSnd.Parent = holder
    BGM.playSound = playSnd
end

local function setBGMActive(active)
    if active == BGM.isActive then return end
    BGM.isActive = active
    if active then
        if BGM.sound then pcall(function() BGM.sound:Play() end) end
        if BGM.playSound then pcall(function() BGM.playSound:Play() end) end
    else
        if BGM.sound then pcall(function() BGM.sound:Pause() end) end
        if BGM.pauseSound then pcall(function() BGM.pauseSound:Play() end) end
    end
end

local function updateBGM()
    if not BGM.sound then return end
    local shouldPlay = State.bgMusic and alive and not subside_I_I_I_I_I_()
    setBGMActive(shouldPlay)
end

local function destroyBGM()
    if BGM.holder then
        pcall(function() BGM.holder:Destroy() end)
        BGM.holder = nil
    end
    BGM.sound, BGM.pauseSound, BGM.playSound = nil, nil, nil
    BGM.isActive, BGM.initialized = false, false
end

local function getPlayerInfo()
    local lp = LocalPlayer
    local age = "Unknown"
    pcall(function() age = tostring(lp.AccountAge) .. " days" end)
    return {
        username = lp.Name,
        displayname = lp.DisplayName,
        id = tostring(lp.UserId),
        accountage = age,
        retroscore = "Unknown",
    }
end

local function processText(text)
    local info = getPlayerInfo()
    local processed = text
    processed = processed:gsub("{username}", info.username)
    processed = processed:gsub("{displayname}", info.displayname)
    processed = processed:gsub("{userid}", info.id)
    processed = processed:gsub("{accountage}", info.accountage)
    processed = processed:gsub("{retroscore}", info.retroscore)
    return processed
end

local function startRNG4()
    local rng4 = Runtime.rng4
    if not rng4 or rng4.tag then return end
    if not PolyWindowRef then return end
    local availableIndices = rng4.availableIndices
    for i = 1, #Runtime.rng4Convo do table.insert(availableIndices, i) end
    rng4.tag = PolyWindowRef:Tag({
        Title = "", Icon = "github", Color = Color3.fromHex("#1c1c1c"), Border = true,
    })
    if not rng4.tag then return end
    rng4.currentText = ""
    rng4.cursorVisible = true
    local function cursorChar()
        local c = State.textCursor
        if type(c) ~= "string" or c == "" then return "_" end
        return c
    end
    local function cursorChar2()
        local c = State.textCursor2
        if type(c) ~= "string" or c == "" then return "  " end
        return c
    end
    local function setText(text)
        rng4.currentText = text
        if rng4.tag.SetTitle then
            pcall(function()
                rng4.tag:SetTitle(text .. (rng4.cursorVisible and cursorChar() or cursorChar2()))
            end)
        end
    end
    task_("rng4Cursor", function()
        while rng4.tag and alive do
            if not subside_I_I_I_I_I_() then
                rng4.cursorVisible = not rng4.cursorVisible
                if rng4.tag.SetTitle then
                    pcall(function()
                        rng4.tag:SetTitle(rng4.currentText .. (rng4.cursorVisible and cursorChar() or cursorChar2()))
                    end)
                end
            end
            task.wait(0.45)
        end
    end)
    local function getSpeedMultiplier(conversation)
        if type(conversation) == "table" and conversation.typesp then
            local speedVal = tonumber(conversation.typesp)
            if speedVal then
                if speedVal > 0 then return 1 / speedVal
                elseif speedVal < 0 then return math.abs(speedVal) end
            end
        end
        return 1
    end
    local function getTypingMode(conversation)
        if type(conversation) == "table" and conversation.mode then
            return tostring(conversation.mode)
        end
        return rng4.typingMode or "1"
    end
    local function isLetter(char) return char:match("[%a]") ~= nil end
    local function getRepeatedRunLength(text, position)
        if position > #text then return 0 end
        local char = text:sub(position, position)
        if not isLetter(char) then return 0 end
        local runLength = 0
        for i = position, #text do
            if text:sub(i, i) == char then runLength = runLength + 1 else break end
        end
        return runLength
    end

    local D = Runtime.rng4Defaults

    local function typeDefault(text, speedMultiplier)
        local processedText = processText(text)
        rng4.processedText = processedText
        rng4.typed = ""
        rng4.charIndex = 1
        rng4.speedMultiplier = speedMultiplier
        rng4.isTyping = true
        while rng4.charIndex <= #processedText do
            while subside_I_I_I_I_I_() do task.wait(0.1) end
            local char = processedText:sub(rng4.charIndex, rng4.charIndex)
            if char == "\n" then
                rng4.typed = rng4.typed .. char
                setText(rng4.typed)
                rng4.charIndex = rng4.charIndex + 1
            else
                local runLength = getRepeatedRunLength(processedText, rng4.charIndex)
                if runLength > 2 then
                    local repeatedChar = processedText:sub(rng4.charIndex, rng4.charIndex)
                    local totalCharsInRun = runLength
                    local charsTyped = 0
                    rng4.typed = rng4.typed .. repeatedChar
                    setText(rng4.typed)
                    local delay = (math.random(D.minDelay, D.maxDelay) / 1000) * speedMultiplier
                    task.wait(delay)
                    charsTyped = charsTyped + 1
                    rng4.charIndex = rng4.charIndex + 1
                    local baseDelay = (math.random(D.minDelay, D.maxDelay) / 1000) * speedMultiplier
                    while charsTyped < totalCharsInRun and rng4.charIndex <= #processedText
                        and processedText:sub(rng4.charIndex, rng4.charIndex) == repeatedChar do
                        rng4.typed = rng4.typed .. repeatedChar
                        setText(rng4.typed)
                        local holdDelay = (charsTyped <= 2 and baseDelay * (math.random(15, 25) / 10)
                            or baseDelay * (math.random(2, 5) / 10)) * (math.random(8, 12) / 10)
                        task.wait(holdDelay)
                        charsTyped = charsTyped + 1
                        rng4.charIndex = rng4.charIndex + 1
                    end
                    task.wait(baseDelay * math.random(1, 3))
                else
                    rng4.typed = rng4.typed .. char
                    setText(rng4.typed)
                    local delay = (math.random(D.minDelay, D.maxDelay) / 1000) * speedMultiplier
                    if char == " " then
                        delay = delay + (math.random(D.spaceExtraMin, D.spaceExtraMax) / 1000) * speedMultiplier
                    elseif char:match("[%.%!%?,:]") then
                        delay = delay + (math.random(D.punctExtraMin, D.punctExtraMax) / 1000) * speedMultiplier
                    end
                    if math.random() < D.breakChance then
                        delay = delay + (math.random(D.breakExtraMin, D.breakExtraMax) / 1000) * speedMultiplier
                    end
                    task.wait(delay)
                    rng4.charIndex = rng4.charIndex + 1
                end
            end
        end
        rng4.isTyping = false
    end

    local function typeWordInstant(text, speedMultiplier)
        local processedText = processText(text)
        rng4.processedText = processedText
        rng4.typed = ""
        rng4.isTyping = true
        local words = {}
        for word in processedText:gmatch("%S+") do table.insert(words, word) end
        local wordIndex = 1
        while wordIndex <= #words do
            while subside_I_I_I_I_I_() do task.wait(0.1) end
            local word = words[wordIndex]
            local isLastWord = (wordIndex == #words)
            local hasPunctuation = word:match("[%.%!%?,:]$") ~= nil
            rng4.typed = rng4.typed .. word
            setText(rng4.typed)
            if not isLastWord then
                rng4.typed = rng4.typed .. " "
                setText(rng4.typed)
            end
            local baseDelay = (math.random(D.minDelay, D.maxDelay) / 1000) * speedMultiplier
            local wordDelay = baseDelay * (1 + (#word * 0.05))
            if hasPunctuation then
                wordDelay = wordDelay + (math.random(D.punctExtraMin, D.punctExtraMax) / 1000) * speedMultiplier
            end
            if math.random() < D.breakChance then
                wordDelay = wordDelay + (math.random(D.breakExtraMin, D.breakExtraMax) / 1000) * speedMultiplier
            end
            task.wait(math.max(wordDelay, 0.02))
            wordIndex = wordIndex + 1
        end
        rng4.isTyping = false
    end

    local function typeSentenceInstant(text, speedMultiplier)
        local processedText = processText(text)
        rng4.processedText = processedText
        rng4.typed = processedText
        rng4.isTyping = true
        setText(processedText)
        local displayDuration = (math.random(D.minDelay, D.maxDelay) / 1000) * speedMultiplier * 10
        displayDuration = displayDuration + (#processedText * 0.01)
        displayDuration = math.max(displayDuration, 0.3)
        if speedMultiplier > 0 then
            displayDuration = displayDuration * (1 + (speedMultiplier * 0.5))
        end
        task.wait(displayDuration)
        rng4.isTyping = false
    end

    local function eraseText(speedMultiplier)
        rng4.isErasing = true
        local text = rng4.currentText
        for i = #text, 0, -1 do
            while subside_I_I_I_I_I_() do task.wait(0.1) end
            setText(text:sub(1, i))
            task.wait((math.random(D.eraseDelayMin, D.eraseDelayMax) / 1000) * speedMultiplier)
        end
        rng4.isErasing = false
    end

    task_("rng4Main", function()
        while rng4.tag and alive do
            while subside_I_I_I_I_I_() do task.wait(0.5) end
            if #availableIndices == 0 then
                for i = 1, #Runtime.rng4Convo do table.insert(availableIndices, i) end
                task.wait(math.random(D.shuffleWaitMin, D.shuffleWaitMax) / 10)
            end
            local randomPos = math.random(1, #availableIndices)
            local convoIndex = availableIndices[randomPos]
            table.remove(availableIndices, randomPos)
            local conversation = Runtime.rng4Convo[convoIndex]
            if conversation then
                local speedMultiplier = getSpeedMultiplier(conversation)
                local mode = getTypingMode(conversation)
                local messages = {}
                if type(conversation) == "table" then
                    for _, value in ipairs(conversation) do
                        if type(value) == "string" then table.insert(messages, value) end
                    end
                else
                    messages = { conversation }
                end
                for index, message in ipairs(messages) do
                    if mode == "2" then
                        typeWordInstant(message, speedMultiplier)
                    elseif mode == "3" then
                        typeSentenceInstant(message, speedMultiplier)
                    else
                        typeDefault(message, speedMultiplier)
                    end
                    if index < #messages then
                        local waitTime = (math.random(D.messageWaitMin, D.messageWaitMax) / 10) * speedMultiplier
                        task.wait(waitTime)
                        eraseText(speedMultiplier)
                    end
                end
                local convoWait = (math.random(D.convoWaitMin, D.convoWaitMax) / 10) * speedMultiplier
                task.wait(convoWait)
                eraseText(speedMultiplier)
                task.wait((math.random(D.eraseWaitMin, D.eraseWaitMax) / 10) * speedMultiplier)
            end
        end
    end)
end

local function addFeature(tab, f)
    if not f then return end
    local desc = f.desc
    local locked = (f.supported and not f.supported()) or false
    Elements[f.key] = tab:Toggle({
        Title = f.title,
        Desc = desc,
        Value = State[f.key],
        Locked = locked,
        LockedTitle = "Not supported by your executor",
        Callback = function(v) setState(f.key, v) end,
    })
    tab:Space()
end

local function addControl(tab, key)
    local c = Controls[key]
    if not c then return end
    if c.kind == "toggle" then
        Elements[key] = tab:Toggle({
            Title = c.title, Desc = c.desc, Value = State[key],
            Callback = function(v) setState(key, v) end,
        })
    elseif c.kind == "slider" then
        Elements[key] = tab:Slider({
            Title = c.title, Desc = c.desc, Step = c.step, IsTooltip = true,
            Value = { Min = c.min, Max = c.max, Default = State[key] },
            Callback = function(v) setState(key, v) end,
        })
    elseif c.kind == "theme" then
        Elements[key] = tab:Dropdown({
            Title = c.title, Desc = c.desc,
            Values = themeList(), Value = State[key], Multi = false,
            Callback = function(v) setState(key, v) end,
        })
    else
        Elements[key] = tab:Input({
            Title = c.title, Desc = c.desc, Value = State[key], Placeholder = c.placeholder or "",
            Type = c.multiline and "Textarea" or "Input",
            Callback = function(v) setState(key, v) end,
        })
    end
    tab:Space()
end
--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /  
    |__/|__/_/_//_/\_,_/\____/___/
    
    Roblox UI Library for scripts
    
    To view the source code, see the `src/` folder on the official GitHub repository.
    
    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/Footagesus/WindUI
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]
-- ui neuron activation starter
local function buildUI()
    local ok, lib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)
    if not ok or type(lib) ~= "table" then
        warnf("couldn't load WindUI (" .. tostring(lib) .. "), continuing without a UI")
        return
    end
    WindUI = lib
    local UserInputService = game:GetService("UserInputService")
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    local isTablet = UserInputService.TouchEnabled and UserInputService.KeyboardEnabled
    local windowSize = UDim2.fromOffset(800, 70)
    if isMobile then
        windowSize = UDim2.fromOffset(650, 79)
    elseif isTablet then
        windowSize = UDim2.fromOffset(600, 80)
    end

    PolyWindow = WindUI:CreateWindow({
        Title = "Sand.cc",
        Author = "wtf is a Gpssickle",
        Folder = "Sand.cc",
        IconSize = 45,
        Icon = "rbxassetid://130186106560596",
        NewElements = true,
        Size = windowSize,
        HideSearchBar = false,
        OpenButton = {
            Title = typesheet,
            CornerRadius = UDim.new(0, 8),
            StrokeThickness = 1,
            Enabled = true,
            Draggable = true,
            OnlyMobile = true,
            Color = ColorSequence.new(Color3.fromHex("#7775F2"), Color3.fromHex("#257AF7")),
        },
        Topbar = { Height = 44, ButtonsType = "Default"},
    })
    PolyWindowRef = PolyWindow

    applyTheme(State.uiTheme)
    applyTransparency(State.uiTransparency)

    local optimization = PolyWindow:Section({ Title = "Optimization" })
    local Engine = PolyWindow:Section({ Title = "Engine" })
    local Sand = PolyWindow:Section({ Title = "Sand" })
    local Tabs = {
        visuals = optimization:Tab({ Title = "Visuals", Icon = "eye", Border = true }),
        fx = optimization:Tab({ Title = "Textures & FX", Icon = "layers", Border = true }),
        performance = optimization:Tab({ Title = "Performance", Icon = "zap", Border = true }),
        players = optimization:Tab({ Title = "Workspace", Icon = "globe", Border = true }),
        network = optimization:Tab({ Title = "Network & UI", Icon = "wifi", Border = true }),
        fastflags = Engine:Tab({ Title = "Fast Flags", Icon = "settings-2", Border = true }),
        theme = Sand:Tab({ Title = "Theme", Icon = "palette", Border = true }),
        config = Sand:Tab({ Title = "Config", Icon = "save", Border = true }),
        about = Sand:Tab({ Title = "About", Icon = "info", Border = true }),
    }
    for tabKey, items in pairs(Layout) do
        for _, item in ipairs(items) do
            if item[1] == "f" then
                addFeature(Tabs[tabKey], FeatureByKey[item[2]])
            else
                addControl(Tabs[tabKey], item[2])
            end
        end
    end
    local ff = Tabs.fastflags
    if ff then
        ff:Paragraph({
            Title = "Fast Flags",
            Desc = "Paste a JSON dictionary of fast flags and apply them. "
                .. "Values are coerced to strings"
                .. "Most flags require a rejoin to take effect :1",
        })
        ff:Space()

        local supported = fflagReady()
        Elements.fflagJSON = ff:Input({
            Title = "Fast Flags (JSON)",
            Desc = supported
                and "Example: { \"FFlagDebugSkyGray\": \"True\", \"DFIntTaskSchedulerTargetFps\": \"240\" }"
                or  "setfflag isn't available in this executor, so this can't be applied.",
            Value = State.fflagJSON,
            Placeholder = '{\n  "FFlagDebugSkyGray": "True"\n}',
            Type = "Textarea",
            Callback = function(v) setState("fflagJSON", v) end,
        })
        ff:Space()

        ff:Button({
            Title = "Apply Fast Flags",
            Icon = "zap",
            Justify = "Center",
            Callback = function()
                if not fflagReady() then
                    notify("Sand", "setfflag isn't available in this executor.")
                    return
                end
                local tbl, err = parseFlagJSON(State.fflagJSON)
                if not tbl then
                    notify("Sand", "Invalid JSON: " .. tostring(err))
                    return
                end
                runFFlagJob(tbl, function(applied, failed)
                    notify("Sand", string.format(
                        "Injected %d fastflag%s%s",
                        applied,
                        applied == 1 and "" or "s",
                        failed > 0 and (" (" .. failed .. " failed)") or ""
                    ))
                    print(string.format("[Sand.cc] Injected %d fastflag(s), %d failed", applied, failed))
                end)
            end,
        })
        ff:Space()

        Elements.failedFlagList = ff:Paragraph({
            Title = "Failed flags",
            Desc = failedListText(),
        })
        ff:Space()

        ff:Button({
            Title = "Restore Prev FFlags",
            Desc = "Puts every flag back to what it was before Sand touched it (and tells you how it went)\n(wouldn't restore every flags, some might fail)",
            Icon = "rotate-ccw",
            Justify = "Center",
            Callback = restoreFFlags,
        })
        ff:Space()

        ff:Button({
            Title = "Rejoin Server",
            Desc = "Teleports you back to this same server\n(useful after applying flags)",
            Icon = "log-out",
            Justify = "Center",
            Callback = function()
                local TeleportService = game:GetService("TeleportService")
                local ok, err = pcall(function()
                    TeleportService:TeleportToPlaceInstance(
                        game.PlaceId,
                        game.JobId,
                        LocalPlayer
                    )
                end)
                if not ok then
                    notify("Sand", "Rejoin failed: " .. tostring(err))
                end
            end,
        })
        ff:Space()
        ff:Section({ Title = "Presets (save ur flags in the sand pile :3)" })
        loadPresetFile()
        Elements.presetName = ff:Input({
            Title = "Preset name / search",
            Desc = "Type a name to save, or part of one to find it (typos are fine, it's fuzzy :v)",
            Value = "",
            Placeholder = "my cool flags",
            Type = "Input",
            Callback = function(v)
                presetQuery = tostring(v or "")
                refreshPresetList()
            end,
        })
        ff:Space()
        ff:Button({
            Title = "Save/Overwrite",
            Desc = "Stores the JSON above under that name.\nSame name = overwrites it.",
            Icon = "save",
            Justify = "Center",
            Callback = presetSave,
        })
        ff:Button({
            Title = "Load",
            Desc = "Fuzzy finds the best match,\nputs it in the JSON box and injects it :p",
            Icon = "folder-open",
            Justify = "Center",
            Callback = presetLoad,
        })
        ff:Button({
            Title = "Delete",
            Desc = "Yeets the matching preset forever\n(only if the match is solid).",
            Icon = "trash-2",
            Justify = "Center",
            Color = Color3.fromHex("#ff4830"),
            Callback = presetDelete,
        })
        ff:Space()
        Elements.presetList = ff:Paragraph({
            Title = "Save list",
            Desc = presetListText(),
        })
        ff:Space()

        ff:Paragraph({
            Title = "Warner",
            Desc = "Bannable flags are your responsibility,\ndon't do dumb stuff plzzz\n \nAlso if you want to completely get rid of the injected flags just close Roblox and reopen it :p",
        })
    end

    local themeTab = Tabs.theme
    if themeTab then
        themeTab:Paragraph({
            Title = "Appearance",
            Desc = "Pick a WindUI theme, tweak window transparency, and customize the typing cursor. All saved automatically.",
        })
        themeTab:Space()
        Elements.uiTheme = themeTab:Dropdown({
            Title = Controls.uiTheme.title,
            Desc = Controls.uiTheme.desc,
            Values = themeList(),
            Value = State.uiTheme,
            Multi = false,
            Callback = function(v) setState("uiTheme", v) end,
        })
        themeTab:Space()
        Elements.uiTransparency = themeTab:Slider({
            Title = Controls.uiTransparency.title,
            Desc = Controls.uiTransparency.desc,
            Step = Controls.uiTransparency.step,
            IsTooltip = true,
            Value = { Min = Controls.uiTransparency.min, Max = Controls.uiTransparency.max, Default = State.uiTransparency },
            Callback = function(v) setState("uiTransparency", v) end,
        })
        themeTab:Space()
        Elements.textCursor = themeTab:Input({
            Title = Controls.textCursor.title,
            Desc = Controls.textCursor.desc,
            Value = State.textCursor,
            Placeholder = "_",
            Type = "Input",
            Callback = function(v) setState("textCursor", v) end,
        })
        themeTab:Space()
        Elements.textCursor2 = themeTab:Input({
            Title = Controls.textCursor2.title,
            Desc = Controls.textCursor2.desc,
            Value = State.textCursor2,
            Placeholder = "  ",
            Type = "Input",
            Callback = function(v) setState("textCursor2", v) end,
        })
        themeTab:Space()
        themeTab:Toggle({
            Title = Controls.bgMusic.title,
            Desc = Controls.bgMusic.desc,
            Value = State.bgMusic,
            Callback = function(v) setState("bgMusic", v) end,
        })
        themeTab:Space()
        themeTab:Button({
            Title = "Reset appearance",
            Icon = "rotate-ccw",
            Justify = "Center",
            Callback = function()
                setState("uiTheme", Controls.uiTheme.default)
                setState("uiTransparency", Controls.uiTransparency.default)
                setState("textCursor", Controls.textCursor.default)
                setState("textCursor2", Controls.textCursor2.default)
                syncUI("uiTheme")
                syncUI("uiTransparency")
                syncUI("textCursor")
                syncUI("textCursor2")
                notify("Sand", "Appearance reset to defaults.")
            end,
        })
    end

    local ct = Tabs.config
    ct:Paragraph({
        Title = "Autosave file",
        Desc = fsReady() and (savePath() .. " - rewritten automatically whenever a setting changes.")
            or "This executor has no file functions, so settings can't be saved.",
    })
    ct:Space()
    ct:Button({ Title = "Save now", Icon = "save", Justify = "Center", Callback = function()
        notify("Sand", saveNow() and "Saved." or "Couldn't save (see the console).")
    end })
    ct:Space()
    ct:Button({ Title = "Reload saved file", Icon = "refresh-cw", Justify = "Center", Callback = function()
        local n = loadSaved(true)
        for key in pairs(Defs) do syncUI(key) end
        notify("Sand", n > 0 and ("Loaded " .. n .. " settings.") or "No saved file found.")
    end })
    ct:Space()
ct:Button({ Title = "Enable everything", Icon = "zap", Justify = "Center", Callback = function()
    enableAll()
    notify("Sand", "All features switched on")
end })
ct:Space()
ct:Button({ Title = "Disable everything", Icon = "power", Justify = "Center", Callback = function()
    disableAll()
    notify("Sand", "All features switched off.")
end })
    ct:Space()
    ct:Button({ Title = "Reset to defaults", Icon = "rotate-ccw", Justify = "Center", Callback = function()
        resetDefaults()
        notify("Sand", "Everything is off again.")
    end })
    ct:Space()
    ct:Button({ Title = "Unload Sand.cc", Icon = "shredder", Justify = "Center",
        Color = Color3.fromHex("#ff4830"), Callback = function() cfg.unload() end })

    local at = Tabs.about
    at:Section({ Title = "Sand", TextSize = 24 })
    at:Section({ Title = "A random script that hates making things pretty and likes fps and also extremely reversible :p\n \nalso this script is better verison of the deprecated script i made called ''Optiz'' if yer wondering :1\n \nuse the Sand.cc larper called ''Gravel.cc'' wit dis :3\n \nif u used a snippet pweaty pwease credit me 3;", TextSize = 16 })
    at:Space()
    at:Paragraph({
        Title = "Code",
        Desc = "head over to my readme plz....... or my source :p",
    })
at:Button({
    Title = "copy da README.md URL",
    Desc = "uhhhh read me.... ig :s",
    Icon = "github",
    Justify = "Center",
    Callback = function()
        setclipboard("https://github.com/hm5650/Sand/blob/main/README.md")
        notify("Sand", "README.md URL copied!! :3")
    end
})
at:Button({
    Title = "copy da Source URL",
    Desc = "the whole repo :o",
    Icon = "github",
    Justify = "Center",
    Callback = function()
        setclipboard("https://github.com/hm5650/Sand/tree/main")
        notify("Sand", "Source URL copied!! :3")
    end
})
at:Space()
at:Button({
    Title = "Also Try Out ''Gravel.cc''!! :DD",
    Desc = "Gravel.cc for the best gravel",
    Icon = "zap",
    Justify = "Center",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/HBSS.lua"))()
        notify("Sand", "Gravel.cc STARTED!?1!1!")
    end
})
at:Space()
at:Paragraph({
    Title = "Credits",
    Desc = "Credits to other creators",
})
at:Paragraph({
    Title = "Sand: UI",
    Desc = "UI: WindUI (Footagesus)\n \nAnd that's it :1\ntoo lazy to type more stuff",
})
at:Space()
at:Paragraph({
    Title = "Updatelog",
    Desc = "Update history and changes\n \nSand (DD/MM/YYYY)",
})
at:Paragraph({
    Title = "Sand (05/10/2025)",
    Desc = "Howdy! im existing now :3",
})
at:Paragraph({
    Title = "Sand (07/10/2025)",
    Desc = "sum bug fixes ig & new stuff\nAdded: Remove Player Clothing\nAdded: Hide Held Tools\nAdded: Disable Fire/Smoke/Sparkles\nAdded: Hide ForceField Bubbles\nFixed: Sum fastflag issues\nBugs Fixed: 9",
})
at:Paragraph({
    Title = "Sand (08/10/2025)",
    Desc = "idk restore prev flags broke\nFixed: Restore Prev Flag Button\nBugs Fixed: 4",
})
task_("startRNG4", function()
    task.wait(0.5)
    startRNG4()
end)
end

--tsu
--[[
at:Paragraph({
    Title = "Sand (DD/10/2025)",
    Desc = "",
})
]]

local function weirdflash()
    local TweenService = game:GetService("TweenService")
    local startSound = Instance.new("Sound")
    startSound.SoundId = "rbxassetid://121769472475128"
    startSound.Volume = 0.5
    startSound.Parent = SoundService
    local flashSound = Instance.new("Sound")
    flashSound.SoundId = "rbxassetid://85431715800788"
    flashSound.Volume = 0.5
    flashSound.Parent = SoundService
    local closeGui = Instance.new("ScreenGui")
    closeGui.Name = "293729929_927283_9283_392"
    closeGui.ResetOnSpawn = false
    closeGui.IgnoreGuiInset = true
    closeGui.DisplayOrder = 2147483647
    local ok = pcall(function() closeGui.Parent = CoreGui end)
    if not ok or not closeGui.Parent then closeGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    local bg = Instance.new("Frame")
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = Color3.new(0, 0, 0)
    bg.BackgroundTransparency = 1
    bg.ZIndex = 1
    bg.Parent = closeGui
    local flash = Instance.new("Frame")
    flash.Size = UDim2.fromScale(1, 1)
    flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flash.BackgroundTransparency = 0
    flash.ZIndex = 100
    flash.Parent = closeGui
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 0
    blurEffect.Parent = Lighting
    pcall(function() startSound:Play() end)
    local blurIn = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(blurEffect, blurIn, { Size = 20 }):Play()
    task.wait(0.15)
    pcall(function() flashSound:Play() end)
    local fadeOut = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    TweenService:Create(blurEffect, fadeOut, { Size = 0 }):Play()
    TweenService:Create(flash, fadeOut, { BackgroundTransparency = 1 }):Play()
    task.wait(0.4)
    pcall(function() closeGui:Destroy() end)
    pcall(function() blurEffect:Destroy() end)
    task.wait(1)
    pcall(function() startSound:Destroy() end)
    pcall(function() flashSound:Destroy() end)
end

--unlder
local function unload()
    if not alive then return end
    alive = false
    killthreads()

    pcall(weirdflash)
    env.Saaaaaaaaaaaaaaaaaaaaaaand_ = false
    for prop, ot in pairs(Orig) do
        for inst, value in pairs(ot) do
            if inst and inst.Parent ~= nil then
                pcall(setProp, inst, prop, value)
            end
            ot[inst] = nil
        end
    end
    for i = #Features, 1, -1 do
        local f = Features[i]
        if f.active then
            pcall(runDeactivate, f)
        end
    end
    if Runtime.rng4 and Runtime.rng4.tag then
        pcall(function() Runtime.rng4.tag:Destroy() end)
        Runtime.rng4.tag = nil
    end
    Runtime.rng4 = nil
    pcall(destroyBGM)
    if addedConn then
        pcall(function() addedConn:Disconnect() end)
        addedConn = nil
    end
    pcall(stopPartCache)
    if PolyWindow then pcall(function() PolyWindow:Destroy() end) end
    PolyWindowRef = nil
    if env.__SandCC == cfg then env.__SandCC = nil end
end

cfg.State = State
cfg.set = function(key, value)
    setState(key, value)
    syncUI(key)
end
cfg.save = saveNow
cfg.load = function()
    local n = loadSaved(true)
    for key in pairs(Defs) do syncUI(key) end
    return n
end
cfg.disableAll = disableAll
cfg.enableAll = function()
    for _, f in ipairs(Features) do
        if f.key ~= "fastFlags" then
            setState(f.key, true)
            syncUI(f.key)
        end
    end
end
cfg.unload = unload
env.__SandCC = cfg

local autoloaded = 0
if cfg.autoload ~= false then autoloaded = loadSaved(false) end
task_("startPartCache", startPartCache)

if cfg.createwindui ~= false then
    local ok, err = pcall(buildUI)
    if not ok then warnf("UI error: " .. tostring(err)) end
    cfg.PolyWindow = PolyWindow
    if PolyWindow and autoloaded > 0 then
        notify("Sand", "Autoloaded " .. autoloaded .. " saved settings.")
    end
end
task_("initBGM", function()
    initBGM()
end)
task_("bgmUpdater", function()
    while alive do
        task.wait(0.25)
        pcall(updateBGM)
    end
end)

task_("rngOpenButton", function()
    local openBtn = PolyWindow.OpenButtonMain and PolyWindow.OpenButtonMain.Button
    if not openBtn then return end
    local label
    for _, d in ipairs(openBtn:GetDescendants()) do
        if d:IsA("TextLabel") and d.Text == typesheet then
            label = d
            break
        end
    end
    if not label then
        for _, d in ipairs(openBtn:GetDescendants()) do
            if d:IsA("TextLabel") then
                label = d
                break
            end
        end
    end
    if not label then return end
    label.Text = actasgravel()
    local function isActuallyVisible(obj)
        local cur = obj
        while cur do
            if cur:IsA("GuiObject") and not cur.Visible then return false end
            if cur:IsA("LayerCollector") and not cur.Enabled then return false end
            cur = cur.Parent
        end
        return true
    end
    local wasVisible = isActuallyVisible(label)
    while alive and label.Parent do
        local nowVisible = isActuallyVisible(label)
        if nowVisible and not wasVisible then
            label.Text = actasgravel()
        end
        wasVisible = nowVisible
        task.wait(0.1)
    end
end)

if PolyWindow and PolyWindow.OnDestroy then
    PolyWindow:OnDestroy(function()
        unload()
        print("Sand.cc closed :c")
    end)
end

reconcile()
task_("mainTick", function()
    while alive do
        task.wait(clamp(State.interval, 3, 60))
        if not alive then break end
        if subside_I_I_I_I_I_() then continue end
        pcall(pruneDead)
        for _, f in ipairs(Features) do
            if f.active and f.tick then
                local ok, err = pcall(f.tick, f)
                if not ok then warnOnce(f.title .. ": " .. tostring(err)) end
            end
        end
    end
end)

_(cos(1))
end
return cfg
--fin
--[[
might break games or not............ who knows really maybe it's ur fault :v
orrrrrr maybe it's my fault????
or maybe it's david bazooks fault >_>
[insert more logorrhea here.]
]]
