--[[ 💻 Hacker GUI v1.0 by Santiago - Roblox Delta Android Compatible ⚙️ Explorador interactivo de objetos/mapa/scripts + buscador, copiar, ocultar/mostrar 🎨 Estética hacker, animaciones, soporte táctil ]]--

local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local CoreGui = game:GetService("CoreGui") local UIS = game:GetService("UserInputService")

if CoreGui:FindFirstChild("HackerGUI") then CoreGui.HackerGUI:Destroy() end

local gui = Instance.new("ScreenGui", CoreGui) gui.Name = "HackerGUI" gui.ResetOnSpawn = false

-- Función para hacer draggable una GUI local function makeDraggable(frame) local dragging, dragInput, startPos, startInputPos = false

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startInputPos = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - startInputPos
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

end

-- GUI inicial local startFrame = Instance.new("Frame", gui) startFrame.Size = UDim2.new(0, 200, 0, 90) startFrame.Position = UDim2.new(0.5, -100, 0.5, -45) startFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10) startFrame.BackgroundTransparency = 0.1 Instance.new("UICorner", startFrame).CornerRadius = UDim.new(0, 12) makeDraggable(startFrame)

local title = Instance.new("TextLabel", startFrame) title.Size = UDim2.new(1, 0, 0.6, 0) title.Position = UDim2.new(0, 0, 0, 0) title.BackgroundTransparency = 1 title.Text = "💀 HACKER GUI" title.TextColor3 = Color3.fromRGB(0, 255, 0) title.Font = Enum.Font.Code title.TextSize = 18

local startBtn = Instance.new("TextButton", startFrame) startBtn.Size = UDim2.new(1, 0, 0.4, 0) startBtn.Position = UDim2.new(0, 0, 0.6, 0) startBtn.Text = "🚀 Empezar" startBtn.Font = Enum.Font.Code startBtn.TextSize = 20 startBtn.TextColor3 = Color3.fromRGB(0, 255, 0) startBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)

-- GUI Principal local mainGui = Instance.new("Frame", gui) mainGui.Visible = false mainGui.Size = UDim2.new(0.9, 0, 0.75, 0) mainGui.Position = UDim2.new(0.05, 0, 0.1, 0) mainGui.BackgroundColor3 = Color3.fromRGB(5, 5, 5) mainGui.BackgroundTransparency = 0.1 Instance.new("UICorner", mainGui).CornerRadius = UDim.new(0, 14) makeDraggable(mainGui)

-- Panel Izquierdo: Explorador local explorer = Instance.new("ScrollingFrame", mainGui) explorer.Size = UDim2.new(0.5, -5, 1, -10) explorer.Position = UDim2.new(0, 5, 0, 5) explorer.BackgroundColor3 = Color3.fromRGB(15, 15, 15) explorer.CanvasSize = UDim2.new(0, 0, 5, 0) explorer.AutomaticCanvasSize = Enum.AutomaticSize.Y explorer.ScrollBarThickness = 4 explorer.BorderSizePixel = 0 Instance.new("UICorner", explorer).CornerRadius = UDim.new(0, 10)

-- Rellenar con objetos del juego local function addExplorerContent() for i, obj in pairs(workspace:GetDescendants()) do local item = Instance.new("TextButton") item.Size = UDim2.new(1, -10, 0, 22) item.Text = obj:GetFullName() item.TextXAlignment = Enum.TextXAlignment.Left item.BackgroundColor3 = Color3.fromRGB(30, 30, 30) item.TextColor3 = Color3.fromRGB(0, 255, 0) item.Font = Enum.Font.Code item.TextSize = 12 item.Name = obj:GetFullName() item.Parent = explorer

item.MouseButton1Click:Connect(function()
        for _, child in ipairs(explorer:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end
        end
        item.BackgroundColor3 = Color3.fromRGB(0, 60, 0)
        _G.SelectedObject = obj
    end)
end

end addExplorerContent()

-- Panel Derecho: Opciones local sidePanel = Instance.new("Frame", mainGui) sidePanel.Size = UDim2.new(0.5, -10, 1, -10) sidePanel.Position = UDim2.new(0.5, 5, 0, 5) sidePanel.BackgroundColor3 = Color3.fromRGB(10, 10, 10) Instance.new("UICorner", sidePanel).CornerRadius = UDim.new(0, 10)

-- Buscador local search = Instance.new("TextBox", sidePanel) search.PlaceholderText = "🔍 Buscar..." search.Size = UDim2.new(1, -10, 0, 30) search.Position = UDim2.new(0, 5, 0, 5) search.BackgroundColor3 = Color3.fromRGB(20, 20, 20) search.TextColor3 = Color3.fromRGB(0, 255, 0) search.Font = Enum.Font.Code search.TextSize = 14 Instance.new("UICorner", search).CornerRadius = UDim.new(0, 6)

search:GetPropertyChangedSignal("Text"):Connect(function() for _, btn in ipairs(explorer:GetChildren()) do if btn:IsA("TextButton") then btn.Visible = string.find(string.lower(btn.Text), string.lower(search.Text), 1, true) ~= nil end end end)

-- Botón Copiar local copyBtn = Instance.new("TextButton", sidePanel) copyBtn.Size = UDim2.new(1, -10, 0, 30) copyBtn.Position = UDim2.new(0, 5, 0, 45) copyBtn.Text = "📋 Copiar" copyBtn.TextColor3 = Color3.fromRGB(0, 255, 0) copyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) copyBtn.Font = Enum.Font.Code copyBtn.TextSize = 14 Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

copyBtn.MouseButton1Click:Connect(function() if _G.SelectedObject then setclipboard(_G.SelectedObject:GetFullName()) end end)

-- Botón Cerrar GUI local closeBtn = Instance.new("TextButton", sidePanel) closeBtn.Size = UDim2.new(1, -10, 0, 30) closeBtn.Position = UDim2.new(0, 5, 0, 85) closeBtn.Text = "❌ Cerrar GUI" closeBtn.TextColor3 = Color3.fromRGB(255, 0, 0) closeBtn.BackgroundColor3 = Color3.fromRGB(30, 10, 10) closeBtn.Font = Enum.Font.Code closeBtn.TextSize = 14 Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Botón para volver a abrir local openBtn = Instance.new("TextButton", gui) openBtn.Size = UDim2.new(0, 120, 0, 30) openBtn.Position = UDim2.new(0, 10, 1, -40) openBtn.Text = "📂 Abrir GUI" openBtn.TextColor3 = Color3.fromRGB(0, 255, 0) openBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10) openBtn.Font = Enum.Font.Code openBtn.TextSize = 14 openBtn.Visible = false Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 6) makeDraggable(openBtn)

closeBtn.MouseButton1Click:Connect(function() mainGui.Visible = false openBtn.Visible = true end)

openBtn.MouseButton1Click:Connect(function() mainGui.Visible = true openBtn.Visible = false end)

-- Animación de inicio startBtn.MouseButton1Click:Connect(function() startFrame:TweenPosition(UDim2.new(0.5, -100, 1.5, 0), "Out", "Quad", 0.5, true) wait(0.5) startFrame.Visible = false mainGui.Visible = true end)

