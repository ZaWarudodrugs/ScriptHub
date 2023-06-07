    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Splix"))()

    local window = library:new({textsize = 13.5,font = Enum.Font.RobotoMono,name = "ZiasHub",color = Color3.fromRGB(225,58,81)})
       
       local tab = window:page({name = "Aimbot"})
       
       local section1 = tab:section({name = "Aimbot",side = "left",size = 250})
       section1:toggle({name = "toggle",def = false,callback = function(value)
        tog = value
        print(tog)
      end})
       
      section1:button({
        Name = "AutoGreen",
        Description = 'hold E',
        Callback = function()
            local UserInputService = game:GetService("UserInputService")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local bar = player.Backpack.ActionValues.Power
            local initialPower = bar.Value
            local executed = false -- Flag variable to track execution
            local function onKeyPress(input)
                if input.KeyCode == Enum.KeyCode.E then
                    if not executed and bar.Value >= _G.valshoot then
                        executed = true -- Set the flag to true to prevent further execution
                        Players.LocalPlayer.Backpack.PlayerEvents.Shooting:FireServer(false, "Shooting", "Standing Shot")
                        print("Shot released")
                        wait(3)
                        executed = false
                    end
                end
            end
            UserInputService.InputBegan:Connect(onKeyPress)
            bar:GetPropertyChangedSignal("Value"):Connect(function()
                if not executed and bar.Value >= _G.valshoot and UserInputService:IsKeyDown(Enum.KeyCode.E) then
                    executed = true -- Set the flag to true to prevent further execution
                    Players.LocalPlayer.Backpack.PlayerEvents.Shooting:FireServer(false, "Shooting", "Standing Shot")
                    print("Shot released")
                    wait(3)
                    executed = false
                end
            end)
        end,
    })
    
    section1:slider{
        Name = "All Meter Aimbot Configuration",
        Description = "Make sure you adjust this before using the aimbot.",
        Max = 70,
        Min = 56,
        Default = 63,
        Callback = function(valuecall)
            _G.valshoot = valuecall
        end,
    }
    
    section1:button({name = "AntiContest",callback = function()
        local player = game.Players.LocalPlayer
    local humanoid = player.Character.Humanoid
    
    local targetHipHeight = 10 -- Adjust this value to change the height
    local originalHipHeight = humanoid.HipHeight
    local isTeleporting = false
    
    local function teleportToAir()
        if isTeleporting then return end
        
        isTeleporting = true
        humanoid.HipHeight = targetHipHeight
        
        wait(1) -- Adjust this value to change the duration in seconds
        
        humanoid.HipHeight = originalHipHeight
        isTeleporting = false
    end
    
    -- Detect when the "E" key is pressed
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.E then
            teleportToAir()
        end
    end)
    
     end})
    
     print("inf stamina")
      local tab = window:page({name = "Character"})
      local section1 = tab:section({name = "Character",side = "left",size = 250})
      
      section1:button({name = "InfStamina",callback = function()
         print('hot ui lib')
      end})local stam = game:GetService("Players").LocalPlayer.Backpack.ActionValues.Stamina
      local stamhook;
      stamhook = hookmetamethod(game, "__index", function(self, v)
      if self == stam and v == "Value" then
          return 67
      end
      return stamhook(self, v)
      end)
      
      section1:slider({Name = "WalkSpeed",
      Default = 10,
      Min = 1,
      Max = 16,
      rounding = true,
      ticking = false,
      measuring = "",
      Callback = function(ws)
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ws
      end
      })
      print("ball mag")
      local tab = window:page({name = "Mags"})
      local section1 = tab:section({name = "Mags",side = "left",size = 250})
      
      
      section1:button({name = "Mags",callback = function()
         local ballMagnet = script.Parent
      local magnetRange = 20
      
      local function isBall(part)
          return part:IsA("BasePart") and part.Name == "Ball"
      end
      
      local function attractBall()
          local player = game.Players.LocalPlayer
          local character = player.Character
          local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
      
          if not humanoidRootPart then
              return
          end
      
          while humanoidRootPart:IsDescendantOf(workspace) do
              local ballsFolder = workspace:FindFirstChild("Balls")
      
              if ballsFolder then
                  for _, ball in ipairs(ballsFolder:GetChildren()) do
                      if isBall(ball) and (ball.Position - humanoidRootPart.Position).Magnitude <= magnetRange then
                          local direction = (humanoidRootPart.Position - ball.Position).Unit
                          ball.Velocity = direction * 50
                      end
                  end
              end
      
              wait()
          end
      end
      
      attractBall()
      end})
    
    
    
    
    
      print("AutoGuard")
      local tab = window:page({name = "AutoGuard"})
      local section1 = tab:section({name = "AutoGuard",side = "left",size = 250})
    
      section1:button({name = "AutoGuard",callback = function()
        local followDistance = 10 -- Adjust this value to set the follow distance
    local speed = 16 -- Adjust this value to change the movement speed
    local isFollowing = false -- Keeps track of whether the character is currently following a player
    
    -- Function to find the nearest player with a ball
    local function findNearestPlayer()
        local players = game:GetService("Players"):GetPlayers()
        local closestPlayer = nil
        local closestDistance = math.huge
    
        local myPosition = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
    
        for _, player in ipairs(players) do
            if player ~= game:GetService("Players").LocalPlayer then
                local character = player.Character
                if character and character:FindFirstChild("Ball") then
                    local distance = (character.HumanoidRootPart.Position - myPosition).magnitude
                    if distance < closestDistance then
                        closestPlayer = player
                        closestDistance = distance
                    end
                end
            end
        end
    
        return closestPlayer
    end
    
    -- Function to make the character move towards the nearest player
    local function moveToNearestPlayer()
        local playerToFollow = findNearestPlayer()
    
        if playerToFollow then
            local humanoidRootPart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
            local targetPosition = playerToFollow.Character.HumanoidRootPart.Position
    
            while playerToFollow.Character and humanoidRootPart and isFollowing do
                humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(CFrame.new(targetPosition), speed / targetPosition.magnitude)
                humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, targetPosition)
                wait()
                targetPosition = playerToFollow.Character.HumanoidRootPart.Position
            end
        end
    end
    
    -- Key binding
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.G then
            isFollowing = true
            moveToNearestPlayer()
        end
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.G then
            isFollowing = false
        end
    end)
     end})
