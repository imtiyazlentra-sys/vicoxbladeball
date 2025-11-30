local ReplicatedStorage = cloneref(game:GetService('RobloxReplicatedStorage'))
local RbxAnalyticsService = cloneref(game:GetService('RbxAnalyticsService'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local NetworkClient = cloneref(game:GetService("NetworkClient"))
local TweenService = cloneref(game:GetService('TweenService'))
local VirtualUser = cloneref(game:GetService('VirtualUser'))
local HttpService = cloneref(game:GetService('HttpService'))
local RunService = cloneref(game:GetService('RunService'))
local LogService = cloneref(game:GetService('LogService'))
local Lighting = cloneref(game:GetService('Lighting'))
local CoreGui = cloneref(game:GetService('CoreGui'))
local Players = cloneref(game:GetService('Players'))
local Debris = cloneref(game:GetService('Debris'))
local Stats = cloneref(game:GetService('Stats'))
local CollectionService = game:GetService("CollectionService")
local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
local Workspace = cloneref(game:GetService('Workspace'))
local ContentProvider = cloneref(game:GetService("ContentProvider"))


if not game:IsLoaded() then
    game.Loaded:Wait()
end

print("yo user!, thanks for using my script. this script is beta i guess. my friend want to try this script for her own.")
print("...")
print("i want to say smth. sorry if the script is so bad ass, yo know im not good at this. just have fun with this")
print("...")
print("Reizo nonchalant + Sigma + Skibidi + Mogger")
print("LETS GO")

local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/RudertTiktok/VICLIB/refs/heads/main/VICNOTIFY", true))()

local success, result = pcall(function()
    loadstring(game:GetObjects("rbxassetid://15900013841")[1].Source)()
end)
if not success then
    Notification.new("error", "Error", "Bypass Not Successfully Loaded!?", true, 4)
else
    Notification.new("success", "Success", "Bypass Successfully Loaded!", true, 4)
end

local LocalPlayer = Players.LocalPlayer


local Tornado_Time = tick()
local Last_Input = UserInputService:GetLastInputType()
local Vector2_Mouse_Location = nil
local Grab_Parry = nil
local Remotes = {}
local Parry_Key = nil
local Speed_Divisor_Multiplier = 1.1
local LobbyAP_Speed_Divisor_Multiplier = 1.1
local firstParryFired = false
local ParryThreshold = 2.5
local firstParryType = 'F_Key'
local Previous_Positions = {}
local VirtualInputService = game:GetService("VirtualInputManager")
local parryCooldown = 0.0
local lastParryTime = 0
local auto_farm_enabled = false
local auto_farm_type = "Random Orbit"
local auto_farm_orbit = 5
local auto_farm_height = 10
local auto_farm_radius = 20
local cameraViewMode = "ThirdPerson"
local Camera = Workspace.CurrentCamera
local visualizerEnabled = false
local cameraLocked = false
local cameraConnection = nil
local ParryRemotes = {}
local OriginalMetas = {}
local Remotes = {}
local HighPingCompensation = false
local Parried = false
local Last_Parry = 0
local Parries = 0
local Alive = Workspace:FindFirstChild("Alive")

getgenv().AnimationsEnabled = false
getgenv().BallDirectionIndicator = true
getgenv().speeddo = 2
getgenv().WorldFilterEnabled = false
getgenv().AtmosphereEnabled = false
getgenv().FogEnabled = false
getgenv().SaturationEnabled = false
getgenv().HueEnabled = false
getgenv().InfinityDetection = true
getgenv().DeathSlashDetection = true
getgenv().TimeHoleDetection = true
getgenv().HighPingCompensation = true
getgenv().LastCloseContact = getgenv().LastCloseContact or 0
getgenv().InCloseRange = getgenv().InCloseRange or false
local PingHistory = {}
local Tornado_Time = Tornado_Time or 0
local BallTrail = nil
local PlayerTrail = nil
local TrailConnection = nil
local lastTrailUpdateTime = 0 

local BallBillboard = nil
local PlayerBillboard = nil
local lastUpdateTime = 0

local ballBillboardEnabled = false
getgenv().FirstParryDone = false
local FirstParryDone = getgenv().FirstParryDone
local playerBillboardEnabled = false

local Last_Spam = Last_Spam or 0

local Auto_Parry = {}

local Configs = {       
    plushie_enabled = false, 
    plushie_type = "Miku", 
    visual_ring = false,    
    manual_spam = false, 
    auto_parry = false,
    auto_spam_parry = false,
    auto_parry_rotation = false,
    lobby_auto_parry = true,
    auto_parry_rotation_acuity = 5,
    curve_method = "Normal",
    no_slow = false,
    no_render = false,
    smart_no_render = false,
    sound_effect_enabled = false,
    night_mode = false,
    strafe = 5,
    strafe_speed = 50,
    personnel_detector = false,
    personnel_detector_auto_leave = true,
    auto_particles = false,
    screen_enabled = true,
    field = false,
    field_of_view = 0,
    camera = false,
    ability_vulnerability = true,
    mode = "Quad Jump",
    animations = false,
    smart_animations = false,
    animation_type = "None",
    manual_spam = false,
    ai_play = false,
    ai_method = "AdvancedPro",    
    ball_text_enabled = false,
    player_text_enabled = false,
    swordModel = "",
    swordAnimations = "",
    swordFX = "",
    plushieEnabled = false,
    plushieType = "",
    visualize_Enabled = false,
    visuals_enabled = true,
    player_follow = false,
    follow_target = nil, 
    color_shift = false, 
    shaders = false, 
    shaders_intensity = 150, 
    shaders_size = 78.54, 
    shaders_threshold = 236.25, 
    environment_specular_scale = 50, 
    environment_diffuse_scale = 50, 
    ray_tracing = false, 
    ambient = false, 
    ambient_density = 50,   
    disable_quantum_effects = false,
    auto_rewards = false, 
    disable_quantum_effects = false, 
    slashes_of_fury_enabled = false, 
    slashes_of_fury_mode = "Blatant", 
    animations = false, 
    visualize = true, 
    triggerbot = false, 
    ping_booster = false, 
    self_effect = true,
    self_effect_selected = "Magic Circle", 
    kill_effect = false, 
    ball_trail_enabled = false, -- Existing: Enable/disable ball trail
    ball_trail_color = Color3.fromRGB(255, 0, 0), -- Existing: Ball trail color
    player_trail_enabled = false, -- Existing: Enable/disable player trail
    player_trail_color = Color3.fromRGB(0, 255, 255), -- Existing: Player trail color
    trail_particle_enabled = false, -- New: Enable/disable particle effect on trails
    trail_particle_rate = 10, -- New: Particle emission rate (particles per second)
    trail_animation_type = "Pulse", -- New: Trail animation type (Static, Pulse, Flicker)
    trail_texture = "None",
    kill_effect = false,
    kill_effect_scale = 1,
    kill_effect_animation = "Spiral", 
    announcer_text = ""
}


local ConnectionsManager = {}

function ConnectionsManager:disconnect()
    if not ConnectionsManager[self] then
        return
    end
    ConnectionsManager[self]:Disconnect()
    ConnectionsManager[self] = nil
end

function ConnectionsManager:abadone()
    for _, connection in ConnectionsManager do
        if typeof(connection) == 'function' then
            continue
        end
        connection:Disconnect()
        connection = nil
    end
end

ConnectionsManager['controller'] = RunService.Heartbeat:Connect(function()
    if not Window then
        ConnectionsManager:abadone()
    end
end)

local AutoParry = AutoParry or {}

AutoParry = {
    ball = nil,
    target = nil,
    entity_properties = nil
}

AutoParry.ball = {
    training_ball_entity = nil,
    client_ball_entity = nil,
    ball_entity = nil,
    properties = {
        aero_dynamic_time = tick(),
        hell_hook_completed = true,
        last_position = Vector3.zero,
        rotation = Vector3.zero,
        position = Vector3.zero,
        last_warping = tick(),               
        is_curveds = false,
        is_curved = false,
        last_tick = tick(),
        auto_spam = false,
        cooldown = false,
        respawn_time = 0,
        parry_range = 0,
        spam_range = 0,        
        maximum_speed = 0,
        old_speed = 0,
        parries = 0,
        direction = 0,
        distance = 0,
        velocity = 0,
        last_hit = 0,
        lerp_radians = 0,
        radians = 0,
        speed = 0,
        prev_speed = 0,
        dot = 0,
        curve_history = {}
    }
}

AutoParry.target = {
    current = nil,
    current_changed = false,  
    direction_changed_on_cframe = false,
    from = nil,
    aim = nil,
}

AutoParry.entity_properties = {
    server_position = Vector3.zero,
    velocity = Vector3.zero,
    is_moving = false,
    direction = 0,
    distance = 0,
    speed = 0,
    dot = 0
}

local Player = {
    Entity = nil,
    properties = {
        grab_animation = nil
    }
}

Player.Entity = {
    properties = {
        sword = '',
        server_position = Vector3.zero,
        velocity = Vector3.zero,
        position = Vector3.zero,
        is_moving = false,
        is_moving_backwards = false,
        speed = 0,
        ping = 0
    }
}



local World = {}


local function linear_predict(a: any, b: any, time_volume: number)
    return a + (b - a) * time_volume
end

function World:get_pointer()
    local UserInputService = game:GetService("UserInputService")    
    local mouse_location = UserInputService:GetMouseLocation()
    local ray = workspace.CurrentCamera:ScreenPointToRay(mouse_location.X, mouse_location.Y, 0)    
    local target = ray.Origin + ray.Direction
    return CFrame.lookAt(ray.Origin, target)
end

function Player:get_aim_entity()
    local closest_entity = nil
    local minimal_dot_product = -math.huge
    local camera_direction = workspace.CurrentCamera.CFrame.LookVector
    for _, player in workspace.Alive:GetChildren() do
        if not player or player.Name == LocalPlayer.Name or not player:FindFirstChild('HumanoidRootPart') then
            continue
        end
        local entity_direction = (player.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).Unit
        local dot_product = camera_direction:Dot(entity_direction)
        if dot_product > minimal_dot_product then
            minimal_dot_product = dot_product
            closest_entity = player
        end
    end
    return closest_entity
end

function Player:get_closest_player_to_cursor()
    local closest_player = nil
    local minimal_dot_product = -math.huge
    for _, player in workspace.Alive:GetChildren() do
        if player == LocalPlayer.Character or player.Parent ~= workspace.Alive then
            continue
        end
        local player_direction = (player.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Unit
        local pointer = World.get_pointer()
        local dot_product = pointer.LookVector:Dot(player_direction)
        if dot_product > minimal_dot_product then
            minimal_dot_product = dot_product
            closest_player = player
        end
    end
    return closest_player
end


local function linear_predict(a: any, b: any, time_volume: number)
    return a + (b - a) * time_volume
end



function Auto_Parry.Lobby_Balls()
    for _, Instance in pairs(workspace.TrainingBalls:GetChildren()) do
        if Instance:GetAttribute("realBall") then
            return Instance
        end
    end
end

function Auto_Parry.Get_Balls()
    local Balls = {}

    for _, Instance in pairs(workspace.Balls:GetChildren()) do
        if Instance:GetAttribute('realBall') then
            Instance.CanCollide = false
            table.insert(Balls, Instance)
        end
    end
    return Balls
end

function Auto_Parry.Get_Ball()
    for _, Instance in pairs(workspace.Balls:GetChildren()) do
        if Instance:GetAttribute('realBall') then
            Instance.CanCollide = false
            return Instance
        end
    end
end

function AutoParry.get_client_ball()
    for _, ball in workspace.Balls:GetChildren() do
        if not ball:GetAttribute("realBall") then
            return ball
        end
    end
end

local function Update_Ping()
    local currentPing = game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()
    table.insert(PingHistory, 1, currentPing)
    if #PingHistory > MaxPingHistory then
        table.remove(PingHistory, #PingHistory)
    end
end
local function GetAveragePing()
    if #PingHistory == 0 then return 0 end
    local sum = 0
    for _, ping in ipairs(PingHistory) do
        sum = sum + ping
    end
    return sum / #PingHistory
end

AutoParry.Velocity_History = AutoParry.Velocity_History or {}


AutoParry.ball.training_ball_entity = Auto_Parry.Lobby_Balls()
AutoParry.ball.ball_entity = Auto_Parry.Get_Ball()
AutoParry.ball.client_ball_entity = AutoParry.get_client_ball()

-- Limit network
NetworkClient:SetOutgoingKBPSLimit(math.huge)

-- Ping cache
local cached_ping = 0
local last_ping_update = 0
local function update_cached_ping()
    if tick() - last_ping_update >= 0.01 then
        cached_ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        last_ping_update = tick()
    end
    return cached_ping
end

local function setupConnections()
    task.spawn(function()
        if ConnectionsManager['server_position_simulation'] then
            ConnectionsManager:disconnect('server_position_simulation')
        end
        if ConnectionsManager['player_properties_update'] then
            ConnectionsManager:disconnect('player_properties_update')
        end
        if ConnectionsManager['ball_properties_update'] then
            ConnectionsManager:disconnect('ball_properties_update')
        end

        -- Simulasi posisi server player
        ConnectionsManager['server_position_simulation'] = RunService.Heartbeat:Connect(function()
            local ping = update_cached_ping()
            if not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return end
            Player.Entity.properties.server_position = LocalPlayer.Character.PrimaryPart.Position
        end)

        -- Update properti player
        ConnectionsManager['player_properties_update'] = RunService.PostSimulation:Connect(function()
            local character = LocalPlayer.Character
            if not character or not character.PrimaryPart then return end
            local props = Player.Entity.properties
            props.sword = character:GetAttribute('CurrentlyEquippedSword')
            props.ping = update_cached_ping()
            props.velocity = character.PrimaryPart.AssemblyLinearVelocity
            props.speed = props.velocity.Magnitude
            props.is_moving = props.speed > 16
            props.is_moving_backwards = false

            if AutoParry.ball and AutoParry.ball.properties.position then
                local ball_pos = AutoParry.ball.properties.position
                local char_pos = character.PrimaryPart.Position
                local dir_to_ball = (ball_pos - char_pos).Unit
                local vel_dir = props.velocity.Unit
                if props.speed > 16 and dir_to_ball:Dot(vel_dir) < -0.1 then
                    props.is_moving_backwards = true
                end
            end
        end)

        -- Update properti bola
        ConnectionsManager['ball_properties_update'] = RunService.PostSimulation:Connect(function()
            local balls = {}
            local ball = AutoParry.ball.ball_entity
            local lobby_ball = AutoParry.ball.training_ball_entity
            if ball then table.insert(balls, ball) end
            if lobby_ball then table.insert(balls, lobby_ball) end
            if #balls == 0 then return end

            for _, ball in pairs(balls) do
                local zoomies = ball:FindFirstChild('zoomies')
                local props = AutoParry.ball.properties

                props.position = ball.Position
                props.velocity = zoomies and zoomies.VectorVelocity or ball.AssemblyLinearVelocity
                props.distance = (Player.Entity.properties.server_position - props.position).Magnitude
                props.speed = props.velocity.Magnitude
                props.direction = (Player.Entity.properties.server_position - props.position).Unit
                props.dot = props.direction:Dot(props.velocity.Unit)
                props.radians = math.rad(math.asin(props.dot))
                props.lerp_radians = props.lerp_radians and (props.lerp_radians * 0.3 + props.radians * 0.9) or props.radians
                if not (props.lerp_radians < 0) and not (props.lerp_radians > 0) then
                    props.lerp_radians = 0.027
                end
                props.maximum_speed = math.max(props.speed, props.maximum_speed)

                -- Pilih target
                AutoParry.target.aim = not UserInputService.TouchEnabled
                    and (Player.get_closest_player_to_cursor and Player.get_closest_player_to_cursor() or nil)
                    or (Player.get_aim_entity and Player.get_aim_entity() or nil)

                if ball:GetAttribute('from') then
                    AutoParry.target.from = workspace.Alive:FindFirstChild(ball:GetAttribute('from'))
                end
                if ball:GetAttribute('target') then
                    AutoParry.target.current = workspace.Alive:FindFirstChild(ball:GetAttribute('target'))
                end

                props.rotation = props.position
                if AutoParry.target.current and AutoParry.target.current.Name == LocalPlayer.Name then
                    props.rotation = AutoParry.target.aim and AutoParry.target.aim.PrimaryPart and AutoParry.target.aim.PrimaryPart.Position or props.position
                    return
                end

                if AutoParry.target.current and AutoParry.target.current.PrimaryPart then
                    local target_pos = AutoParry.target.current.PrimaryPart.Position
                    local target_vel = AutoParry.target.current.PrimaryPart.AssemblyLinearVelocity
                    AutoParry.entity_properties.server_position = target_pos
                    AutoParry.entity_properties.velocity = target_vel
                    AutoParry.entity_properties.distance = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and (LocalPlayer.Character.PrimaryPart.Position - target_pos).Magnitude or math.huge
                    AutoParry.entity_properties.direction = (Player.Entity.properties.server_position - target_pos).Unit
                    AutoParry.entity_properties.speed = target_vel.Magnitude
                    AutoParry.entity_properties.is_moving = target_vel.Magnitude > 0.1
                    AutoParry.entity_properties.dot = AutoParry.entity_properties.is_moving and math.max(AutoParry.entity_properties.direction:Dot(target_vel.Unit), 0)
                end

                ball.AncestryChanged:Connect(function(_, parent)
                    if not parent then
                        props.maximum_speed = 0
                        AutoParry.target.current = nil
                        AutoParry.target.from = nil
                    end
                end)
            end
        end)
    end)
end

task.spawn(setupConnections)
LocalPlayer.CharacterAdded:Connect(function(character)
    if character then task.spawn(setupConnections) end
end)

if LocalPlayer.Character then task.spawn(setupConnections) end


local GuiService = game:GetService('GuiService')

local function updateNavigation(guiObject: GuiObject | nil)
    GuiService.SelectedObject = guiObject
end

VicoX = loadstring(game:HttpGet("https://raw.githubusercontent.com/RudertTiktok/VICLIB/refs/heads/main/VICI.txt"))()

main = VicoX.new()

local rage = main:create_tab('Blatant', 'rbxassetid://118074323629998')
local player = main:create_tab('Player', 'rbxassetid://16149111731')
local visuals = main:create_tab('Visuals', 'rbxassetid://100148515061030')
local world = main:create_tab('World', 'rbxassetid://11395780588')
local farm = main:create_tab('Farm', 'rbxassetid://98567440108767')
local misc = main:create_tab('Misc', 'rbxassetid://121192820778837')


local function performFirstPress(parryType)
    if parryType == 'F_Key' then
        VirtualInputService:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
    elseif parryType == 'Left_Click' then
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    elseif parryType == 'Navigation' then
        local button = Players.LocalPlayer.PlayerGui.Hotbar.Block
        updateNavigation(button)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        task.wait(0.0)
        updateNavigation(nil)
    end
end

local function IsValidRemoteArgs(args)
    return #args == 7 and
           type(args[2]) == "string" and
           type(args[3]) == "number" and
           typeof(args[4]) == "CFrame" and
           type(args[5]) == "table" and
           type(args[6]) == "table" and
           type(args[7]) == "boolean"
end
local Is_Supported_Test = typeof(hookmetamethod) == "function"
local oldIndex
if Is_Supported_Test then
    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if (key == "FireServer" and self:IsA("RemoteEvent")) or (key == "InvokeServer" and self:IsA("RemoteFunction")) then
            return function(_, ...)
                local args = {...}
                if IsValidRemoteArgs(args) then
                    if not ParryRemotes[self] then
                        ParryRemotes[self] = args
                    end
                end
                return oldIndex(self, key)(_, unpack(args))
            end
        end
        return oldIndex(self, key)
    end))
end
local function RestoreParryRemote()
    for remote, _ in pairs(ParryRemotes) do
        if OriginalMetas[getmetatable(remote)] then
            local meta = getrawmetatable(remote)
            setreadonly(meta, false)
            meta.__index = nil
            setreadonly(meta, true)
        end
    end
    ParryRemotes = {}
end


type functionInfo = {
    scriptName: string,
    name: string,
    line: number,
    upvalueCount: number,
    constantCount: number
}

local function getFunction(t:functionInfo)
    t = t or {}
    local functions = {}
    local function findMatches()
        Setthreadidentity(6)
        for i,v in getgc() do
            if type(v) == "function" and islclosure(v) then
                local match = true
                local info = getinfo(v)
                if t.scriptName and (not tostring(getfenv(v).script):find(t.scriptName)) then
                    match = false
                end
                if t.name and info.name ~= t.name then
                    match = false
                end
                if t.line and info.currentline ~= t.line then
                    match = false
                end
                if t.upvalueCount and #getupvalues(v) ~= t.upvalueCount then
                    match = false
                end
                if t.constantCount and #getconstants(v) ~= t.constantsCount then
                    match = false
                end
                if match then
                    table.insert(functions,v)
                end
            end
        end
        setthreadidentity(8)
    end

    findMatches()

    if #functions == 0 then
        while task.wait(1) and #functions == 0 do
            findMatches()
        end
    end
    
    if #functions == 1 then
        return functions[1]
    end
end

type tableInfo = {
    highEntropyTableIndex: string,
}

getgenv().skinChanger = false
getgenv().swordModel = ""
getgenv().swordAnimations = ""
getgenv().swordFX = ""



if getgenv().updateSword and getgenv().skinChanger then
    getgenv().updateSword()
    return
end

local function getTable(t:tableInfo)
    t = t or {}
    local tables = {}
    
    local function findMatches()
        for i,v in getgc(true) do
            if type(v) == "table" then
                local match = true
                if t.highEntropyTableIndex and (not rawget(v,t.highEntropyTableIndex)) then
                    match = false
                end
                if match then
                    table.insert(tables,v)
                end
            end
        end
    end

    findMatches()

    if #tables == 0 then
        while task.wait(1) and #tables == 0 do
            findMatches()
        end
    end

    if #tables == 1 then
        return tables[1]
    end
end

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local swordInstancesInstance = rs:WaitForChild("Shared",9e9):WaitForChild("ReplicatedInstances",9e9):WaitForChild("Swords",9e9)
local swordInstances = require(swordInstancesInstance)

local swordsController

while task.wait() and (not swordsController) do
    for i,v in getconnections(rs.Remotes.FireSwordInfo.OnClientEvent) do
        if v.Function and islclosure(v.Function) then
            local upvalues = getupvalues(v.Function)
            if #upvalues == 1 and type(upvalues[1]) == "table" then
                swordsController = upvalues[1]
                break
            end
        end
    end
end

function getSlashName(swordName)
    local slashName = swordInstances:GetSword(swordName)
    return (slashName and slashName.SlashName) or "SlashEffect"
end

function setSword()
    if not getgenv().skinChanger then return end
    
    setupvalue(rawget(swordInstances,"EquipSwordTo"),2,false)
    
    swordInstances:EquipSwordTo(plr.Character, getgenv().swordModel)
    swordsController:SetSword(getgenv().swordAnimations)
end

local playParryFunc
local parrySuccessAllConnection

while task.wait() and not parrySuccessAllConnection do
    for i,v in getconnections(rs.Remotes.ParrySuccessAll.OnClientEvent) do
        if v.Function and getinfo(v.Function).name == "parrySuccessAll" then
            parrySuccessAllConnection = v
            playParryFunc = v.Function
            v:Disable()
        end
    end
end

local parrySuccessClientConnection
while task.wait() and not parrySuccessClientConnection do
    for i,v in getconnections(rs.Remotes.ParrySuccessClient.Event) do
        if v.Function and getinfo(v.Function).name == "parrySuccessAll" then
            parrySuccessClientConnection = v
            v:Disable()
        end
    end
end

getgenv().slashName = getSlashName(getgenv().swordFX)

local lastOtherParryTimestamp = 0
local clashConnections = {}

rs.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(...)
    setthreadidentity(2)
    local args = {...}
    if tostring(args[4]) ~= plr.Name then
        lastOtherParryTimestamp = tick()
    elseif getgenv().skinChanger then
        args[1] = getgenv().slashName
        args[3] = getgenv().swordFX
    end
    return playParryFunc(unpack(args))
end)

table.insert(clashConnections, getconnections(rs.Remotes.ParrySuccessAll.OnClientEvent)[1])

getgenv().updateSword = function()
    getgenv().slashName = getSlashName(getgenv().swordFX)
    setSword()
end

task.spawn(function()
    while task.wait(1) do
        if getgenv().skinChanger then
            local char = plr.Character or plr.CharacterAdded:Wait()
            if plr:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then
                setSword()
            end
            if char and (not char:FindFirstChild(getgenv().swordModel)) then
                setSword()
            end
            for _,v in (char and char:GetChildren()) or {} do
                if v:IsA("Model") and v.Name ~= getgenv().swordModel then
                    v:Destroy()
                end
                task.wait()
            end
        end
    end
end)

local Parries = 0

function create_animation(object, info, value)
    local animation = game:GetService('TweenService'):Create(object, info, value)

    animation:Play()
    task.wait(info.Time)

    Debris:AddItem(animation, 0)

    animation:Destroy()
    animation = nil
end

local Animation = {}
Animation.storage = {}

Animation.current = nil
Animation.track = nil

for _, v in pairs(game:GetService("ReplicatedStorage").Misc.Emotes:GetChildren()) do
    if v:IsA("Animation") and v:GetAttribute("EmoteName") then
        local Emote_Name = v:GetAttribute("EmoteName")
        Animation.storage[Emote_Name] = v
    end
end

local Emotes_Data = {}

for Object in pairs(Animation.storage) do
    table.insert(Emotes_Data, Object)
end

table.sort(Emotes_Data)

function Auto_Parry.Parry_Animation()
    local Parry_Animation = game:GetService("ReplicatedStorage").Shared.SwordAPI.Collection.Default:FindFirstChild('GrabParry')
    local Current_Sword = LocalPlayer.Character:GetAttribute('CurrentlyEquippedSword')

    if not Current_Sword then
        return
    end

    if not Parry_Animation then
        return
    end

    local Sword_Data = game:GetService("ReplicatedStorage").Shared.ReplicatedInstances.Swords.GetSword:Invoke(Current_Sword)

    if not Sword_Data or not Sword_Data['AnimationType'] then
        return
    end

    for _, object in pairs(game:GetService('ReplicatedStorage').Shared.SwordAPI.Collection:GetChildren()) do
        if object.Name == Sword_Data['AnimationType'] then
            if object:FindFirstChild('GrabParry') or object:FindFirstChild('Grab') then
                local sword_animation_type = 'GrabParry'

                if object:FindFirstChild('Grab') then
                    sword_animation_type = 'Grab'
                end

                Parry_Animation = object[sword_animation_type]
            end
        end
    end

    Grab_Parry = LocalPlayer.Character.Humanoid.Animator:LoadAnimation(Parry_Animation)
    Grab_Parry:Play()
end

Auto_Parry.Spam = Auto_Parry.Spam or {
    parries = 0,
    last_hit = tick(),
    speed = 0,
    old_speed = 0,
    maximum_speed = 0,
    entity_distance = 0,
    ball_distance = 0,
    last_position_distance = 0,
    range = 0,
    spam_accuracy = 34
}

function Auto_Parry.Play_Animation(v)
    local Animations = Animation.storage[v]

    if not Animations then
        return false
    end

    local Animator = LocalPlayer.Character.Humanoid.Animator

    if Animation.track then
        Animation.track:Stop()
    end

    Animation.track = Animator:LoadAnimation(Animations)
    Animation.track:Play()

    Animation.current = v
end



local Closest_Entity = nil

function Auto_Parry.Closest_Player()
    local Max_Distance = math.huge
    local Found_Entity = nil
    
    for _, Entity in pairs(workspace.Alive:GetChildren()) do
        if tostring(Entity) ~= tostring(LocalPlayer) then
            if Entity.PrimaryPart then
                local Distance = LocalPlayer:DistanceFromCharacter(Entity.PrimaryPart.Position)
                if Distance < Max_Distance then
                    Max_Distance = Distance
                    Found_Entity = Entity
                end
            end
        end
    end
    
    Closest_Entity = Found_Entity
    return Found_Entity
end

function Auto_Parry:Get_Entity_Properties()
    Auto_Parry.Closest_Player()

    if not Closest_Entity then
        return false
    end

    local Entity_Velocity = Closest_Entity.PrimaryPart.Velocity
    local Entity_Direction = (LocalPlayer.Character.PrimaryPart.Position - Closest_Entity.PrimaryPart.Position).Unit
    local Entity_Distance = (LocalPlayer.Character.PrimaryPart.Position - Closest_Entity.PrimaryPart.Position).Magnitude

    return {
        Velocity = Entity_Velocity,
        Direction = Entity_Direction,
        Distance = Entity_Distance
    }
end

local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled


function Auto_Parry.Parry_Data(Parry_Type)
    Auto_Parry.Closest_Player()
    
    local Events = {}
    local Camera = workspace.CurrentCamera
    local Vector2_Mouse_Location
    
    if Last_Input == Enum.UserInputType.MouseButton1 or (Enum.UserInputType.MouseButton2 or Last_Input == Enum.UserInputType.Keyboard) then
        local Mouse_Location = UserInputService:GetMouseLocation()
        Vector2_Mouse_Location = {Mouse_Location.X, Mouse_Location.Y}
    else
        Vector2_Mouse_Location = {Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2}
    end
    
    if isMobile then
        Vector2_Mouse_Location = {Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2}
    end
    
    local Players_Screen_Positions = {}
    for _, v in pairs(workspace.Alive:GetChildren()) do
        if v ~= LocalPlayer.Character then
            local worldPos = v.PrimaryPart.Position
            local screenPos, isOnScreen = Camera:WorldToScreenPoint(worldPos)
            
            if isOnScreen then
                Players_Screen_Positions[v] = Vector2.new(screenPos.X, screenPos.Y)
            end
            
            Events[tostring(v)] = screenPos
        end
    end
    
    if Parry_Type == 'Camera' then
        return {0, Camera.CFrame, Events, Vector2_Mouse_Location}
    end
    
    if Parry_Type == 'Backwards' then
        local Backwards_Direction = Camera.CFrame.LookVector * -10000
        Backwards_Direction = Vector3.new(Backwards_Direction.X, 0, Backwards_Direction.Z)
        return {0, CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Backwards_Direction), Events, Vector2_Mouse_Location}
    end

    if Parry_Type == 'Straight' then
        local Aimed_Player = nil
        local Closest_Distance = math.huge
        local Mouse_Vector = Vector2.new(Vector2_Mouse_Location[1], Vector2_Mouse_Location[2])
        
        for _, v in pairs(workspace.Alive:GetChildren()) do
            if v ~= LocalPlayer.Character then
                local worldPos = v.PrimaryPart.Position
                local screenPos, isOnScreen = Camera:WorldToScreenPoint(worldPos)
                
                if isOnScreen then
                    local playerScreenPos = Vector2.new(screenPos.X, screenPos.Y)
                    local distance = (Mouse_Vector - playerScreenPos).Magnitude
                    
                    if distance < Closest_Distance then
                        Closest_Distance = distance
                        Aimed_Player = v
                    end
                end
            end
        end
        
        if Aimed_Player then
            return {0, CFrame.new(LocalPlayer.Character.PrimaryPart.Position, Aimed_Player.PrimaryPart.Position), Events, Vector2_Mouse_Location}
        else
            return {0, CFrame.new(LocalPlayer.Character.PrimaryPart.Position, Closest_Entity.PrimaryPart.Position), Events, Vector2_Mouse_Location}
        end
    end
    
    if Parry_Type == 'Random' then
        return {0, CFrame.new(Camera.CFrame.Position, Vector3.new(math.random(-4000, 4000), math.random(-4000, 4000), math.random(-4000, 4000))), Events, Vector2_Mouse_Location}
    end
    
    if Parry_Type == 'High' then
        local High_Direction = Camera.CFrame.UpVector * 10000
        return {0, CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + High_Direction), Events, Vector2_Mouse_Location}
    end
    
    if Parry_Type == 'High' then
    local High_Direction = Vector3.new(0, -1, 0) * 10000 -- reto pra baixo seco
    return {0, CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + High_Direction), Events, Vector2_Mouse_Location}
end
    
    if Parry_Type == 'Slowball' then
    local Slowball_Direction = Vector3.new(0, -1, 0) * 99999 -- Super reto pra baixo
    return {0, CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Slowball_Direction), Events, Vector2_Mouse_Location}
end
    
    if Parry_Type == 'Left' then
        local Left_Direction = Camera.CFrame.RightVector * 10000
        return {0, CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position - Left_Direction), Events, Vector2_Mouse_Location}
    end
    
    if Parry_Type == 'Right' then
        local Right_Direction = Camera.CFrame.RightVector * 10000
        return {0, CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Right_Direction), Events, Vector2_Mouse_Location}
    end

    if Parry_Type == 'RandomTarget' then
        local candidates = {}
        for _, v in pairs(workspace.Alive:GetChildren()) do
            if v ~= LocalPlayer.Character and v.PrimaryPart then
                local screenPos, isOnScreen = Camera:WorldToScreenPoint(v.PrimaryPart.Position)
                if isOnScreen then
                    table.insert(candidates, {
                        character = v,
                        screenXY  = { screenPos.X, screenPos.Y }
                    })
                end
            end
        end
        if #candidates > 0 then
            local pick = candidates[ math.random(1, #candidates) ]
            local lookCFrame = CFrame.new(LocalPlayer.Character.PrimaryPart.Position, pick.character.PrimaryPart.Position)
            return {0, lookCFrame, Events, pick.screenXY}
        else
            return {0, Camera.CFrame, Events, { Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 }}
        end
    end
    
    return Parry_Type
end

function Auto_Parry.Parry(Parry_Type)
    if tick() - lastParryTime < parryCooldown then 
        return false 
    end

     local ball_properties = AutoParry.ball.properties
        
    lastParryTime = tick()

    local presses = getgenv().speeddo and isSpam or 1

	local hasRemotes = false

     if not FirstParryDone then
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.015)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        getgenv().FirstParryDone = true
        FirstParryDone = true
        Notification.new("success", "Parry", "Parry Pressed!", true, 2)
        return
	else	
        local Parry_Data = Auto_Parry.Parry_Data(Parry_Type)
        for remote, originalArgs in pairs(ParryRemotes) do
        local modifiedArgs = {originalArgs[1], originalArgs[2], 0, Parry_Data[2], Parry_Data[3], Parry_Data[4]}
        if remote:IsA("RemoteEvent") then
            remote:FireServer(unpack(modifiedArgs))
        elseif remote:IsA("RemoteFunction") then
            remote:InvokeServer(unpack(modifiedArgs))
                 end
             end   
	end

    if Parries > 7 then
        return false
    end

    Parries += 1

    ball_properties.parries += 1

    task.delay(0.35, function()
        if Parries > 0 then
            Parries -= 1
        end
    end)
     task.delay(0.35, function()
        if ball_properties.parries > 0 then
            ball_properties.parries -= 1
            AutoParry.ball.properties.parries = ball_properties.parries
        end
    end)
end

local Lerp_Radians = 0
local Last_Warping = tick()

function Auto_Parry.Linear_Interpolation(a, b, time_volume)
    return a + (b - a) * time_volume
end

local Previous_Velocity = {}
local Curving = tick()

local Runtime = workspace.Runtime

function Auto_Parry.Is_Curved()
    local Ball = Auto_Parry.Get_Ball()

    if not Ball then
        return false
    end

    local Zoomies = Ball:FindFirstChild('zoomies')
    if not Zoomies then
        return false
    end

    local Ping = game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()
    local Velocity = Zoomies.VectorVelocity
    local Ball_Direction = Velocity.Unit

    local playerPos = LocalPlayer.Character.PrimaryPart.Position
    local ballPos = Ball.Position
    local Direction = (playerPos - ballPos).Unit
    local Dot = Direction:Dot(Ball_Direction)
    local Speed = Velocity.Magnitude

    local Speed_Threshold = math.min(Speed/100, 40)
    local Angle_Threshold = 40 * math.max(Dot, 0)
    local Distance = (playerPos - ballPos).Magnitude
    local Reach_Time = Distance / Speed - (Ping / 1000)
    
    local Ball_Distance_Threshold = 15 - math.min(Distance/1000, 15) + Speed_Threshold

    table.insert(Previous_Velocity, Velocity)
    if #Previous_Velocity > 4 then
        table.remove(Previous_Velocity, 1)
    end

    if Ball:FindFirstChild('AeroDynamicSlashVFX') then
        Debris:AddItem(Ball.AeroDynamicSlashVFX, 0)
        Tornado_Time = tick()
    end

    if Runtime:FindFirstChild('Tornado') then
        if (tick() - Tornado_Time) < ((Runtime.Tornado:GetAttribute("TornadoTime") or 1) + 0.314159) then
            return true
        end
    end

local Enough_Speed = Speed > 160
if Enough_Speed and Reach_Time > (Ping / 10 + 0.03) then
    if Speed < 300 then
        Ball_Distance_Threshold = math.max(Ball_Distance_Threshold - 15, 15)
    elseif Speed <= 600 then
        Ball_Distance_Threshold = math.max(Ball_Distance_Threshold - 17, 17)
    elseif Speed <= 1000 then
        Ball_Distance_Threshold = math.max(Ball_Distance_Threshold - 19, 19)
    else
        Ball_Distance_Threshold = math.max(Ball_Distance_Threshold - 20, 20)
    end
end

if Distance < Ball_Distance_Threshold then
    return false
end

local adjustedReachTime = Reach_Time + 0.03 -- compensação real de ping

if Speed < 300 then
    if (tick() - Curving) < (adjustedReachTime / 1.2) then return true end
elseif Speed < 450 then
    if (tick() - Curving) < (adjustedReachTime / 1.21) then return true end
elseif Speed < 600 then
    if (tick() - Curving) < (adjustedReachTime / 1.335) then return true end
else
    if (tick() - Curving) < (adjustedReachTime / 1.5) then return true end
end

local Dot_Threshold = (0 - Ping / 1000)
local Direction_Difference = (Ball_Direction - Velocity.Unit)
local Direction_Similarity = Direction:Dot(Direction_Difference.Unit)
local Dot_Difference = Dot - Direction_Similarity

if Dot_Difference < Dot_Threshold then
    return true
end

local Clamped_Dot = math.clamp(Dot, -1, 1)
local Radians = math.deg(math.asin(Clamped_Dot))
Lerp_Radians = Auto_Parry.Linear_Interpolation(Lerp_Radians, Radians, 0.8)

if Speed < 300 then
    if Lerp_Radians < 0.02 then
        Last_Warping = tick()
    end
    if (tick() - Last_Warping) < (adjustedReachTime / 1.19) then
        return true
    end
else
    if Lerp_Radians < 0.018 then
        Last_Warping = tick()
    end
    if (tick() - Last_Warping) < (adjustedReachTime / 1.5) then
        return true
    end
end

if #Previous_Velocity == 4 then
    for i = 1, 2 do
        local prevDir = (Ball_Direction - Previous_Velocity[i].Unit).Unit
        local prevDot = Direction:Dot(prevDir)
        if (Dot - prevDot) < Dot_Threshold then
            return true
        end
    end
end

local backwardsCurveDetected = false
local backwardsAngleThreshold = 60
local horizDirection = Vector3.new(playerPos.X - ballPos.X, 0, playerPos.Z - ballPos.Z)

if horizDirection.Magnitude > 0 then
    horizDirection = horizDirection.Unit
end

local awayFromPlayer = -horizDirection
local horizBallDir = Vector3.new(Ball_Direction.X, 0, Ball_Direction.Z)

if horizBallDir.Magnitude > 0 then
    horizBallDir = horizBallDir.Unit
    local backwardsAngle = math.deg(math.acos(math.clamp(awayFromPlayer:Dot(horizBallDir), -1, 1)))
    if backwardsAngle < backwardsAngleThreshold then
        backwardsCurveDetected = true
    end
end

return (Dot < Dot_Threshold) or backwardsCurveDetected
end


function Auto_Parry:Get_Ball_Properties()
    local Ball = Auto_Parry.Get_Ball()

    local Ball_Velocity = Vector3.zero
    local Ball_Origin = Ball

    local Ball_Direction = (LocalPlayer.Character.PrimaryPart.Position - Ball_Origin.Position).Unit
    local Ball_Distance = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Magnitude
    local Ball_Dot = Ball_Direction:Dot(Ball_Velocity.Unit)

    return {
        Velocity = Ball_Velocity,
        Direction = Ball_Direction,
        Distance = Ball_Distance,
        Dot = Ball_Dot
    }
end

local Connections_Manager = {}
local Selected_Parry_Type = nil

local Parried = false
local Last_Parry = 0


local deathshit = false

ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(c, d)
    if d then
        deathshit = true
    else
        deathshit = false
    end
end)

local Infinity = false

ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(a, b)
    if b then
        Infinity = true
    else
        Infinity = false
    end
end)


local timehole = false

ReplicatedStorage.Remotes.TimeHoleHoldBall.OnClientEvent:Connect(function(e, f)
    if f then
        timehole = true
    else
        timehole = false
    end
end)


function Auto_Parry.Spam_Service(self)
    local Ball = Auto_Parry.Get_Ball()

    local Entity = Auto_Parry.Closest_Player()

    if not Ball then
        return false
    end

    if not Entity or not Entity.PrimaryPart then
        return false
    end


    local Spam_Accuracy = 0

    local Velocity = Ball.AssemblyLinearVelocity
local Speed = Velocity.Magnitude

local Direction = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Unit
local Dot = Direction:Dot(Velocity.Unit)

local Target_Position = Entity.PrimaryPart.Position
local Target_Distance = LocalPlayer:DistanceFromCharacter(Target_Position)

local Movement_Factor = 1
local MoveDir = LocalPlayer.Character.Humanoid.MoveDirection
local TargetDir = (Target_Position - LocalPlayer.Character.PrimaryPart.Position).Unit
local TargetMoveDir = Entity.Humanoid.MoveDirection

_G.Last_Close_Contact = _G.Last_Close_Contact or 0
_G.In_Close_Contact = _G.In_Close_Contact or false

local now = tick()

if Target_Distance <= 3 then
    _G.In_Close_Contact = true
end

if _G.In_Close_Contact and Target_Distance > 3.3 then
    _G.In_Close_Contact = false
    _G.Last_Close_Contact = now
end

local can_use_div10 = (not _G.In_Close_Contact) and ((now - _G.Last_Close_Contact) >= 1.5)

if can_use_div10 and MoveDir.Magnitude > 0.2 and MoveDir:Dot(TargetDir) < -0.4 then
    Movement_Factor = 10
end

if can_use_div10 and TargetMoveDir.Magnitude > 0.2 and TargetMoveDir:Dot(-TargetDir) < -0.4 then
    Movement_Factor = 10
end

local Maximum_Spam_Distance = self.Ping * 0.7 + math.min(Speed / (Movement_Factor * 1.2), 80)

if self.Entity_Properties.Distance > Maximum_Spam_Distance then
    return Spam_Accuracy
end

if self.Ball_Properties.Distance > Maximum_Spam_Distance then
    return Spam_Accuracy
end

if Target_Distance > Maximum_Spam_Distance then
    return Spam_Accuracy
end

local Dot_Reduction = math.clamp(-Dot, 0, 1) 
local Dot_Impact = math.clamp(Dot_Reduction * (Speed / 40), 0, 4)

Spam_Accuracy = Maximum_Spam_Distance - Dot_Impact

return Spam_Accuracy
end


ConnectionsManager['Auto Parry'] = RunService.PreSimulation:Connect(function()
    print("Auto Parry loop running...")
    if not Configs.auto_parry then
        return
    end

    local One_Ball = Auto_Parry.Get_Ball()
    local Balls = Auto_Parry.Get_Balls()
   print("Ball count:", #Balls)
   if #Balls == 0 then
      print("No real balls found!")
   end
    for _, Ball in pairs(Balls) do
        if not Ball then
            return
        end

        local ball_properties = AutoParry.ball.properties        

        local Zoomies = Ball:FindFirstChild('zoomies')
        if not Zoomies then
            return
        end

        Ball:GetAttributeChangedSignal('target'):Once(function()
            Parried = false
        end)

        if Parried then
            return
        end

        local Ball_Target = Ball:GetAttribute('target')
        local One_Target = One_Ball:GetAttribute('target')     
        local Ping = Player.Entity.properties.ping
        local Ping_Threshold = math.clamp(Ping / 10, 10, 18)
        local player_properties = Player.Entity.properties        
		local Velocity = Ball.AssemblyLinearVelocity
local Speed = Velocity.Magnitude
        

        local parry_accuracity = (Ping_Threshold + Speed) * 1.55 / 11.4 + Ping_Threshold
        local effectiveMultiplier = 1
        if getgenv().RandomParryAccuracyEnabled then
            if  Speed < 200 then
                effectiveMultiplier = 0.8 + (math.random(40, 100) - 1) * (0.35 / 99)
            else
                effectiveMultiplier = 0.7 + (math.random(1, 100) - 1) * (0.35 / 99)
            end
        end
        parry_accuracity = parry_accuracity * effectiveMultiplier

        if player_properties.is_moving then
            parry_accuracity = parry_accuracity * 1.1
        end

        if player_properties.is_moving_backwards then
            parry_accuracity = parry_accuracity * (1 / 1.05)
        end

        if Player.Entity.properties.ping >= 270 then
            parry_accuracity = parry_accuracity * (1 + (Player.Entity.properties.ping / 500))
        end        
        
        ball_properties.parry_range = (Ping_Threshold + Speed) * 2.5 / 3 + Ping_Threshold
        ball_properties.spam_range = (Ping_Threshold + Speed) * 1.26 / 3.14     

        if Player.Entity.properties.sword == 'Titan Blade' then
            ball_properties.parry_range = ball_properties.parry_range + 11
            ball_properties.spam_range += 2
        end

        AutoParry.target.current_changed = AutoParry.target.current_changed or false
    AutoParry.target.direction_changed_on_cframe = AutoParry.target.direction_changed_on_cframe or false

    if AutoParry.target.current ~= AutoParry.target.previous then
        AutoParry.target.current_changed = true
        AutoParry.target.previous = AutoParry.target.current
    else
        AutoParry.target.current_changed = false
    end

    if AutoParry.target.current then
        local current_cframe = AutoParry.target.current.PrimaryPart and AutoParry.target.current.PrimaryPart.CFrame or CFrame.new()
        if not AutoParry.target.last_cframe then
            AutoParry.target.last_cframe = current_cframe
        end
        local current_direction = current_cframe.LookVector
        local last_direction = AutoParry.target.last_cframe.LookVector
        AutoParry.target.direction_changed_on_cframe = (current_direction - last_direction).Magnitude > 0.1
        AutoParry.target.last_cframe = current_cframe
    else
        AutoParry.target.direction_changed_on_cframe = false
    end                          

        local Curved = Auto_Parry.Is_Curved()

        if Ball:FindFirstChild('AeroDynamicSlashVFX') then
            Debris:AddItem(Ball.AeroDynamicSlashVFX, 0)
            Tornado_Time = tick()
        end

        if Runtime:FindFirstChild('Tornado') then
            if (tick() - Tornado_Time) < (Runtime.Tornado:GetAttribute("TornadoTime") or 1) + 0.314159 then
                return
            end
        end

       local distance_to_last_position = LocalPlayer:DistanceFromCharacter(ball_properties.last_position)
         

        if One_Target == tostring(LocalPlayer) and Curved then
            return
        end

        if Ball:FindFirstChild("ComboCounter") then
            return
        end

        local Singularity_Cape = LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape')
        if Singularity_Cape then
            return
        end

        if getgenv().InfinityDetection and Infinity then
            return
        end

        if getgenv().DeathSlashDetection and deathshit then
            return
        end

        if getgenv().TimeHoleDetection and timehole then
            return
        end

			print("Auto Parry running...")
print("Ball found:", Auto_Parry.Get_Ball() ~= nil)
print("Target is me:", Ball:GetAttribute('target') == LocalPlayer.Name)
print("Distance:", ball_properties.distance)
print("Parry range:", ball_properties.parry_range)

        if Ball_Target == tostring(LocalPlayer) and ball_properties.distance < ball_properties.parry_range then
            if getgenv().AutoAbility and AutoAbility() then
                return
            end
        end

        if Ball_Target == tostring(LocalPlayer) and ball_properties.distance < ball_properties.parry_range and ball_properties.distance < parry_accuracity then
            if getgenv().CooldownProtection and cooldownProtection() then
                return
            end

            local Parry_Time = os.clock()
            local Time_View = Parry_Time - (Last_Parry)
            if Time_View > 0.5 then
                Auto_Parry.Parry_Animation()
            end

            if getgenv().AutoParryKeypress then
                VirtualInputService:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
            else
                Auto_Parry.Parry(Selected_Parry_Type)
			    print("PARRY!")
            end

            Last_Parry = Parry_Time
            Parried = true
        end

        local Last_Parrys = tick()

                             repeat
                            RunService.PreSimulation:Wait()
                        until (tick() - Last_Parrys) >= 1 or not Parried
                        Parried = false
                    end
                end)

local Balls = workspace:WaitForChild('Balls')
local CurrentBall = nil
local InputTask = nil
local Cooldown = 0
local RunTime = workspace:FindFirstChild("Runtime")



local function GetBall()
    for _, Ball in ipairs(Balls:GetChildren()) do
        if Ball:FindFirstChild("ff") then
            return Ball
        end
    end
    return nil
end

local function SpamInput(Label)
    if InputTask then return end
    InputTask = task.spawn(function()
        while AutoParry do
            Auto_Parry.Parry(Selected_Parry_Type)
            task.wait(Cooldown)
        end
        InputTask = nil
    end)
end

Balls.ChildAdded:Connect(function(Value)
    Value.ChildAdded:Connect(function(Child)
        if getgenv().SlashOfFuryDetection and Child.Name == 'ComboCounter' then
            local Sof_Label = Child:FindFirstChildOfClass('TextLabel')

            if Sof_Label then
                repeat
                    local Slashes_Counter = tonumber(Sof_Label.Text)

                    if Slashes_Counter and Slashes_Counter < 32 then
                        Auto_Parry.Parry(Selected_Parry_Type)
                    end

                    task.wait()

                until not Sof_Label.Parent or not Sof_Label
            end
        end
    end)
end)


local player10239123 = Players.LocalPlayer
local RunService = game:GetService("RunService")

if not player10239123 then return end

RunTime.ChildAdded:Connect(function(Object)
    local Name = Object.Name
    if getgenv().PhantomV2Detection then
        if Name == "maxTransmission" or Name == "transmissionpart" then
            local Weld = Object:FindFirstChildWhichIsA("WeldConstraint")
            if Weld then
                local Character = player10239123.Character or player10239123.CharacterAdded:Wait()
                if Character and Weld.Part1 == Character.HumanoidRootPart then
                    CurrentBall = GetBall()
                    Weld:Destroy()
    
                    if CurrentBall then
                        local FocusConnection
                        FocusConnection = RunService.RenderStepped:Connect(function()
                            local Highlighted = CurrentBall:GetAttribute("highlighted")
    
                            if Highlighted == true then
                                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 36
    
                                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                                if HumanoidRootPart then
                                    local PlayerPosition = HumanoidRootPart.Position
                                    local BallPosition = CurrentBall.Position
                                    local PlayerToBall = (BallPosition - PlayerPosition).Unit
    
                                    game.Players.LocalPlayer.Character.Humanoid:Move(PlayerToBall, false)
                                end
    
                            elseif Highlighted == false then
                                FocusConnection:Disconnect()
    
                                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 10
                                game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 0), false)
    
                                task.delay(3, function()
                                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 36
                                end)
    
                                CurrentBall = nil
                            end
                        end)
    
                        task.delay(3, function()
                            if FocusConnection and FocusConnection.Connected then
                                FocusConnection:Disconnect()
    
                                game.Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 0), false)
                                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 36
                                CurrentBall = nil
                            end
                        end)
                    end
                end
            end
        end
    end
end)

local function setupVisualRing()       
    -- Ring untuk Spam Range
    local spamRing = Instance.new("Part")
    spamRing.Anchored = true
    spamRing.CanCollide = false
    spamRing.Transparency = 0.2
    spamRing.CastShadow = false
    spamRing.Size = Vector3.new(2, 2, 2) -- Ukuran dasar sesuai kode terbaru
    spamRing.Parent = Workspace

    local spamRingMesh = Instance.new("SpecialMesh", spamRing)
    spamRingMesh.MeshId = "rbxassetid://79874370541467"
    spamRingMesh.TextureId = ""
    spamRingMesh.Scale = Vector3.new(1, 1, 1)

    
    local parryRing = Instance.new("Part")
    parryRing.Anchored = true
    parryRing.CanCollide = false
    parryRing.Transparency = 0.3
    parryRing.CastShadow = false
    parryRing.Size = Vector3.new(2, 2, 2)
    parryRing.Parent = Workspace

    local parryRingMesh = Instance.new("SpecialMesh", parryRing)
    parryRingMesh.MeshId = "rbxassetid://105747096053609" -- ID mesh dari kode terbaru
    parryRingMesh.TextureId = ""
    parryRingMesh.Scale = Vector3.new(1, 1, 1)

    local function getCharacter()
        return LocalPlayer.Character or nil
    end

    local function getPrimaryPart()
        local char = getCharacter()
        return char and char:FindFirstChild("HumanoidRootPart") or nil
    end

    local function getActiveBall()
        local ballCont = Workspace:FindFirstChild("Balls")
        if not ballCont then 
            return nil 
        end
        for _, b in ipairs(ballCont:GetChildren()) do
            if not b.Anchored and b:IsA("BasePart") then 
                return b 
            end
        end
        return nil
    end

    ConnectionsManager['visual_ring'] = RunService.RenderStepped:Connect(function()
        if not Configs.visual_ring then
            spamRingMesh.Scale = Vector3.new(0, 0, 0)
            parryRingMesh.Scale = Vector3.new(0, 0, 0)
            spamRing.Transparency = 1
            parryRing.Transparency = 1
            return
        end

        local prim = getPrimaryPart()
        local ball = getActiveBall()
        
        if prim and ball and AutoParry and AutoParry.ball and AutoParry.ball.properties then
            local spamRange = AutoParry.ball.properties.spam_range or 10 
            local parryRange = AutoParry.ball.properties.parry_range or 10

            -- Spam Ring
            spamRingMesh.Scale = Vector3.new(spamRange, spamRange, spamRange) * 0.1
            local direction = ball.Velocity.Unit
            local lookAtPos = prim.Position + direction * 5
            spamRing.CFrame = CFrame.new(prim.Position + Vector3.new(0, 0.5, 0), lookAtPos) -- Offset kecil ke atas
            spamRing.Transparency = 0.2
            if AutoParry.ball.properties.auto_spam then
                spamRing.Color = Color3.new(1, 0, 0) -- Merah untuk auto_spam
                spamRingMesh.Scale = Vector3.new(30, 30, 30) * 8
            elseif not (AutoParry.target.current and AutoParry.target.current ~= LocalPlayer.Character) then
                spamRing.Color = Color3.new(0, 1, 0) -- Hijau untuk kondisi normal
            elseif AutoParry.ball.properties.distance < AutoParry.ball.properties.parry_range then
                spamRing.Color = Color3.new(0, 0, 0) -- Hitam jika jarak < parry_range
            else
                spamRing.Color = Color3.new(1, 1, 1) -- Putih untuk kondisi lain
            end

            -- Parry Ring
            parryRingMesh.Scale = Vector3.new(parryRange, parryRange, parryRange) * 0.2 
            parryRing.CFrame = CFrame.new(prim.Position + Vector3.new(0, -0.5, 0), lookAtPos) -- Offset kecil ke bawah
            parryRing.Transparency = 0.3
            parryRing.Color = Color3.new(0, 1, 0) -- Hijau untuk parry range
            if AutoParry.ball.properties.auto_spam then
                parryRing.Color = Color3.new(1, 0, 0) -- Merah untuk auto_spam
                parryRingMesh.Scale = Vector3.new(30, 30, 30) * 5
            end
        else
            spamRingMesh.Scale = Vector3.new(0, 0, 0)
            parryRingMesh.Scale = Vector3.new(0, 0, 0)
            spamRing.Transparency = 1
            parryRing.Transparency = 1
        end
    end)

    local function cleanup()
        if spamRing and spamRing.Parent then
            spamRing:Destroy()
            spamRing = nil
        end
        if parryRing and parryRing.Parent then
            parryRing:Destroy()
            parryRing = nil
        end
        if ConnectionsManager['visual_ring'] then
            ConnectionsManager['visual_ring']:Disconnect()
            ConnectionsManager['visual_ring'] = nil
        end
    end

    local originalAbadone = ConnectionsManager.abadone
    ConnectionsManager.abadone = function()
        originalAbadone()
        cleanup()
    end
end

setupVisualRing()

local function setupPlushie()
    local plushie_temp = Instance.new("Folder")
    plushie_temp.Name = "PlushieTemp"
    plushie_temp.Parent = Workspace

    
    local plushie_data = {
        Miku = { 
            MeshId = "rbxassetid://7749007933", 
            TextureId = "rbxassetid://7749008046", 
            Scale = Vector3.new(0.2, 0.2, 0.2), -- Lebih kecil lagi
            Angles = CFrame.Angles(0, 0, 0) -- Menghadap ke depan
        },
        SpongeBob = { 
            MeshId = "rbxassetid://5343759781", 
            TextureId = "rbxassetid://5343759854", 
            Scale = Vector3.new(0.8, 0.8, 0.8), -- Tetap
            Angles = CFrame.Angles(0, 0, 0) -- Menghadap ke depan
        },
        Patrick = { 
            MeshId = "rbxassetid://5730253467", 
            TextureId = "rbxassetid://5730253510", 
            Scale = Vector3.new(0.4, 0.4, 0.4), -- Lebih kecil lagi
            Angles = CFrame.Angles(0, 0, 0) -- Menghadap ke depan
        },
        Sonic = { 
            MeshId = "rbxassetid://5458555841", 
            TextureId = "rbxassetid://5458555873", 
            Scale = Vector3.new(1, 1, 1), -- Tidak diubah
            Angles = CFrame.Angles(0, math.rad(90), 0) -- Tetap
        },
        Shion = { 
            MeshId = "rbxassetid://5701509472", 
            TextureId = "rbxassetid://5701509496", 
            Scale = Vector3.new(2, 2, 2), -- Lebih besar lagi
            Angles = CFrame.Angles(0, 0, 0) -- Menghadap ke depan
        },
        Kaito = { 
            MeshId = "rbxassetid://7749025144", 
            TextureId = "rbxassetid://7749025177", 
            Scale = Vector3.new(0.2, 0.2, 0.2), -- Standar, bisa disesuaikan
            Angles = CFrame.Angles(0, 0, 0) -- Menghadap ke depan
        },
        Reimu = { 
            MeshId = "rbxassetid://12189551557", 
            TextureId = "rbxassetid://12189551941", 
            Scale = Vector3.new(0.6, 0.6, 0.6), -- Standar, bisa disesuaikan
            Angles = CFrame.Angles(0, 0, 0) -- Menghadap ke depan
        },
        Len = { 
            MeshId = "rbxassetid://7749022295", 
            TextureId = "rbxassetid://7749022336", 
            Scale = Vector3.new(0.2, 0.2, 0.2), -- Standar, bisa disesuaikan
            Angles = CFrame.Angles(0, 0, 0) -- Menghadap ke depan
        },
        Bear = { 
            MeshId = "rbxassetid://12218321", 
            TextureId = "rbxassetid://12218077", 
            Scale = Vector3.new(1, 1, 1), -- Standar, bisa disesuaikan
            Angles = CFrame.Angles(0, math.rad(90), 0) -- Menghadap ke depan
        },
        Frieren = { 
            MeshId = "rbxassetid://18730983304", 
            TextureId = "rbxassetid://18730984922", 
            Scale = Vector3.new(5, 5, 5), -- Standar, bisa disesuaikan
            Angles = CFrame.Angles(0, 0, 0) -- Menghadap ke depan
        }
    }

    
    local names_map = {
        Miku = "MikuPlushie",
        SpongeBob = "SpongeBobPlushie",
        Patrick = "PatrickPlushie",
        Sonic = "SonicPlushie",
        Shion = "ShionPlushie",
        Kaito = "KaitoPlushie",
        Reimu = "ReimuPlushie",
        Len = "LenPlushie",
        Bear = "BearPlushie",
        Frieren = "FrierenPlushie"
    }

    local function clear_all_plushies()
        if #plushie_temp:GetChildren() == 0 then
            return
        end
        for _, mesh in plushie_temp:GetChildren() do
            Debris:AddItem(mesh, 0)
        end
    end

    local function create_animation(part, tweenInfo, properties)
        local tween = TweenService:Create(part, tweenInfo, properties)
        tween:Play()
        return tween
    end

    local function getCharacter()
        return LocalPlayer.Character or nil
    end

    local function getPrimaryPart()
        local char = getCharacter()
        return char and char:FindFirstChild("HumanoidRootPart") or nil
    end

    ConnectionsManager['plushie'] = RunService.RenderStepped:Connect(function()
        if not Configs.plushie_enabled then
            clear_all_plushies()
            return
        end

        if not getCharacter() or not getPrimaryPart() then
            clear_all_plushies()
            return
        end

        local selected_plushie = Configs.plushie_type
        local protected_name = names_map[selected_plushie] or "DefaultPlushie"

        if plushie_temp:FindFirstChild(protected_name) then
            local plushie = plushie_temp[protected_name]
            local target_CFrame = getPrimaryPart().CFrame
                * CFrame.new(Vector3.new(-2 - math.cos(tick() / 2), 6.5 + math.cos(tick() / 2), -2 - math.sin(tick() / 2)))
                * (plushie_data[selected_plushie] and plushie_data[selected_plushie].Angles or CFrame.Angles(0, 0, 0))

            create_animation(plushie, TweenInfo.new(1.45), {
                CFrame = target_CFrame
            })
        else
            clear_all_plushies()

            if plushie_data[selected_plushie] then
                local plushie = Instance.new("Part")
                plushie.Anchored = true
                plushie.CanCollide = false
                plushie.Size = Vector3.new(2, 2, 2) -- Ukuran dasar
                plushie.Transparency = 0
                plushie.Name = protected_name
                plushie.Parent = plushie_temp

                local mesh = Instance.new("SpecialMesh", plushie)
                mesh.MeshId = plushie_data[selected_plushie].MeshId
                mesh.TextureId = plushie_data[selected_plushie].TextureId
                mesh.Scale = plushie_data[selected_plushie].Scale -- Skala khusus per boneka
            end
        end
    end)

    local function cleanup()
        clear_all_plushies()
        if plushie_temp and plushie_temp.Parent then
            plushie_temp:Destroy()
            plushie_temp = nil
        end
 
        if ConnectionsManager['plushie'] then
            ConnectionsManager['plushie']:Disconnect()
            ConnectionsManager['plushie'] = nil
        end
    end

    local originalAbadone = ConnectionsManager.abadone
    ConnectionsManager.abadone = function()
        originalAbadone()
        cleanup()
    end
end

setupPlushie() 

function play_kill_effect(Part)
    if not Part or not Part:IsA("BasePart") then
        warn("play_kill_effect: Invalid or missing Part")
        return
    end

    task.defer(function()
        local success, bell = pcall(function()
            return game:GetObjects("rbxassetid://17519762269")[1]
        end)        

        bell.Name = 'Yeat_BELL'
        bell.Parent = workspace

        -- Scale the bell
        local scaleFactor = Config.kill_effect_scale
        bell:ScaleTo(scaleFactor)

        -- Set initial position
        bell.Position = Part.Position + Vector3.new(0, 10, 0)

        -- Play sound if available
        local bellSound = bell:FindFirstChild("Sound")
        if bellSound then
            bellSound:Play()
        end

        local TweenService = game:GetService("TweenService")
        local animationType = Configs.kill_effect_animation

        -- Add particle emitter for dramatic effect
        local particle = Instance.new("ParticleEmitter")
        particle.Name = "KillEffectParticles"
        particle.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
        particle.Size = NumberSequence.new(0.5 * scaleFactor)
        particle.Rate = 20
        particle.Lifetime = NumberRange.new(0.5, 1)
        particle.Speed = NumberRange.new(5, 10)
        particle.SpreadAngle = Vector2.new(45, 45)
        particle.Texture = "rbxassetid://243660364" -- Sparkle particle
        particle.Parent = bell
        particle.Enabled = true
        Debris:AddItem(particle, 5)

        -- Animation based on type
        if animationType == "Spiral" then
            -- Spiral upward with rotation
            local tween1 = TweenService:Create(bell, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = Part.Position + Vector3.new(0, 20, 0),
                Orientation = Vector3.new(0, 360, 0)
            })
            local tween2 = TweenService:Create(bell, TweenInfo.new(1.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Position = Part.Position + Vector3.new(0, 50, 0),
                Orientation = Vector3.new(0, 720, 0)
            })
            tween1:Play()
            task.delay(1, function()
                tween2:Play()
            end)
        elseif animationType == "Pulse" then
            -- Pulsing scale and upward movement
            local tween1 = TweenService:Create(bell, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2, true), {
                CFrame = CFrame.new(Part.Position + Vector3.new(0, 15, 0)) * CFrame.Angles(0, math.rad(45), 0)
            })
            local tween2 = TweenService:Create(bell, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Size = Vector3.new(1, 1, 1) * scaleFactor * 1.5
            })
            local tween3 = TweenService:Create(bell, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = Part.Position + Vector3.new(0, 40, 0)
            })
            tween1:Play()
            tween2:Play()
            task.delay(0.5, function()
                tween3:Play()
            end)
        else -- Linear
            -- Smooth upward movement with slight rotation
            local tween1 = TweenService:Create(bell, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = Part.Position + Vector3.new(0, 20, 0),
                Orientation = Vector3.new(0, 90, 0)
            })
            local tween2 = TweenService:Create(bell, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = Part.Position + Vector3.new(0, 50, 0),
                Orientation = Vector3.new(0, 180, 0)
            })
            tween1:Play()
            task.delay(1, function()
                tween2:Play()
            end)
        end

        -- Color transition
        local primaryPart = bell:IsA("Model") and bell.PrimaryPart or bell
        if primaryPart then
            local tweenColor = TweenService:Create(primaryPart, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                BrickColor = BrickColor.new("Really red")
            })
            tweenColor:Play()
        end

        
        Debris:AddItem(bell, 6)
    end)
end

task.defer(function()
    ConnectionsManager['kill_effect'] = workspace.Alive.ChildRemoved:Connect(function(child)
        if not Configs.kill_effect then return end
        if not workspace.Dead:FindFirstChild(child.Name) then return end
        local hrp = child:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function()
                play_kill_effect(hrp)
            end)
        end
    end)
end)


local BallTrail = nil
local PlayerTrail = nil
local TrailConnection = nil
local lastTrailUpdateTime = 0

local function CreateTrail(parent, color, name)
    if not parent or not parent:IsA("BasePart") then
        warn("CreateTrail: Invalid or missing parent for " .. tostring(name))
        return nil
    end

    local trail = Instance.new("Trail")
    trail.Name = name

    -- Dynamic color gradient with more keypoints for vibrant effect
    trail.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color),
        ColorSequenceKeypoint.new(0.3, color:Lerp(Color3.fromRGB(255, 255, 255), 0.5)),
        ColorSequenceKeypoint.new(0.7, color:Lerp(Color3.fromRGB(255, 255, 0), 0.3)),
        ColorSequenceKeypoint.new(1, color:Lerp(Color3.new(0, 0, 0), 0.7))
    })

    -- Dynamic width with animation based on type
    local widthKeypoints = Configs.trail_animation_type == "Pulse" and {
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.5),
        NumberSequenceKeypoint.new(1, 0.2)
    } or Configs.trail_animation_type == "Flicker" and {
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(0.25, 0.4),
        NumberSequenceKeypoint.new(0.5, 0.8),
        NumberSequenceKeypoint.new(0.75, 0.4),
        NumberSequenceKeypoint.new(1, 0.2)
    } or {
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(1, 0.2)
    }
    trail.WidthScale = NumberSequence.new(widthKeypoints)

    -- Smooth transparency with animation
    local transparencyKeypoints = Configs.trail_animation_type == "Pulse" and {
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.4),
        NumberSequenceKeypoint.new(1, 0.9)
    } or Config.trail_animation_type == "Flicker" and {
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.25, 0.5),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.75, 0.5),
        NumberSequenceKeypoint.new(1, 0.9)
    } or {
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 0.8)
    }
    trail.Transparency = NumberSequence.new(transparencyKeypoints)

    -- Set texture if specified
    if Configs.trail_texture == "Spark" then
        trail.Texture = "rbxassetid://299531902" -- Spark texture
    elseif Configs.trail_texture == "Flame" then
        trail.Texture = "rbxassetid://243098098" -- Flame texture
    end
    trail.TextureLength = 2
    trail.Lifetime = Config.trail_animation_type == "Flicker" and 0.8 or 1.5
    trail.Enabled = true

    -- Create attachments
    local attachment0 = Instance.new("Attachment")
    attachment0.Name = name .. "Attachment0"
    attachment0.Parent = parent
    local attachment1 = Instance.new("Attachment")
    attachment1.Name = name .. "Attachment1"
    attachment1.Position = Vector3.new(0, -1.5, 0) -- Adjusted for visibility
    attachment1.Parent = parent

    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Parent = parent

    -- Add particle emitter if enabled
    if Configs.trail_particle_enabled then
        local particle = Instance.new("ParticleEmitter")
        particle.Name = name .. "Particles"
        particle.Color = ColorSequence.new(color)
        particle.Size = NumberSequence.new(0.2)
        particle.Rate = Configs.trail_particle_rate
        particle.Lifetime = NumberRange.new(0.5, 1)
        particle.Speed = NumberRange.new(2, 5)
        particle.SpreadAngle = Vector2.new(30, 30)
        particle.Texture = Configs.trail_texture == "Spark" and "rbxassetid://299531902" or Configs.trail_texture == "Flame" and "rbxassetid://243098098" or "rbxassetid://243660364" -- Default particle texture
        particle.Enabled = true
        particle.Parent = attachment0
        Debris:AddItem(particle, 5) -- Clean up particles after 5 seconds
    end

    return trail
end

-- Update ball trail with dynamic effects
local function UpdateBallTrail()
    if Configs.ball_trail_enabled then
        local ball = Auto_Parry.Get_Balls()
        if ball and ball:IsA("BasePart") and ball.Parent then
            if not BallTrail or BallTrail.Parent ~= ball then
                if BallTrail then
                    BallTrail:Destroy()
                    BallTrail = nil
                end
                BallTrail = CreateTrail(ball, Configs.ball_trail_color, "BallTrail")
            end
            if BallTrail then
                -- Dynamic color based on ball speed
                local velocity = ball.Velocity.Magnitude
                local speedFactor = math.clamp(velocity / 50, 0, 1)
                local dynamicColor = Config.ball_trail_color:Lerp(Color3.fromRGB(255, 255, 255), speedFactor)
                BallTrail.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, dynamicColor),
                    ColorSequenceKeypoint.new(0.3, dynamicColor:Lerp(Color3.fromRGB(255, 255, 0), 0.5)),
                    ColorSequenceKeypoint.new(0.7, dynamicColor:Lerp(Color3.fromRGB(255, 0, 0), 0.3)),
                    ColorSequenceKeypoint.new(1, dynamicColor:Lerp(Color3.new(0, 0, 0), 0.7))
                })
                BallTrail.Enabled = true
            end
        else
            if BallTrail then
                BallTrail:Destroy()
                BallTrail = nil
            end
        end
    else
        if BallTrail then
            BallTrail:Destroy()
            BallTrail = nil
        end
    end
end

local function UpdatePlayerTrail()
    if Configs.player_trail_enabled then
        local character = LocalPlayer.Character
        local hrp = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
        if hrp and hrp:IsA("BasePart") and hrp.Parent then
            if not PlayerTrail or PlayerTrail.Parent ~= hrp then
                if PlayerTrail then
                    PlayerTrail:Destroy()
                    PlayerTrail = nil
                end
                PlayerTrail = CreateTrail(hrp, Configs.player_trail_color, "PlayerTrail")
            end
            if PlayerTrail then              
                local timeFactor = math.sin(tick() * 2) * 0.5 + 0.5
                local dynamicColor = Config.player_trail_color:Lerp(Color3.fromRGB(255, 255, 255), timeFactor)
                PlayerTrail.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, dynamicColor),
                    ColorSequenceKeypoint.new(0.3, dynamicColor:Lerp(Color3.fromRGB(0, 255, 255), 0.5)),
                    ColorSequenceKeypoint.new(0.7, dynamicColor:Lerp(Color3.fromRGB(0, 0, 255), 0.3)),
                    ColorSequenceKeypoint.new(1, dynamicColor:Lerp(Color3.new(0, 0, 0), 0.7))
                })
                PlayerTrail.Enabled = true
            end
        else
            if PlayerTrail then
                PlayerTrail:Destroy()
                PlayerTrail = nil
            end
        end
    else
        if PlayerTrail then
            PlayerTrail:Destroy()
            PlayerTrail = nil
        end
    end
end

local function StartTrailUpdate()
    if TrailConnection then
        TrailConnection:Disconnect()
        TrailConnection = nil
    end
    TrailConnection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        if currentTime - lastTrailUpdateTime < 0.05 then return end -- Throttle updates to 20 FPS
        lastTrailUpdateTime = currentTime
        pcall(UpdateBallTrail)
        pcall(UpdatePlayerTrail)
    end)
end

local function StopTrailUpdate()
    if TrailConnection then
        TrailConnection:Disconnect()
        TrailConnection = nil
    end
    if BallTrail then
        BallTrail:Destroy()
        BallTrail = nil
    end
    if PlayerTrail then
        PlayerTrail:Destroy()
        PlayerTrail = nil
    end
end

if Configs.ball_trail_enabled or Configs.player_trail_enabled then
    task.spawn(StartTrailUpdate)
end


local player11 = game.Players.LocalPlayer
local PlayerGui = player11:WaitForChild("PlayerGui")
local playerGui = player11:WaitForChild("PlayerGui")
local Hotbar = PlayerGui:WaitForChild("Hotbar")


local ParryCD = playerGui.Hotbar.Block.UIGradient
local AbilityCD = playerGui.Hotbar.Ability.UIGradient

local function isCooldownInEffect1(uigradient)
    return uigradient.Offset.Y < 0.4
end

local function isCooldownInEffect2(uigradient)
    return uigradient.Offset.Y == 0.5
end

local function cooldownProtection()
    if isCooldownInEffect1(ParryCD) then
        game:GetService("ReplicatedStorage").Remotes.AbilityButtonPress:Fire()
        return true
    end
    return false
end

local function AutoAbility()
    if isCooldownInEffect2(AbilityCD) then
        if Player.Character.Abilities["Raging Deflection"].Enabled or Player.Character.Abilities["Rapture"].Enabled or Player.Character.Abilities["Calming Deflection"].Enabled or Player.Character.Abilities["Aerodynamic Slash"].Enabled or Player.Character.Abilities["Fracture"].Enabled or Player.Character.Abilities["Death Slash"].Enabled then
            Parried = true
            game:GetService("ReplicatedStorage").Remotes.AbilityButtonPress:Fire()
            task.wait(2.432)
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
            return true
        end
    end
    return false
end

do
    local module = rage:create_module({
        title = 'Auto Parry',
        flag = 'Auto_Parry',
        description = 'Automatically parries ball',
        section = 'left',
        callback = function(value: boolean)
            Configs.auto_parry = value  

            if getgenv().AutoParryNotify then
                Library.SendNotification({
                    title = "Module Notification",
                    text = "Auto Parry has been turned " .. (value and "ON" or "OFF"),
                    duration = 3
                })
            end
        end
    })

    local dropdown3 = module:create_dropdown({
        title = 'First Parry Type',
        flag = 'First_Parry_Type',

        options = {
            'F_Key',
            'Left_Click',
            'Navigation'
        },

        multi_dropdown = false,
        maximum_options = 3,
        callback = function(value)
            firstParryType = value
        end
    })

    local parryTypeMap = {
        ["Camera"] = "Camera",
        ["Slowball"] = "Slowball",
        ["Random"] = "Random",
        ["Backwards"] = "Backwards",
        ["Straight"] = "Straight",
        ["High"] = "High",
        ["Left"] = "Left",
        ["Right"] = "Right",
        ["Random Target"] = "RandomTarget"
    }

    local dropdown = module:create_dropdown({
        title = 'Parry Type',
        flag = 'Parry_Type',

        options = {
            'Camera',
            'Slowball',
            'Random',
            'Backwards',
            'Straight',
            'High',
            'Left',
            'Right',
            'Random Target'
        },

        multi_dropdown = false,
        maximum_options = 8,

        callback = function(value: string)
            Selected_Parry_Type = parryTypeMap[value] or value
        end
    })



    local UserInputService = game:GetService("UserInputService")

    local parryOptions = {
    [Enum.KeyCode.One] = "Camera",
    [Enum.KeyCode.Two] = "Random",
    [Enum.KeyCode.Three] = "Backwards",
    [Enum.KeyCode.Four] = "Straight",
    [Enum.KeyCode.Five] = "High",
    [Enum.KeyCode.Six] = "Left",
    [Enum.KeyCode.Seven] = "Right",
    [Enum.KeyCode.Eight] = "Random Target",
    [Enum.KeyCode.Nine] = "Slowball"
}

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then 
            return 
        end

        if not getgenv().HotkeyParryType then
            return
        end

        local newType = parryOptions[input.KeyCode]
        if newType then
            Selected_Parry_Type = parryTypeMap[newType] or newType
            dropdown:update(newType)
            if getgenv().HotkeyParryTypeNotify then
                Library.SendNotification({
                    title = "Module Notification",
                    text = "Parry Type changed to " .. newType,
                    duration = 3
                })
            end
        end
    end)

    module:create_slider({
        title = 'Parry Accuracy',
        flag = 'Parry_Accuracy',

        maximum_value = 100,
        minimum_value = 1,
        value = 100,

        round_number = true,

        callback = function(value: boolean)
            Speed_Divisor_Multiplier = 0.7 + (value - 1) * (0.35 / 99)
        end
    })

    module:create_divider({
    })

    module:create_checkbox({
        title = "Randomized Parry Accuracy",
        flag = "Random_Parry_Accuracy",
        callback = function(value: boolean)
            getgenv().RandomParryAccuracyEnabled = value
            if value then
                getgenv().RandomParryAccuracyEnabled = value
            end
        end
    })

    module:create_checkbox({
        title = "Infinity Detection",
        flag = "Infinity_Detection",
        callback = function(value: boolean)
            if value then
                getgenv().InfinityDetection = value
            end
        end
    })

    module:create_checkbox({
        title = "Death Slash Detection",
        flag = "DeathSlash_Detection",
        callback = function(value: boolean)
            getgenv().DeathSlashDetection = value
        end
    })

    module:create_checkbox({
        title = "Time Hole Detection",
        flag = "TimeHole_Detection",
        callback = function(value: boolean)
            getgenv().TimeHoleDetection = value
        end
    })

    module:create_checkbox({
        title = "Slash Of Fury Detection",
        flag = "SlashOfFuryDetection",
        callback = function(value: boolean)
            getgenv().SlashOfFuryDetection = value
        end
    })

    module:create_checkbox({
        title = "Anti Phantom",
        flag = "Anti_Phantom",
        callback = function(value: boolean)
            getgenv().PhantomV2Detection = value
        end
    })

    module:create_checkbox({
        title = "Cooldown Protection",
        flag = "CooldownProtection",
        callback = function(value: boolean)
            getgenv().CooldownProtection = value
        end
    })

    module:create_checkbox({
        title = "Auto Ability",
        flag = "AutoAbility",
        callback = function(value: boolean)
            getgenv().AutoAbility = value
        end
    })

    module:create_checkbox({
        title = "Keypress",
        flag = "Auto_Parry_Keypress",
        callback = function(value: boolean)
            getgenv().AutoParryKeypress = value
        end
    })


    module:create_checkbox({
        title = "Notify",
        flag = "Auto_Parry_Notify",
        callback = function(value: boolean)
            getgenv().AutoParryNotify = value
        end
    })
end

do
local SpamParry = rage:create_module({
    title = 'Auto Spam Parry',
    flag = 'Auto_Spam_Parry',
    description = 'Automatically spam parries ball',
    section = 'right',
    callback = function(value: boolean)
        if getgenv().AutoSpamNotify then
            Library.SendNotification({
                title = "Module Notification",
                text = "Auto Spam Parry turned " .. (value and "ON" or "OFF"),
                duration = 3
            })
        end

        if value then
            Connections_Manager['Auto Spam'] = RunService.PreSimulation:Connect(function()
                local Ball = Auto_Parry.Get_Ball()
                if not Ball then return end

                local Zoomies = Ball:FindFirstChild('zoomies')
                if not Zoomies then return end

                Auto_Parry.Closest_Player()

                local Ping = Player.Entity.properties.ping
                local Ping_Threshold = math.clamp(Ping / 10, 10, 18)

                local Ball_Target = Ball:GetAttribute('target')
                if not Ball_Target then return end

                local Ball_Properties = Auto_Parry:Get_Ball_Properties()
                local Entity_Properties = Auto_Parry:Get_Entity_Properties()

                
                local Spam_Accuracy = Auto_Parry.Spam_Service({
                    Ball_Properties = Ball_Properties,
                    Entity_Properties = Entity_Properties,
                    Ping = Ping_Threshold
                })

                if Spam_Accuracy <= 0 then
                    return
                end

                local Target_Position = Closest_Entity.PrimaryPart.Position
                local Target_Distance = LocalPlayer:DistanceFromCharacter(Target_Position)
                local Distance = LocalPlayer:DistanceFromCharacter(Ball.Position)

                if Target_Distance > Spam_Accuracy or Distance > Spam_Accuracy then
                    return
                end

                if LocalPlayer.Character:GetAttribute('Pulsed') then
                    return
                end
                if Ball_Target == tostring(LocalPlayer) and Target_Distance > 25 and Distance > 30 then
                    return
                end

                
                if Distance <= Spam_Accuracy and Parries > ParryThreshold then
                    if getgenv().SpamParryKeypress then
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                    else
                        Auto_Parry.Parry(Selected_Parry_Type)
                    end
                end
            end)
        else
            if Connections_Manager['Auto Spam'] then
                Connections_Manager['Auto Spam']:Disconnect()
                Connections_Manager['Auto Spam'] = nil
            end
        end
    end
})

    local dropdown2 = SpamParry:create_dropdown({
        title = 'Parry Type',
        flag = 'Spam_Parry_Type',

        options = {
            'Legit',
            'Blatant'
        },

        multi_dropdown = false,
        maximum_options = 2,

        callback = function(value: string)
        end
    })

    SpamParry:create_slider({
        title = "Parry Threshold",
        flag = "Parry_Threshold",
        maximum_value = 3,
        minimum_value = 1,
        value = 2.5,
        round_number = false,
        callback = function(value: number)
            ParryThreshold = value
        end
    })

       
 
    SpamParry:create_slider({
        title = "Spam Speed",
        flag = "Spam_Speed",
        maximum_value = 5,
        minimum_value = 1,
        value = 2,
        round_number = false,
        callback = function(value: number)
            getgenv().speeddo = value
        end
    })
end


    
do
    local ManualSpam = rage:create_module({
        title = 'Manual Spam Parry',
        flag = 'Manual_Spam_Parry',
        description = 'Manually Spams Parry',
        section = 'right',
        callback = function(value: boolean)
            if getgenv().ManualSpamNotify then
                if value then
                    Library.SendNotification({
                        title = "Module Notification",
                        text = "Manual Spam Parry turned ON",
                        duration = 3
                    })
                else
                    Library.SendNotification({
                        title = "Module Notification",
                        text = "Manual Spam Parry turned OFF",
                        duration = 3
                    })
                end
            end
            if value then
                Connections_Manager['Manual Spam'] = RunService.PreSimulation:Connect(function()
                    if getgenv().spamui then
                        return
                    end

                    if getgenv().ManualSpamKeypress then
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game) 
                    else
                        Auto_Parry.Parry(Selected_Parry_Type)
                    end

                end)
            else
                if Connections_Manager['Manual Spam'] then
                    Connections_Manager['Manual Spam']:Disconnect()
                    Connections_Manager['Manual Spam'] = nil
                end
            end
        end
    })
    
    ManualSpam:change_state(false)

    if isMobile then
        ManualSpam:create_checkbox({
            title = "UI",
            flag = "Manual_Spam_UI",
            callback = function(value: boolean)
                getgenv().spamui = value
        
if value then
    local gui = Instance.new("ScreenGui")
    gui.Name = "ManualSpamUI"
    gui.ResetOnSpawn = false
    gui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Position = UDim2.new(0, 20, 0, 20)
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(90, 60, 180)
    frame.BackgroundTransparency = 0.25
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiCorner.Parent = frame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Color = Color3.fromRGB(190, 150, 255) -- borda lilás suave
    uiStroke.Transparency = 0.2 -- leve transparência na borda também
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Parent = frame

    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 60, 180)),  -- roxo médio
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 25))    -- quase preto
    }
    uiGradient.Rotation = 0
    uiGradient.Parent = frame

    local button = Instance.new("TextButton")
    button.Name = "ClashModeButton"
    button.Text = "Clash Mode"
    button.Size = UDim2.new(0, 160, 0, 40)
    button.Position = UDim2.new(0.5, -80, 0.5, -20)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamSemibold
    button.TextColor3 = Color3.fromRGB(235, 215, 255) -- lilás claro com ótimo contraste
    button.TextSize = 22
    button.Parent = frame


        
                    local activated = false
        
                    local function toggle()
                        activated = not activated
                        button.Text = activated and "Stop" or "Clash Mode"
                        if activated then
                            Connections_Manager['Manual Spam UI'] = game:GetService("RunService").Heartbeat:Connect(function()
                                Auto_Parry.Parry(Selected_Parry_Type)
                            end)
                        else
                            if Connections_Manager['Manual Spam UI'] then
                                Connections_Manager['Manual Spam UI']:Disconnect()
                                Connections_Manager['Manual Spam UI'] = nil
                            end
                        end
                    end
        
                    button.MouseButton1Click:Connect(toggle)
                else
                    if game.CoreGui:FindFirstChild("ManualSpamUI") then
                        game.CoreGui:FindFirstChild("ManualSpamUI"):Destroy()
                    end
        
                    if Connections_Manager['Manual Spam UI'] then
                        Connections_Manager['Manual Spam UI']:Disconnect()
                        Connections_Manager['Manual Spam UI'] = nil
                    end
                end
            end
        })
    end
    
    ManualSpam:create_checkbox({
        title = "Keypress",
        flag = "Manual_Spam_Keypress",
        callback = function(value: boolean)
            getgenv().ManualSpamKeypress = value
        end
    })
    
    ManualSpam:create_checkbox({
        title = "Notify",
        flag = "Manual_Spam_Parry_Notify",
        callback = function(value: boolean)
            getgenv().ManualSpamNotify = value
        end
    })
end

do
    local Triggerbot = rage:create_module({
        title = 'Triggerbot',
        flag = 'Triggerbot',
        description = 'Instantly hits ball when targeted',
        section = 'left',
        callback = function(value: boolean)
            if getgenv().TriggerbotNotify then
                if value then
                    Library.SendNotification({
                        title = "Module Notification",
                        text = "Triggerbot turned ON",
                        duration = 3
                    })
                else
                    Library.SendNotification({
                        title = "Module Notification",
                        text = "Triggerbot turned OFF",
                        duration = 3
                    })
                end
            end
            if value then
                Connections_Manager['Triggerbot'] = RunService.PreSimulation:Connect(function()
                    local Balls = Auto_Parry.Get_Balls()
        
                    for _, Ball in pairs(Balls) do
                        if not Ball then
                            return
                        end
                        
                        Ball:GetAttributeChangedSignal('target'):Once(function()
                            TriggerbotParried = false
                        end)
    
                        if TriggerbotParried then
                            return
                        end

                        local Ball_Target = Ball:GetAttribute('target')
                        local Singularity_Cape = LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape')
            
                        if Singularity_Cape then 
                            return
                        end 
                    
                        if getgenv().TriggerbotInfinityDetection and Infinity then
                            return
                        end
        
                        if Ball_Target == tostring(LocalPlayer) then
                            if getgenv().TriggerbotKeypress then
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game) 
                            else
                                Auto_Parry.Parry(Selected_Parry_Type)
                            end
                            TriggerbotParried = true
                        end
                        local Triggerbot_Last_Parrys = tick()
                        repeat
                            RunService.PreSimulation:Wait()
                        until (tick() - Triggerbot_Last_Parrys) >= 1 or not TriggerbotParried
                        TriggerbotParried = false
                    end
    
                end)
            else
                if Connections_Manager['Triggerbot'] then
                    Connections_Manager['Triggerbot']:Disconnect()
                    Connections_Manager['Triggerbot'] = nil
                end
            end
        end
    })

    Triggerbot:create_checkbox({
        title = "Infinity Detection",
        flag = "Infinity_Detection",
        callback = function(value: boolean)
            getgenv().TriggerbotInfinityDetection = value
        end
    })

    Triggerbot:create_checkbox({
        title = "Keypress",
        flag = "Triggerbot_Keypress",
        callback = function(value: boolean)
            getgenv().TriggerbotKeypress = value
        end
    })

    Triggerbot:create_checkbox({
        title = "Notify",
        flag = "TriggerbotNotify",
        callback = function(value: boolean)
            getgenv().TriggerbotNotify = value
        end
    })
end


    local parryTypeList = {
    "Camera", "Random", "Backwards", "Straight", "High", "Left", "Right", "Random Target", "Slowball"
}

local currentIndex = 1

do
local HotkeyParryType = rage:create_module({
    title = 'Hotkey Parry Type [PC]',
    flag = 'HotkeyParryType',
    description = 'Allows Hotkey Parry Type',
    section = 'left',
    callback = function(value: boolean)
        getgenv().HotkeyParryType = value
    end
})

HotkeyParryType:create_checkbox({
    title = "Notify",
    flag = "HotkeyParryTypeNotify",
    callback = function(value: boolean)
        getgenv().HotkeyParryTypeNotify = value
    end
})
end

do
local SetCurveModule = rage:create_module({
    title = 'Button select curve',
    flag = 'SetCurveModule',
    description = 'Enable UI to click and change parry type',
    section = 'left',
    callback = function(value: boolean)
        if value then
            local gui = Instance.new("ScreenGui")
            gui.Name = "SetCurveUI"
            gui.ResetOnSpawn = false
            gui.Parent = game.CoreGui

            local frame = Instance.new("Frame")
            frame.Name = "MainFrame"
            frame.Position = UDim2.new(0, 20, 0, 20)
            frame.Size = UDim2.new(0, 200, 0, 100)
            frame.BackgroundColor3 = Color3.fromRGB(90, 60, 180)
            frame.BackgroundTransparency = 0.25
            frame.BorderSizePixel = 0
            frame.Active = true
            frame.Draggable = true
            frame.Parent = gui

            local uiCorner = Instance.new("UICorner")
            uiCorner.CornerRadius = UDim.new(0, 12)
            uiCorner.Parent = frame

            local uiStroke = Instance.new("UIStroke")
            uiStroke.Thickness = 2
            uiStroke.Color = Color3.fromRGB(190, 150, 255)
            uiStroke.Transparency = 0.2
            uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            uiStroke.Parent = frame

            local uiGradient = Instance.new("UIGradient")
            uiGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 60, 180)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 25))
            }
            uiGradient.Rotation = 0
            uiGradient.Parent = frame

            local button = Instance.new("TextButton")
            button.Name = "SetCurveButton"
            button.Text = "Set Curve"
            button.Size = UDim2.new(0, 160, 0, 40)
            button.Position = UDim2.new(0.5, -80, 0.5, -20)
            button.BackgroundTransparency = 1
            button.BorderSizePixel = 0
            button.Font = Enum.Font.GothamSemibold
            button.TextColor3 = Color3.fromRGB(235, 215, 255)
            button.TextSize = 22
            button.Parent = frame

            button.MouseButton1Click:Connect(function()
                currentIndex += 1
                if currentIndex > #parryTypeList then currentIndex = 1 end

                local newType = parryTypeList[currentIndex]
                Selected_Parry_Type = parryTypeMap and parryTypeMap[newType] or newType

                if dropdown and dropdown.update then
                    dropdown:update(newType)
                end

                button.Text = newType

                if getgenv().HotkeyParryTypeNotify then
                    Library.SendNotification({
                        title = "Module Notification",
                        text = "Parry Type changed to " .. newType,
                        duration = 3
                    })
                end
            end)

        else
            local existing = game.CoreGui:FindFirstChild("SetCurveUI")
            if existing then
                existing:Destroy()
            end
        end
    end
})
end

do
    local LobbyAP = rage:create_module({
        title = 'Lobby AP',
        flag = 'Lobby_AP',
        description = 'Auto parries ball in lobby',
        section = 'right',
        callback = function(state)
            if getgenv().LobbyAPNotify then
                if state then
                    Library.SendNotification({
                        title = "Module Notification",
                        text = "Lobby AP has been turned ON",
                        duration = 3
                    })
                else
                    Library.SendNotification({
                        title = "Module Notification",
                        text = "Lobby AP has been turned OFF",
                        duration = 3
                    })
                end
            end
            if state then
                Connections_Manager['Lobby AP'] = RunService.Heartbeat:Connect(function()
                    local Ball = Auto_Parry.Lobby_Balls()
                    if not Ball then
                        return
                    end
    
                    local Zoomies = Ball:FindFirstChild('zoomies')
                    if not Zoomies then
                        return
                    end
    
                    Ball:GetAttributeChangedSignal('target'):Once(function()
                        Training_Parried = false
                    end)
    
                    if Training_Parried then
                        return
                    end
    
                    local Ball_Target = Ball:GetAttribute('target')
                    local Velocity = Zoomies.VectorVelocity
                    local Distance = LocalPlayer:DistanceFromCharacter(Ball.Position)
                    local Speed = Velocity.Magnitude
    
                    local Ping = game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue() / 10
                    local LobbyAPcappedSpeedDiff = math.min(math.max(Speed - 9.5, 0), 650)
                    local LobbyAPspeed_divisor_base = 2.4 + LobbyAPcappedSpeedDiff * 0.002
    
                    local LobbyAPeffectiveMultiplier = LobbyAP_Speed_Divisor_Multiplier
                    if getgenv().LobbyAPRandomParryAccuracyEnabled then
                        LobbyAPeffectiveMultiplier = 0.7 + (math.random(1, 100) - 1) * (0.35 / 99)
                    end
    
                    local LobbyAPspeed_divisor = LobbyAPspeed_divisor_base * LobbyAPeffectiveMultiplier
                    local LobbyAPParry_Accuracys = Ping + math.max(Speed / LobbyAPspeed_divisor, 9.5)
    
                    if Ball_Target == tostring(LocalPlayer) and Distance <= LobbyAPParry_Accuracys then
                            if getgenv().LobbyAPKeypress then
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game) 
                            else
                                Auto_Parry.Parry(Selected_Parry_Type)
                            end
                        Training_Parried = true
                    end
                    local Last_Parrys = tick()
                    repeat 
                        RunService.PreSimulation:Wait() 
                    until (tick() - Last_Parrys) >= 1 or not Training_Parried
                    Training_Parried = false
                end)
            else
                if Connections_Manager['Lobby AP'] then
                    Connections_Manager['Lobby AP']:Disconnect()
                    Connections_Manager['Lobby AP'] = nil
                end
            end
        end
    })

    LobbyAP:create_slider({
        title = 'Parry Accuracy',
        flag = 'Parry_Accuracy',
        maximum_value = 100,
        minimum_value = 1,
        value = 100,
        round_number = true,
        callback = function(value: number)
            LobbyAP_Speed_Divisor_Multiplier = 0.7 + (value - 1) * (0.35 / 99)
        end
    })

    LobbyAP:create_divider({
    })
    
    LobbyAP:create_checkbox({
        title = "Randomized Parry Accuracy",
        flag = "Random_Parry_Accuracy",
        callback = function(value: boolean)
            getgenv().LobbyAPRandomParryAccuracyEnabled = value
        end
    })

    LobbyAP:create_checkbox({
        title = "Keypress",
        flag = "Lobby_AP_Keypress",
        callback = function(value: boolean)
            getgenv().LobbyAPKeypress = value
        end
    })

    LobbyAP:create_checkbox({
        title = "Notify",
        flag = "Lobby_AP_Notify",
        callback = function(value: boolean)
            getgenv().LobbyAPNotify = value
        end
    })
end

    local plr = game.Players.LocalPlayer
    local cam = workspace.CurrentCamera
    local hit = game.ReplicatedStorage.Remotes.ParryAttempt
    
    getgenv().originalCameraSubject = nil
    
    function getspeed(ball)
        if ball then
            if ball:FindFirstChild("zoomies") and ball.zoomies.VectorVelocity then
                return ball.zoomies.VectorVelocity
            end
        else
            for _, b in pairs(workspace.Balls:GetChildren()) do
                if b:FindFirstChild("zoomies") and b.zoomies.VectorVelocity then
                    return b.zoomies.VectorVelocity
                end
            end
        end
        return Vector3.new(0,0,0)
    end
    
    function restoreCamera()
        local character = plr.Character
        if character and character:FindFirstChild("Humanoid") then
            cam.CameraSubject = character.Humanoid
        end
    end
    
do
    local BallTP = rage:create_module({
        title = "Ball TP",
        flag = "Ball_TP",
        description = "Teleports to the ball",
        section = "left",
        callback = function(value)
            getgenv().BallTPEnabled = value
            if value then
                if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    getgenv().originalCameraSubject = cam.CameraSubject
                end
                
                Connections_Manager['BallTP_Added'] = workspace.Balls.ChildAdded:Connect(function(v)
                    if v:IsA("BasePart") then
                        Connections_Manager['BallTP_Changed_' .. v.Name] = v.Changed:Connect(function(prop)
                            local c = plr.Character
                            if not c then return end
                            local hrp = c:FindFirstChild("HumanoidRootPart")
                            if not hrp then return end
    
                            local speed = getspeed(v)
                            if speed then
                                if math.abs(speed.X) > math.abs(speed.Z) then
                                    hrp.CFrame = v.CFrame + Vector3.new(0,5,10)
                                else
                                    hrp.CFrame = v.CFrame + Vector3.new(10,5,0)
                                end
                            end
    
                            cam.CameraSubject = v
    
                            if v:GetAttribute("target") == plr.Name then
                                while v:GetAttribute("target") == plr.Name and v and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 do
                                    local cnt = 0
                                    while v:GetAttribute("target") == plr.Name and cnt ~= 20 do
                                        cnt = cnt + 1
                                        task.wait()
                                    end
                                end
                                task.wait()
                            end
                        end)
                    end
                end)
            else
                for connName, conn in pairs(Connections_Manager) do
                    if string.find(connName, "BallTP") then
                        conn:Disconnect()
                        Connections_Manager[connName] = nil
                    end
                end
                
                restoreCamera()
            end
        end
    })
end

do
    local InstantBallTP = rage:create_module({
        title = "Instant Ball TP",
        flag = "Instant_Ball_TP",
        description = "Instantly teleports to the ball and back.",
        section = "right",
        callback = function(value)
            getgenv().InstantBallTPEnabled = value
            
            if value then
                if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    getgenv().originalCameraSubject = cam.CameraSubject
                end
                
                getgenv().originalCFrame = nil
                
                for _, ball in ipairs(workspace.Balls:GetChildren()) do
                    if ball:IsA("BasePart") then
                        Connections_Manager['InstantBallTP_Attr_' .. ball.Name] = ball:GetAttributeChangedSignal("target"):Connect(function()
                            handleBallTargetChange(ball)
                        end)
                    end
                end
                
                Connections_Manager['InstantBallTP_Added'] = workspace.Balls.ChildAdded:Connect(function(ball)
                    if ball:IsA("BasePart") then
                        task.wait(0.1)
                        
                        if ball:GetAttribute("target") == plr.Name then
                            handleBallTargetChange(ball)
                        end
                        
                        Connections_Manager['InstantBallTP_Attr_' .. ball.Name] = ball:GetAttributeChangedSignal("target"):Connect(function()
                            handleBallTargetChange(ball)
                        end)
                    end
                end)
            else
                for connName, conn in pairs(Connections_Manager) do
                    if string.find(connName, "InstantBallTP") then
                        conn:Disconnect()
                        Connections_Manager[connName] = nil
                    end
                end
                
                if getgenv().originalCFrame then
                    local c = plr.Character
                    if c then
                        local hrp = c:FindFirstChild("HumanoidRootPart")
                        local hum = c:FindFirstChild("Humanoid")
                        if hrp and hum then
                            hum.PlatformStand = true
                            hrp:PivotTo(getgenv().originalCFrame)
                            task.wait(0.1)
                            hum.PlatformStand = false
                        end
                    end
                    getgenv().originalCFrame = nil
                end
                
                restoreCamera()
            end
        end
    })
end
    
    function handleBallTargetChange(ball)
        local target = ball:GetAttribute("target")
        local c = plr.Character
        if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChild("Humanoid")
        if not hrp or not hum then return end
        
        if target == plr.Name then
            if not getgenv().originalCFrame then
                getgenv().originalCFrame = hrp.CFrame
            end
            
            local speed = getspeed(ball)
            if speed.Magnitude > 100 then
                task.wait(0.2)
            end
            
            -- Teleport to ball
            local offset = Vector3.new(5, 5, 5)
            hum.PlatformStand = true
            hrp:PivotTo(ball.CFrame + offset)
            task.wait(0.1)
            hum.PlatformStand = false
            
            cam.CameraSubject = ball
        else
            if getgenv().originalCFrame then
                hum.PlatformStand = true
                hrp:PivotTo(getgenv().originalCFrame)
                task.wait(0.1)
                hum.PlatformStand = false
                getgenv().originalCFrame = nil
                
                restoreCamera()
            end
        end
    end

    local StrafeSpeed = 36

do
    local Strafe = player:create_module({
        title = 'Speed',
        flag = 'Speed',
        description = 'Changes character speed',
        section = 'left',
    
        callback = function(value)
            if value then
                Connections_Manager['Strafe'] = game:GetService("RunService").PreSimulation:Connect(function()
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("Humanoid") then
                        character.Humanoid.WalkSpeed = StrafeSpeed
                    end
                end)
            else
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = 36
                end
                
                if Connections_Manager['Strafe'] then
                    Connections_Manager['Strafe']:Disconnect()
                    Connections_Manager['Strafe'] = nil
                end
            end
        end
    })
    
    Strafe:create_slider({
        title = 'Strafe Speed',
        flag = 'Strafe_Speed',
        minimum_value = 36,
        maximum_value = 200,
        value = 36,
        round_number = true,
        callback = function(value)
            StrafeSpeed = value
        end
    })
end

do
    local killEffectModule = player:create_module({
        title = "Kill Effect",
        description = "Customize bell kill effect",
        section = "right",
        flag = "kill_effect",
        callback = function(state)
            Configs.kill_effect = state
            if state then
                Notification.new("success","Kill Effect","Enabled",true,0.5)
            else
                Notification.new("error","Kill Effect","Disabled",true,0.5)
            end
        end
    })

    killEffectModule:create_slider({
        title = "Bell Scale",
        min = 1,
        max = 5,
        default = 1,
        flag = "kill_effect_scale",
        callback = function(val)
            Configs.kill_effect_scale = val
            Notification.new("success","Kill Effect","Scale set to "..val.."x",true,0.5)
        end
    })

    killEffectModule:create_dropdown({
        title = "Kill Effect Animation",
        options = {"Linear","Spiral","Pulse"},
        default = "Spiral",
        flag = "kill_effect_animation",
        callback = function(opt)
            Configs.kill_effect_animation = opt
            Notification.new("success","Kill Effect","Animation set to "..opt,true,0.5)
        end
    })
end

do
    local Spinbot = player:create_module({
        title = 'Spinbot',
        flag = 'Spinbot',

        description = 'Spins Player',
        section = 'right',

        callback = function(value: boolean)

            getgenv().Spinbot = value
            if value then
                getgenv().spin = true
                getgenv().spinSpeed = getgenv().spinSpeed or 1 
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local Client = Players.LocalPlayer
    
                
                local function spinCharacter()
                    while getgenv().spin do
                        RunService.Heartbeat:Wait()
                        local char = Client.Character
                        local funcHRP = char and char:FindFirstChild("HumanoidRootPart")
                        
                        if char and funcHRP then
                            funcHRP.CFrame *= CFrame.Angles(0, getgenv().spinSpeed, 0)
                        end
                    end
                end
    
                
                if not getgenv().spinThread then
                    getgenv().spinThread = coroutine.create(spinCharacter)
                    coroutine.resume(getgenv().spinThread)
                end
    
            else
                getgenv().spin = false
    
                
                if getgenv().spinThread then
                    getgenv().spinThread = nil
                end
            end
        end
    })

    Spinbot:create_slider({
        title = 'Spinbot Speed',
        flag = 'Spinbot_Speed',
    
        maximum_value = 100,
        minimum_value = 1,
        value = 1,
    
        round_number = true,
    
        callback = function(value)
            getgenv().spinSpeed = math.rad(value)
        end
    })
end

do
    local CameraToggle = player:create_module({
        title = 'Field of View',
        flag = 'Field_Of_View',
    
        description = 'Changes Camera POV',
        section = 'left',
    
        callback = function(value)
            getgenv().CameraEnabled = value
            local Camera = game:GetService("Workspace").CurrentCamera
    
            if value then
                getgenv().CameraFOV = getgenv().CameraFOV or 70
                Camera.FieldOfView = getgenv().CameraFOV
                
                if not getgenv().FOVLoop then
                    getgenv().FOVLoop = game:GetService("RunService").RenderStepped:Connect(function()
                        if getgenv().CameraEnabled then
                            Camera.FieldOfView = getgenv().CameraFOV
                        end
                    end)
                end
            else
                Camera.FieldOfView = 70
                
                if getgenv().FOVLoop then
                    getgenv().FOVLoop:Disconnect()
                    getgenv().FOVLoop = nil
                end
            end
        end
    })
    
    CameraToggle:create_slider({
        title = 'Camera FOV',
        flag = 'Camera_FOV',
    
        maximum_value = 120,
        minimum_value = 50,
        value = 70,
    
        round_number = true,
    
        callback = function(value)
            getgenv().CameraFOV = value
            if getgenv().CameraEnabled then
                game:GetService("Workspace").CurrentCamera.FieldOfView = value
            end
        end
    })
end

do
-- Módulo principal de animações
local Animations = player:create_module({    
    title = 'Emotes',    
    flag = 'Emotes',    
    description = 'Custom Emotes',    
    section = 'right',    

    callback = function(value)    
        getgenv().Animations = value    

        if value then    
            Connections_Manager['Animations'] = RunService.Heartbeat:Connect(function()    
                if not LocalPlayer.Character or not Player.Character.PrimaryPart then    
                    return    
                end    

                local Speed = LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Magnitude    

                if Speed > 30 then    
                    if Animation.track and not getgenv().LoopEmote then    
                        Animation.track:Stop()    
                        Animation.track:Destroy()    
                        Animation.track = nil    
                    end    
                else    
                    if not Animation.track and Animation.current then    
                        Auto_Parry.Play_Animation(Animation.current)    
                    end    
                end    
            end)    
        else    
            if Animation.track then    
                Animation.track:Stop()    
                Animation.track:Destroy()    
                Animation.track = nil    
            end    

            if Connections_Manager['Animations'] then    
                Connections_Manager['Animations']:Disconnect()    
                Connections_Manager['Animations'] = nil    
            end    
        end    
    end    
})

-- Checkbox dentro do módulo
Animations:create_checkbox({
    title = "Loop Emote",
    flag = "Loop_Emote",
    default = false,
    callback = function(value)
        getgenv().LoopEmote = value
    end
})
   
    local selected_animation = Emotes_Data[1]
    
    local AnimationChoice = Animations:create_dropdown({
        title = 'Animation Type',
        flag = 'Selected_Animation',
    
        options = Emotes_Data,
    
        multi_dropdown = false,
        maximum_options = #Emotes_Data,
    
        callback = function(value)
            selected_animation = value
    
            if getgenv().Animations then
                Auto_Parry.Play_Animation(value)
            end
        end
    })
    
    AnimationChoice:update(selected_animation)
end

    _G.PlayerCosmeticsCleanup = {}
    
do
    local PlayerCosmetics = player:create_module({
        title = "Player Cosmetics",
        flag = "Player_Cosmetics",
        description = "Apply headless and korblox",
        section = "left",
        callback = function(value: boolean)
            local players = game:GetService("Players")
            local lp = players.LocalPlayer
    
            local function applyKorblox(character)
                local rightLeg = character:FindFirstChild("RightLeg") or character:FindFirstChild("Right Leg")
                if not rightLeg then
                    warn("Right leg not found on character")
                    return
                end
                
                for _, child in pairs(rightLeg:GetChildren()) do
                    if child:IsA("SpecialMesh") then
                        child:Destroy()
                    end
                end
                local specialMesh = Instance.new("SpecialMesh")
                specialMesh.MeshId = "rbxassetid://101851696"
                specialMesh.TextureId = "rbxassetid://115727863"
                specialMesh.Scale = Vector3.new(1, 1, 1)
                specialMesh.Parent = rightLeg
            end
    
            local function saveRightLegProperties(char)
                if char then
                    local rightLeg = char:FindFirstChild("RightLeg") or char:FindFirstChild("Right Leg")
                    if rightLeg then
                        local originalMesh = rightLeg:FindFirstChildOfClass("SpecialMesh")
                        if originalMesh then
                            _G.PlayerCosmeticsCleanup.originalMeshId = originalMesh.MeshId
                            _G.PlayerCosmeticsCleanup.originalTextureId = originalMesh.TextureId
                            _G.PlayerCosmeticsCleanup.originalScale = originalMesh.Scale
                        else
                            _G.PlayerCosmeticsCleanup.hadNoMesh = true
                        end
                        
                        _G.PlayerCosmeticsCleanup.rightLegChildren = {}
                        for _, child in pairs(rightLeg:GetChildren()) do
                            if child:IsA("SpecialMesh") then
                                table.insert(_G.PlayerCosmeticsCleanup.rightLegChildren, {
                                    ClassName = child.ClassName,
                                    Properties = {
                                        MeshId = child.MeshId,
                                        TextureId = child.TextureId,
                                        Scale = child.Scale
                                    }
                                })
                            end
                        end
                    end
                end
            end
            
            local function restoreRightLeg(char)
                if char then
                    local rightLeg = char:FindFirstChild("RightLeg") or char:FindFirstChild("Right Leg")
                    if rightLeg and _G.PlayerCosmeticsCleanup.rightLegChildren then
                        for _, child in pairs(rightLeg:GetChildren()) do
                            if child:IsA("SpecialMesh") then
                                child:Destroy()
                            end
                        end
                        
                        if _G.PlayerCosmeticsCleanup.hadNoMesh then
                            return
                        end
                        
                        for _, childData in ipairs(_G.PlayerCosmeticsCleanup.rightLegChildren) do
                            if childData.ClassName == "SpecialMesh" then
                                local newMesh = Instance.new("SpecialMesh")
                                newMesh.MeshId = childData.Properties.MeshId
                                newMesh.TextureId = childData.Properties.TextureId
                                newMesh.Scale = childData.Properties.Scale
                                newMesh.Parent = rightLeg
                            end
                        end
                    end
                end
            end
    
            if value then
                CosmeticsActive = true
    
                getgenv().Config = {
                    Headless = true
                }
                
                if lp.Character then
                    local head = lp.Character:FindFirstChild("Head")
                    if head and getgenv().Config.Headless then
                        _G.PlayerCosmeticsCleanup.headTransparency = head.Transparency
                        
                        local decal = head:FindFirstChildOfClass("Decal")
                        if decal then
                            _G.PlayerCosmeticsCleanup.faceDecalId = decal.Texture
                            _G.PlayerCosmeticsCleanup.faceDecalName = decal.Name
                        end
                    end
                    
                    saveRightLegProperties(lp.Character)
                    applyKorblox(lp.Character)
                end
                
                _G.PlayerCosmeticsCleanup.characterAddedConn = lp.CharacterAdded:Connect(function(char)
                    local head = char:FindFirstChild("Head")
                    if head and getgenv().Config.Headless then
                        _G.PlayerCosmeticsCleanup.headTransparency = head.Transparency
                        
                        local decal = head:FindFirstChildOfClass("Decal")
                        if decal then
                            _G.PlayerCosmeticsCleanup.faceDecalId = decal.Texture
                            _G.PlayerCosmeticsCleanup.faceDecalName = decal.Name
                        end
                    end
                    
                    saveRightLegProperties(char)
                    applyKorblox(char)
                end)
                
                if getgenv().Config.Headless then
                    headLoop = task.spawn(function()
                        while CosmeticsActive do
                            local char = lp.Character
                            if char then
                                local head = char:FindFirstChild("Head")
                                if head then
                                    head.Transparency = 1
                                    local decal = head:FindFirstChildOfClass("Decal")
                                    if decal then
                                        decal:Destroy()
                                    end
                                end
                            end
                            task.wait(0.1)
                        end
                    end)
                end
    
            else
                CosmeticsActive = false
    
                if _G.PlayerCosmeticsCleanup.characterAddedConn then
                    _G.PlayerCosmeticsCleanup.characterAddedConn:Disconnect()
                    _G.PlayerCosmeticsCleanup.characterAddedConn = nil
                end
    
                if headLoop then
                    task.cancel(headLoop)
                    headLoop = nil
                end
    
                local char = lp.Character
                if char then
                    local head = char:FindFirstChild("Head")
                    if head and _G.PlayerCosmeticsCleanup.headTransparency ~= nil then
                        head.Transparency = _G.PlayerCosmeticsCleanup.headTransparency
                        
                        if _G.PlayerCosmeticsCleanup.faceDecalId then
                            local newDecal = head:FindFirstChildOfClass("Decal") or Instance.new("Decal", head)
                            newDecal.Name = _G.PlayerCosmeticsCleanup.faceDecalName or "face"
                            newDecal.Texture = _G.PlayerCosmeticsCleanup.faceDecalId
                            newDecal.Face = Enum.NormalId.Front
                        end
                    end
                    
                    restoreRightLeg(char)
                end
    
                _G.PlayerCosmeticsCleanup = {}
            end
        end
    })
end

do
    local fly = player:create_module({
        title = "Fly",
        flag = "Fly",
        description = "Allows the player to fly",
        section = "right",
        callback = function(value: boolean)
            if value then
                getgenv().FlyEnabled = true
                local char = Player.Character or Player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                local humanoid = char:WaitForChild("Humanoid")
                
                getgenv().OriginalStateType = humanoid:GetState()
                
                getgenv().RagdollHandler = humanoid.StateChanged:Connect(function(oldState, newState)
                    if getgenv().FlyEnabled then
                        if newState == Enum.HumanoidStateType.Physics or newState == Enum.HumanoidStateType.Ragdoll then
                            task.defer(function()
                                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                                humanoid:ChangeState(Enum.HumanoidStateType.Running)
                            end)
                        end
                    end
                end)
                
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.P = 90000
                bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bodyGyro.Parent = hrp
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bodyVelocity.Parent = hrp
                
                humanoid.PlatformStand = true
                
                getgenv().ResetterConnection = RunService.Heartbeat:Connect(function()
                    if not getgenv().FlyEnabled then return end
                    
                    if bodyGyro and bodyGyro.Parent then
                        bodyGyro.P = 90000
                        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                    end
                    
                    if bodyVelocity and bodyVelocity.Parent then
                        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    end
                    
                    humanoid.PlatformStand = true
                    
                    if not bodyGyro.Parent or not bodyVelocity.Parent then
                        if bodyGyro then bodyGyro:Destroy() end
                        if bodyVelocity then bodyVelocity:Destroy() end
                        
                        bodyGyro = Instance.new("BodyGyro")
                        bodyGyro.P = 90000
                        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                        bodyGyro.Parent = hrp
                        
                        bodyVelocity = Instance.new("BodyVelocity")
                        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        bodyVelocity.Parent = hrp
                    end
                end)
                
                getgenv().FlyConnection = RunService.RenderStepped:Connect(function()
                    if not getgenv().FlyEnabled then return end
                    local camCF = workspace.CurrentCamera.CFrame
                    local moveDir = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDir = moveDir + camCF.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDir = moveDir - camCF.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDir = moveDir - camCF.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDir = moveDir + camCF.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                        moveDir = moveDir + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                        moveDir = moveDir - Vector3.new(0, 1, 0)
                    end
                    
                    if moveDir.Magnitude > 0 then
                        moveDir = moveDir.Unit
                    end
                    bodyVelocity.Velocity = moveDir * (getgenv().FlySpeed or 50)
                    bodyGyro.CFrame = camCF
                end)
            else
                getgenv().FlyEnabled = false
                
                if getgenv().FlyConnection then
                    getgenv().FlyConnection:Disconnect()
                    getgenv().FlyConnection = nil
                end
                
                if getgenv().RagdollHandler then
                    getgenv().RagdollHandler:Disconnect()
                    getgenv().RagdollHandler = nil
                end
                
                if getgenv().ResetterConnection then
                    getgenv().ResetterConnection:Disconnect()
                    getgenv().ResetterConnection = nil
                end
                
                local char = Player.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local humanoid = char:FindFirstChild("Humanoid")
                    
                    if humanoid then
                        humanoid.PlatformStand = false
                        if getgenv().OriginalStateType then
                            humanoid:ChangeState(getgenv().OriginalStateType)
                        end
                    end
                    
                    if hrp then
                        for _, v in ipairs(hrp:GetChildren()) do
                            if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then
                                v:Destroy()
                            end
                        end
                    end
                end
            end
        end
    })
    
    fly:create_slider({
        title = "Fly Speed",
        flag = "Fly_Speed",
        minimum_value = 10,
        maximum_value = 200,
        value = 50,
        round_number = true,
        callback = function(value: number)
            getgenv().FlySpeed = value
        end
    })
end

    local localPlayer = Players.LocalPlayer
                
    local SelectedPlayerFollow = nil
    local followDropdown
    
    local function getPlayerNames()
        local names = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                table.insert(names, player.Name)
            end
        end
        return names
    end
    
    local function updateFollowTarget()
        local availablePlayers = getPlayerNames()
        if #availablePlayers > 0 then
            SelectedPlayerFollow = availablePlayers[1]
            if followDropdown then
                followDropdown:update(SelectedPlayerFollow)
            end
        else
            SelectedPlayerFollow = nil
        end
    end
    
do
    local PlayerFollow = player:create_module({
        title = "Player Follow",
        flag = "Player_Follow",
        description = "Follows the selected player",
        section = "left",
        callback = function(value)
            if value then
                getgenv().PlayerFollowEnabled = true
                getgenv().PlayerFollowConnection = RunService.Heartbeat:Connect(function()
                    if not SelectedPlayerFollow then return end -- Prevents nil indexing
                    local targetPlayer = Players:FindFirstChild(SelectedPlayerFollow)
                    if targetPlayer and targetPlayer.Character and targetPlayer.Character.PrimaryPart then
                        local char = localPlayer.Character
                        if char then
                            local humanoid = char:FindFirstChild("Humanoid")
                            if humanoid then
                                humanoid:MoveTo(targetPlayer.Character.PrimaryPart.Position)
                            end
                        end
                    end
                end)
            else
                getgenv().PlayerFollowEnabled = false
                if getgenv().PlayerFollowConnection then
                    getgenv().PlayerFollowConnection:Disconnect()
                    getgenv().PlayerFollowConnection = nil
                end
            end
        end
    })

    local initialOptions = getPlayerNames()
    if #initialOptions > 0 then
        followDropdown = PlayerFollow:create_dropdown({
            title = "Follow Target",
            flag = "Follow_Target",
            options = initialOptions,
            multi_dropdown = false,
            maximum_options = #initialOptions,
            callback = function(value)
                if value then
                    SelectedPlayerFollow = value
                    if getgenv().FollowNotifyEnabled then
                        Library.SendNotification({
                            title = "Module Notification",
                            text = "Now following: " .. value,
                            duration = 3
                        })
                    end
                end
            end
        })
        SelectedPlayerFollow = initialOptions[1]
        followDropdown:update(SelectedPlayerFollow)
        getgenv().FollowDropdown = followDropdown
    else
        SelectedPlayerFollow = nil
    end
    
    local lastOptionsString = table.concat(initialOptions, ",")
    local updateTimer = 0
    
    RunService.Heartbeat:Connect(function(dt)
        updateTimer = updateTimer + dt
        if updateTimer >= 10 then
            local newOptions = getPlayerNames()
            table.sort(newOptions)
            local newOptionsString = table.concat(newOptions, ",")
            
            if newOptionsString ~= lastOptionsString then
                if followDropdown then
                    if #newOptions > 0 then
                        if followDropdown.set_options then
                            followDropdown:set_options(newOptions)
                        else
                            followDropdown.maximum_options = #newOptions
                        end
                        if not table.find(newOptions, SelectedPlayerFollow) then
                            SelectedPlayerFollow = newOptions[1]
                            followDropdown:update(SelectedPlayerFollow)
                        end
                    else
                        SelectedPlayerFollow = nil
                    end
                end
                lastOptionsString = newOptionsString
            end
            updateTimer = 0
        end
    end)
    
    PlayerFollow:create_checkbox({
        title = "Notify",
        flag = "Follow_Notify",
        default = false,
        callback = function(value)
            getgenv().FollowNotifyEnabled = value
        end
    })
end

do
    local HitSounds = player:create_module({
        title = 'Hit Sounds',
        flag = 'Hit_Sounds',
        description = 'Toggles hit sounds',
        section = 'right',
        callback = function(value)
            hit_Sound_Enabled = value
        end
    })

    
    local Folder = Instance.new("Folder")
    Folder.Name = "Useful Utility"
    Folder.Parent = workspace
    
    local hit_Sound = Instance.new('Sound', Folder)
    hit_Sound.Volume = 6
    
    local hitSoundOptions = { 
        "Medal", 
        "Fatality", 
        "Skeet",
        "Switches",
        "Rust Headshot", 
        "Neverlose Sound", 
        "Bubble", 
        "Laser", 
        "Steve", 
        "Call of Duty", 
        "Bat", 
        "TF2 Critical", 
        "Saber", 
        "Bameware"
    }
    
    local hitSoundIds = {
        Medal = "rbxassetid://6607336718",
        Fatality = "rbxassetid://6607113255",
        Skeet = "rbxassetid://6607204501",
        Switches = "rbxassetid://6607173363",
        ["Rust Headshot"] = "rbxassetid://138750331387064",
        ["Neverlose Sound"] = "rbxassetid://110168723447153",
        Bubble = "rbxassetid://6534947588",
        Laser = "rbxassetid://7837461331",
        Steve = "rbxassetid://4965083997",
        ["Call of Duty"] = "rbxassetid://5952120301",
        Bat = "rbxassetid://3333907347",
        ["TF2 Critical"] = "rbxassetid://296102734",
        Saber = "rbxassetid://8415678813",
        Bameware = "rbxassetid://3124331820"
    }

    HitSounds:create_slider({
        title = 'Volume',
        flag = 'HitSoundVolume',
        minimum_value = 1,
        maximum_value = 10,
        value = 5,
        callback = function(value)
            hit_Sound.Volume = value
        end
    })

    HitSounds:create_dropdown({
        title = "Hit Sound Type",
        flag = "hit_sound_type",
        options = hitSoundOptions,
        maximum_options = #hitSoundOptions,
        multi_dropdown = false,
        callback = function(selectedOption)
            if hitSoundIds[selectedOption] then
                hit_Sound.SoundId = hitSoundIds[selectedOption]
            else
                warn("Invalid hit sound selection: " .. tostring(selectedOption))
            end
        end
    })
end
    
    ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
        if hit_Sound_Enabled then
            hit_Sound:Play()
        end
    end)

    local soundOptions = {
        ["Eeyuh"] = "rbxassetid://16190782181",
        ["Sweep"] = "rbxassetid://103508936658553",
        ["Bounce"] = "rbxassetid://134818882821660",
        ["Everybody Wants To Rule The World"] = "rbxassetid://87209527034670",
        ["Missing Money"] = "rbxassetid://134668194128037",
        ["Sour Grapes"] = "rbxassetid://117820392172291",
        ["Erwachen"] = "rbxassetid://124853612881772",
        ["Grasp the Light"] = "rbxassetid://89549155689397",
        ["Beyond the Shadows"] = "rbxassetid://120729792529978",
        ["Rise to the Horizon"] = "rbxassetid://72573266268313",
        ["Echoes of the Candy Kingdom"] = "rbxassetid://103040477333590",
        ["Speed"] = "rbxassetid://125550253895893",
        ["Lo-fi Chill A"] = "rbxassetid://9043887091",
        ["Lo-fi Ambient"] = "rbxassetid://129775776987523",
        ["Tears in the Rain"] = "rbxassetid://129710845038263"
    }
    
    local currentSound = Instance.new("Sound")
    currentSound.Volume = 3
    currentSound.Looped = false
    currentSound.Parent = game:GetService("SoundService")   
    
    local soundModule
    
    local function playSoundById(soundId)
        currentSound:Stop()
        currentSound.SoundId = soundId
        currentSound:Play()
    end
    
    local selectedSound = "Eeyuh"
    
do
    local soundModule = world:create_module({
        title = 'Sound Controller',
        flag = 'sound_controller',
        description = 'Control background music and sounds',
        section = 'left',
        callback = function(value)
            getgenv().soundmodule = value
            if value then
                playSoundById(soundOptions[selectedSound])
            else
                currentSound:Stop()
            end
        end
    })

    soundModule:create_checkbox({
        title = "Loop Song",
        flag = "LoopSong",
        callback = function(value)
            currentSound.Looped = value
        end
    })

    soundModule:create_slider({
        title = 'Volume',
        flag = 'HitSoundVolume',
        minimum_value = 1,
        maximum_value = 10,
        value = 3,
        callback = function(value)
            currentSound.Volume = value
        end
    })

    soundModule:create_divider({
    })
    
    soundModule:create_dropdown({
        title = 'Select Sound',
        flag = 'sound_selection',
        options = {
            "Eeyuh",
            "Sweep", 
            "Bounce",
            "Everybody Wants To Rule The World",
            "Missing Money",
            "Sour Grapes",
            "Erwachen",
            "Grasp the Light",
            "Beyond the Shadows",
            "Rise to the Horizon",
            "Echoes of the Candy Kingdom",
            "Speed",
            "Lo-fi Chill A",
            "Lo-fi Ambient",
            "Tears in the Rain"
        },
        multi_dropdown = false,
        maximum_options = 15,
        callback = function(value)
            selectedSound = value
            if getgenv().soundmodule then
                playSoundById(soundOptions[value])
            end
        end
    })
end

do
    local WorldFilter = world:create_module({
        title = 'Filter',
        flag = 'Filter',
    
        description = 'Toggles custom world filter effects',
        section = 'right',
    
        callback = function(value)
            getgenv().WorldFilterEnabled = value
    
            if not value then

                if game.Lighting:FindFirstChild("CustomAtmosphere") then
                    game.Lighting.CustomAtmosphere:Destroy()
                end
                game.Lighting.FogEnd = 100000
                game.Lighting.ColorCorrection.TintColor = Color3.new(1, 1, 1)
                game.Lighting.ColorCorrection.Saturation = 0
            end
        end
    })
    
    WorldFilter:create_checkbox({
        title = 'Enable Atmosphere',
        flag = 'World_Filter_Atmosphere',
    
        callback = function(value)
            getgenv().AtmosphereEnabled = value
    
            if value then
                if not game.Lighting:FindFirstChild("CustomAtmosphere") then
                    local atmosphere = Instance.new("Atmosphere")
                    atmosphere.Name = "CustomAtmosphere"
                    atmosphere.Parent = game.Lighting
                end
            else
                if game.Lighting:FindFirstChild("CustomAtmosphere") then
                    game.Lighting.CustomAtmosphere:Destroy()
                end
            end
        end
    })

    WorldFilter:create_slider({
        title = 'Atmosphere Density',
        flag = 'World_Filter_Atmosphere_Slider',
    
        minimum_value = 0,
        maximum_value = 1,
        value = 0.5,
    
        callback = function(value)
            if getgenv().AtmosphereEnabled and game.Lighting:FindFirstChild("CustomAtmosphere") then
                game.Lighting.CustomAtmosphere.Density = value
            end
        end
    })

    WorldFilter:create_checkbox({
        title = 'Enable Fog',
        flag = 'World_Filter_Fog',
    
        callback = function(value)
            getgenv().FogEnabled = value
    
            if not value then
                game.Lighting.FogEnd = 100000
            end
        end
    })

    WorldFilter:create_slider({
        title = 'Fog Distance',
        flag = 'World_Filter_Fog_Slider',
    
        minimum_value = 50,
        maximum_value = 10000,
        value = 1000,
    
        callback = function(value)
            if getgenv().FogEnabled then
                game.Lighting.FogEnd = value
            end
        end
    })

    WorldFilter:create_checkbox({
        title = 'Enable Saturation',
        flag = 'World_Filter_Saturation',
    
        callback = function(value)
            getgenv().SaturationEnabled = value
    
            if not value then
                game.Lighting.ColorCorrection.Saturation = 0
            end
        end
    })

    WorldFilter:create_slider({
        title = 'Saturation Level',
        flag = 'World_Filter_Saturation_Slider',
    
        minimum_value = -1,
        maximum_value = 1,
        value = 0,
    
        callback = function(value)
            if getgenv().SaturationEnabled then
                game.Lighting.ColorCorrection.Saturation = value
            end
        end
    })

    WorldFilter:create_checkbox({
        title = 'Enable Hue',
        flag = 'World_Filter_Hue',
    
        callback = function(value)
            getgenv().HueEnabled = value
    
            if not value then
                game.Lighting.ColorCorrection.TintColor = Color3.new(1, 1, 1)
            end
        end
    })
    
    WorldFilter:create_slider({
        title = 'Hue Shift',
        flag = 'World_Filter_Hue_Slider',
    
        minimum_value = -1,
        maximum_value = 1,
        value = 0,
    
        callback = function(value)
            if getgenv().HueEnabled then
                game.Lighting.ColorCorrection.TintColor = Color3.fromHSV(value, 1, 1)
            end
        end
    })
end

do
    local BallTrail = world:create_module({
	title = "Ball Trail",
	flag = "Ball_Trail",
	description = "Toggles ball trail effects",
	section = "left",
	callback = function(value)
		getgenv().BallTrailEnabled = value
	end
})

BallTrail:create_slider({
	title = "Ball Trail Hue",
	flag = "Ball_Trail_Hue",
	minimum_value = 0,
	maximum_value = 360,
	value = 0,
	round_number = true,
	callback = function(value)
		if not getgenv().BallTrailRainbowEnabled then
			local newColor = Color3.fromHSV(value / 360, 1, 1)
			getgenv().BallTrailColor = newColor
		end
	end
})

BallTrail:create_checkbox({
	title = "Rainbow Trail",
	flag = "Ball_Trail_Rainbow",
	callback = function(value)
		getgenv().BallTrailRainbowEnabled = value
	end
})

BallTrail:create_checkbox({
	title = "Particle Emitter",
	flag = "Ball_Trail_Particle",
	callback = function(value)
		getgenv().BallTrailParticleEnabled = value
	end
})

BallTrail:create_checkbox({
	title = "Glow Effect",
	flag = "Ball_Trail_Glow",
	callback = function(value)
		getgenv().BallTrailGlowEnabled = value
	end
})
end

local hue = 0
local trackedBalls = {}

local function clearEffects(ball)
	local trail = ball:FindFirstChild("Trail")
	if trail then trail:Destroy() end

	local emitter = ball:FindFirstChild("ParticleEmitter")
	if emitter then emitter:Destroy() end

	local glow = ball:FindFirstChild("BallGlow")
	if glow then glow:Destroy() end

	local att0 = ball:FindFirstChild("Attachment0")
	if att0 then att0:Destroy() end
	local att1 = ball:FindFirstChild("Attachment1")
	if att1 then att1:Destroy() end
end

local function applyEffects(ball)
	if not getgenv().BallTrailEnabled then
		if trackedBalls[ball] then
			clearEffects(ball)
			trackedBalls[ball] = nil
		end
		return
	end

	if trackedBalls[ball] then
		local trail = ball:FindFirstChild("Trail")
		if trail then
			if getgenv().BallTrailRainbowEnabled then
				local color = Color3.fromHSV(hue / 360, 1, 1)
				trail.Color = ColorSequence.new(color)
				getgenv().BallTrailColor = color
			else
				trail.Color = ColorSequence.new(getgenv().BallTrailColor or Color3.new(1, 1, 1))
			end
		end
		return
	end

	trackedBalls[ball] = true

	local trail = Instance.new("Trail")
	trail.Name = "Trail"

	local att0 = Instance.new("Attachment")
	att0.Name = "Attachment0"
	att0.Position = Vector3.new(0, ball.Size.Y / 2, 0)
	att0.Parent = ball

	local att1 = Instance.new("Attachment")
	att1.Name = "Attachment1"
	att1.Position = Vector3.new(0, -ball.Size.Y / 2, 0)
	att1.Parent = ball

	trail.Attachment0 = att0
	trail.Attachment1 = att1
	trail.Lifetime = 0.4
	trail.WidthScale = NumberSequence.new(0.5)
	trail.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1)
	})
	trail.Color = ColorSequence.new(getgenv().BallTrailColor or Color3.new(1, 1, 1))
	trail.Parent = ball

	if getgenv().BallTrailParticleEnabled then
		local emitter = Instance.new("ParticleEmitter")
		emitter.Name = "ParticleEmitter"
		emitter.Rate = 100
		emitter.Lifetime = NumberRange.new(0.5, 1)
		emitter.Speed = NumberRange.new(0, 1)
		emitter.Size = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.5),
			NumberSequenceKeypoint.new(1, 0)
		})
		emitter.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
		emitter.Parent = ball
	end

	if getgenv().BallTrailGlowEnabled then
		local glow = Instance.new("PointLight")
		glow.Name = "BallGlow"
		glow.Range = 15
		glow.Brightness = 2
		glow.Parent = ball
	end
end

game:GetService("RunService").Heartbeat:Connect(function()
	hue = (hue + 1) % 360

	for _, ball in pairs(Auto_Parry.Get_Balls()) do
		applyEffects(ball)
	end
end)

    local billboardLabels = {}

    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer

getgenv().AbilityESP = true
local billboardLabels = {}

function qolPlayerNameVisibility()
	local function createBillboardGui(p)
		local character = p.Character
		while not (character and character.Parent) do
			task.wait()
			character = p.Character
		end

		local head = character:WaitForChild("Head")

		-- 🧠 Criar o Billboard fixo
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "AbilityBillboard"
		billboardGui.Adornee = head
		billboardGui.Size = UDim2.new(0, 200, 0, 25)
		billboardGui.StudsOffset = Vector3.new(0, 3, 0)
		billboardGui.AlwaysOnTop = true
		billboardGui.Parent = head

		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.TextColor3 = Color3.fromRGB(0, 255, 255) -- ciano
		textLabel.TextSize = 12
		textLabel.Font = Enum.Font.SourceSansSemibold
		textLabel.BackgroundTransparency = 1
		textLabel.TextWrapped = false
		textLabel.TextTruncate = Enum.TextTruncate.AtEnd
		textLabel.TextXAlignment = Enum.TextXAlignment.Center
		textLabel.TextYAlignment = Enum.TextYAlignment.Center
		textLabel.TextScaled = false
		textLabel.Text = ""
		textLabel.Parent = billboardGui

		billboardLabels[p] = textLabel

		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		end

		RunService.Heartbeat:Connect(function()
			if not character or not character.Parent then
				billboardGui:Destroy()
				billboardLabels[p] = nil
				return
			end

			if getgenv().AbilityESP then
				textLabel.Visible = true
				local abilityName = p:GetAttribute("EquippedAbility")
				if abilityName then
					textLabel.Text = p.DisplayName .. " [" .. tostring(abilityName) .. "]"
				else
					textLabel.Text = p.DisplayName .. " [???]"
				end
			else
				textLabel.Visible = false
			end
		end)
	end

	for _, p in Players:GetPlayers() do
		if p ~= plr then
			p.CharacterAdded:Connect(function()
				createBillboardGui(p)
			end)
			createBillboardGui(p)
		end
	end

	Players.PlayerAdded:Connect(function(newPlayer)
		newPlayer.CharacterAdded:Connect(function()
			createBillboardGui(newPlayer)
		end)
	end)
end

qolPlayerNameVisibility()
    
do
    local AbilityESP = world:create_module({
        title = 'Ability ESP',
        flag = 'AbilityESP',
        description = 'Displays Player Abilities',
        section = 'right',
        callback = function(value: boolean)
            getgenv().AbilityESP = value
            for _, label in pairs(billboardLabels) do
                label.Visible = value
            end
        end
    })

    local CustomSky = world:create_module({
        title = 'Custom Sky',
        flag = 'Custom_Sky',
        description = 'Toggles a custom skybox',
        section = 'left',
        callback = function(value)
            local Lighting = game.Lighting
            local Sky = Lighting:FindFirstChildOfClass("Sky")
            if value then
                if not Sky then
                    Sky = Instance.new("Sky", Lighting)
                end
            else
                if Sky then
                    local defaultSkyboxIds = {"591058823", "591059876", "591058104", "591057861", "591057625", "591059642"}
                    local skyFaces = {"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}
                    
                    for index, face in ipairs(skyFaces) do
                        Sky[face] = "rbxassetid://" .. defaultSkyboxIds[index]
                    end
                    Lighting.GlobalShadows = true
                    
                end
            end
        end
    })
    
    CustomSky:create_dropdown({
        title = 'Select Sky',
        flag = 'custom_sky_selector',
        options = {
            "Default",
            "Vaporwave",
            "Redshift",
            "Desert",
            "DaBaby",
            "Minecraft",
            "SpongeBob",
            "Skibidi",
            "Blaze",
            "Pussy Cat",
            "Among Us",
            "Space Wave",
            "Space Wave2",
            "Turquoise Wave",
            "Dark Night",
            "Bright Pink",
            "White Galaxy",
            "Blue Galaxy"
        },
        multi_dropdown = false,
        maximum_options = 18,
        callback = function(selectedOption)
            local skyboxData = nil
            if selectedOption == "Default" then
                skyboxData = {"591058823", "591059876", "591058104", "591057861", "591057625", "591059642"}
            elseif selectedOption == "Vaporwave" then
                skyboxData = {"1417494030", "1417494146", "1417494253", "1417494402", "1417494499", "1417494643"}
            elseif selectedOption == "Redshift" then
                skyboxData = {"401664839", "401664862", "401664960", "401664881", "401664901", "401664936"}
            elseif selectedOption == "Desert" then
                skyboxData = {"1013852", "1013853", "1013850", "1013851", "1013849", "1013854"}
            elseif selectedOption == "DaBaby" then
                skyboxData = {"7245418472", "7245418472", "7245418472", "7245418472", "7245418472", "7245418472"}
            elseif selectedOption == "Minecraft" then
                skyboxData = {"1876545003", "1876544331", "1876542941", "1876543392", "1876543764", "1876544642"}
            elseif selectedOption == "SpongeBob" then
                skyboxData = {"7633178166", "7633178166", "7633178166", "7633178166", "7633178166", "7633178166"}
            elseif selectedOption == "Skibidi" then
                skyboxData = {"14952256113", "14952256113", "14952256113", "14952256113", "14952256113", "14952256113"}
            elseif selectedOption == "Blaze" then
                skyboxData = {"150939022", "150939038", "150939047", "150939056", "150939063", "150939082"}
            elseif selectedOption == "Pussy Cat" then
                skyboxData = {"11154422902", "11154422902", "11154422902", "11154422902", "11154422902", "11154422902"}
            elseif selectedOption == "Among Us" then
                skyboxData = {"5752463190", "5752463190", "5752463190", "5752463190", "5752463190", "5752463190"}
            elseif selectedOption == "Space Wave" then
                skyboxData = {"16262356578", "16262358026", "16262360469", "16262362003", "16262363873", "16262366016"}
            elseif selectedOption == "Space Wave2" then
                skyboxData = {"1233158420", "1233158838", "1233157105", "1233157640", "1233157995", "1233159158"}
            elseif selectedOption == "Turquoise Wave" then
                skyboxData = {"47974894", "47974690", "47974821", "47974776", "47974859", "47974909"}
            elseif selectedOption == "Dark Night" then
                skyboxData = {"6285719338", "6285721078", "6285722964", "6285724682", "6285726335", "6285730635"}
            elseif selectedOption == "Bright Pink" then
                skyboxData = {"271042516", "271077243", "271042556", "271042310", "271042467", "271077958"}
            elseif selectedOption == "White Galaxy" then
                skyboxData = {"5540798456", "5540799894", "5540801779", "5540801192", "5540799108", "5540800635"}
            elseif selectedOption == "Blue Galaxy" then
                skyboxData = {"14961495673", "14961494492", "14961492844", "14961491298", "14961490439", "14961489508"}
            end
    
            if not skyboxData then
                warn("Sky option not found: " .. tostring(selectedOption))
                return
            end
    
            local Lighting = game.Lighting
            local Sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)
    
            local skyFaces = {"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}
            for index, face in ipairs(skyFaces) do
                Sky[face] = "rbxassetid://" .. skyboxData[index]
            end

            Lighting.GlobalShadows = false
        end
    })
end

do
    local AbilityExploit = world:create_module({
        title = 'Ability Exploit',
        flag = 'AbilityExploit',
        description = 'Ability Exploit',    
        section = 'right',
    
        callback = function(value)
            getgenv().AbilityExploit = value
        end
    })

    AbilityExploit:create_checkbox({
        title = 'Thunder Dash No Cooldown',
        flag = 'ThunderDashNoCooldown',
        callback = function(value)
            getgenv().ThunderDashNoCooldown = value
            if getgenv().AbilityExploit and getgenv().ThunderDashNoCooldown then
                local thunderModule = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Abilities"):WaitForChild("Thunder Dash")
                local mod = require(thunderModule)
                mod.cooldown = 0
                mod.cooldownReductionPerUpgrade = 0
            end
        end
    })

    AbilityExploit:create_checkbox({
        title = 'Continuity Zero Exploit',
        flag  = 'ContinuityZeroExploit',
        callback = function(value)
            getgenv().ContinuityZeroExploit = value
    
            if getgenv().AbilityExploit and getgenv().ContinuityZeroExploit then
                local ContinuityZeroRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseContinuityPortal")
                local oldNamecall
                oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                    local method = getnamecallmethod()
    
                    if self == ContinuityZeroRemote and method == "FireServer" then
                        return oldNamecall(self,
                            CFrame.new(9e17, 9e16, 9e15, 9e14, 9e13, 9e12, 9e11, 9e10, 9e9, 9e8, 9e7, 9e6),
                            player.Name
                        )
                    end
    
                    return oldNamecall(self, ...)
                end)
            end
        end
    })
end

    local autoDuelsRequeueEnabled = false

do
    local AutoDuelsRequeue = farm:create_module({
        title = 'Auto Duels Requeue',
        flag = 'AutoDuelsRequeue',
    
        description = 'Automatically requeues duels',
        section = 'left',
    
        callback = function(value)
            autoDuelsRequeueEnabled = value

            if autoDuelsRequeueEnabled then
                task.spawn(function()
                    while autoDuelsRequeueEnabled do
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.1.0"):WaitForChild("net"):WaitForChild("RE/PlayerWantsRematch"):FireServer()
                        task.wait(5)
                    end
                end)
            end
        end
    })

    local validRankedPlaceIds = {
        13772394625,
        14915220621,
    }

    local selectedQueue = "FFA"
    local autoRequeueEnabled = false

    local AutoRankedRequeue = farm:create_module({
        title = 'Auto Ranked Requeue',
        flag = 'AutoRankedRequeue',
    
        description = 'Automatically requeues Ranked',
        section = 'right',
    
        callback = function(value)
            autoRequeueEnabled = value

            if autoRequeueEnabled then
                if not table.find(validRankedPlaceIds, game.PlaceId) then
                    autoRequeueEnabled = false
                    return
                end

                task.spawn(function()
                    while autoRequeueEnabled do
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("JoinQueue"):FireServer("Ranked", selectedQueue, "Normal")
                        task.wait(5)
                    end
                end)
            end
        end
    })

    AutoRankedRequeue:create_dropdown({
        title = 'Select Queue Type',
        flag = 'QueueType',
        options = { 
            "FFA",
            "Duo" 
        },
        multi_dropdown = false,
        maximum_options = 2,
        callback = function(selectedOption)
            selectedQueue = selectedOption
        end
    })
end

    local autoLTMRequeueEnabled = false
    local validLTMPlaceId = 13772394625

do
    local AutoLTMRequeue = farm:create_module({
        title = 'Auto LTM Requeue',
        flag = 'AutoLTMRequeue',
    
        description = 'Automatically requeues LTM',
        section = 'left',
    
        callback = function(value)
            autoLTMRequeueEnabled = value

            if autoLTMRequeueEnabled then
                if game.PlaceId ~= validLTMPlaceId then
                    autoLTMRequeueEnabled = false
                    return
                end

                task.spawn(function()
                    while autoLTMRequeueEnabled do
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.1.0"):WaitForChild("net"):WaitForChild("RF/JoinTournamentEventQueue"):InvokeServer({})
                        task.wait(5)
                    end
                end)
            end
        end
    })
end

do
    local SkinChanger = misc:create_module({
        title = 'Skin Changer (Disabled)',
        flag = 'SkinChanger',
        description = 'Skin Changer',
        section = 'left',
        callback = function(value: boolean)            
            if value then
                print("disabled")
            end
        end
    })


    SkinChanger:change_state(false)

    SkinChanger:create_paragraph({
        title = "âš ï¸EVERYONE CAN SEE ANIMATIONS",
        text = "IF YOU USE SKIN CHANGER BACKSWORD YOU MUST EQUIP AN ACTUAL BACKSWORD"
    })

    local skinchangertextbox = SkinChanger:create_textbox({
        title = "ï¿¬ Skin Name (Case Sensitive) ï¿¬",
        placeholder = "Enter Sword Skin Name... ",
        flag = "SkinChangerTextbox",
        callback = function(value: boolean)            
            if value then
                print("disabled")
            end
        end
    })
end
    
    local AutoPlayModule = {}
    AutoPlayModule.CONFIG = {
        DEFAULT_DISTANCE = 30,
        MULTIPLIER_THRESHOLD = 70,
        TRAVERSING = 25,
        DIRECTION = 1,
        JUMP_PERCENTAGE = 50,
        DOUBLE_JUMP_PERCENTAGE = 50,
        JUMPING_ENABLED = false,
        MOVEMENT_DURATION = 0.8,
        OFFSET_FACTOR = 0.7,
        GENERATION_THRESHOLD = 0.25
    }
    
    AutoPlayModule.ball = nil
    AutoPlayModule.lobbyChoice = nil
    AutoPlayModule.animationCache = nil
    AutoPlayModule.doubleJumped = false
    AutoPlayModule.ELAPSED = 0
    AutoPlayModule.CONTROL_POINT = nil
    AutoPlayModule.LAST_GENERATION = 0
    AutoPlayModule.signals = {}
    
    do
        local getServiceFunction = game.GetService
        
        local function getClonerefPermission()
            local permission = cloneref(getServiceFunction(game, "ReplicatedFirst"))
            return permission
        end
        
        AutoPlayModule.clonerefPermission = getClonerefPermission()
        
        if not AutoPlayModule.clonerefPermission then
            warn("cloneref is not available on your executor! There is a risk of getting detected.")
        end
        
        function AutoPlayModule.findCachedService(self, name)
            for index, value in self do
                if value.Name == name then
                    return value
                end
            end
            return
        end
        
        function AutoPlayModule.getService(self, name)
            local cachedService = AutoPlayModule.findCachedService(self, name)
        
            if cachedService then
                return cachedService
            end
        
            local service = getServiceFunction(game, name)
        
            if AutoPlayModule.clonerefPermission then
                service = cloneref(service)
            end
        
            table.insert(self, service)
            return service
        end
        
        AutoPlayModule.customService = setmetatable({}, {
            __index = AutoPlayModule.getService
        })
    end
    
    AutoPlayModule.playerHelper = {
        isAlive = function(player)
            local character = nil
        
            if player and player:IsA("Player") then
                character = player.Character
            end
        
            if not character then
                return false
            end
        
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
        
            if not rootPart or not humanoid then
                return false
            end
        
            return humanoid.Health > 0
        end,
        
        inLobby = function(character)
            if not character then
                return false
            end
        
            return character.Parent == AutoPlayModule.customService.Workspace.Dead
        end,
        
        onGround = function(character)
            if not character then
                return false
            end
        
            return character.Humanoid.FloorMaterial ~= Enum.Material.Air
        end
    }
    
    function AutoPlayModule.isLimited()
        local passedTime = tick() - AutoPlayModule.LAST_GENERATION
        return passedTime < AutoPlayModule.CONFIG.GENERATION_THRESHOLD
    end
    
    function AutoPlayModule.percentageCheck(limit)
        if AutoPlayModule.isLimited() then
            return false
        end
    
        local percentage = math.random(100)
        AutoPlayModule.LAST_GENERATION = tick()
    
        return limit >= percentage
    end

    AutoPlayModule.ballUtils = {
        getBall = function()
            for _, object in AutoPlayModule.customService.Workspace.Balls:GetChildren() do
                if object:GetAttribute("realBall") then
                    AutoPlayModule.ball = object
                    return
                end
            end
        
            AutoPlayModule.ball = nil
        end,
        
        getDirection = function()
            if not AutoPlayModule.ball then
                return
            end
        
            local direction = (AutoPlayModule.customService.Players.LocalPlayer.Character.HumanoidRootPart.Position - AutoPlayModule.ball.Position).Unit
            return direction
        end,
        
        getVelocity = function()
            if not AutoPlayModule.ball then
                return
            end
        
            local zoomies = AutoPlayModule.ball:FindFirstChild("zoomies")
        
            if not zoomies then
                return
            end
        
            return zoomies.VectorVelocity
        end,
        
        getSpeed = function()
            local velocity = AutoPlayModule.ballUtils.getVelocity()
        
            if not velocity then
                return
            end
        
            return velocity.Magnitude
        end,
        
        isExisting = function()
            return AutoPlayModule.ball ~= nil
        end
    }
    
    AutoPlayModule.lerp = function(start, finish, alpha)
        return start + (finish - start) * alpha
    end
    
    AutoPlayModule.quadratic = function(start, middle, finish, alpha)
        local firstLerp = AutoPlayModule.lerp(start, middle, alpha)
        local secondLerp = AutoPlayModule.lerp(middle, finish, alpha)
    
        return AutoPlayModule.lerp(firstLerp, secondLerp, alpha)
    end
    
    AutoPlayModule.getCandidates = function(middle, theta, offsetLength)
        local firstCanditateX = math.cos(theta + math.pi / 2)
        local firstCanditateZ = math.sin(theta + math.pi / 2)
        local firstCandidate = middle + Vector3.new(firstCanditateX, 0, firstCanditateZ) * offsetLength
    
        local secondCanditateX = math.cos(theta - math.pi / 2)
        local secondCanditateZ = math.sin(theta - math.pi / 2)
        local secondCandidate = middle + Vector3.new(secondCanditateX, 0, secondCanditateZ) * offsetLength
    
        return firstCandidate, secondCandidate
    end
    
    AutoPlayModule.getControlPoint = function(start, finish)
        local middle = (start + finish) * 0.5
        local difference = start - finish
    
        if difference.Magnitude < 5 then
            return finish
        end
    
        local theta = math.atan2(difference.Z, difference.X)
        local offsetLength = difference.Magnitude * AutoPlayModule.CONFIG.OFFSET_FACTOR
    
        local firstCandidate, secondCandidate = AutoPlayModule.getCandidates(middle, theta, offsetLength)
        local dotValue = start - middle
    
        if (firstCandidate - middle):Dot(dotValue) < 0 then
            return firstCandidate
        else
            return secondCandidate
        end
    end
    
    AutoPlayModule.getCurve = function(start, finish, delta)
        AutoPlayModule.ELAPSED = AutoPlayModule.ELAPSED + delta
        local timeElapsed = math.clamp(AutoPlayModule.ELAPSED / AutoPlayModule.CONFIG.MOVEMENT_DURATION, 0, 1)
    
        if timeElapsed >= 1 then
            local distance = (start - finish).Magnitude
    
            if distance >= 10 then
                AutoPlayModule.ELAPSED = 0
            end
    
            AutoPlayModule.CONTROL_POINT = nil
            return finish
        end
    
        if not AutoPlayModule.CONTROL_POINT then
            AutoPlayModule.CONTROL_POINT = AutoPlayModule.getControlPoint(start, finish)
        end
    
        assert(AutoPlayModule.CONTROL_POINT, "CONTROL_POINT: Vector3 expected, got nil")
        return AutoPlayModule.quadratic(start, AutoPlayModule.CONTROL_POINT, finish, timeElapsed)
    end
    
    AutoPlayModule.map = {
        getFloor = function()
            local floor = AutoPlayModule.customService.Workspace:FindFirstChild("FLOOR")
            
            if not floor then
                for _, part in pairs(AutoPlayModule.customService.Workspace:GetDescendants()) do
                    if part:IsA("MeshPart") or part:IsA("BasePart") then
                        local size = part.Size
                        if size.X > 50 and size.Z > 50 and part.Position.Y < 5 then
                            return part
                        end
                    end
                end
            end
            
            return floor
        end
    }
    
    AutoPlayModule.getRandomPosition = function()
        local floor = AutoPlayModule.map.getFloor()
    
        if not floor or not AutoPlayModule.ballUtils.isExisting() then
            return
        end
    
        local ballDirection = AutoPlayModule.ballUtils.getDirection() * AutoPlayModule.CONFIG.DIRECTION
        local ballSpeed = AutoPlayModule.ballUtils.getSpeed()
    
        local speedThreshold = math.min(ballSpeed / 10, AutoPlayModule.CONFIG.MULTIPLIER_THRESHOLD)
        local speedMultiplier = AutoPlayModule.CONFIG.DEFAULT_DISTANCE + speedThreshold
        local negativeDirection = ballDirection * speedMultiplier
    
        local currentTime = os.time() / 1.2
        local sine = math.sin(currentTime) * AutoPlayModule.CONFIG.TRAVERSING
        local cosine = math.cos(currentTime) * AutoPlayModule.CONFIG.TRAVERSING
    
        local traversing = Vector3.new(sine, 0, cosine)
        local finalPosition = floor.Position + negativeDirection + traversing
    
        return finalPosition
    end
    
    
    AutoPlayModule.lobby = {
        isChooserAvailable = function()
            return AutoPlayModule.customService.Workspace.Spawn.NewPlayerCounter.GUI.SurfaceGui.Top.Options.Visible
        end,
        
        updateChoice = function(choice)
            AutoPlayModule.lobbyChoice = choice
        end,
        
        getMapChoice = function()
            local choice = AutoPlayModule.lobbyChoice or math.random(1, 3)
            local collider = AutoPlayModule.customService.Workspace.Spawn.NewPlayerCounter.Colliders:FindFirstChild(choice)
        
            return collider
        end,
        
        getPadPosition = function()
            if not AutoPlayModule.lobby.isChooserAvailable() then
                AutoPlayModule.lobbyChoice = nil
                return
            end
        
            local choice = AutoPlayModule.lobby.getMapChoice()
        
            if not choice then
                return
            end
        
            return choice.Position, choice.Name
        end
    }
    
    AutoPlayModule.movement = {
        removeCache = function()
            if AutoPlayModule.animationCache then
                AutoPlayModule.animationCache = nil
            end
        end,
        
        createJumpVelocity = function(player)
            local maxForce = math.huge
            local velocity = Instance.new("BodyVelocity")
            velocity.MaxForce = Vector3.new(maxForce, maxForce, maxForce)
            velocity.Velocity = Vector3.new(0, 80, 0)
            velocity.Parent = player.Character.HumanoidRootPart
        
            AutoPlayModule.customService.Debris:AddItem(velocity, 0.001)
            AutoPlayModule.customService.ReplicatedStorage.Remotes.DoubleJump:FireServer()
        end,
        
        playJumpAnimation = function(player)
            if not AutoPlayModule.animationCache then
                local doubleJumpAnimation = AutoPlayModule.customService.ReplicatedStorage.Assets.Tutorial.Animations.DoubleJump
                AutoPlayModule.animationCache = player.Character.Humanoid.Animator:LoadAnimation(doubleJumpAnimation)
            end
        
            if AutoPlayModule.animationCache then
                AutoPlayModule.animationCache:Play()
            end
        end,
        
        doubleJump = function(player)
            if AutoPlayModule.doubleJumped then
                return
            end
        
            if not AutoPlayModule.percentageCheck(AutoPlayModule.CONFIG.DOUBLE_JUMP_PERCENTAGE) then
                return
            end
        
            AutoPlayModule.doubleJumped = true
            AutoPlayModule.movement.createJumpVelocity(player)
            AutoPlayModule.movement.playJumpAnimation(player)
        end,
        
        jump = function(player)
            if not AutoPlayModule.CONFIG.JUMPING_ENABLED then
                return
            end
            
            if not AutoPlayModule.playerHelper.onGround(player.Character) then
                AutoPlayModule.movement.doubleJump(player)
                return
            end
        
            if not AutoPlayModule.percentageCheck(AutoPlayModule.CONFIG.JUMP_PERCENTAGE) then
                return
            end
        
            AutoPlayModule.doubleJumped = false
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end,
        
        move = function(player, playerPosition)
            player.Character.Humanoid:MoveTo(playerPosition)
        end,
        
        stop = function(player)
            local playerPosition = player.Character.HumanoidRootPart.Position
            player.Character.Humanoid:MoveTo(playerPosition)
        end
    }
    
    AutoPlayModule.signal = {
        connect = function(name, connection, callback)
            if not name then
                name = AutoPlayModule.customService.HttpService:GenerateGUID()
            end
        
            AutoPlayModule.signals[name] = connection:Connect(callback)
            return AutoPlayModule.signals[name]
        end,
        
        disconnect = function(name)
            if not name or not AutoPlayModule.signals[name] then
                return
            end
        
            AutoPlayModule.signals[name]:Disconnect()
            AutoPlayModule.signals[name] = nil
        end,
        
        stop = function()
            for name, connection in pairs(AutoPlayModule.signals) do
                if typeof(connection) ~= "RBXScriptConnection" then
                    continue
                end
        
                connection:Disconnect()
                AutoPlayModule.signals[name] = nil
            end
        end
    }
    
    AutoPlayModule.findPath = function(inLobby, delta)
        local rootPosition = AutoPlayModule.customService.Players.LocalPlayer.Character.HumanoidRootPart.Position
    
        if inLobby then
            local padPosition, padNumber = AutoPlayModule.lobby.getPadPosition()
            local choice = tonumber(padNumber)
            if choice then
                AutoPlayModule.lobby.updateChoice(choice)
                if getgenv().AutoVote then
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.1.0"):WaitForChild("net"):WaitForChild("RE/UpdateVotes"):FireServer("FFA")
                end
            end
    
            if not padPosition then
                return
            end
    
            return AutoPlayModule.getCurve(rootPosition, padPosition, delta)
        end
    
        local randomPosition = AutoPlayModule.getRandomPosition()
    
        if not randomPosition then
            return
        end
    
        return AutoPlayModule.getCurve(rootPosition, randomPosition, delta)
    end
    
    
    AutoPlayModule.followPath = function(delta)
        if not AutoPlayModule.playerHelper.isAlive(AutoPlayModule.customService.Players.LocalPlayer) then
            AutoPlayModule.movement.removeCache()
            return
        end
    
        local inLobby = AutoPlayModule.customService.Players.LocalPlayer.Character.Parent == AutoPlayModule.customService.Workspace.Dead
        local path = AutoPlayModule.findPath(inLobby, delta)
    
        if not path then
            AutoPlayModule.movement.stop(AutoPlayModule.customService.Players.LocalPlayer)
            return
        end
    
        AutoPlayModule.movement.move(AutoPlayModule.customService.Players.LocalPlayer, path)
        AutoPlayModule.movement.jump(AutoPlayModule.customService.Players.LocalPlayer)
    end
    
    AutoPlayModule.finishThread = function()
        AutoPlayModule.signal.disconnect("auto-play")
        AutoPlayModule.signal.disconnect("synchronize")
        
        if not AutoPlayModule.playerHelper.isAlive(AutoPlayModule.customService.Players.LocalPlayer) then
            return
        end
        
        AutoPlayModule.movement.stop(AutoPlayModule.customService.Players.LocalPlayer)
    end
    
    AutoPlayModule.runThread = function()
        AutoPlayModule.signal.connect("auto-play", AutoPlayModule.customService.RunService.PostSimulation, AutoPlayModule.followPath)
        AutoPlayModule.signal.connect("synchronize", AutoPlayModule.customService.RunService.PostSimulation, AutoPlayModule.ballUtils.getBall)
    end
    
    --[[
        TeleportService = cloneref(game:GetService("TeleportService"))
        PlaceId, JobId = game.PlaceId, game.JobId
        if #Players:GetPlayers() < 5 then
            if getgenv().AutoServerHop then
                Players.LocalPlayer:Kick("\nRejoining")
                wait()
                TeleportService:Teleport(PlaceId, Players.LocalPlayer)
            else
                TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
            end
        end
    ]]

do
    local AutoPlay = misc:create_module({
        title = 'Auto Play',
        flag = 'AutoPlay',
        description = 'Automatically Plays Game',
        section = 'right',
        callback = function(value)
            if value then
                AutoPlayModule.runThread()
            else
                AutoPlayModule.finishThread()
            end
        end
    })

    

    local AntiAFK = AutoPlay:create_checkbox({
        title = "Anti AFK",
        flag = "AutoPlayAntiAFK",
        callback = function(value: boolean)
            if value then
                local GC = getconnections or get_signal_cons
                if GC then
                    for i, v in pairs(GC(Players.LocalPlayer.Idled)) do
                        if v["Disable"] then
                            v["Disable"](v)
                        elseif v["Disconnect"] then
                            v["Disconnect"](v)
                        end
                    end
                else
                    local VirtualUser = cloneref(game:GetService("VirtualUser"))
                    Players.LocalPlayer.Idled:Connect(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end
        end
    })


    AntiAFK:change_state(true)


    AutoPlay:create_checkbox({
        title = "Enable Jumping",
        flag = "jumping_enabled",
        callback = function(value)
            AutoPlayModule.CONFIG.JUMPING_ENABLED = value
        end
    })

    AutoPlay:create_checkbox({
        title = "Auto Vote",
        flag = "AutoVote",
        callback = function(value)
            getgenv().AutoVote = value
        end
    })

    --[[
        local AutoServerHop = AutoPlay:create_checkbox({
            title = "Auto Server Hop",
            flag = "AutoServerHop",
            callback = function(value)
                getgenv().AutoServerHop = value
            end
        })

        AutoServerHop:change_state(false)
    ]]
    AutoPlay:create_divider({
    })
    
    AutoPlay:create_slider({
        title = 'Distance From Ball',
        flag = 'default_distance',
        maximum_value = 100,
        minimum_value = 5,
        value = AutoPlayModule.CONFIG.DEFAULT_DISTANCE,
        round_number = true,
        callback = function(value)
            AutoPlayModule.CONFIG.DEFAULT_DISTANCE = value
        end
    })
    
    AutoPlay:create_slider({
        title = 'Speed Multiplier',
        flag = 'multiplier_threshold',
        maximum_value = 200,
        minimum_value = 10,
        value = AutoPlayModule.CONFIG.MULTIPLIER_THRESHOLD,
        round_number = true,
        callback = function(value)
            AutoPlayModule.CONFIG.MULTIPLIER_THRESHOLD = value
        end
    })
    
    AutoPlay:create_slider({
        title = 'Transversing',
        flag = 'traversing',
        maximum_value = 100,
        minimum_value = 0,
        value = AutoPlayModule.CONFIG.TRAVERSING,
        round_number = true,
        callback = function(value)
            AutoPlayModule.CONFIG.TRAVERSING = value
        end
    })

    AutoPlay:create_slider({
        title = 'Direction',
        flag = 'Direction',
        maximum_value = 1,
        minimum_value = -1,
        value = AutoPlayModule.CONFIG.DIRECTION,
        round_number = false,
        callback = function(value)
            AutoPlayModule.CONFIG.DIRECTION = value
        end
    })

    AutoPlay:create_slider({
        title = 'Offset Factor',
        flag = 'OffsetFactor',
        maximum_value = 1,
        minimum_value = 0.1,
        value = AutoPlayModule.CONFIG.OFFSET_FACTOR,
        round_number = false,
        callback = function(value)
            AutoPlayModule.CONFIG.OFFSET_FACTOR = value
        end
    })

    AutoPlay:create_slider({
        title = 'Movement Duration',
        flag = 'MovementDuration',
        maximum_value = 1,
        minimum_value = 0.1,
        value = AutoPlayModule.CONFIG.MOVEMENT_DURATION,
        round_number = false,
        callback = function(value)
            AutoPlayModule.CONFIG.MOVEMENT_DURATION = value
        end
    })

    AutoPlay:create_slider({
        title = 'Generation Threshold',
        flag = 'GenerationThreshold',
        maximum_value = 0.5,
        minimum_value = 0.1,
        value = AutoPlayModule.CONFIG.GENERATION_THRESHOLD,
        round_number = false,
        callback = function(value)
            AutoPlayModule.CONFIG.GENERATION_THRESHOLD = value
        end
    })

    AutoPlay:create_slider({
        title = 'Jump Chance',
        flag = 'jump_percentage',
        maximum_value = 100,
        minimum_value = 0,
        value = AutoPlayModule.CONFIG.JUMP_PERCENTAGE,
        round_number = true,
        callback = function(value)
            AutoPlayModule.CONFIG.JUMP_PERCENTAGE = value
        end
    })
    
    AutoPlay:create_slider({
        title = 'Double Jump Chance',
        flag = 'double_jump_percentage',
        maximum_value = 100,
        minimum_value = 0,
        value = AutoPlayModule.CONFIG.DOUBLE_JUMP_PERCENTAGE,
        round_number = true,
        callback = function(value)
            AutoPlayModule.CONFIG.DOUBLE_JUMP_PERCENTAGE = value
        end
    })
end

local ballStatsUI
local updateConn

do
local BallStats = misc:create_module({
    title = "Ball Stats",
    flag = "ballStats",
    description = "Displays the current ball speed",
    section = "left",
    callback = function(value)
        if value then
            if not ballStatsUI then
                local player = game.Players.LocalPlayer
                ballStatsUI = Instance.new("ScreenGui")
                ballStatsUI.Name = "BallStatsUI"
                ballStatsUI.ResetOnSpawn = false
                ballStatsUI.DisplayOrder = 9999 
                ballStatsUI.ZIndexBehavior = Enum.ZIndexBehavior.Global -- 🔼 permite sobreposição visual
                ballStatsUI.Parent = player:WaitForChild("PlayerGui") -- ✅ continua no PlayerGui

                local textLabel = Instance.new("TextLabel")
                textLabel.Name = "SpeedDisplay"
                textLabel.Size = UDim2.new(0, 180, 0, 24)
                textLabel.Position = UDim2.new(0, 10, 0, 10) -- ⚠️ EXATO MESMO LUGAR
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.new(1, 1, 1)
                textLabel.Font = Enum.Font.Gotham
                textLabel.TextSize = 15 -- só um pouco maior
                textLabel.Text = "0.0"
                textLabel.ZIndex = 9999 -- 🧠 por cima de tudo
                textLabel.Parent = ballStatsUI

                updateConn = game:GetService("RunService").RenderStepped:Connect(function()
                    local Balls = Auto_Parry.Get_Balls() or {}
                    local speedShown = false

                    for _, Ball in ipairs(Balls) do
                        local zoomies = Ball:FindFirstChild("zoomies")
                        if zoomies then
                            local speed = zoomies.VectorVelocity.Magnitude
                            textLabel.Text = ("%.12f"):format(speed)
                            speedShown = true
                            break
                        end
                    end

                    if not speedShown then
                        textLabel.Text = "0.0"
                    end
                end)
            end
        else
            if updateConn then
                updateConn:Disconnect()
                updateConn = nil
            end
            if ballStatsUI then
                ballStatsUI:Destroy()
                ballStatsUI = nil
            end
        end
    end
})
end

do
local VisualRing = misc:create_module({
    title = 'Visual Ring',
    flag = 'Visual_Ring',
    description = 'Displays a visual ring around the character',
    section = 'left',
    callback = function(state: boolean)
        Configs.visual_ring = state
        if state then
            Notification.new("success","Visual Ring","Enabled",true,0.5)
        else
            Notification.new("error","Visual Ring","Disabled",true,0.5)
        end
    end
})

local Plushie = misc:create_module({
    title = 'Plushie',
    flag = 'Plushie_Enabled',
    description = 'Enable or disable plushie companion',
    section = 'left',
    callback = function(state: boolean)
        Configs.plushie_enabled = state
        if state then
            Notification.new("success","Plushie","Enabled",true,0.5)
        else
            Notification.new("error","Plushie","Disabled",true,0.5)
        end
    end
})

Plushie:create_dropdown({
    title = "Plushie Type",
    flag = "Plushie_Type",
    options = {"Miku", "SpongeBob", "Patrick", "Sonic", "Shion", "Kaito", "Reimu", "Len", "Bear", "Frieren"},
    maximum_options = 10,
    multi_dropdown = false,
    callback = function(opt: string)
        Configs.plushie_type = opt
        Notification.new("success","Plushie","Type set to "..opt,true,0.5)
    end
})

Plushie:create_textbox({
    title = "Custom Plushie",
    placeholder = "Enter plushie name",
    flag = "Custom_Plushie",
    callback = function(text: string)
        if Configs.plushie_type == "Custom" then
            Configs.plushie_type = text
            Notification.new("success","Plushie","Custom plushie: "..text,true,0.5)
        end
    end
})

local ballTrailModule = misc:create_module({
    title = "Ball Trail",
    description = "Enable trail effect on the ball",
    section = "right",
    flag = "ball_trail_module",
    callback = function(state)
        Configs.ball_trail_enabled = state
        if state then
            Notification.new("success","Ball Trail","Enabled",true,0.5)
        else
            Notification.new("error","Ball Trail","Disabled",true,0.5)
        end
    end
})

ballTrailModule:create_colorpicker({
    title = "Trail Color",
    default = Configs.ball_trail_color or Color3.fromRGB(255,0,0),
    flag = "ball_trail_color",
    callback = function(c, a)
        Configs.ball_trail_color = c
        Notification.new("success","Ball Trail","Color updated",true,0.5)
    end
})

local playerTrailModule = misc:create_module({
    title = "Player Trail",
    description = "Enable trail effect on your character",
    section = "right",
    flag = "player_trail_module",
    callback = function(state)
        Configs.player_trail_enabled = state
        if state then
            Notification.new("success","Player Trail","Enabled",true,0.5)
        else
            Notification.new("error","Player Trail","Disabled",true,0.5)
        end
    end
})

playerTrailModule:create_colorpicker({
    title = "Trail Color",
    default = Configs.player_trail_color or Color3.fromRGB(0,255,255),
    flag = "player_trail_color",
    callback = function(c, a)
        Configs.player_trail_color = c
        Notification.new("success","Player Trail","Color updated",true,0.5)
    end
})
end

    local visualPart

do
    local Visualiser = misc:create_module({
        title = 'Visualiser',
        flag = 'Visualiser',
        description = 'Parry Range Visualiser',
        section = 'right',
        callback = function(value: boolean)
            if value then
                if not visualPart then
                    visualPart = Instance.new("Part")
                    visualPart.Name = "VisualiserPart"
                    visualPart.Shape = Enum.PartType.Ball
                    visualPart.Material = Enum.Material.ForceField
                    -- Initial color; will be overridden by slider/checkbox callbacks
                    visualPart.Color = Color3.fromRGB(255, 255, 255)
                    visualPart.Transparency = 0  
                    visualPart.CastShadow = false 
                    visualPart.Anchored = true
                    visualPart.CanCollide = false
                    visualPart.Parent = workspace
                end
    
                Connections_Manager['Visualiser'] = game:GetService("RunService").RenderStepped:Connect(function()
                    local character = LocalPlayer.Character
                    local HumanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart and visualPart then
                        visualPart.CFrame = HumanoidRootPart.CFrame  
                    end
    
                    if getgenv().VisualiserRainbow then
                        local hue = (tick() % 5) / 5
                        visualPart.Color = Color3.fromHSV(hue, 1, 1)
                    else
                        local hueVal = getgenv().VisualiserHue or 0
                        visualPart.Color = Color3.fromHSV(hueVal / 360, 1, 1)
                    end
    
                    local speed = 0
                    local maxSpeed = 350 
                    local Balls = Auto_Parry.Get_Balls()
    
                    for _, Ball in pairs(Balls) do
                        if Ball and Ball:FindFirstChild("zoomies") then
                            local Velocity = Ball.AssemblyLinearVelocity
                            speed = math.min(Velocity.Magnitude, maxSpeed) / 6.5  
                            break
                        end
                    end
    
                    local size = math.max(speed, 6.5)
                    if visualPart then
                        visualPart.Size = Vector3.new(size, size, size)
                    end
                end)
            else
                if Connections_Manager['Visualiser'] then
                    Connections_Manager['Visualiser']:Disconnect()
                    Connections_Manager['Visualiser'] = nil
                end
    
                if visualPart then
                    visualPart:Destroy()
                    visualPart = nil
                end
            end
        end
    })


    Visualiser:create_checkbox({
        title = 'Rainbow',
        flag = 'VisualiserRainbow',
        callback = function(value)
            getgenv().VisualiserRainbow = value
        end
    })

    Visualiser:create_slider({
        title = 'Color Hue',
        flag = 'VisualiserHue',
        minimum_value = 0,
        maximum_value = 360,
        value = 0,
        callback = function(value)
            getgenv().VisualiserHue = value
        end
    })
    

    local AutoClaimRewards = misc:create_module({
        title = 'Auto Claim Rewards',
        flag = 'AutoClaimRewards',
        description = 'Automatically claims rewards.',
        section = 'left',
        callback = function(value: boolean)
            getgenv().AutoClaimRewards = value
            if value then
                local rs = game:GetService("ReplicatedStorage")
                local net = rs:WaitForChild("Packages")
                    :WaitForChild("_Index")
                    :WaitForChild("sleitnick_net@0.1.0")
                    :WaitForChild("net")
                    
                task.spawn(function()
                    net["RF/RedeemQuestsType"]:InvokeServer("Battlepass", "Weekly")
                    net["RF/RedeemQuestsType"]:InvokeServer("Battlepass", "Daily")
                    net["RF/ClaimAllDailyMissions"]:InvokeServer("Daily")
                    net["RF/ClaimAllDailyMissions"]:InvokeServer("Weekly")
                    net["RF/ClaimAllClanBPQuests"]:InvokeServer()
        
                    local joinTimestamp = tonumber(plr:GetAttribute("JoinedTimestamp")) + 10
                    for i = 1, 6 do
                        while workspace:GetServerTimeNow() < joinTimestamp + (i * 300) + 1 do
                            task.wait(1)
                            if not getgenv().AutoClaimRewards then 
                                return 
                            end
                        end
                        net["RF/ClaimPlaytimeReward"]:InvokeServer(i)
                    end
                end)
            end
        end
    })

    local DisableQuantumEffects = misc:create_module({
        title = 'Disable Quantum Arena Effects',
        flag = 'NoQuantumEffects',
        description = 'Disables Quantum Arena effects.',
        section = 'right',
        callback = function(value: boolean)
            getgenv().NoQuantumEffects = value
            if value then
                task.spawn(function()
                    local quantumfx
                    while task.wait() and getgenv().NoQuantumEffects and not quantumfx do
                        for _, v in getconnections(ReplicatedStorage.Remotes.QuantumArena.OnClientEvent) do
                            quantumfx = v
                            v:Disable()
                        end
                    end
                end)
            end
        end
    })

    local No_Render = misc:create_module({
        title = 'No Render',
        flag = 'No_Render',
        description = 'Disables rendering of effects',
        section = 'left',
        
        callback = function(state)
            LocalPlayer.PlayerScripts.EffectScripts.ClientFX.Disabled = state
    
            if state then
                ConnectionsManager['No Render'] = workspace.Runtime.ChildAdded:Connect(function(Value)
                    Debris:AddItem(Value, 0)
                end)
            else
                if ConnectionsManager['No Render'] then
                    ConnectionsManager['No Render']:Disconnect()
                    ConnectionsManager['No Render'] = nil
                end
            end
        end
    })

    local announcerConnection
local winnerConnection

local CustomAnnouncer = misc:create_module({
    title = 'Custom Announcer',
    flag = 'Custom_Announcer',
    description = 'Customize the game announcements',
    section = 'right',
    callback = function(state: boolean)
        if state then
            local Announcer = Player.PlayerGui:WaitForChild("announcer")
            local Winner = Announcer:FindFirstChild("Winner")
            if Winner then
                Winner.Text = Configs.announcer_text or "discord.gg/Riser"
            end

            announcerConnection = Announcer.ChildAdded:Connect(function(Value)
                if Value.Name == "Winner" then
                    -- kalau sebelumnya ada koneksi, disconnect dulu
                    if winnerConnection then winnerConnection:Disconnect() end
                    winnerConnection = Value.Changed:Connect(function(Property)
                        if Property == "Text" and Configs.Custom_Announcer then
                            Value.Text = Config.announcer_text or "discord.gg/Riser"
                        end
                    end)

                    if Configs.Custom_Announcer then
                        Value.Text = Configs.announcer_text or "discord.gg/Riser"
                    end
                end
            end)

        else
            -- Matikan semua koneksi saat OFF
            if announcerConnection then announcerConnection:Disconnect() announcerConnection = nil end
            if winnerConnection then winnerConnection:Disconnect() winnerConnection = nil end
        end
    end
})

CustomAnnouncer:create_textbox({
    title = "Custom Announcement Text",
    placeholder = "Enter custom announcer text... ",
    flag = "announcer_text",
    callback = function(text)
        Configs.announcer_text = text

        if Config.Custom_Announcer then
            local Announcer = Player.PlayerGui:WaitForChild("announcer")
            local Winner = Announcer:FindFirstChild("Winner")
            if Winner then
                Winner.Text = text
            end
        end
    end
})
end

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, root)
    if root.Parent and root.Parent ~= LocalPlayer.Character then
        if root.Parent.Parent ~= workspace.Alive then
            return
        end
    end

    Auto_Parry.Closest_Player()

    local Ball = Auto_Parry.Get_Ball()

    if not Ball then
        return
    end

    local ball_properties = AutoParry.ball.properties

    local Target_Distance = (LocalPlayer.Character.PrimaryPart.Position - Closest_Entity.PrimaryPart.Position).Magnitude
    local Distance = ball_properties.distance
    local Direction = ball_properties.direction
    local Dot = ball_properties.dot

    local Curve_Detected = Auto_Parry.Is_Curved()

    if Target_Distance < 15 and Distance < 15 and Dot > 0 then -- wtf ?? maybe the big issue
        if Curve_Detected then
            Auto_Parry.Parry(Selected_Parry_Type)
        end
    end

    if not Grab_Parry then
        return
    end

    Grab_Parry:Stop()
end)

ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
    if LocalPlayer.Character.Parent ~= workspace.Alive then
        return
    end

    if not Grab_Parry then
        return
    end

    Grab_Parry:Stop()
end)

workspace.Balls.ChildAdded:Connect(function()
    Parried = false
end)

workspace.Balls.ChildRemoved:Connect(function(Value)
    Parries = 0
    Parried = false

    if ConnectionsManager['Target Change'] then
        ConnectionsManager['Target Change']:Disconnect()
        ConnectionsManager['Target Change'] = nil
    end
end)




main:load()  












