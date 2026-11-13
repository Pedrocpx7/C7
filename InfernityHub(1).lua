local InfernityUI=(function()
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local Library = {Version = "1.0.2", Name="Senior Orbit"}
local Icons = {
    ["play"] = "rbxassetid://135609604299893",
    ["pencil"] = "rbxassetid://137986121120732",
    ["plus"] = "rbxassetid://111774323017047",
    ["trash-2"] = "rbxassetid://109843431391323",
    ["house"] = "rbxassetid://98755624629571",
    ["layers"] = "rbxassetid://81973586053257",
    ["sliders-horizontal"] = "rbxassetid://85538382643347",
    ["settings"] = "rbxassetid://80758916183665",
    ["search"] = "rbxassetid://121018724060431",
    ["x"] = "rbxassetid://110786993356448",
    ["minus"] = "rbxassetid://118026365011536",
    ["chevron-down"] = "rbxassetid://134243273101015",
    ["chevron-right"] = "rbxassetid://92473583511724",
    ["check"] = "rbxassetid://93898873302694",
    ["bell"] = "rbxassetid://97392696311902",
    ["palette"] = "rbxassetid://86350350950064",
    ["keyboard"] = "rbxassetid://121474456068237",
    ["external-link"] = "rbxassetid://129331830773832",
    ["code"] = "rbxassetid://107380207681249",
    ["layout-grid"] = "rbxassetid://81344910161871",
    ["user"] = "rbxassetid://81589895647169",
    ["shield"] = "rbxassetid://110987169760162",
    ["sparkles"] = "rbxassetid://138635884129147",
    ["rotate-ccw"] = "rbxassetid://110116685948665",
    ["menu"] = "rbxassetid://77021539815611",
    ["maximize"] = "rbxassetid://76045941763188",
    ["copy"] = "rbxassetid://78979572434545",
    ["info"] = "rbxassetid://124560466474914",
    ["circle-check"] = "rbxassetid://85262178816537",
    ["crosshair"] = "rbxassetid://134242818164054",
    ["eye"] = "rbxassetid://100033680381365",
    ["boxes"] = "rbxassetid://136372617578355",
    ["swords"] = "rbxassetid://81872698913435",
    ["grip"] = "rbxassetid://109058783556768",
    ["save"] = "rbxassetid://126116963775616",
    ["folder"] = "rbxassetid://80846616596607",
    ["sun"] = "rbxassetid://110150589884127",
    ["moon"] = "rbxassetid://83380517901735",
}
local C = Color3.fromRGB
local themes = {
 Blossom={Background=C(27,28,29),Sidebar=C(22,23,24),Panel=C(34,36,38),Hover=C(46,49,52),Stroke=C(48,50,53),Text=C(226,229,234),Muted=C(139,144,151),Accent=C(122,171,224)},
 Afterglow={Background=C(29,24,22),Sidebar=C(24,20,19),Panel=C(39,32,28),Hover=C(53,43,36),Stroke=C(60,48,39),Text=C(238,229,220),Muted=C(161,143,130),Accent=C(233,163,113)},
 Ocean={Background=C(17,24,30),Sidebar=C(13,20,26),Panel=C(24,34,42),Hover=C(33,46,57),Stroke=C(42,55,65),Text=C(223,237,245),Muted=C(132,158,174),Accent=C(107,191,218)},
 Rose={Background=C(28,23,29),Sidebar=C(23,19,24),Panel=C(39,31,40),Hover=C(52,42,53),Stroke=C(59,46,61),Text=C(240,227,238),Muted=C(165,140,160),Accent=C(218,145,181)},
 Forest={Background=C(20,28,24),Sidebar=C(17,23,20),Panel=C(28,38,33),Hover=C(39,52,44),Stroke=C(46,59,51),Text=C(226,238,228),Muted=C(141,164,148),Accent=C(133,194,156)},
 Graphite={Background=C(25,25,26),Sidebar=C(20,20,21),Panel=C(34,34,36),Hover=C(46,46,49),Stroke=C(51,51,54),Text=C(231,232,235),Muted=C(147,148,153),Accent=C(185,190,203)},
 Frostbite={Background=C(21,27,34),Sidebar=C(17,22,28),Panel=C(29,37,46),Hover=C(42,54,66),Stroke=C(46,59,72),Text=C(228,240,249),Muted=C(137,159,178),Accent=C(133,205,241)},
 Volt={Background=C(23,27,22),Sidebar=C(18,22,17),Panel=C(31,37,29),Hover=C(45,55,37),Stroke=C(52,62,43),Text=C(234,243,225),Muted=C(148,164,130),Accent=C(183,229,92)},
 Obsidian={Background=C(17,16,21),Sidebar=C(13,12,17),Panel=C(25,23,31),Hover=C(38,33,48),Stroke=C(43,36,54),Text=C(232,226,243),Muted=C(144,133,163),Accent=C(170,139,222)},
 ["Sakura Drift"]={Background=C(31,24,29),Sidebar=C(26,19,24),Panel=C(43,32,39),Hover=C(58,42,52),Stroke=C(65,46,58),Text=C(249,230,240),Muted=C(175,144,161),Accent=C(240,158,194)},
 ["Neon Mirage"]={Background=C(17,25,28),Sidebar=C(12,20,23),Panel=C(24,35,39),Hover=C(31,49,53),Stroke=C(35,57,60),Text=C(222,247,245),Muted=C(129,173,171),Accent=C(79,225,203)},
 ["Copper Dust"]={Background=C(30,26,23),Sidebar=C(24,21,19),Panel=C(41,35,30),Hover=C(56,46,37),Stroke=C(66,53,41),Text=C(241,230,215),Muted=C(170,150,126),Accent=C(200,149,105)},
 Abyss={Background=C(10,20,28),Sidebar=C(7,15,22),Panel=C(16,29,40),Hover=C(23,41,56),Stroke=C(28,48,64),Text=C(221,238,250),Muted=C(116,149,173),Accent=C(80,162,219)},
 Porcelain={Background=C(238,238,233),Sidebar=C(227,228,225),Panel=C(248,248,244),Hover=C(216,220,225),Stroke=C(198,201,204),Text=C(38,42,49),Muted=C(111,117,125),Accent=C(91,134,191)},
}
themes.Crimson={Background=C(14,14,16),Sidebar=C(8,8,9),Panel=C(25,25,28),Hover=C(45,34,37),Stroke=C(63,50,53),Text=C(255,255,255),Muted=C(190,182,184),Accent=C(199,34,51)}
themes.Orqan={Background=C(16,15,20),Sidebar=C(14,13,18),Panel=C(20,19,26),Hover=C(28,26,35),Stroke=C(31,29,38),Text=C(236,235,240),Muted=C(116,113,129),Accent=C(229,65,98)}
local function accentInk(color)
    local function linear(v) return v<=.04045 and v/12.92 or ((v+.055)/1.055)^2.4 end
    local light=.2126*linear(color.R)+.7152*linear(color.G)+.0722*linear(color.B)
    return 1.05/(light+.05)>=4.5 and C(255,255,255) or C(10,14,20)
end
for _, theme in pairs(themes) do
    theme.Inline=theme.Stroke:Lerp(theme.Panel,.5); theme.Gradient=C(255,255,255); theme.Shadow=C(0,0,0); theme.White=C(255,255,255); theme.Black=C(0,0,0); theme.Online=C(63,195,132); theme.AccentText=accentInk(theme.Accent)
end
local function make(class, props, parent)
    local obj = Instance.new(class)
    for key, value in pairs(props or {}) do obj[key] = value end
    obj.Parent = parent
    return obj
end
local function corner(obj, radius) make("UICorner", {CornerRadius=UDim.new(0,radius or 8)}, obj) end
local function pad(obj, x, y)
    make("UIPadding", {PaddingLeft=UDim.new(0,x),PaddingRight=UDim.new(0,x),PaddingTop=UDim.new(0,y or x),PaddingBottom=UDim.new(0,y or x)},obj)
end
local function list(obj, gap, horizontal)
    return make("UIListLayout", {Padding=UDim.new(0,gap or 8),SortOrder=Enum.SortOrder.LayoutOrder,FillDirection=horizontal and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical},obj)
end
local function tween(obj, props)
    TweenService:Create(obj,TweenInfo.new(.17,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),props):Play()
end
local function copy(value) if typeof(value)=="table" then local t={} for k,v in pairs(value) do t[k]=copy(v) end return t end return value end
local function clamp(v,a,b) return math.max(a,math.min(b,v)) end
local function round(v,step) return math.floor(v/step+.5)*step end
local function options(o) if type(o)=="string" then return {Title=o} end return o or {} end
local function image(name)
    if type(name)=="number" then return "rbxassetid://"..tostring(name) end
    name = tostring(name or "layers")
    if name:match("^rbxassetid://") then return name end
    return Icons[name:gsub("^lucide%-","")] or Icons.layers or ""
end
local function validBinding(key)
    return typeof(key)=="EnumItem" and (key.EnumType==Enum.KeyCode or (key.EnumType==Enum.UserInputType and table.find({"MouseButton1","MouseButton2","MouseButton3"},key.Name)~=nil))
end
local function bindingMatches(input,key) return key.EnumType==Enum.UserInputType and input.UserInputType==key or input.KeyCode==key end
local function inputBinding(input)
    if input.KeyCode and input.KeyCode~=Enum.KeyCode.Unknown then return input.KeyCode end
    if input.UserInputType and table.find({"MouseButton1","MouseButton2","MouseButton3"},input.UserInputType.Name) then return input.UserInputType end
end
local windowCreated = false
function Library:CreateWindow(config)
    config=config or {}
    assert(config.ProfileStore==nil or (type(config.ProfileStore)=="table" and (config.ProfileStore.Profiles==nil or type(config.ProfileStore.Profiles)=="table")),"ProfileStore must be a table with an optional Profiles table")
    local width,height=config.Width or 720,config.Height or 476
    assert(type(width)=="number" and type(height)=="number" and width>=480 and width<=2400 and height>=320 and height<=1800,"Window size must be 480–2400 x 320–1800")
    assert(config.Scale==nil or (type(config.Scale)=="number" and config.Scale>0 and config.Scale<=2),"Scale must be greater than 0 and at most 2")
    local player=Players.LocalPlayer
    assert(player or config.Parent,"Senior Orbit must run on the client")
    local w={_gradients={},_textRecords={},Casing="Normal",Tabs={},Categories={},Sections={},DetachedSections={},Controls={},Flags={},Connections={},_bindings={},_searchables={},_popConnections={},_resultConnections={},_toasts={},Profiles={},Theme=copy(themes[config.Theme] or themes.Crimson),ThemeName=themes[config.Theme] and config.Theme or "Crimson",Visible=true,Destroyed=false,Keybind=config.Keybind or Enum.KeyCode.RightShift}
    if config.Accent then w.Theme.Accent=config.Accent; w.Theme.AccentText=accentInk(config.Accent) end
    function w:Connect(signal,fn) local c=signal:Connect(fn); table.insert(self.Connections,c); return c end
    function w:Bind(obj,property,token) obj[property]=self.Theme[token]; table.insert(self._bindings,{obj,property,token}); return obj end
    function w:Frame(parent,props,token) local f=make("Frame",props,parent); f.BorderSizePixel=0; if token then self:Bind(f,"BackgroundColor3",token) else f.BackgroundTransparency=1 end; return f end
    function w:Text(parent,text,props,token)
        local p={Text=tostring(text or ""),BackgroundTransparency=1,BorderSizePixel=0,Font=Enum.Font.BuilderSans,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left}
        for k,v in pairs(props or {}) do p[k]=v end
        local obj=self:Bind(make("TextLabel",p,parent),"TextColor3",token or "Text")
        local record={Object=obj,Base=obj.Text,Font=obj.Font}; table.insert(self._textRecords,record)
        self:Connect(obj:GetPropertyChangedSignal("Text"),function() if not record.Lock and obj.Text~=record.Expected then record.Base=obj.Text; self:ApplyTextCase(record) end end)
        self:ApplyTextCase(record); return obj
    end
    function w:ApplyTextCase(record)
        local obj=record.Object; if not obj.Parent then return end; if record.Expected and obj.Text~=record.Expected then record.Base=obj.Text end; record.Lock=true
        record.Expected=self.Casing=="Lower Case" and record.Base:lower() or self.Casing=="Upper Case" and record.Base:upper() or record.Base; obj.Text=record.Expected
        obj.Font=self.Casing=="Bold Case" and Enum.Font.BuilderSansBold or record.Font; record.Lock=false
    end
    function w:SetCasing(mode)
        assert(table.find({"Normal","Lower Case","Upper Case","Bold Case"},mode),"Invalid casing")
        self.Casing=mode; for _,record in ipairs(self._textRecords) do self:ApplyTextCase(record) end
    end
    function w:Button(parent,props,token)
        local p={Text="",BorderSizePixel=0,AutoButtonColor=false}; for k,v in pairs(props or {}) do p[k]=v end
        local b=make("TextButton",p,parent); if token then self:Bind(b,"BackgroundColor3",token) elseif p.BackgroundTransparency==nil then b.BackgroundTransparency=1 end
        if token=="Panel" or token=="Hover" then
            self:Connect(b.MouseEnter,function() tween(b,{BackgroundColor3=self.Theme.Hover}) end)
            self:Connect(b.MouseLeave,function() tween(b,{BackgroundColor3=self.Theme[token]}) end)
        end
        if token=="Panel" or token=="Hover" then local gradient=make("UIGradient",{Rotation=90,Color=ColorSequence.new(C(255,255,255),self.Theme.Gradient)},b); table.insert(self._gradients,gradient) end
        return b
    end
    function w:Icon(parent,name,props,token)
        local p={Image=image(name),Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,ScaleType=Enum.ScaleType.Fit,BorderSizePixel=0}; for k,v in pairs(props or {}) do p[k]=v end
        return self:Bind(make("ImageLabel",p,parent),"ImageColor3",token or "Muted")
    end
    function w:Stroke(obj) return self:Bind(make("UIStroke",{Thickness=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},obj),"Color","Stroke") end
    function w:PruneBindings()
        local connected={};for _,connection in ipairs(self.Connections) do if connection.Connected then table.insert(connected,connection) end end;self.Connections=connected
        local gradients={}; for _,gradient in ipairs(self._gradients) do if gradient.Parent then table.insert(gradients,gradient) end end; self._gradients=gradients
        local texts={}; for _,record in ipairs(self._textRecords) do if record.Object.Parent then table.insert(texts,record) end end; self._textRecords=texts
        local live={}; for _,b in ipairs(self._bindings) do if b[1].Parent then table.insert(live,b) end end; self._bindings=live end
    function w:Call(fn,...) if not fn or self.Destroyed then return end; local args=table.pack(...); task.spawn(function() if self.Destroyed then return end; local ok,err=pcall(fn,table.unpack(args,1,args.n)); if not ok then warn("[Senior Orbit callback] "..tostring(err)) end end) end
    function w:CloseSubPopup() if self.SubPopup then self.SubPopup:Destroy(); self.SubPopup=nil; self:PruneBindings(); local live={}; for _,c in ipairs(self.Connections) do if c.Connected then table.insert(live,c) end end; self.Connections=live end end
    function w:ClosePopup()
        self._capturing=nil
        if self._modePopupControl then self._modePopupControl.RefreshKeyMenu=nil;self._modePopupControl=nil end
        if self._popupOnClose then self._popupOnClose();self._popupOnClose=nil end
        self:CloseSubPopup()
        for _,c in ipairs(self._popConnections) do c:Disconnect() end; self._popConnections={}
        if self.Popup then self.Popup:Destroy(); self.Popup=nil end
        local live={}; for _,c in ipairs(self.Connections) do if c.Connected then table.insert(live,c) end end; self.Connections=live; self:PruneBindings()
    end
    function w:Destroy(external)
        if self.Destroyed then return end; self.Destroyed=true; self:ClosePopup()
        for _,c in ipairs(self._resultConnections) do c:Disconnect() end
        for _,c in ipairs(self.Connections) do c:Disconnect() end
        self.Connections={}; self._bindings={}; self._searchables={}; self._resultConnections={}; self._capturing=nil
        for _,section in ipairs(self.Sections) do section._dragging=false end
        self.DetachedSections={}; self._textRecords={}; self._gradients={}
        if self.Gui and not external then self.Gui:Destroy() end
    end
    local parent=config.Parent or player:WaitForChild("PlayerGui")
    for _,old in ipairs(parent:GetChildren()) do
        if old:IsA("ScreenGui") and old.Name=="SeniorHubOrbit" then
            local dispose=old:FindFirstChild("SeniorOrbitDispose"); if dispose then pcall(function() dispose:Invoke() end) end; old:Destroy()
        end
    end
    local gui=make("ScreenGui",{Name="SeniorHubOrbit",ResetOnSpawn=false,IgnoreGuiInset=true,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=config.DisplayOrder or 81},parent); w.Gui=gui
    local dispose=make("BindableFunction",{Name="SeniorOrbitDispose"},gui); dispose.OnInvoke=function() w:Destroy(); return true end
    w:Connect(gui.Destroying,function() w:Destroy(true) end)
    local width,height=config.Width or 720,config.Height or 476; local sidebarWidth=80
    assert(width>=480 and height>=320,"Minimum window size is 480 x 320")
    local root=w:Frame(gui,{Name="OrbitWindow",AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(width,height),ClipsDescendants=true},"Background"); corner(root,16); w:Stroke(root); w.Root=root
    local scale=make("UIScale",{Scale=1},root); w.Scale=scale
    local function fit()
        local size=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or gui.AbsoluteSize
        scale.Scale=math.max(.1,math.min(config.Scale or 1,(size.X-24)/width,(size.Y-50)/height))
        local halfW,halfH=width*scale.Scale/2,height*scale.Scale/2
        local x=root.Position.X.Scale*size.X+root.Position.X.Offset;local y=root.Position.Y.Scale*size.Y+root.Position.Y.Offset
        root.Position=UDim2.fromOffset(clamp(x,halfW+8,math.max(halfW+8,size.X-halfW-8)),clamp(y,halfH+8,math.max(halfH+8,size.Y-halfH-8)))
        if w.Restore then w.Restore.Position=UDim2.fromOffset(clamp(w.Restore.Position.X.Offset,8,math.max(8,size.X-48)),clamp(w.Restore.Position.Y.Offset,8,math.max(8,size.Y-48))) end
        if w.ClampFloatingSections then w:ClampFloatingSections() end; if w.RefreshToasts then w:RefreshToasts() end
    end
    local cameraConnection
    local function bindCamera() if cameraConnection then cameraConnection:Disconnect() end; if workspace.CurrentCamera then cameraConnection=w:Connect(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),fit) end; fit() end
    w:Connect(workspace:GetPropertyChangedSignal("CurrentCamera"),bindCamera); bindCamera()
    local sidebar=w:Frame(root,{Name="IconRail",Size=UDim2.new(0,80,1,0)},"Sidebar");w.Sidebar=sidebar
    corner(sidebar,16)
    w:Frame(sidebar,{
        Name="RailInnerEdge",
        AnchorPoint=Vector2.new(1,0),
        Position=UDim2.fromScale(1,0),
        Size=UDim2.new(0,16,1,0),
        ZIndex=0
    },"Sidebar")
    local drag=w:Button(sidebar,{Name="DragHandle",Modal=true,Size=UDim2.fromOffset(80,67)})
    w:Icon(drag,config.Logo or 110418509405462,{Position=UDim2.fromOffset(20,16),Size=UDim2.fromOffset(40,40)},"White")
    w.TitleLabel=w:Text(drag,config.Title or "Infernity Hub",{Visible=false})
    local nav=make("ScrollingFrame",{Name="Categories",Active=true,Position=UDim2.fromOffset(8,70),Size=UDim2.new(1,-16,1,-132),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageTransparency=.35,ScrollingDirection=Enum.ScrollingDirection.Y,ClipsDescendants=true,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y},sidebar);list(nav,5);w:Bind(nav,"ScrollBarImageColor3","Muted");w.Nav=nav
    local border=w:Frame(root,{Name="ContentBorder",Position=UDim2.fromOffset(80,14),Size=UDim2.new(1,-94,1,-28)});corner(border,7);w:Stroke(border)
    local header=w:Frame(root,{Name="Header",Position=UDim2.fromOffset(81,15),Size=UDim2.new(1,-96,0,46),ZIndex=2})
    local headerDrag=w:Button(header,{Name="WindowDragHandle",Size=UDim2.new(1,-158,1,0),ZIndex=2})
    w.Breadcrumb=w:Text(header,"Combat / Aimbot",{Position=UDim2.fromOffset(10,3),Size=UDim2.new(1,-165,0,20),TextSize=12,ZIndex=3})
    w.Description=w:Text(header,"Customize the product as you wish",{Position=UDim2.fromOffset(10,20),Size=UDim2.new(1,-165,0,18),TextSize=11,ZIndex=3},"Muted")
    w:Frame(header,{Position=UDim2.new(0,0,1,-1),Size=UDim2.new(1,0,0,1),ZIndex=3},"Stroke")
    local pageButton=w:Button(header,{Name="SubtabDropdown",Position=UDim2.new(1,-150,0,7),Size=UDim2.fromOffset(139,30),ZIndex=4})
    w.PageLabel=w:Text(pageButton,"Aimbot",{Position=UDim2.fromOffset(10,0),Size=UDim2.new(1,-34,1,0),TextSize=12,ZIndex=5})
    w:Icon(pageButton,"chevron-down",{Position=UDim2.new(1,-18,0,10),Size=UDim2.fromOffset(10,10),ZIndex=5})
    w:Connect(pageButton.Activated,function()
        if not w.ActiveCategory then return end;local names={};for _,tab in ipairs(w.ActiveCategory.Tabs) do table.insert(names,tab.Title) end
        w:OptionList(pageButton,names,function(name) return w.ActiveTab.Title==name end,function(name) for _,tab in ipairs(w.ActiveCategory.Tabs) do if tab.Title==name then tab:Select();break end end end)
    end)
    w.PageButton=pageButton
    local searchFrame=w:Frame(sidebar,{Visible=false});local search=make("TextBox",{Text="",Visible=false},searchFrame);w.SearchBox=search
    local pages=w:Frame(root,{Name="Pages",Position=UDim2.fromOffset(92,70),Size=UDim2.new(1,-118,1,-84)});w.Pages=pages
    local avatar=w:Button(sidebar,{Name="AvatarSettings",Position=UDim2.new(0,24,1,-49),Size=UDim2.fromOffset(32,32)})
    local avatarPlaceholder=w:Icon(avatar,"user",{Position=UDim2.fromOffset(6,6),Size=UDim2.fromOffset(20,20)},"Muted")
    local avatarImage=make("ImageLabel",{Name="PlayerHeadshot",Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0,ImageColor3=C(255,255,255),ScaleType=Enum.ScaleType.Fit,Image=player and ("rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150") or ""},avatar)
    corner(avatarImage,16);avatar.ClipsDescendants=true;w.AvatarButton=avatar;w.AvatarImage=avatarImage;w.AvatarPlaceholder=avatarPlaceholder
    local function avatarLoaded() if avatarImage.Parent then avatarPlaceholder.Visible=not avatarImage.IsLoaded end end
    w:Connect(avatarImage:GetPropertyChangedSignal("IsLoaded"),avatarLoaded);avatarLoaded()
    local avatarGeneration=0
    function w:RefreshAvatar()
        avatarGeneration=avatarGeneration+1;local generation=avatarGeneration
        if not player or self.Destroyed then return end
        local retryDelays={.35,1,2,4}
        local function fetch(attempt)
            if self.Destroyed or generation~=avatarGeneration or not avatarImage.Parent then return end
            local ok,url,ready=pcall(function() return Players:GetUserThumbnailAsync(player.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150) end)
            if ok and ready==true and type(url)=="string" and url~="" then if avatarImage.Image~=url then avatarImage.Image=url end end
            avatarLoaded()
            if (not ok or ready~=true or not avatarImage.IsLoaded) and retryDelays[attempt] then task.delay(retryDelays[attempt],function() fetch(attempt+1) end) end
        end
        task.spawn(function() fetch(1) end)
    end
    w:RefreshAvatar()
    function w:SetScale(value) assert(type(value)=="number" and value>=.5 and value<=1.25,"Scale must be .5–1.25");config.Scale=value;fit();self:ClosePopup();return self end
    function w:SetNotificationsVisible(value) self.HideNotifications=value~=true;for _,toast in ipairs(self._toasts) do toast.Visible=value==true end end
    function w:OpenUISettings()
        local frame=self:PopupAt(avatar,202,157,{Left=true,OffsetX=40});frame.Name="UISettings"
        local sf=scale.Scale;local view=gui.AbsoluteSize
        frame.Position=UDim2.fromOffset(clamp(avatar.AbsolutePosition.X+40*sf,8,math.max(8,view.X-202*sf-8)),clamp(avatar.AbsolutePosition.Y-130*sf,8,math.max(8,view.Y-157*sf-8)))
        self:Text(frame,"UI Settings",{Position=UDim2.fromOffset(10,3),Size=UDim2.fromOffset(180,23),TextSize=12,ZIndex=204})
        self:Text(frame,"UI Scale",{Position=UDim2.fromOffset(10,28),Size=UDim2.fromOffset(180,20),TextSize=11,ZIndex=204},"Muted")
        local scaleButton=self:Button(frame,{Name="UIScaleField",Position=UDim2.fromOffset(10,51),Size=UDim2.fromOffset(182,25),ZIndex=203},"Panel");corner(scaleButton,3)
        self:Text(scaleButton,tostring(math.floor((config.Scale or 1)*100)).."%",{Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-28,1,0),TextSize=11,ZIndex=204})
        self:Icon(scaleButton,"chevron-down",{Position=UDim2.fromOffset(165,9),Size=UDim2.fromOffset(9,9),ZIndex=204})
        self:Connect(scaleButton.Activated,function() self:OptionList(scaleButton,{"50%","70%","100%","125%"},function(value) return tonumber(value:sub(1,-2))==math.floor((config.Scale or 1)*100) end,function(value) self:SetScale(tonumber(value:sub(1,-2))/100) end,{Nested=true}) end)
        local function setting(title,y,get,set)
            local button=self:Button(frame,{Position=UDim2.fromOffset(10,y),Size=UDim2.fromOffset(182,27),ZIndex=203})
            self:Text(button,title,{Size=UDim2.new(1,-30,1,0),TextSize=11,ZIndex=204},"Muted")
            local track=self:Frame(button,{Position=UDim2.new(1,-25,0,7),Size=UDim2.fromOffset(25,14),ZIndex=204},"Hover");corner(track,10)
            local knob=self:Frame(track,{Size=UDim2.fromOffset(9,9),Position=UDim2.fromOffset(3,2),ZIndex=205},"Muted");corner(knob,10)
            local function refresh() knob.Position=UDim2.fromOffset(get() and 13 or 3,2);knob.BackgroundColor3=get() and self.Theme.Accent or self.Theme.Muted end
            self:Connect(button.Activated,function() set(not get());refresh() end);refresh()
        end
        setting("Hide Notifications",84,function() return self.HideNotifications==true end,function(value) self:SetNotificationsVisible(not value) end)
        setting("Hide Watermark",116,function() return not self.Watermark.Visible end,function(value) self:SetWatermarkVisible(not value) end)
        return frame
    end
    w:Connect(avatar.Activated,function() w:OpenUISettings() end)
    local searchOverlay=w:Frame(root,{Name="SearchModalOverlay",Size=UDim2.fromScale(1,1),Visible=false,ZIndex=180},"Black"); searchOverlay.BackgroundTransparency=.48; w.SearchOverlay=searchOverlay
    local dismissSearch=w:Button(searchOverlay,{Size=UDim2.fromScale(1,1),ZIndex=180})
    local results=w:Frame(searchOverlay,{Name="SearchResults",AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(math.min(480,width-48),math.min(380,height-48)),ZIndex=181},"Sidebar"); corner(results,5); w:Stroke(results); w.SearchPanel=results
    local summary=w:Text(results,"Search",{Position=UDim2.fromOffset(16,12),Size=UDim2.new(1,-32,0,25),TextSize=13,ZIndex=182})
    local modalInput=w:Bind(make("TextBox",{Name="SearchModalInput",Position=UDim2.fromOffset(16,47),Size=UDim2.new(1,-32,0,33),Text="",PlaceholderText="Type to search...",ClearTextOnFocus=false,Font=Enum.Font.BuilderSans,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,ZIndex=183},results),"BackgroundColor3","Panel"); w:Bind(modalInput,"TextColor3","Text"); w:Bind(modalInput,"PlaceholderColor3","Muted"); corner(modalInput,4); pad(modalInput,11,0); w.ModalSearchBox=modalInput
    local resultList=make("ScrollingFrame",{Active=true,Position=UDim2.fromOffset(16,92),Size=UDim2.new(1,-32,1,-106),CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,BorderSizePixel=0,BackgroundTransparency=1,ScrollBarThickness=2,ZIndex=182},results); list(resultList,3); w:Bind(resultList,"ScrollBarImageColor3","Accent")
    local restore=w:Button(gui,{Name="Restore",Position=UDim2.fromOffset(18,160),Size=UDim2.fromOffset(40,40),Visible=false},"Sidebar"); corner(restore,9); w:Stroke(restore); w:Icon(restore,config.Logo or 110418509405462,{Position=UDim2.fromOffset(7,7),Size=UDim2.fromOffset(26,26)},"White"); w.Restore=restore
    function w:PopupAt(anchor,pw,ph,o)
        o=o or {}; self:ClosePopup(); local view=gui.AbsoluteSize
        local popupScale=math.max(.1,math.min(o.Scale or scale.Scale,(view.X-16)/pw,(view.Y-16)/ph))
        local x=clamp((o.Left and anchor.AbsolutePosition.X or anchor.AbsolutePosition.X+anchor.AbsoluteSize.X-pw*popupScale)+(o.OffsetX or 0)*popupScale,8,math.max(8,view.X-pw*popupScale-8))
        local gap=(o.Gap or 4)*popupScale; local y=anchor.AbsolutePosition.Y+anchor.AbsoluteSize.Y+gap
        if y+ph*popupScale>view.Y-8 then y=math.max(8,anchor.AbsolutePosition.Y-ph*popupScale-gap) end
        local overlay=self:Button(gui,{Name="PopupOverlay",Size=UDim2.fromScale(1,1),ZIndex=200}); self.Popup=overlay
        local frame=self:Frame(overlay,{Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(pw,ph),ZIndex=201,ClipsDescendants=true},"Sidebar"); corner(frame,3); self:Stroke(frame); make("UIScale",{Scale=popupScale},frame)
        self:Button(frame,{Size=UDim2.fromScale(1,1),ZIndex=201}); self:Connect(overlay.Activated,function() self:ClosePopup() end); return frame
    end
    w:Connect(UIS.InputBegan,function(input,processed) if input.KeyCode==Enum.KeyCode.Escape and not processed and not w._capturing and w.Popup then if w.SubPopup then w:CloseSubPopup() else w:ClosePopup() end end end)
    function w:OptionList(anchor,values,isSelected,onSelect,o)
        o=o or {}; local sf=o.Scale or scale.Scale
        local pw=math.max(80,anchor.AbsoluteSize.X/math.max(.1,sf)); local ph=math.min(#values,o.MaxVisible or 10)*30+4
        local frame
        if o.Nested then
            self:CloseSubPopup()
            local view=gui.AbsoluteSize; sf=math.max(.1,math.min(sf,(view.X-16)/pw,(view.Y-16)/ph))
            local x=clamp(anchor.AbsolutePosition.X,8,math.max(8,view.X-pw*sf-8)); local y=anchor.AbsolutePosition.Y+anchor.AbsoluteSize.Y+3*sf
            if y+ph*sf>view.Y-8 then y=math.max(8,anchor.AbsolutePosition.Y-ph*sf-3*sf) end
            local overlay=self:Button(gui,{Name="NestedOptionOverlay",Size=UDim2.fromScale(1,1),ZIndex=250}); self.SubPopup=overlay
            frame=self:Frame(overlay,{Name="OptionList",Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(pw,ph),ZIndex=251,ClipsDescendants=true},"Sidebar"); make("UIScale",{Scale=sf},frame); corner(frame,3); self:Stroke(frame)
            self:Connect(overlay.Activated,function() self:CloseSubPopup() end)
        else frame=self:PopupAt(anchor,pw,ph,{Scale=sf,Left=true,Gap=3}); frame.Name="OptionList" end
        self:Bind(frame,"BackgroundColor3","Hover")
        local z=o.Nested and 252 or 202
        local scroll=make("ScrollingFrame",{Name="Options",ScrollingDirection=Enum.ScrollingDirection.Y,ClipsDescendants=true,Position=UDim2.fromOffset(2,2),Size=UDim2.new(1,-4,1,-4),CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,BorderSizePixel=0,Active=true,ScrollBarThickness=2,ZIndex=z},frame); list(scroll,0); self:Bind(scroll,"ScrollBarImageColor3","Accent")
        local entries={}
        local function refresh()
            for _,item in ipairs(entries) do local selected=isSelected(item.Value); item.Bar.Visible=selected; item.Button.BackgroundTransparency=1; item.Label.TextColor3=selected and self.Theme.Text or self.Theme.Muted end
        end
        for index,value in ipairs(values) do
            local button=self:Button(scroll,{Name="Option",LayoutOrder=index,Size=UDim2.new(1,-2,0,30),ZIndex=z+1},"Hover"); corner(button,2)
            local bar=self:Frame(button,{Name="SelectionAccent",Position=UDim2.fromOffset(8,13),Size=UDim2.fromOffset(4,4),ZIndex=z+2},"Accent")
            corner(bar,4)
            local label=self:Text(button,value,{Position=UDim2.fromOffset(19,0),Size=UDim2.new(1,-18,1,0),TextSize=12,ZIndex=z+2},"Muted")
            table.insert(entries,{Value=value,Button=button,Label=label,Bar=bar})
            self:Connect(button.Activated,function() onSelect(value); if frame.Parent then refresh() end end)
        end
        refresh(); local fullSize=frame.Size; frame.Size=UDim2.new(fullSize.X.Scale,fullSize.X.Offset,0,0); tween(frame,{Size=fullSize}); return frame
    end
    function w:RefreshDependencies()
        for _,control in ipairs(self.Controls) do if control.RefreshEnabled then control:RefreshEnabled() end end
    end
    function w:GetDetachedSections()
        local sections={}; for section in pairs(self.DetachedSections) do table.insert(sections,section) end; return sections
    end
    function w:DockAllSections()
        for _,section in ipairs(self:GetDetachedSections()) do section:Dock(false) end
    end
    function w:ClampFloatingSections()
        for section in pairs(self.DetachedSections) do section:RefreshFloatingBounds() end
    end
    w:Connect(gui:GetPropertyChangedSignal("AbsoluteSize"),function() w:ClampFloatingSections() end)
    function w:Toggle(state)
        if self.Destroyed then return end; if state==nil then state=not self.Visible end
        self.Visible=state; root.Visible=state; restore.Visible=not state; if not state then self:CloseSearch() end
        for _,section in ipairs(self.Sections) do section._dragging=false; if section.Float then section.Float.Visible=state and section._visible end end
        self:ClosePopup()
    end
    function w:SetKeybind(key) assert(typeof(key)=="EnumItem" and key.EnumType==Enum.KeyCode,"Expected Enum.KeyCode"); self.Keybind=key end
    local dragging,start,origin,touch,restoreDragging,restoreOrigin,restoreStart,restoreTouch,moved
    w:Connect(drag.InputBegan,function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true; start=i.Position; origin=root.Position; touch=i; w:ClosePopup() end end)
    w:Connect(headerDrag.InputBegan,function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true;start=i.Position;origin=root.Position;touch=i;w:ClosePopup() end end)
    w:Connect(restore.InputBegan,function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then restoreDragging=true; restoreOrigin=restore.Position; restoreStart=i.Position; restoreTouch=i; moved=false end end)
    local suppressRestore=0
    w:Connect(restore.Activated,function() if os.clock()>=suppressRestore then w:Toggle(true) end end)
    w:Connect(UIS.InputChanged,function(i)
        if dragging and (i==touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
            local d=i.Position-start; local view=gui.AbsoluteSize; local actual=root.AbsoluteSize
            root.Position=UDim2.fromOffset(clamp(origin.X.Scale*view.X+origin.X.Offset+d.X,actual.X/2,math.max(actual.X/2,view.X-actual.X/2)),clamp(origin.Y.Scale*view.Y+origin.Y.Offset+d.Y,actual.Y/2,math.max(actual.Y/2,view.Y-actual.Y/2)))
        end
        if restoreDragging and (i==restoreTouch or i.UserInputType==Enum.UserInputType.MouseMovement) then
            local d=i.Position-restoreStart; moved=moved or d.X*d.X+d.Y*d.Y>36; if moved then local v=gui.AbsoluteSize; restore.Position=UDim2.fromOffset(clamp(restoreOrigin.X.Offset+d.X,8,math.max(8,v.X-48)),clamp(restoreOrigin.Y.Offset+d.Y,8,math.max(8,v.Y-48))) end
        end
    end)
    w:Connect(UIS.WindowFocusReleased,function() dragging=false;restoreDragging=false;for _,section in ipairs(w.Sections) do section._dragging=false end;w:ClosePopup() end)
    w:Connect(UIS.InputEnded,function(i) if i==touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end; if i==restoreTouch or i.UserInputType==Enum.UserInputType.MouseButton1 then if moved then suppressRestore=os.clock()+.25 end; restoreDragging=false end end)
    w:Connect(UIS.InputBegan,function(i,processed)
        if processed or UIS:GetFocusedTextBox() or w._capturing then return end
        if i.KeyCode==w.Keybind then w:Toggle() end
    end)
    local watermark=w:Button(gui,{Name="Watermark",AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-14,0,14),Size=UDim2.fromOffset(80,30),Visible=config.Watermark~=false},"Sidebar"); corner(watermark,5); w:Stroke(watermark)
    w:Connect(watermark.Activated,function() w:Toggle() end)
    w:Icon(watermark,config.Logo or 110418509405462,{Position=UDim2.fromOffset(7,5),Size=UDim2.fromOffset(15,15)},"White")
    w.WatermarkText=w:Text(watermark,config.WatermarkText or "Infernity Hub",{Position=UDim2.fromOffset(28,0),Size=UDim2.new(1,-34,1,0),TextSize=10,TextTruncate=Enum.TextTruncate.AtEnd}); w.Watermark=watermark
    local markScale=make("UIScale",{Scale=1},watermark);w.WatermarkScale=markScale
    function w:FitWatermark()
        if self.Destroyed then return end
        local text=self.WatermarkText;local measured
        local ok,bounds=pcall(function() return TextService:GetTextSize(text.Text,text.TextSize,text.Font,Vector2.new(16384,64)) end)
        if ok and bounds then measured=bounds.X else measured=(utf8.len(text.Text) or #text.Text)*(text.TextSize or 10)*.54 end
        local contentWidth=math.max(80,math.ceil(measured)+36)
        watermark.Size=UDim2.fromOffset(contentWidth,30);self.WatermarkContentWidth=contentWidth
        markScale.Scale=math.max(.05,math.min(1,(gui.AbsoluteSize.X-28)/contentWidth))
    end
    w:Connect(w.WatermarkText:GetPropertyChangedSignal("Text"),function() w:FitWatermark() end)
    w:Connect(w.WatermarkText:GetPropertyChangedSignal("TextSize"),function() w:FitWatermark() end)
    w:Connect(w.WatermarkText:GetPropertyChangedSignal("Font"),function() w:FitWatermark() end)
    w:Connect(gui:GetPropertyChangedSignal("AbsoluteSize"),function() w:FitWatermark() end)
    w:FitWatermark()
    local hotkeys=w:Frame(gui,{Name="Hotkeys",AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,14,.5,0),Size=UDim2.fromOffset(164,0),AutomaticSize=Enum.AutomaticSize.Y,Visible=config.Hotkeys==true},"Sidebar"); corner(hotkeys,5); w:Stroke(hotkeys); pad(hotkeys,8); list(hotkeys,3); w.Hotkeys=hotkeys
    w:Text(hotkeys,"Hotkeys",{Size=UDim2.new(1,0,0,19),Font=Enum.Font.BuilderSansMedium,LayoutOrder=0})
    local hotkeyRows={}
    function w:RefreshHotkeys()
        for _,row in ipairs(hotkeyRows) do row:Destroy() end; hotkeyRows={}; self:PruneBindings()
        for _,c in ipairs(self.Controls) do
            if c.Keybind and c.Value==true and #hotkeyRows<6 then
                local row=self:Frame(hotkeys,{Size=UDim2.new(1,0,0,18),LayoutOrder=#hotkeyRows+1}); table.insert(hotkeyRows,row)
                self:Text(row,c.HotkeyTitle or c.Title,{Size=UDim2.new(.65,0,1,0),TextSize=11,TextTruncate=Enum.TextTruncate.AtEnd})
                self:Text(row,c.Keybind.Name,{Position=UDim2.fromScale(.65,0),Size=UDim2.new(.35,0,1,0),TextSize=9,TextXAlignment=Enum.TextXAlignment.Right},"Muted")
            end
        end
    end
    function w:SetWatermarkVisible(value) watermark.Visible=value==true end
    function w:SetHotkeysVisible(value) hotkeys.Visible=value==true end
    function w:SetWatermark(text) self.CustomWatermark=true;self.WatermarkText.Text=tostring(text);self:FitWatermark() end
    function w:RefreshTheme()
        local alive={}; for _,b in ipairs(self._bindings) do if b[1].Parent then b[1][b[2]]=self.Theme[b[3]]; table.insert(alive,b) end end; self._bindings=alive
        local gradients={}; for _,gradient in ipairs(self._gradients) do if gradient.Parent then gradient.Color=ColorSequence.new(C(255,255,255),self.Theme.Gradient); table.insert(gradients,gradient) end end; self._gradients=gradients
        for _,c in ipairs(self.Controls) do c:Refresh();if c.RefreshKeyMenu then c:RefreshKeyMenu() end end; for _,t in ipairs(self.Tabs) do t:Refresh() end; self:RefreshHotkeys()
    end
    function w:SetTheme(name) assert(themes[name],"Unknown theme"); self.ThemeName=name; self.Theme=copy(themes[name]); self:RefreshTheme() end
    function w:SetThemeColor(token,color) assert(self.Theme[token] and typeof(color)=="Color3","Invalid theme color"); self.Theme[token]=color; if token=="Accent" then self.Theme.AccentText=accentInk(color) end; self:RefreshTheme() end
    function w:SetAccent(color) self:SetThemeColor("Accent",color) end
    function w:Find(query)
        query=tostring(query or ""):lower():match("^%s*(.-)%s*$"); local found={}; if query=="" then return found end
        for _,t in ipairs(self.Tabs) do if (t.Title.." "..t.Description.." "..t.Category.Title):lower():find(query,1,true) then table.insert(found,{Tab=t,Title=t.Title,Kind="Tab"}) end end
        for _,entry in ipairs(self._searchables) do if entry.Frame.Parent and entry.Search:find(query,1,true) then table.insert(found,entry) end end
        return found
    end
    function w:OpenSearchResult(result)
        if not result or self.Destroyed or not table.find(self.Tabs,result.Tab) then return false end
        self:CloseSearch(); result.Tab:Select(); local target=result.Frame
        if target then task.defer(function()
            if self.Destroyed or self.ActiveTab~=result.Tab or not target.Parent then return end
            local section=result.Section
            local page=result.Column; local targetScale=scale.Scale
            if section and section.IsDetached then
                section:BringToFront(); page=target==section.Header and nil or section.FloatScroll; targetScale=section.FloatScale.Scale
            end
            if page then local offset=(target.AbsolutePosition.Y-page.AbsolutePosition.Y)/math.max(.1,targetScale)+page.CanvasPosition.Y; page.CanvasPosition=Vector2.new(0,math.max(0,offset-6)) end
            local stroke=make("UIStroke",{Name="SearchHighlight",Color=self.Theme.Accent,Thickness=1.5},target)
            task.delay(1.4,function() if stroke.Parent then stroke:Destroy() end end)
        end) end
        return true
    end
    function w:Search(query)
        if self.Destroyed then return {} end
        query=tostring(query or ""); self._globalQuery=query; if search.Text~=query then search.Text=query end
        for _,c in ipairs(self._resultConnections) do c:Disconnect() end; self._resultConnections={}
        for _,child in ipairs(resultList:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
        self.SearchResults=self:Find(query); local active=query:match("%S")~=nil or self._searchOpen==true; searchOverlay.Visible=active; results.Visible=active; pages.Visible=true; if modalInput.Text~=query then modalInput.Text=query end
        summary.Text=query:match("%S") and query or "Search"
        for i,result in ipairs(self.SearchResults) do if i>150 then break end
            local row=self:Button(resultList,{Size=UDim2.new(1,-3,0,46),ZIndex=183},"Panel"); corner(row,2); self:Frame(row,{Position=UDim2.fromOffset(3,6),Size=UDim2.fromOffset(2,34),ZIndex=184},"Accent")
            self:Text(row,result.Title,{Position=UDim2.fromOffset(10,3),Size=UDim2.new(1,-20,0,20),TextSize=12,ZIndex=184})
            self:Text(row,result.Tab.Title..(result.Section and " / "..result.Section.Title or "").." · "..result.Kind,{Position=UDim2.fromOffset(10,23),Size=UDim2.new(1,-20,0,16),TextSize=10,ZIndex=184},"Muted")
            table.insert(self._resultConnections,row.Activated:Connect(function() self:OpenSearchResult(result) end))
        end
        self:PruneBindings(); return self.SearchResults
    end
    function w:ShowSearch() self._searchOpen=true; self:Search(search.Text); modalInput:CaptureFocus() end
    function w:CloseSearch() if self._searchOpen or (self._globalQuery and self._globalQuery~="") then self:Search("") end;self._searchOpen=false;searchOverlay.Visible=false;modalInput:ReleaseFocus() end
    w:Connect(dismissSearch.Activated,function() w:CloseSearch() end)
    w:Connect(search.Focused,function() w:ShowSearch() end)
    w:Connect(modalInput:GetPropertyChangedSignal("Text"),function() if modalInput.Text~=w._globalQuery then w:Search(modalInput.Text) end end)
    w:Connect(modalInput.FocusLost,function(enter) if enter and w.SearchResults and w.SearchResults[1] then w:OpenSearchResult(w.SearchResults[1]) end end)
    w:Connect(UIS.InputBegan,function(input) if input.KeyCode==Enum.KeyCode.Escape and searchOverlay.Visible then w:CloseSearch() end end)
    w.Filter=w.Search
    w:Connect(search:GetPropertyChangedSignal("Text"),function() if search.Text~=w._globalQuery then w:Search(search.Text) end end)
    w:Connect(search.FocusLost,function(enter) if enter and w.SearchResults and w.SearchResults[1] then w:OpenSearchResult(w.SearchResults[1]) end end)
    function w:EnsureCategoryVisible(category)
        local button=category and category.Button
        if self.Destroyed or not button or not button.Parent then return end
        local y=button.AbsolutePosition.Y-nav.AbsolutePosition.Y;local height=button.AbsoluteSize.Y
        if y<0 then nav.CanvasPosition=Vector2.new(0,math.max(0,nav.CanvasPosition.Y+y))
        elseif y+height>nav.AbsoluteSize.Y then nav.CanvasPosition=Vector2.new(0,math.max(0,nav.CanvasPosition.Y+y+height-nav.AbsoluteSize.Y)) end
    end
    function w:CreateCategory(o)
        o=options(o);local name=o.Title or "General";if self.Categories[name] then return self.Categories[name] end
        local icons={Combat="swords",Visuals="eye",Player="user",Misc="boxes",Settings="settings"}
        local category={Title=name,Icon=o.Icon or icons[name] or "layers",Window=self,Tabs={}}
        local index=0;for _ in pairs(self.Categories) do index=index+1 end
        local button=self:Button(nav,{Name="Category_"..name,Size=UDim2.fromOffset(64,50),LayoutOrder=index});category.Button=button
        local glyph=self:Icon(button,category.Icon,{Position=UDim2.fromOffset(22,16),Size=UDim2.fromOffset(20,20)});category.Glyph=glyph
        function category:CreateTab(tabConfig) tabConfig=options(tabConfig);tabConfig.Category=self.Title;return self.Window:CreateTab(tabConfig) end
        function category:Select() local tab=self.LastTab or self.Tabs[1];if tab then tab:Select() end end
        self:Connect(button.Activated,function() category:Select() end)
        self.Categories[name]=category;return category
    end
    function w:CreateTab(o)
        o=options(o);local category=self:CreateCategory(o.Category or "General")
        local tab={Window=self,Category=category,Title=o.Title or "Tab",Icon=o.Icon or category.Icon,Description=o.Description or "Customize the product as you wish",Sections={},Columns={}}
        local page=self:Frame(pages,{Name="Tab_"..tab.Title,Size=UDim2.fromScale(1,1),Visible=false});tab.Page=page
        for i=1,3 do
            local column=make("ScrollingFrame",{Name="Column"..i,Active=true,Position=i==2 and UDim2.new(.5,7,0,0) or UDim2.new(),Size=i==3 and UDim2.fromScale(1,1) or UDim2.new(.5,-7,1,0),Visible=i~=3,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=2,BackgroundTransparency=1,BorderSizePixel=0},page);list(column,10);self:Bind(column,"ScrollBarImageColor3","Stroke");tab.Columns[i]=column
        end
        function tab:Refresh() for _,cat in pairs(w.Categories) do cat.Glyph.ImageColor3=w.ActiveCategory==cat and w.Theme.Text or w.Theme.Muted end end
        function tab:Select()
            if w.Destroyed then return end;if w.ActiveTab then w.ActiveTab.Page.Visible=false end
            w.ActiveTab=self;w.ActiveCategory=self.Category;self.Category.LastTab=self;self.Page.Visible=true
            w.Breadcrumb.Text='<font color="#E32636">I</font><font color="#FFFFFF">nfernity </font><font color="#E32636">H</font><font color="#FFFFFF">ub</font>';w.Description.Text=self.Title;w.PageLabel.Text=self.Title
            w:CloseSearch();w:ClosePopup();self:Refresh();task.defer(function() if not w.Destroyed and w.ActiveTab==self then w:EnsureCategoryVisible(self.Category) end end);return self
        end
        function tab:CreateSection(sectionConfig)
            sectionConfig=options(sectionConfig); local column=self.Columns[sectionConfig.FullWidth and 3 or (sectionConfig.Side=="Right" and 2 or 1)]
            local s={Window=w,Tab=self,Column=column,Title=sectionConfig.Title or "Section"}
            local holder=w:Frame(column,{Size=UDim2.new(1,-3,0,0),AutomaticSize=Enum.AutomaticSize.Y,LayoutOrder=#self.Sections+1}); list(holder,3)
            local head=w:Frame(holder,{Size=UDim2.new(1,0,0,28),LayoutOrder=0})
            w:Frame(head,{Position=UDim2.new(0,0,1,-1),Size=UDim2.new(1,0,0,1)},"Stroke")
            w:Text(head,sectionConfig.Title or "Section",{Position=UDim2.fromOffset(12,0),Size=UDim2.new(1,-48,1,0),TextSize=12})
            local panel=w:Frame(holder,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,LayoutOrder=1},"Panel"); panel.BackgroundTransparency=1;pad(panel,12,5);list(panel,0); s.Frame=panel; s.Container=holder
            s.Header=head; s.IsDetached=false; s.Draggable=sectionConfig.Draggable==true; s._visible=true
            local grip=w:Icon(head,"grip",{Position=UDim2.new(1,-17,0,5),Size=UDim2.fromOffset(11,11),Visible=s.Draggable})
            local sectionDrag=w:Button(head,{Name="SectionDragHandle",Size=UDim2.new(1,-22,1,0),Active=s.Draggable,ZIndex=2})
            local dock=w:Button(head,{Name="DockSection",Position=UDim2.new(1,-22,0,0),Size=UDim2.fromOffset(22,21),Visible=false,ZIndex=4})
            w:Icon(dock,"rotate-ccw",{Position=UDim2.fromOffset(5,4),Size=UDim2.fromOffset(12,12),ZIndex=5},"Accent")
            s.DragHandle=sectionDrag; s.DockButton=dock
            local function viewport()
                local v=gui.AbsoluteSize
                if v.X<32 or v.Y<32 then v=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280,720) end
                return v
            end
            if sectionConfig.FullWidth then self.Columns[1].Visible=false;self.Columns[2].Visible=false;self.Columns[3].Visible=true end
            function s:BringToFront()
                if w.Destroyed or not self.IsDetached then return false end
                w._floatZ=(w._floatZ or 100)+1
                if w._floatZ>=180 then
                    for other in pairs(w.DetachedSections) do if other.Float then other.Float.ZIndex=100 end end
                    w._floatZ=101
                end
                self.Float.ZIndex=w._floatZ; return true
            end
            function s:SetPosition(x,y)
                if w.Destroyed or not self.IsDetached then return false end
                assert(type(x)=="number" and x==x and math.abs(x)~=math.huge and type(y)=="number" and y==y and math.abs(y)~=math.huge,"Position must be finite")
                local v=viewport(); local sf=self.FloatScale.Scale
                x=clamp(x,8,math.max(8,v.X-self._floatWidth*sf-8))
                y=clamp(y,8,math.max(8,v.Y-self._floatHeight*sf-8))
                self.Float.Position=UDim2.fromOffset(x,y); return true
            end
            function s:RefreshFloatingBounds()
                if w.Destroyed or not self.IsDetached or self._fitting then return end
                self._fitting=true
                local v=viewport(); local oldScale=math.max(.01,self.FloatScale.Scale)
                local content=panel.AbsoluteSize.Y/oldScale
                if content>0 then self._floatContentHeight=content end
                local sf=math.max(.1,math.min(scale.Scale,(v.X-16)/self._floatWidth))
                self.FloatScale.Scale=sf
                self._floatHeight=math.max(45,math.min(self._floatContentHeight+28,math.max(45,(v.Y-16)/sf)))
                self.Float.Size=UDim2.fromOffset(self._floatWidth,self._floatHeight)
                self:SetPosition(self.Float.Position.X.Offset,self.Float.Position.Y.Offset)
                self._fitting=false
            end
            function s:Detach(x,y)
                if w.Destroyed or not self.Draggable then return false end
                if self.IsDetached then if x and y then self:SetPosition(x,y) end; self:BringToFront(); return true end
                w:ClosePopup()
                local position=head.AbsolutePosition
                local originScale=math.max(.01,scale.Scale)
                self._floatWidth=holder.AbsoluteSize.X>0 and math.max(130,holder.AbsoluteSize.X/originScale) or ((width-sidebarWidth-18)*.5-8)
                self._floatContentHeight=math.max(1,panel.AbsoluteSize.Y/originScale)
                self._floatHeight=self._floatContentHeight+28
                local float=w:Frame(gui,{Name="FloatingSection",Position=UDim2.fromOffset(position.X,position.Y),Size=UDim2.fromOffset(self._floatWidth,self._floatHeight),ZIndex=100,Active=true,ClipsDescendants=true,Visible=w.Visible and self._visible},"Sidebar"); corner(float,5); w:Stroke(float)
                self.Float=float; self.FloatScale=make("UIScale",{Scale=originScale},float)
                local scroll=make("ScrollingFrame",{Name="FloatingSectionBody",Position=UDim2.fromOffset(0,24),Size=UDim2.new(1,0,1,-24),Active=true,BorderSizePixel=0,BackgroundTransparency=1,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=2,ScrollingDirection=Enum.ScrollingDirection.Y},float)
                w:Bind(scroll,"ScrollBarImageColor3","Stroke"); self.FloatScroll=scroll
                self.IsDetached=true; w.DetachedSections[self]=true
                head.Parent=float; head.Position=UDim2.fromOffset(0,0)
                panel.Parent=scroll; panel.Position=UDim2.fromOffset(2,0); panel.Size=UDim2.new(1,-4,0,0)
                holder.Visible=false; dock.Visible=true; grip.Visible=false
                self._floatSizeConnection=w:Connect(panel:GetPropertyChangedSignal("AbsoluteSize"),function() self:RefreshFloatingBounds() end)
                self:RefreshFloatingBounds(); self:SetPosition(x or position.X,y or position.Y); self:BringToFront()
                w:Call(sectionConfig.OnDetach,self); return true
            end
            function s:MoveTo(side,index)
                local target=self.Tab.Columns[(side=="Right" or side==2) and 2 or 1]
                local others={}; for _,section in ipairs(self.Tab.Sections) do if section~=self and section.Column==target then table.insert(others,section) end end
                table.sort(others,function(a,b) return a.Container.LayoutOrder<b.Container.LayoutOrder end)
                index=clamp(math.floor(tonumber(index) or #others+1),1,#others+1); table.insert(others,index,self)
                column=target; self.Column=target; holder.Parent=target
                for order,section in ipairs(others) do section.Container.LayoutOrder=order*10 end
                for _,entry in ipairs(w._searchables) do if entry.Section==self then entry.Column=target end end
                return true
            end
            function s:Dock(activate,side,index)
                if w.Destroyed then return false end
                if not self.IsDetached then if side then self:MoveTo(side,index) end; return true end
                if side then self:MoveTo(side,index) end
                w:ClosePopup(); self.IsDetached=false; w.DetachedSections[self]=nil
                if self._floatSizeConnection then self._floatSizeConnection:Disconnect(); self._floatSizeConnection=nil end
                head.Parent=holder; head.Position=UDim2.fromOffset(0,0)
                panel.Parent=holder; panel.Position=UDim2.fromOffset(0,0); panel.Size=UDim2.new(1,0,0,0)
                self.Float:Destroy(); self.Float=nil; self.FloatScroll=nil; self.FloatScale=nil
                dock.Visible=false; grip.Visible=self.Draggable; holder.Visible=self._visible
                w:PruneBindings()
                if activate~=false and w.Visible then self.Tab:Select() end
                w:Call(sectionConfig.OnDock,self); return true
            end
            function s:SetVisible(value)
                self._visible=value==true
                if self.IsDetached then self.Float.Visible=self._visible and w.Visible else holder.Visible=self._visible end
            end
            w:Connect(dock.Activated,function() s:Dock() end)
            w:Connect(sectionDrag.InputBegan,function(input)
                if not s.Draggable or w.Destroyed or not w.Visible or not s._visible then return end
                if input.UserInputType~=Enum.UserInputType.MouseButton1 and input.UserInputType~=Enum.UserInputType.Touch then return end
                w:ClosePopup(); s._dragging=true; s._dragInput=input; s._dragStart=input.Position; s._dragMoved=false
                s._dragOrigin=s.IsDetached and Vector2.new(s.Float.Position.X.Offset,s.Float.Position.Y.Offset) or head.AbsolutePosition
                if s.IsDetached then s:BringToFront() end
            end)
            w:Connect(UIS.InputChanged,function(input)
                if not s._dragging or w.Destroyed then return end
                if input~=s._dragInput and not (s._dragInput.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseMovement) then return end
                local delta=input.Position-s._dragStart
                if delta.X*delta.X+delta.Y*delta.Y>=36 then s._dragMoved=true end
                if not s._dragMoved then return end
                if not s.IsDetached then s:Detach(s._dragOrigin.X,s._dragOrigin.Y) end
                s:SetPosition(s._dragOrigin.X+delta.X,s._dragOrigin.Y+delta.Y)
            end)
            w:Connect(UIS.InputEnded,function(input)
                if not s._dragging then return end
                if input~=s._dragInput and not (s._dragInput.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseButton1) then return end
                s._dragging=false
                if s._dragMoved and s.IsDetached and w.Visible then
                    local point=input.Position; local p=root.AbsolutePosition; local size=root.AbsoluteSize
                    if point.X>=p.X and point.X<=p.X+size.X and point.Y>=p.Y and point.Y<=p.Y+size.Y then
                        local area=pages.AbsolutePosition; local areaSize=pages.AbsoluteSize
                        if point.X>=area.X and point.X<=area.X+areaSize.X then
                            local side=point.X<area.X+areaSize.X*.5 and "Left" or "Right"; local target=s.Tab.Columns[side=="Left" and 1 or 2]; local index=1
                            for _,other in ipairs(s.Tab.Sections) do if other~=s and other.Column==target and not other.IsDetached and point.Y>other.Container.AbsolutePosition.Y+other.Container.AbsoluteSize.Y*.5 then index=index+1 end end
                            s:Dock(true,side,index)
                        else s:Dock() end
                    end
                end
            end)
            table.insert(w.Sections,s)
            table.insert(w._searchables,{Tab=self,Section=s,Frame=head,Column=column,Title=sectionConfig.Title or "Section",Kind="Section",Search=(sectionConfig.Title or "Section"):lower()})
            local order=0
            function s:Row(o,height)
                order=order+1; local row=w:Frame(panel,{Size=UDim2.new(1,0,0,height or 25),LayoutOrder=order})
                local label=w:Text(row,o.Title or "Control",{Size=UDim2.new(1,-50,0,22),TextSize=12,TextTruncate=Enum.TextTruncate.AtEnd})
                if o.Description then row.Size=UDim2.new(1,0,0,(height or 25)+14); w:Text(row,o.Description,{Position=UDim2.fromOffset(0,height or 25),Size=UDim2.new(1,0,0,14),TextSize=10,TextTruncate=Enum.TextTruncate.AtEnd},"Muted") end
                local entry={Tab=self.Tab,Section=self,Frame=row,Column=column,Title=o.Title or "Control",Kind="Control",Search=((o.Title or "").." "..(o.Description or "")):lower()}; table.insert(w._searchables,entry)
                return row,label,entry
            end
            function s:Register(o,row,default,normalize,render)
                local control={Frame=row,Title=o.Title or "Control",Value=copy(default),Default=copy(default),Normalize=normalize,Enabled=true,_manualEnabled=o.Enabled~=false,EnabledIf=o.EnabledIf}
                function control:Get() return copy(self.Value) end
                function control:Set(value,silent)
                    self.Value=copy(self:Normalize(value))
                    self:Refresh()
                    if self.Keybind and w.RefreshHotkeys then w:RefreshHotkeys() end
                    if w.RefreshDependencies then w:RefreshDependencies() end
                    if not silent then w:Call(o.Callback,self:Get(),self.Opacity) end
                    return self
                end
                function control:Refresh() render(self.Value) end
                local blocker=w:Button(row,{Name="DisabledOverlay",Size=UDim2.fromScale(1,1),ZIndex=190,Visible=false,Active=true},"Panel"); blocker.BackgroundTransparency=.48
                function control:RefreshEnabled()
                    local enabled=self._manualEnabled
                    if type(self.EnabledIf)=="string" then enabled=enabled and w.Flags[self.EnabledIf]~=nil and w.Flags[self.EnabledIf]:Get()==true end
                    self.Enabled=enabled; blocker.Visible=not enabled
                end
                function control:SetEnabled(enabled) self._manualEnabled=enabled==true; self:RefreshEnabled(); return self end
                function control:SetVisible(visible) row.Visible=visible end
                function control:Reset(silent) return self:Set(self.Default,silent) end
                if o.Flag then assert(not w.Flags[o.Flag],"Duplicate flag: "..o.Flag); w.Flags[o.Flag]=control end
                table.insert(w.Controls,control); control:Set(default,true)
                return control
            end
            function s:AddToggle(o)
                o=options(o)
                local row,label,entry=self:Row(o); entry.Kind="Toggle"
                local hit=w:Button(row,{Size=UDim2.fromScale(1,1)})
                local track=w:Frame(row,{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,4),Size=UDim2.fromOffset(38,20)},"Hover"); corner(track,10)
                local knob=w:Frame(track,{Position=UDim2.fromOffset(3,3),Size=UDim2.fromOffset(14,14)},"Muted"); corner(knob,8)
                local control=self:Register(o,row,o.Default==true,function(_,v) assert(type(v)=="boolean","Expected boolean"); return v end,function(v)
                    track.BackgroundColor3=v and w.Theme.Accent:Lerp(w.Theme.Panel,.78) or w.Theme.Hover
                    tween(knob,{Position=UDim2.fromOffset(v and 21 or 3,3),BackgroundColor3=v and w.Theme.Accent or w.Theme.Muted})
                end)
                w:Connect(hit.Activated,function() if control.Enabled then control:Set(not control.Value) end end)
                if o.Keybind then
                    assert(validBinding(o.Keybind),"Expected keyboard/mouse binding")
                    control.Keybind=o.Keybind;control.DefaultKeybind=o.Keybind;control.KeyMode=o.KeyMode or "Toggle";control.HotkeyTitle=o.HotkeyTitle or o.Title
                    label.Size=UDim2.new(1,-64,0,22)
                    local gear=w:Button(row,{Name="KeybindSettings",Position=UDim2.new(1,-53,0,4),Size=UDim2.fromOffset(19,19)})
                    w:Icon(gear,"settings",{Position=UDim2.fromOffset(2,2),Size=UDim2.fromOffset(15,15)})
                    local keyLabel
                    function control:SetKeybind(key) assert(validBinding(key),"Expected keyboard/mouse binding");if self.KeyMode=="Hold" and self.Value then self:Set(false) end;self.Keybind=key;if keyLabel and keyLabel.Parent then keyLabel.Text=key.Name end;w:RefreshHotkeys() end
                    function control:SetKeyMode(mode,silent) assert(mode=="Toggle" or mode=="Hold","Expected Toggle or Hold");self.KeyMode=mode;if mode=="Hold" and self.Value then self:Set(false,silent) end;if self.RefreshKeyMenu then self:RefreshKeyMenu() end end
                    function control:ResetKeybind() self:SetKeybind(self.DefaultKeybind);self:SetKeyMode("Toggle") end
                    local function menu()
                        local frame=w:PopupAt(gear,200,110,{Left=true,OffsetX=-190});control.KeyMenu=frame
                        w:Text(frame,'"'..(o.Title or "Toggle")..'"',{Position=UDim2.fromOffset(10,5),Size=UDim2.new(1,-20,0,24),TextSize=12,ZIndex=204})
                        local capture=w:Button(frame,{Name="CaptureBinding",Position=UDim2.fromOffset(10,30),Size=UDim2.new(1,-20,0,29),ZIndex=203},"Panel");corner(capture,3)
                        keyLabel=w:Text(capture,control.Keybind.Name,{Size=UDim2.fromScale(1,1),TextXAlignment=Enum.TextXAlignment.Center,ZIndex=204});control.BindingLabel=keyLabel
                        w:Connect(capture.Activated,function() if not w._capturing then w._capturing=control;keyLabel.Text="Press a key..." end end)
                        local modes={}
                        local function refresh()
                            if not frame.Parent then return end
                            for name,item in pairs(modes) do
                                local selected=control.KeyMode==name
                                item.Button.BackgroundTransparency=0;item.Button.Visible=true
                                item.Button.BackgroundColor3=selected and w.Theme.Accent or w.Theme.Panel
                                item.Label.TextTransparency=0;item.Label.Visible=true
                                item.Label.TextColor3=selected and w.Theme.White or w.Theme.Muted
                            end
                        end
                        control.RefreshKeyMenu=refresh;w._modePopupControl=control
                        for index,mode in ipairs({"Toggle","Hold"}) do
                            local button=w:Button(frame,{Name="Mode"..mode,Position=UDim2.fromOffset(10+(index-1)*92,68),Size=UDim2.fromOffset(88,32),BackgroundTransparency=0,ZIndex=203});corner(button,3)
                            local caption=w:Text(button,mode,{Size=UDim2.fromScale(1,1),TextXAlignment=Enum.TextXAlignment.Center,TextSize=12,ZIndex=204})
                            modes[mode]={Button=button,Label=caption}
                            w:Connect(button.Activated,function() control:SetKeyMode(mode) end)
                            w:Connect(button.MouseEnter,function() if control.KeyMode~=mode then button.BackgroundColor3=w.Theme.Hover end end)
                            w:Connect(button.MouseLeave,refresh)
                        end
                        refresh()
                    end
                    w:Connect(gear.Activated,menu)
                    w:Connect(UIS.InputEnded,function(input) if control.KeyMode=="Hold" and bindingMatches(input,control.Keybind) and control.Value then control:Set(false) end end)
                    w:Connect(UIS.InputBegan,function(input,processed)
                        if w._capturing==control then
                            if inputBinding(input) then
                                if input.KeyCode~=Enum.KeyCode.Escape then control:SetKeybind(inputBinding(input)) elseif keyLabel and keyLabel.Parent then keyLabel.Text=control.Keybind.Name end
                                task.defer(function() if w._capturing==control then w._capturing=nil end end)
                            end
                        elseif not processed and not UIS:GetFocusedTextBox() and not w._capturing and bindingMatches(input,control.Keybind) and control.Enabled then control:Set(control.KeyMode=="Hold" or not control.Value) end
                    end)
                    control.KeyButton=gear
                end
                if o.Color then
                    local colorOptions=typeof(o.Color)=="table" and copy(o.Color) or {Default=o.Color}
                    colorOptions.Title=colorOptions.Title or ((o.Title or "Toggle").." color"); colorOptions.Flag=colorOptions.Flag or o.ColorFlag; colorOptions.Inline=true
                    local colorControl=self:AddColorPicker(colorOptions); local oldRow=colorControl.Frame
                    colorControl.Swatch.Parent=row; colorControl.Swatch.Position=UDim2.new(1,-48,0,8); colorControl.Swatch.Size=UDim2.fromOffset(12,12)
                    for _,entry in ipairs(w._searchables) do if entry.Frame==oldRow then entry.Frame=row end end
                    colorControl.Frame=row; function colorControl:SetVisible(value) self.Swatch.Visible=value end; oldRow:Destroy(); control.ColorControl=colorControl
                    label.Size=UDim2.new(1,o.Keybind and -116 or -70,0,22)
                    if control.KeyButton then control.KeyButton.Position=UDim2.new(1,-100,0,5) end
                end
                return control
            end
            function s:AddButton(o)
                o=options(o)
                local row,label,entry=self:Row(o,32); entry.Kind="Button"; label.Visible=false
                local b=w:Button(row,{Size=UDim2.new(1,0,0,29)},o.Primary and "Accent" or "Hover"); corner(b,3)
                local text=w:Text(b,o.Title or "Button",{Size=UDim2.fromScale(1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Center},o.Primary and "AccentText" or "Text")
                if o.Icon then w:Icon(b,o.Icon,{Position=UDim2.fromOffset(8,5),Size=UDim2.fromOffset(13,13)},o.Primary and "AccentText" or "Muted") end
                w:Connect(b.Activated,function() w:Call(o.Callback) end)
                return {Frame=row,SetText=function(_,v)
                    text.Text=tostring(v); entry.Title=text.Text; entry.Search=string.lower(text.Text.." "..(o.Description or ""))
                    if w._globalQuery and w._globalQuery:match("%S") then w:Filter(w._globalQuery) end
                end,SetVisible=function(_,v) row.Visible=v end}
            end
            function s:AddLabel(o)
                o=options(o)
                local auto=o.AutoHeight~=false and (o.Height==nil or o.AutoHeight==true)
                local row,label,entry=self:Row(o,auto and 0 or (o.Height or 42)); entry.Kind="Label"
                label.TextWrapped=true; label.TextYAlignment=Enum.TextYAlignment.Top
                label.TextSize=o.TextSize or 12; label.TextTruncate=Enum.TextTruncate.None
                if auto then
                    row.Size=UDim2.new(1,0,0,0); row.AutomaticSize=Enum.AutomaticSize.Y
                    label.Size=UDim2.new(1,0,0,0); label.AutomaticSize=Enum.AutomaticSize.Y
                    if o.Description then
                        for _,child in ipairs(row:GetChildren()) do
                            if child~=label and child:IsA("TextLabel") then
                                child.Size=UDim2.new(1,0,0,0); child.AutomaticSize=Enum.AutomaticSize.Y
                                child.TextWrapped=true; child.TextTruncate=Enum.TextTruncate.None; child.LayoutOrder=2
                            end
                        end
                        label.LayoutOrder=1; list(row,4)
                    end
                else label.Size=UDim2.fromScale(1,1) end
                return {Frame=row,SetText=function(_,v)
                    label.Text=tostring(v); entry.Title=label.Text; entry.Search=string.lower(label.Text.." "..(o.Description or ""))
                    if w._globalQuery and w._globalQuery:match("%S") then w:Filter(w._globalQuery) end
                end,SetVisible=function(_,v) row.Visible=v end}
            end
            function s:AddSlider(o)
                o=options(o)
                if o.Range then return self:AddRangeSlider(o) end
                local lo,hi=tonumber(o.Min) or 0,tonumber(o.Max) or 100
                assert(hi>lo and math.abs(lo)~=math.huge and math.abs(hi)~=math.huge,"Slider limits must be finite")
                local step=tonumber(o.Step) or 1; assert(step>0 and step~=math.huge,"Step must be finite and positive")
                local row,label,entry=self:Row(o,25); entry.Kind="Slider"
                local numberWidth=step<1 and 34 or 52;label.Size=UDim2.new(1,-(numberWidth+144),0,22);w:Bind(label,"TextColor3","Muted")
                local valueText=w:Bind(make("TextBox",{Name="SliderValue",Position=UDim2.new(1,-(numberWidth+138),0,2),Size=UDim2.fromOffset(numberWidth,20),Text="",ClearTextOnFocus=false,Font=Enum.Font.BuilderSans,TextSize=11,TextXAlignment=Enum.TextXAlignment.Right,BorderSizePixel=0},row),"TextColor3","Muted"); valueText.BackgroundTransparency=1; w:Bind(valueText,"BackgroundColor3","Panel"); corner(valueText,3)
                local track=w:Frame(row,{Position=UDim2.new(1,-130,0,5),Size=UDim2.fromOffset(130,16)},"Hover"); corner(track,10)
                local fill=w:Frame(track,{Size=UDim2.fromScale(0,1)},"Accent"); corner(fill,10);make("UIGradient",{Color=ColorSequence.new(C(160,160,160),C(255,255,255))},fill)
                local knob=w:Frame(track,{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(0,.5),Size=UDim2.fromOffset(9,9)},"Text"); corner(knob,6)
                local hit=w:Button(row,{Position=UDim2.new(1,-130,0,0),Size=UDim2.fromOffset(130,25)})
                local control=self:Register(o,row,o.Default or lo,function(_,v)
                    assert(type(v)=="number" and v==v and math.abs(v)~=math.huge,"Expected finite number")
                    return clamp(lo+round(v-lo,step),lo,hi)
                end,function(v)
                    local alpha=(v-lo)/(hi-lo)
                    fill.Size=UDim2.fromScale(alpha,1); knob.Position=UDim2.fromScale(alpha,.5)
                    valueText.Text=string.format("%.4g",v)..(o.Suffix or "")
                end)
                local sliding,touch=false,nil
                local function update(x) control:Set(lo+clamp((x-track.AbsolutePosition.X)/math.max(1,track.AbsoluteSize.X),0,1)*(hi-lo)) end
                w:Connect(hit.InputBegan,function(input)
                    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then if not control.Enabled then return end; sliding=true; touch=input; update(input.Position.X) end
                end)
                w:Connect(UIS.InputChanged,function(input)
                    if sliding and (input==touch or input.UserInputType==Enum.UserInputType.MouseMovement) then update(input.Position.X) end
                end)
                w:Connect(UIS.InputEnded,function(input) if input==touch or input.UserInputType==Enum.UserInputType.MouseButton1 then sliding=false end end)
                w:Connect(UIS.WindowFocusReleased,function() sliding=false;touch=nil end)
                control.ValueBox=valueText
                w:Connect(valueText.FocusLost,function() local number=tonumber(valueText.Text:match("^%s*([%+%-]?[%d%.]+)")); if number and control.Enabled then control:Set(number) else control:Refresh() end end)
                return control
            end
            function s:AddRangeSlider(o)
                o=options(o)
                local lo,hi=tonumber(o.Min) or 0,tonumber(o.Max) or 100
                local step=tonumber(o.Step) or 1
                local function finite(n) return type(n)=="number" and n==n and math.abs(n)~=math.huge end
                assert(finite(lo) and finite(hi) and hi>lo,"Range Max must exceed finite Min")
                assert(finite(step) and step>0,"Range Step must be positive and finite")
                local function snap(v) return clamp(lo+round(v-lo,step),lo,hi) end
                local row,label,entry=self:Row(o,25); entry.Kind="RangeSlider"
                local numberWidth=o.Suffix and 68 or 44;label.Size=UDim2.new(1,-(numberWidth+144),0,22);w:Bind(label,"TextColor3","Muted")
                local valueText=w:Text(row,"",{Name="RangeValue",Position=UDim2.new(1,-(numberWidth+138),0,2),Size=UDim2.fromOffset(numberWidth,20),TextSize=12,TextXAlignment=Enum.TextXAlignment.Right},"Muted")
                local track=w:Frame(row,{Name="RangeTrack",Position=UDim2.new(1,-130,0,5),Size=UDim2.fromOffset(130,16)},"Hover"); corner(track,10)
                local fill=w:Frame(track,{Name="RangeFill",Size=UDim2.fromScale(0,1)},"Accent"); corner(fill,10);make("UIGradient",{Color=ColorSequence.new(C(160,160,160),C(255,255,255))},fill)
                local knobs={}
                for i=1,2 do
                    knobs[i]=w:Frame(track,{Name=i==1 and "LowerHandle" or "UpperHandle",AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(0,.5),Size=UDim2.fromOffset(11,11)},"Text")
                    corner(knobs[i],6)
                end
                local hit=w:Button(row,{Name="RangeInput",Position=UDim2.new(1,-130,0,0),Size=UDim2.fromOffset(130,25)})
                local control=self:Register(o,row,o.Default or {lo,hi},function(_,v)
                    assert(type(v)=="table" and finite(v[1]) and finite(v[2]),"Expected {minimum, maximum} numeric pair")
                    local a,b=snap(v[1]),snap(v[2])
                    if a>b then a,b=b,a end
                    return {a,b}
                end,function(v)
                    local a,b=(v[1]-lo)/(hi-lo),(v[2]-lo)/(hi-lo)
                    fill.Position=UDim2.fromScale(a,0); fill.Size=UDim2.fromScale(b-a,1)
                    knobs[1].Position=UDim2.fromScale(a,.5); knobs[2].Position=UDim2.fromScale(b,.5)
                    local suffix=o.Suffix or ""
                    valueText.Text=string.format("%.4g",v[1])..suffix.." - "..string.format("%.4g",v[2])..suffix
                end)
                control.LowerHandle=knobs[1]; control.UpperHandle=knobs[2]; control.Track=track
                local active,touch,lastHandle
                local function at(x)
                    return snap(lo+clamp((x-track.AbsolutePosition.X)/math.max(1,track.AbsoluteSize.X),0,1)*(hi-lo))
                end
                local function update(x)
                    local pair=control:Get(); local nextValue=at(x)
                    if active==1 then pair[1]=math.min(nextValue,pair[2]) else pair[2]=math.max(nextValue,pair[1]) end
                    if pair[1]~=control.Value[1] or pair[2]~=control.Value[2] then control:Set(pair) end
                end
                w:Connect(hit.InputBegan,function(input)
                    if input.UserInputType~=Enum.UserInputType.MouseButton1 and input.UserInputType~=Enum.UserInputType.Touch then return end
                    if not control.Enabled then return end
                    local v=at(input.Position.X); local pair=control.Value
                    if pair[1]==pair[2] then
                        active=v<pair[1] and 1 or (v>pair[2] and 2 or (lastHandle==1 and 2 or 1))
                    else active=math.abs(v-pair[1])<=math.abs(v-pair[2]) and 1 or 2 end
                    touch=input; lastHandle=active; update(input.Position.X)
                end)
                w:Connect(UIS.InputChanged,function(input)
                    if active and (input==touch or input.UserInputType==Enum.UserInputType.MouseMovement) then update(input.Position.X) end
                end)
                w:Connect(UIS.InputEnded,function(input)
                    if input==touch or input.UserInputType==Enum.UserInputType.MouseButton1 then active=nil; touch=nil end
                end)
                w:Connect(UIS.WindowFocusReleased,function() active=nil;touch=nil end)
                return control
            end
            function s:AddDropdown(o)
                o=options(o); local values=copy(o.Options or {"Option"}); assert(#values>0,"Dropdown options cannot be empty")
                local row,label,entry=self:Row(o,66); entry.Kind="Dropdown"
                local b=w:Button(row,{Name="DropdownField",Position=UDim2.fromOffset(0,29),Size=UDim2.new(1,0,0,30)},"Panel"); corner(b,3)
                w:Bind(label,"TextColor3","Muted")
                local selected=w:Text(b,"",{Position=UDim2.fromOffset(7,0),Size=UDim2.new(1,-29,1,0),TextSize=11,TextTruncate=Enum.TextTruncate.AtEnd},"Muted")
                local arrow=w:Icon(b,"chevron-down",{Position=UDim2.new(1,-19,0,10),Size=UDim2.fromOffset(12,12)})
                local control=self:Register(o,row,o.Default or (o.Multi and {} or values[1]),function(_,v)
                    if o.Multi then assert(type(v)=="table","Expected selected options array"); local result={}; for _,value in ipairs(v) do assert(table.find(values,value),"Unknown option"); if not table.find(result,value) then table.insert(result,value) end end; return result end
                    assert(table.find(values,v),"Unknown option: "..tostring(v)); return v
                end,function(v) selected.Text=o.Multi and (#v>0 and table.concat(v,", ") or "None") or tostring(v) end)
                control.Button=b; control.SelectedLabel=selected
                w:Connect(b.Activated,function()
                    if control.Enabled==false then return end
                    local sf=self.IsDetached and self.FloatScale.Scale or w.Scale.Scale
                    control.PopupList=w:OptionList(b,values,function(value) return o.Multi and table.find(control.Value,value)~=nil or control.Value==value end,function(value)
                        if o.Multi then local next=control:Get(); local i=table.find(next,value); if i then table.remove(next,i) else table.insert(next,value) end; control:Set(next)
                        else control:Set(value);if o.CloseOnSelect then w:ClosePopup() end end
                    end,{Scale=sf,Multi=o.Multi})
                    arrow.Rotation=180;w._popupOnClose=function() if arrow.Parent then arrow.Rotation=0 end end
                end)
                function control:SetOptions(newOptions)
                    assert(type(newOptions)=="table" and #newOptions>0,"Expected non-empty options"); values=copy(newOptions)
                    if o.Multi then local valid={}; for _,value in ipairs(self.Value) do if table.find(values,value) then table.insert(valid,value) end end; self:Set(valid,true)
                    elseif not table.find(values,self.Value) then self:Set(values[1],true) end
                    w:ClosePopup()
                end
                return control
            end
            function s:AddTextbox(o)
                o=options(o)
                local row,label,entry=self:Row(o,o.Compact and 32 or 63); entry.Kind="Textbox"
                local box=w:Bind(make("TextBox",{Position=UDim2.fromOffset(0,o.Compact and 0 or 29),Size=UDim2.new(1,0,0,30),Text="",PlaceholderText=o.Placeholder or "Enter text...",ClearTextOnFocus=false,TextXAlignment=Enum.TextXAlignment.Left,Font=Enum.Font.BuilderSans,TextSize=12,BorderSizePixel=0},row),"BackgroundColor3","Hover")
                w:Bind(box,"TextColor3","Text"); w:Bind(box,"PlaceholderColor3","Muted"); corner(box,3); pad(box,8,0)
                if o.Compact then label.Visible=false end
                w:Bind(label,"TextColor3","Muted")
                local control=self:Register(o,row,o.Default or "",function(_,v)
                    assert(type(v)=="string","Expected string"); return v:sub(1,o.MaxLength or 2048)
                end,function(v) if box.Text~=v then box.Text=v end end)
                w:Connect(box.FocusLost,function(enter) control:Set(box.Text); w:Call(o.OnEnter,control.Value,enter) end)
                if o.Live then w:Connect(box:GetPropertyChangedSignal("Text"),function() control:Set(box.Text) end) end
                return control
            end
            function s:AddKeybind(o)
                o=options(o)
                local row,label,entry=self:Row(o); entry.Kind="Keybind"
                local b=w:Button(row,{AnchorPoint=Vector2.new(1,0),Position=UDim2.fromScale(1,0),Size=UDim2.fromOffset(96,26)},"Hover"); corner(b,6)
                label.Size=UDim2.new(1,-101,0,28)
                local text=w:Text(b,"",{Size=UDim2.fromScale(1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Center})
                local control=self:Register(o,row,o.Default or Enum.KeyCode.F,function(_,v)
                    assert(typeof(v)=="EnumItem" and v.EnumType==Enum.KeyCode,"Expected Enum.KeyCode"); return v
                end,function(v) text.Text=v.Name end)
                w:Connect(b.Activated,function()
                    if w._capturing then return end
                    w._capturing=control; text.Text="Press a key..."
                end)
                w:Connect(UIS.InputBegan,function(input,processed)
                    if w._capturing==control then
                        if input.KeyCode~=Enum.KeyCode.Unknown then
                            if input.KeyCode~=Enum.KeyCode.Escape then control:Set(input.KeyCode) else control:Refresh() end
                            task.defer(function() if w._capturing==control then w._capturing=false end end)
                        end
                    elseif not processed and not UIS:GetFocusedTextBox() and not w._capturing and input.KeyCode==control.Value then w:Call(o.OnPressed,control.Value) end
                end)
                return control
            end
            function s:AddColorPicker(o)
                o=options(o);if o.ShowHex==nil then o.ShowHex=true end; local row,label,entry=self:Row(o); entry.Kind="ColorPicker"
                local swatch=w:Button(row,{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,5),Size=UDim2.fromOffset(16,16)},"Accent"); corner(swatch,12); w:Stroke(swatch)
                local control=self:Register(o,row,o.Default or w.Theme.Accent,function(_,v) assert(typeof(v)=="Color3","Expected Color3"); return v end,function(v) swatch.BackgroundColor3=v end)
                control.Opacity=clamp(tonumber(o.Alpha) or 1,0,1); control.Animation="None"
                local set=control.Set
                function control:Set(value,silent) local normalized=self:Normalize(value); if not self._animating then self._baseColor=normalized end; return set(self,normalized,silent) end
                function control:GetAlpha() return self.Opacity end
                function control:SetAlpha(alpha,silent)
                    assert(type(alpha)=="number" and alpha==alpha and alpha>=0 and alpha<=1,"Opacity must be 0–1")
                    self.Opacity=alpha; if not self._animating then self._baseAlpha=alpha end; swatch.BackgroundTransparency=1-alpha
                    if not silent then w:Call(o.Callback,self:Get(),alpha) end
                end
                function control:SetAnimation(mode,silent)
                    assert(table.find({"None","Rainbow","Fade","Fade Alpha"},mode),"Unknown color animation")
                    if self.Animation=="None" then self._baseColor=self:Get(); self._baseAlpha=self.Opacity end
                    self.Animation=mode
                    if self.AnimationLabel and self.AnimationLabel.Parent then self.AnimationLabel.Text=mode end
                    if mode=="None" then self:Set(self._baseColor or self:Get(),silent); self:SetAlpha(self._baseAlpha or 1,silent) end
                end
                function control:StepAnimation(time)
                    if self.Animation=="None" or not self._baseColor then return end
                    local hue,sat,val=self._baseColor:ToHSV(); local wave=.5+.5*math.sin(time*2)
                    self._animating=true
                    if self.Animation=="Rainbow" then self:Set(Color3.fromHSV((time*.12)%1,math.max(.6,sat),math.max(.7,val)))
                    elseif self.Animation=="Fade" then self:Set(Color3.fromHSV(hue,sat,val*(.35+.65*wave)))
                    elseif self.Animation=="Fade Alpha" then self:SetAlpha((self._baseAlpha or 1)*(.15+.85*wave)) end
                    self._animating=false
                end
                control:SetAlpha(control.Opacity,true); control.Swatch=swatch
                w:Connect(swatch.Activated,function()
                    if not control.Enabled then return end
                    local sf=self.IsDetached and self.FloatScale.Scale or w.Scale.Scale
                    local f=w:PopupAt(swatch,172,219,{Scale=sf}); control.Picker=f
                    w:Text(f,'"'..(o.Title or "Color")..'"',{Position=UDim2.fromOffset(10,3),Size=UDim2.fromOffset(160,22),ZIndex=204,TextSize=12})
                    local hue,sat,val=control.Value:ToHSV()
                    local sv=w:Frame(f,{Position=UDim2.fromOffset(8,27),Size=UDim2.fromOffset(126,126),ZIndex=203}); sv.BackgroundTransparency=0; corner(sv,3)
                    local white=w:Frame(sv,{Size=UDim2.fromScale(1,1),ZIndex=204},"White"); make("UIGradient",{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})},white)
                    local black=w:Frame(sv,{Size=UDim2.fromScale(1,1),ZIndex=205},"Black"); make("UIGradient",{Rotation=90,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)})},black)
                    local cursor=w:Frame(sv,{AnchorPoint=Vector2.new(.5,.5),Size=UDim2.fromOffset(11,11),ZIndex=207}); corner(cursor,8); make("UIStroke",{Color=C(255,255,255),Thickness=1.5},cursor)
                    local hit=w:Button(sv,{Size=UDim2.fromScale(1,1),ZIndex=208})
                    local huebar=w:Frame(f,{Position=UDim2.fromOffset(144,27),Size=UDim2.fromOffset(14,126),ZIndex=203},"White"); corner(huebar,3)
                    local points={}; for i=0,6 do table.insert(points,ColorSequenceKeypoint.new(i/6,Color3.fromHSV(i/6,1,1))) end; make("UIGradient",{Rotation=90,Color=ColorSequence.new(points)},huebar)
                    local hueCursor=w:Frame(huebar,{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,hue),Size=UDim2.fromOffset(14,5),ZIndex=205},"Text"); corner(hueCursor,5)
                    local hueHit=w:Button(huebar,{Size=UDim2.fromScale(1,1),ZIndex=208})
                    local alphaTrack=w:Frame(f,{Name="OpacityTrack",Position=UDim2.fromOffset(8,161),Size=UDim2.fromOffset(126,12),ClipsDescendants=false,ZIndex=203})
                    alphaTrack.BackgroundTransparency=0;w:Bind(alphaTrack,"BackgroundColor3","Panel")
                    local alphaFill=w:Frame(alphaTrack,{Size=UDim2.fromScale(1,1),ZIndex=204}); alphaFill.BackgroundTransparency=0; make("UIGradient",{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})},alphaFill)
                    local alphaKnob=w:Frame(alphaTrack,{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(1-control.Opacity,.5),Size=UDim2.fromOffset(4,15),ZIndex=205},"Text"); corner(alphaKnob,5)
                    local alphaHit=w:Button(alphaTrack,{Size=UDim2.fromScale(1,1),ZIndex=208})
                    local hex
                    if o.ShowHex then hex=w:Bind(make("TextBox",{Name="HexColor",Position=UDim2.fromOffset(8,183),Size=UDim2.fromOffset(126,25),Text="#"..control.Value:ToHex(),Font=Enum.Font.Code,TextSize=12,ClearTextOnFocus=false,BorderSizePixel=0,ZIndex=204},f),"BackgroundColor3","Panel"); w:Bind(hex,"TextColor3","Text") end
                    w:Icon(f,"pencil",{Position=UDim2.fromOffset(145,188),Size=UDim2.fromOffset(14,14),ZIndex=205})
                    local function redraw(commit)
                        sv.BackgroundColor3=Color3.fromHSV(hue,1,1); cursor.Position=UDim2.fromScale(sat,1-val); hueCursor.Position=UDim2.fromScale(.5,hue)
                        if commit then control:Set(Color3.fromHSV(hue,sat,val)) end
                        alphaFill.BackgroundColor3=control.Value; if hex then hex.Text="#"..control.Value:ToHex() end
                    end
                    local mode,touch
                    local function update(input)
                        if mode=="sv" then sat=clamp((input.Position.X-sv.AbsolutePosition.X)/math.max(1,sv.AbsoluteSize.X),0,1); val=1-clamp((input.Position.Y-sv.AbsolutePosition.Y)/math.max(1,sv.AbsoluteSize.Y),0,1)
                        elseif mode=="alpha" then control:SetAlpha(1-clamp((input.Position.X-alphaTrack.AbsolutePosition.X)/math.max(1,alphaTrack.AbsoluteSize.X),0,1)); alphaKnob.Position=UDim2.fromScale(1-control.Opacity,.5); return
                        else hue=clamp((input.Position.Y-huebar.AbsolutePosition.Y)/math.max(1,huebar.AbsoluteSize.Y),0,1) end
                        redraw(true)
                    end
                    local function begin(input,m) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then mode=m; touch=input; update(input) end end
                    w:Connect(hit.InputBegan,function(i) begin(i,"sv") end); w:Connect(alphaHit.InputBegan,function(i) begin(i,"alpha") end); w:Connect(hueHit.InputBegan,function(i) begin(i,"hue") end)
                    table.insert(w._popConnections,UIS.InputChanged:Connect(function(i) if mode and (i==touch or i.UserInputType==Enum.UserInputType.MouseMovement) then update(i) end end))
                    table.insert(w._popConnections,UIS.InputEnded:Connect(function(i) if i==touch or i.UserInputType==Enum.UserInputType.MouseButton1 then mode=nil end end))
                    if hex then w:Connect(hex.FocusLost,function() local value=hex.Text:gsub("#",""); if value:match("^%x%x%x%x%x%x$") then hue,sat,val=Color3.fromHex(value):ToHSV(); redraw(true) else redraw(false) end end) end
                    redraw(false)
                end)
                return control
            end
            function s:AddDivider(o)
                o=options(o); local row=self:Row({Title=o.Title or ""},o.Title and 24 or 9)
                for _,child in ipairs(row:GetChildren()) do if child:IsA("TextLabel") then child.Visible=false end end
                if o.Title then w:Text(row,o.Title,{Size=UDim2.new(1,0,0,16),TextSize=10},"Muted") end
                w:Frame(row,{Position=UDim2.new(0,0,1,-3),Size=UDim2.new(1,0,0,1)},"Stroke"); return {Frame=row}
            end
            function s:AddListbox(o)
                o=options(o); local values=copy(o.Options or {}); assert(#values>0,"Listbox needs options")
                local row,label,entry=self:Row(o,o.Height or 128); label.Size=UDim2.new(1,0,0,20); entry.Kind="Listbox"
                local scroll=make("ScrollingFrame",{Position=UDim2.fromOffset(0,23),Size=UDim2.new(1,0,1,-26),CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,Active=true,BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2},row); list(scroll,2); w:Bind(scroll,"ScrollBarImageColor3","Stroke")
                local buttons={}
                local control=self:Register(o,row,o.Default or values[1],function(_,v) assert(table.find(values,v),"Unknown listbox value"); return v end,function(v)
                    for value,entry in pairs(buttons) do entry.Button.BackgroundColor3=value==v and w.Theme.Hover or w.Theme.Panel; entry.Label.TextColor3=value==v and w.Theme.Text or w.Theme.Muted end
                end)
                local function renderOptions()
                    for _,entry in pairs(buttons) do entry.Button:Destroy() end; buttons={}
                    for _,value in ipairs(values) do
                        local button=w:Button(scroll,{Size=UDim2.new(1,-4,0,24)},"Panel"); corner(button,3)
                        local label=w:Text(button,tostring(value),{Position=UDim2.fromOffset(6,0),Size=UDim2.new(1,-12,1,0),TextSize=11})
                        buttons[value]={Button=button,Label=label}; w:Connect(button.Activated,function() control:Set(value) end)
                    end
                    control:Refresh(); w:PruneBindings()
                end
                function control:SetOptions(options) assert(type(options)=="table" and #options>0,"Options cannot be empty"); values=copy(options); if not table.find(values,self.Value) then self.Value=values[1] end; renderOptions() end
                renderOptions(); return control
            end
            table.insert(self.Sections,s); return s
        end
        function tab:AddConfigManager(o)
            o=o or {};for _,column in ipairs(self.Columns) do column.Visible=false end
            local frame=w:Frame(self.Page,{Name="ConfigManager",Size=UDim2.fromScale(1,1)})
            local input=w:Bind(make("TextBox",{Name="ConfigName",Text="",PlaceholderText="Create a config",ClearTextOnFocus=false,TextSize=12,Font=Enum.Font.BuilderSans,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,BackgroundTransparency=1,Size=UDim2.new(1,-44,0,34)},frame),"TextColor3","Text");w:Bind(input,"PlaceholderColor3","Muted");pad(input,10,0)
            w:Icon(frame,"pencil",{Position=UDim2.new(.45,0,0,10),Size=UDim2.fromOffset(15,15)})
            local add=w:Button(frame,{Name="CreateConfig",Position=UDim2.new(1,-33,0,6),Size=UDim2.fromOffset(26,26)},"Panel");corner(add,4);w:Icon(add,"plus",{Position=UDim2.fromOffset(6,6),Size=UDim2.fromOffset(14,14)})
            w:Frame(frame,{Position=UDim2.fromOffset(0,39),Size=UDim2.new(1,0,0,1)},"Stroke")
            local scroll=make("ScrollingFrame",{Position=UDim2.fromOffset(0,48),Size=UDim2.new(1,0,1,-48),CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,Active=true,BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2},frame);list(scroll,5)
            local manager={Frame=frame,Input=input,CreateButton=add,List=scroll}
            function manager:Refresh()
                for _,child in ipairs(scroll:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
                for index,name in ipairs(w:GetProfileNames()) do
                    local row=w:Frame(scroll,{Name="Profile_"..name,Size=UDim2.new(1,-3,0,63),LayoutOrder=index},"Panel");row.BackgroundTransparency=.4;corner(row,4)
                    w:Text(row,name,{Position=UDim2.fromOffset(10,7),Size=UDim2.new(1,-100,0,22),TextSize=12})
                    w:Text(row,"Creation date: "..(w.ProfileDates[name] or os.date("%d.%m.%Y")),{Position=UDim2.fromOffset(10,30),Size=UDim2.new(1,-100,0,17),TextSize=10},"Muted")
                    local remove=w:Button(row,{Name="Delete",Position=UDim2.new(1,-78,0,18),Size=UDim2.fromOffset(26,28)});w:Icon(remove,"trash-2",{Position=UDim2.fromOffset(5,5),Size=UDim2.fromOffset(16,16)})
                    local load=w:Button(row,{Name="Load",Position=UDim2.new(1,-39,0,18),Size=UDim2.fromOffset(27,28)},"Panel");corner(load,4);w:Icon(load,"play",{Position=UDim2.fromOffset(6,6),Size=UDim2.fromOffset(15,15)})
                    if w.ActiveProfile==name then load.BackgroundColor3=w.Theme.Accent end
                    w:Connect(remove.Activated,function() w:DeleteProfile(name);self:Refresh() end)
                    w:Connect(load.Activated,function() local ok,err=w:LoadProfile(name);if ok then self:Refresh() else w:Notify({Title=err}) end end)
                end
                w:PruneBindings()
            end
            function manager:Create(name)
                if type(name)~="string" or not name:match("%S") then return false,"Enter a config name" end
                local ok,err=w:SaveProfile(name);if ok then w.ActiveProfile=name;w.ProfileDates[name]=os.date("%d.%m.%Y");input.Text="";self:Refresh() end;return ok,err
            end
            w:Connect(add.Activated,function() local ok,err=manager:Create(input.Text);if not ok then w:Notify({Title=err}) end end)
            w:Connect(input.FocusLost,function(enter) if enter then local ok,err=manager:Create(input.Text);if not ok then w:Notify({Title=err}) end end end)
            self.ConfigManager=manager;manager:Refresh();return manager
        end
        table.insert(category.Tabs,tab); table.insert(self.Tabs,tab)
        if not self.ActiveTab then tab:Select() else tab:Refresh() end
        return tab
    end
    function w:ExportConfig()
        local data={Format="SeniorOrbit",Version=1,Values={},Opacity={},Bindings={},KeyModes={},Animations={},Casing=self.Casing,Palette={},Theme=self.ThemeName,MenuKey=self.Keybind.Name,Watermark=self.Watermark.Visible,Hotkeys=self.Hotkeys.Visible}
        for token,color in pairs(self.Theme) do data.Palette[token]=color:ToHex() end
        for flag,control in pairs(self.Flags) do
            local value=control._baseColor or control:Get()
            if typeof(value)=="Color3" then value={Type="Color3",Hex=value:ToHex()} end
            if typeof(value)=="EnumItem" then value={Type="KeyCode",Name=value.Name} end
            data.Values[flag]=value
            if control.Opacity~=nil then data.Opacity[flag]=control._baseAlpha or control.Opacity end
            if control.Keybind then data.Bindings[flag]=control.Keybind.Name; data.KeyModes[flag]=control.KeyMode end
            if control.Animation then data.Animations[flag]=control.Animation end
        end
        return HttpService:JSONEncode(data)
    end
    function w:ImportConfig(json,fireCallbacks)
        local ok,data=pcall(HttpService.JSONDecode,HttpService,json)
        if not ok or type(data)~="table" or data.Format~="SeniorOrbit" or data.Version~=1 or type(data.Values)~="table" then return false,"Invalid Compact config" end
        if (data.Watermark~=nil and type(data.Watermark)~="boolean") or (data.Hotkeys~=nil and type(data.Hotkeys)~="boolean") then return false,"Invalid HUD visibility" end
        local pending,alphas,bindings,palette,keymodes,animations={},{},{},{},{},{}
        local function key(name)
            local valid,value=pcall(function() return (tostring(name):match("^MouseButton[123]$") and Enum.UserInputType or Enum.KeyCode)[name] end); if valid and value and value~=Enum.KeyCode.Unknown then return value end
        end
        for flag,value in pairs(data.Values) do
            local c=self.Flags[flag]
            if c then
                if type(value)=="table" and value.Type=="Color3" then
                    if type(value.Hex)~="string" or not value.Hex:match("^%x%x%x%x%x%x$") then return false,"Invalid color" end; value=Color3.fromHex(value.Hex)
                elseif type(value)=="table" and value.Type=="KeyCode" then value=key(value.Name); if not value then return false,"Invalid key" end end
                local valid,normalized=pcall(c.Normalize,c,value); if not valid then return false,"Invalid value: "..flag end
                table.insert(pending,{c,normalized})
            end
        end
        if data.Opacity~=nil and type(data.Opacity)~="table" then return false,"Invalid opacity map" end
        for flag,value in pairs(data.Opacity or {}) do
            if self.Flags[flag] and self.Flags[flag].SetAlpha then
                if type(value)~="number" or value~=value or value<0 or value>1 then return false,"Invalid opacity" end; table.insert(alphas,{self.Flags[flag],value})
            end
        end
        if data.Bindings~=nil and type(data.Bindings)~="table" then return false,"Invalid binding map" end
        for flag,value in pairs(data.Bindings or {}) do
            if self.Flags[flag] and self.Flags[flag].SetKeybind then local k=key(value); if not k then return false,"Invalid binding" end; table.insert(bindings,{self.Flags[flag],k}) end
        end
        if data.Palette~=nil and type(data.Palette)~="table" then return false,"Invalid palette" end
        for token,value in pairs(data.Palette or {}) do
            if self.Theme[token] then if type(value)~="string" or not value:match("^%x%x%x%x%x%x$") then return false,"Invalid palette color" end; palette[token]=Color3.fromHex(value) end
        end
        local menu=data.MenuKey and key(data.MenuKey) or self.Keybind; if not menu or menu.EnumType~=Enum.KeyCode then return false,"Invalid menu key" end
        if data.Theme and not themes[data.Theme] then return false,"Unknown theme" end
        if data.Casing~=nil and not table.find({"Normal","Lower Case","Upper Case","Bold Case"},data.Casing) then return false,"Invalid casing" end
        if data.KeyModes~=nil and type(data.KeyModes)~="table" then return false,"Invalid key mode map" end
        for flag,mode in pairs(data.KeyModes or {}) do if self.Flags[flag] and self.Flags[flag].SetKeyMode then if mode~="Toggle" and mode~="Hold" then return false,"Invalid key mode" end; table.insert(keymodes,{self.Flags[flag],mode}) end end
        if data.Animations~=nil and type(data.Animations)~="table" then return false,"Invalid animation map" end
        for flag,mode in pairs(data.Animations or {}) do if self.Flags[flag] and self.Flags[flag].SetAnimation then if not table.find({"None","Rainbow","Fade","Fade Alpha"},mode) then return false,"Invalid animation" end; table.insert(animations,{self.Flags[flag],mode}) end end
        if data.Theme then self.ThemeName=data.Theme end
        for token,color in pairs(palette) do self.Theme[token]=color end; self.Theme.AccentText=accentInk(self.Theme.Accent); self.Keybind=menu
        for _,entry in ipairs(bindings) do entry[1]:SetKeybind(entry[2]) end
        for _,entry in ipairs(pending) do if entry[1].SetAnimation then entry[1]:SetAnimation("None",true) end end
        for _,entry in ipairs(alphas) do entry[1]:SetAlpha(entry[2],true) end
        for _,entry in ipairs(pending) do entry[1]:Set(entry[2],fireCallbacks~=true) end
        for _,entry in ipairs(keymodes) do entry[1]:SetKeyMode(entry[2],true) end
        for _,entry in ipairs(animations) do entry[1]:SetAnimation(entry[2],true) end
        if data.Casing then self:SetCasing(data.Casing) end
        if data.Watermark~=nil then self:SetWatermarkVisible(data.Watermark) end
        if data.Hotkeys~=nil then self:SetHotkeysVisible(data.Hotkeys) end
        self:RefreshTheme(); return true
    end
    local profileStore=config.ProfileStore or {};profileStore.Profiles=profileStore.Profiles or {};assert(profileStore.Dates==nil or type(profileStore.Dates)=="table","ProfileStore.Dates must be a table");profileStore.Dates=profileStore.Dates or {};w.Profiles=profileStore.Profiles;w.ProfileDates=profileStore.Dates
    function w:SetAutoload(name) if not self.Profiles[name] then return false,"Profile not found" end; profileStore.Autoload=name; return true end
    function w:GetAutoload() return profileStore.Autoload end
    function w:ClearAutoload() profileStore.Autoload=nil; return true end
    function w:LoadAutoload() if not profileStore.Autoload then return false,"No autoload selected" end; return self:LoadProfile(profileStore.Autoload) end
    function w:GetProfileNames() local names={}; for name in pairs(self.Profiles) do table.insert(names,name) end; table.sort(names); return names end
    function w:SaveProfile(name,overwrite)
        if type(name)~="string" or not name:match("%S") or #name>60 then return false,"Profile name must contain 1–60 characters" end
        if self.Profiles[name] and not overwrite then return false,"Profile already exists" end
        self.Profiles[name]=self:ExportConfig();self.ProfileDates[name]=self.ProfileDates[name] or os.date("%d.%m.%Y"); return true
    end
    function w:LoadProfile(name) if not self.Profiles[name] then return false,"Profile not found" end;local ok,err=self:ImportConfig(self.Profiles[name],false);if ok then self.ActiveProfile=name end;return ok,err end
    function w:DeleteProfile(name) if not self.Profiles[name] then return false,"Profile not found" end; self.Profiles[name]=nil;self.ProfileDates[name]=nil;if self.ActiveProfile==name then self.ActiveProfile=nil end; if self:GetAutoload()==name then self:ClearAutoload() end; return true end
    function w:RefreshToasts()
        for i,toast in ipairs(self._toasts) do toast.Position=UDim2.new(1,-12,0,12+(i-1)*(30*scale.Scale+5)); local sf=toast:FindFirstChild("ToastScale"); if sf then sf.Scale=scale.Scale end end
    end
    function w:Notify(o)
        if self.Destroyed or self.HideNotifications then return end; o=options(o); local title=tostring(o.Title or "Senior Orbit")
        local row=self:Frame(gui,{Name="Notification",AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-12,0,12),Size=UDim2.fromOffset(clamp(#title*5.5+32,120,300),30),ZIndex=300},"Sidebar"); corner(row,4); self:Stroke(row); make("UIScale",{Name="ToastScale",Scale=scale.Scale},row)
        self:Icon(row,o.Icon or "check",{Position=UDim2.fromOffset(7,8),Size=UDim2.fromOffset(13,13),ZIndex=301},"Accent")
        self:Text(row,title,{Position=UDim2.fromOffset(27,0),Size=UDim2.new(1,-33,1,0),TextSize=10,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=301})
        table.insert(self._toasts,row); if #self._toasts>3 then table.remove(self._toasts,1):Destroy() end; self:RefreshToasts()
        task.delay(math.max(.5,tonumber(o.Duration) or 3),function() if self.Destroyed then return end; local i=table.find(self._toasts,row); if i then table.remove(self._toasts,i); row:Destroy(); self:PruneBindings(); self:RefreshToasts() end end)
    end
    w:RefreshHotkeys()
    w:Connect(UIS.WindowFocusReleased,function() for _,control in ipairs(w.Controls) do if control.KeyMode=="Hold" and control.Value then control:Set(false) end end end)
    local animationTime=0;local metricTime=0;local smoothFPS=60
    w:Connect(game:GetService("RunService").RenderStepped,function(dt)
        local delta=tonumber(dt) or 1/60;animationTime=animationTime+delta;metricTime=metricTime+delta
        if delta>0 then smoothFPS=smoothFPS*.9+(.1/delta) end
        if metricTime>=.5 and not config.WatermarkText and not w.CustomWatermark then
            metricTime=0;local ping=0
            pcall(function() ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() end)
            w.WatermarkText.Text=(player and player.DisplayName or "Player").."  |  "..(config.MapName or game.Name or "Roblox").."  |  "..math.floor(smoothFPS+.5).." FPS  |  "..math.floor(ping+.5).." ms  |  "..os.date("%H:%M:%S");w:FitWatermark()
        end
        for _,control in ipairs(w.Controls) do if w.Destroyed then break end; if control.StepAnimation then control:StepAnimation(animationTime) end end
    end)
    windowCreated = true
    return w
end
Library.Themes=themes; Library.Icons=Icons
return Library
end)()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local C = (getgenv and getgenv()) or _G
cloneref = cloneref or function(v) return v end
gethui = gethui or get_hidden_gui
protect_gui = protect_gui or protectgui or (syn and syn.protect_gui)
if C.__INFERNITY_HUB_CLEANUP then pcall(C.__INFERNITY_HUB_CLEANUP) end
local P = 1500
local T = {
    monitorarStaff = false, sorte2xEnabled = false,
    espEnabled = false, box = false, name = false, distance = false, heldItem = false,
    skeleton = false, highlight = false, tracer = false, arrow = false, box3d = false, teamTag = false,
    maxDistance = P, bundles = {}, spoofWalkEnabled = false, spoofJumpEnabled = false,
    spoofWalkSpeed = 40, spoofJumpPower = 90,
    walkSpeedKeybind = Enum.KeyCode.V, menuKeybind = Enum.KeyCode.Insert,
    noclipEnabled = false, noclipKeybind = Enum.KeyCode.N,
    flyEnabled = false, flyKeybind = Enum.KeyCode.F, flySpeed = 60,
    ghostEnabled = false, spinEnabled = false, spinSpeed = 720,
    aimbotEnabled = false, aimbotMode = "Legit", aimbotFov = 120, aimbotDistance = 500,
    aimbotVisibleOnly = false, aimbotFovVisible = false,
    aimbotHitChance = 100, aimbotBodyPart = "Cabeca", aimbotSmoothness = 0.15,
    aimbotTargetMode = "Closest", aimbotWallCheck = false, aimbotTeamCheck = false,
    aimbotKeybind = Enum.KeyCode.E, friendCheck = false, adminCheck = false,
    armaTracer = false, armaTracerCor = "Ciano",
    perfectLockpick = false, returnOnWeaponPickup = false,
    pullWeaponsEnabled = false,
    autoFarmLixeiroEnabled = false, autoFarmLixeiroQuantidade = 20,
    farmPartesEnabled = false,
    durabilidadeHudEnabled = false,
    autoCintoEnabled = false,
    noclipCarEnabled = false, vFlyEnabled = false,
    vFlyHorizontalSpeed = 60, vFlyVerticalSpeed = 30,
    boostFactor = 1, fullbright = false, noLag = false,
    autoFarmPescaEnabled = false,
    autoColetaEnabled = false, autoColetaCooldown = 0.35,
    coletaHudEnabled = false, coletaYOffset = 3, coletaReachDistance = 4,
    camuflarNickEnabled = false, antiAFKEnabled = false, autoRobberyEnabled = false,
    carEspEnabled = false, carEspDistance = 1500, reducedMotion = false,
}
local o = {
    connections = {}, placeMatched = tostring(game.PlaceId) == "125299131646017",
    destroyed = false,
    itemTeleportRunId = 0, farmPartesRunId = 0, farmPartesColetadas = 0,
    garbageFarmRunId = 0, garbageFarmStatus = "Parado",
    durabilidadeRunId = 0,
    relationships = {}, relationshipConnections = {}, staffCount = 0, staffNames = {},
    pescaRunId = 0, pescaStatus = "Parado", pescaColetados = 0,
    coletaRunId = 0, coletaHudRunId = 0,
}
C.__INFERNITY_HUB_RUNTIME = o
o.state = T
local function handleReady(conn) table.insert(o.connections, conn); return conn end
local function Xz(msg)
    pcall(function()
        S:Notify({ Title = "INFERNITY HUB", Description = tostring(msg), Duration = 3, Tone = "Info" })
    end)
end
local function isCValid()
    local c = LocalPlayer.Character
    return c and c:FindFirstChildOfClass("Humanoid") or nil
end
local function isRoot()
    local c = LocalPlayer.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end
do
    local function setupACBypass()
        local getgc = getgc or get_gc_objects
        local getupvalues = debug and debug.getupvalues
        local setupvalue = debug and debug.setupvalue
        if not (getgc and getupvalues and setupvalue) then
            warn("[AC Bypass] Executor sem suporte.")
            return { acSilenciados = 0, acStatus = "Sem suporte", destroyed = false }
        end
        local patched = 0
        local foundAC = false
        local function safePatch(fn)
            local ok, ups = pcall(getupvalues, fn)
            if not ok or type(ups) ~= "table" then return end
            for i, val in pairs(ups) do
                if type(val) == "function" then
                    local success = pcall(setupvalue, fn, i, function() return nil end)
                    if success then patched = patched + 1 end
                elseif type(val) == "table" and (rawget(val, "Teleporte") or rawget(val, "Velocidade")) then
                    local success = pcall(setupvalue, fn, i, setmetatable({}, {__index = function() return 0 end}))
                    if success then patched = patched + 1 end
                end
            end
        end
        local function applyBypass(source)
            task.spawn(function()
                local okGc, gcObjects = pcall(getgc, true)
                if not okGc or type(gcObjects) ~= "table" then
                    warn("[AC Bypass] getgc falhou (" .. tostring(source) .. ").")
                    return
                end
                for _, obj in pairs(gcObjects) do
                    if type(obj) == "function" then
                        local okInfo, src = pcall(debug.info, obj, "s")
                        if okInfo and type(src) == "string" and src:find("ClientAC") then
                            foundAC = true
                            safePatch(obj)
                        end
                    end
                end
                if foundAC then
                    print("[AC Bypass] ClientAC silenciado (" .. tostring(source) .. "). " .. patched .. " variáveis anuladas.")
                else
                    warn("[AC Bypass] ClientAC não encontrado (" .. tostring(source) .. ").")
                end
            end)
        end
        applyBypass("carga")
        if game:GetService("Players").LocalPlayer then
            game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
                applyBypass("respawn")
            end)
        end
        return {
            acSilenciados = 1,
            acMotivosVivos = {},
            acStatus = "Bypass Ativo",
            destroyed = false
        }
    end
    o.acRuntime = setupACBypass()
end
local Jz = {}
do
    local rankMin = 254
    local friendCol = Color3.fromRGB(60, 210, 255)
    local normCol = Color3.fromRGB(170, 70, 255)
    local staffCol = Color3.fromRGB(255, 20, 40)
    local keywords = { "admin","staff","moder","owner","founder","creator","developer",
        "dono","fundador","gerente","supervis","diretor","gestor" }
    local function hasKeyword(s)
        s = string.lower(tostring(s or ""))
        for _, k in ipairs(keywords) do
            if string.find(s, k, 1, true) then return true end
        end
        return false
    end
    local function isTruthy(v)
        local t = typeof(v)
        if t == "boolean" then return v end
        if t == "number" then return v > 0 end
        if t == "string" then
            local s = string.lower(v)
            return s ~= "" and s ~= "false" and s ~= "0" and s ~= "none" and s ~= "guest" and s ~= "member"
        end
        return v ~= nil
    end
    local function isConfiguredStaff(plr)
        local list = C.INFERNITY_HUB_STAFF_USER_IDS
        if type(list) ~= "table" then return false end
        return list[plr.UserId] == true or list[tostring(plr.UserId)] == true or table.find(list, plr.UserId) ~= nil
    end
    local function isAdminRaw(plr)
        if isConfiguredStaff(plr) then return true, "configured" end
        if game.CreatorType == Enum.CreatorType.User and plr.UserId == game.CreatorId then
            return true, "creator"
        end
        local okA, attrs = pcall(function() return plr:GetAttributes() end)
        if okA then
            for k, v in pairs(attrs) do
                if hasKeyword(k) and isTruthy(v) then return true, "attribute:" .. k end
            end
        end
        local okT, tags = pcall(CollectionService.GetTags, CollectionService, plr)
        if okT then
            for _, tag in ipairs(tags) do
                if hasKeyword(tag) then return true, "tag:" .. tag end
            end
        end
        return false, nil
    end
    local function getRel(plr)
        local r = o.relationships[plr]
        if r then return r end
        r = { ready = false, checking = false, friend = false, admin = false, rank = 0, role = "", source = nil }
        o.relationships[plr] = r
        return r
    end
    local function checkReady(plr)
        if plr == LocalPlayer or plr.Parent ~= Players then return end
        local rel = getRel(plr)
        if rel.checking then return end
        rel.checking = true
        task.spawn(function()
            local friend = false
            local okF, res = pcall(function() return LocalPlayer:IsFriendsWith(plr.UserId) end)
            if okF then friend = res == true end
            local admin, src = isAdminRaw(plr)
            local rank, role = 0, ""
            if game.CreatorType == Enum.CreatorType.Group and game.CreatorId > 0 then
                local okR, r = pcall(function() return plr:GetRankInGroup(game.CreatorId) end)
                if okR and type(r) == "number" then rank = r end
                local okRo, ro = pcall(function() return plr:GetRoleInGroup(game.CreatorId) end)
                if okRo and type(ro) == "string" then role = ro end
                if rank >= rankMin then admin, src = true, "group-rank:" .. rank
                elseif hasKeyword(role) then admin, src = true, "group-role:" .. role end
            end
            if plr.Parent == Players and o.relationships[plr] == rel then
                rel.friend = friend
                rel.admin = admin
                rel.rank = rank
                rel.role = role
                rel.source = src
                rel.ready = true
                rel.checking = false
            end
        end)
    end
    local function getRelSafe(plr)
        local r = getRel(plr)
        if not r.ready and not r.checking then checkReady(plr) end
        return r
    end
    function Jz.Protected(plr)
        local r = getRelSafe(plr)
        if (T.friendCheck or T.adminCheck) and not r.ready then return true end
        if T.adminCheck and r.admin then return true end
        if T.friendCheck and r.friend then return true end
        return false
    end
    Jz.Admin = function(plr)
        local r = getRelSafe(plr)
        return r.ready and r.admin
    end
    Jz.Appearance = function(plr)
        local r = getRelSafe(plr)
        if r.ready and (T.adminCheck and r.admin) then return staffCol, " [STAFF]" end
        if r.ready and (T.friendCheck and r.friend) then return friendCol, " [AMIGO]" end
        return normCol, ""
    end
    local function onAdded(plr)
        if plr == LocalPlayer then return end
        checkReady(plr)
        local conn = plr.AttributeChanged:Connect(function(name)
            if hasKeyword(name) then
                local r = o.relationships[plr]
                if r then r.ready = false end
                checkReady(plr)
            end
        end)
        o.relationshipConnections[plr] = conn
        handleReady(conn)
    end
    for _, plr in ipairs(Players:GetPlayers()) do onAdded(plr) end
    handleReady(Players.PlayerAdded:Connect(onAdded))
    handleReady(Players.PlayerRemoving:Connect(function(plr)
        o.relationships[plr] = nil
        o.relationshipConnections[plr] = nil
    end))
end
local U = Vector3.zero
task.spawn(function()
    while not o.destroyed do
        local hum = isCValid()
        if hum then U = hum.MoveDirection end
        task.wait(0.05)
    end
end)
local L = 28
local function isUpdateInstancePropertiesEValid()
    local ac = o.acRuntime
    return ac ~= nil and not ac.destroyed and not ac.acAplicando and (ac.acSilenciados or 0) > 0
        and (ac.acMotivosVivos == nil or #ac.acMotivosVivos == 0)
end
local b = {
    [Enum.HumanoidStateType.Seated] = true,
    [Enum.HumanoidStateType.Dead] = true,
    [Enum.HumanoidStateType.Climbing] = true,
}
local y = 0.5
local x = 18
local c = 34
local l = 36
local Z = 0.08
local D = 16
local function handleG(arr, now)
    local sum = 0
    for i = #arr, 1, -1 do
        if now - arr[i].t > y then
            table.remove(arr, i)
        else
            sum = sum + arr[i].passo
        end
    end
    return sum
end
local function handleInstanceProperties(arr, now, from, to)
    if not to then return end
    local d = (to - from).Magnitude
    if d > 0 then
        table.insert(arr, { t = now, passo = d })
    end
end
local j = { root = nil, posicao = nil, ultimaAmostra = 0, historico = {} }
local function updateG(root, now)
    local st = j
    if st.root ~= root or now - st.ultimaAmostra > y then
        st.root = root
        st.posicao = root.Position
        st.ultimaAmostra = now
        table.clear(st.historico)
        return 0
    end
    handleInstanceProperties(st.historico, now, st.posicao, root.Position)
    st.posicao = root.Position
    st.ultimaAmostra = now
    return handleG(st.historico, now)
end
local function isGhValid(root, dt)
    local hum = isCValid()
    if root.Anchored or not hum or hum.Health <= 0 or dt >= Z then return true end
    local st = hum:GetState()
    return root.AssemblyLinearVelocity.Magnitude < 12
        and (st ~= Enum.HumanoidStateType.Freefall and st ~= Enum.HumanoidStateType.Jumping)
end
local function handleQ(root, dt, targetVel, isFly)
    local step = math.clamp(dt or 0.016666, 0.004166, y)
    local moved = updateG(root, os.clock())
    local stable = not isFly or isGhValid(root, step)
    local slow = isFly and (stable and moved > x)
    local cap = isFly and (stable and x or c) or x
    if slow then cap = c end
    local slack = math.max(0, cap - moved)
    local vel = math.min(math.max(targetVel or 0, 0), slack / step)
    local phys = math.max(0, slack - vel * step)
    if slow then phys = 0 end
    return step, vel, phys, moved, stable
end
o.handleQ = handleQ
local w, a, i, d = 4, 8, 105, 65
local G, t, K = 0.05, 0.6, 14
local Cz, Yz, gz = 20, 14, 0.55
local mz = Vector3.zero
local Ez, Mz, Hz, Az = 0, 0, 4, 0
local function Fz(dt)
    if not T.spoofWalkEnabled then Az = 0; return end
    if T.flyEnabled or T.autoFarmPescaEnabled or T.farmPartesEnabled then Az = 0; return end
    local root = isRoot()
    if not root then return end
    local hum = isCValid()
    if not hum then return end
    if hum.Sit or b[hum:GetState()] then Az = 0; return end
    if U.Magnitude <= 0 then
        Az = 0
        if os.clock() < Ez and mz.Magnitude > 0 then
            local ws = math.max(hum.WalkSpeed, 1)
            local frac = math.clamp(Yz / ws, 0, 1)
            pcall(hum.Move, hum, mz * frac, false)
        end
        return
    end
    mz = U.Unit
    Ez = os.clock() + gz
    local vel = root.AssemblyLinearVelocity
    local horiz = Vector3.new(vel.X, 0, vel.Z).Magnitude
    if (dt or 0) >= G or root.Anchored or horiz < 12 then
        Mz = os.clock() + t
    end
    local unblocked = isUpdateInstancePropertiesEValid()
    local speed = math.min(T.spoofWalkSpeed, unblocked and T.spoofWalkSpeed or (os.clock() < Mz and d or i))
    local diff = speed - L
    if diff <= 0 then Az = 0; return end
    local jitter = 0.9 + math.random() * 0.1
    local want = (diff * dt) * jitter + Az
    local step = math.min(want, diff * dt, unblocked and a or w)
    Az = math.clamp(want - step, 0, Hz)
    local dir = U.Unit
    root.CFrame = root.CFrame + dir * step
    local v = root.AssemblyLinearVelocity
    if Vector3.new(v.X, 0, v.Z).Magnitude < K then
        root.AssemblyLinearVelocity = Vector3.new(dir.X * Cz, v.Y, dir.Z * Cz)
    end
end
o.Fz = Fz
do
    local tracked, saved
    local function restore()
        if tracked and saved then
            pcall(function()
                tracked.UseJumpPower = saved.UseJumpPower
                tracked.JumpPower = saved.JumpPower
                tracked.JumpHeight = saved.JumpHeight
                tracked:SetStateEnabled(Enum.HumanoidStateType.Jumping, saved.Jumping)
            end)
        end
        tracked, saved = nil, nil
    end
    function o.updateJumpPower(hum)
        if tracked ~= hum then restore() end
        if not T.spoofJumpEnabled or o.destroyed or not hum then
            restore()
            return
        end
        if not saved then
            tracked = hum
            saved = {
                UseJumpPower = hum.UseJumpPower,
                JumpPower = hum.JumpPower,
                JumpHeight = hum.JumpHeight,
                Jumping = hum:GetStateEnabled(Enum.HumanoidStateType.Jumping),
            }
        end
        local power = math.clamp(tonumber(T.spoofJumpPower) or 90, 0, 1000)
        if not hum.UseJumpPower then hum.UseJumpPower = true end
        if hum.JumpPower ~= power then hum.JumpPower = power end
        if not T.flyEnabled and not T.ghostEnabled and not hum.Sit then
            hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end
    end
    function o.setJumpPower(v)
        T.spoofJumpEnabled = v == true
        o.updateJumpPower(isCValid())
    end
    o.restoreJumpPower = restore
    o.uz = function() o.updateJumpPower(isCValid()) end
    handleReady(UserInputService.JumpRequest:Connect(function()
        if T.spoofJumpEnabled and not o.destroyed then pcall(o.uz) end
    end))
end
local sz, Nz, ez
do
    local leases = {}
    local originals = setmetatable({}, { __mode = "k" })
    local character
    local function restore()
        for part, collidable in pairs(originals) do
            if part.Parent then pcall(function() part.CanCollide = collidable end) end
        end
        table.clear(originals)
    end
    local function wanted()
        return T.noclipEnabled or T.noclipCarEnabled or T.vFlyEnabled or next(leases) ~= nil
    end
    local function step(force)
        local current = LocalPlayer.Character
        if character ~= current then restore(); character = current end
        if o.destroyed or not current or (force ~= true and not wanted()) then restore(); return end
        for _, part in ipairs(current:GetDescendants()) do
            if part:IsA("BasePart") then
                if originals[part] == nil then originals[part] = part.CanCollide end
                if part.CanCollide then part.CanCollide = false end
            end
        end
    end
    o.noclip = {
        acquire = function(owner) leases[owner] = true; step() end,
        release = function(owner) leases[owner] = nil; step() end,
        step = function() step() end,
        restore = function() table.clear(leases); restore() end,
    }
    sz = function(force) step(force) end
    Nz = function() step() end
    ez = function() end
    o.sz, o.Nz, o.ez = sz, Nz, ez
    handleReady(LocalPlayer.CharacterAdded:Connect(function() step() end))
end
local Uz, Lz, kz = 60, 30, 14
local nz = Uz
local bz = Vector3.zero
local yz = false
local function xz(dt)
    local root = isRoot()
    local hum = isCValid()
    if not root or not hum then return end
    if not T.flyEnabled then
        hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        if hum:GetState() == Enum.HumanoidStateType.Swimming then
            local target = hum.FloorMaterial == Enum.Material.Air
                and Enum.HumanoidStateType.Freefall or Enum.HumanoidStateType.Running
            pcall(hum.ChangeState, hum, target)
        end
        if T.autoFarmPescaEnabled or T.farmPartesEnabled then yz = false; return end
        if isUpdateInstancePropertiesEValid() then
            yz = false
            root.AssemblyLinearVelocity = Vector3.zero
            return
        end
        local _, vel, phys, _, stable = handleQ(root, dt, kz, true)
        if yz and (stable and bz.Magnitude > 0) then
            root.AssemblyLinearVelocity = bz * vel
            return
        end
        yz = false
        root.AssemblyLinearVelocity = Vector3.zero
        return
    end
    if hum.Health <= 0 then return end
    local flySpeed = math.clamp(tonumber(T.flySpeed) or 60, 0, 100)
    hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    hum:ChangeState(Enum.HumanoidStateType.Swimming)
    local vert = 0
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vert = 1
    elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vert = -1 end
    local dir = hum.MoveDirection + Vector3.new(0, vert, 0)
    if dir.Magnitude <= 0 then
        if isUpdateInstancePropertiesEValid() then
            root.AssemblyLinearVelocity = Vector3.zero
            return
        end
        local _, vel, _, _, stable = handleQ(root, dt, kz, true)
        if stable and bz.Magnitude > 0 then
            root.AssemblyLinearVelocity = bz * vel
        else
            root.AssemblyLinearVelocity = Vector3.zero
        end
        return
    end
    dir = dir.Unit
    bz = dir
    yz = true
    if isUpdateInstancePropertiesEValid() then
        root.AssemblyLinearVelocity = dir * flySpeed
        return
    end
    local cap = hum.MoveDirection.Magnitude > 0 and Uz or nz
    local goal = math.min(flySpeed, cap)
    local vel = math.min(goal, Lz)
    local _, step, _, _, stable = handleQ(root, dt, vel, true)
    local wanted = math.min(goal, stable and l or Uz)
    local want2 = math.max(0, wanted - step)
    if want2 > 0 then
        root.CFrame = root.CFrame + dir * want2 * (dt or 0.016)
    end
    root.AssemblyLinearVelocity = dir * step
end
o.xz = xz
do
    local HEIGHT = 10
    local PLATFORM_OFFSET = 3.5
    local WALK_ANIMATION_R15 = "rbxassetid://507777826"
    local WALK_ANIMATION_R6 = "rbxassetid://180426354"
    local isGhost = false
    local fakeModel = nil
    local platform = nil
    local walkTrack = nil
    local camLockConnection = nil
    local ghostNoclipEnabled = false
    local changedParts = {}
    local targetY = 0
    local ghostConnection = nil
    local ghostNoclipLoop = nil
    local overlapParams = OverlapParams.new()
    overlapParams.FilterType = Enum.RaycastFilterType.Exclude
    local function startGhostNoclip()
        if ghostNoclipEnabled then return end
        ghostNoclipEnabled = true
        table.clear(changedParts)
        ghostNoclipLoop = RunService.Stepped:Connect(function()
            if not ghostNoclipEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            overlapParams.FilterDescendantsInstances = { char, fakeModel, platform }
            local parts = workspace:GetPartBoundsInBox(root.CFrame, Vector3.new(4, 6, 4), overlapParams)
            for _, part in ipairs(parts) do
                if part:IsA("BasePart") and part.Parent and part ~= platform and part.CanCollide then
                    if changedParts[part] == nil then changedParts[part] = true end
                    part.CanCollide = false
                end
            end
        end)
    end
    local function stopGhostNoclip()
        ghostNoclipEnabled = false
        if ghostNoclipLoop then ghostNoclipLoop:Disconnect(); ghostNoclipLoop = nil end
        for part in pairs(changedParts) do
            if part and part.Parent and part ~= platform then part.CanCollide = true end
        end
        table.clear(changedParts)
    end
    local function setupFakeCharacter(model)
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        humanoid.AutoRotate = false
        humanoid.PlatformStand = true
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        for _, state in ipairs({ Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Ragdoll,
            Enum.HumanoidStateType.Jumping, Enum.HumanoidStateType.Climbing,
            Enum.HumanoidStateType.Swimming, Enum.HumanoidStateType.Freefall,
            Enum.HumanoidStateType.Flying }) do
            pcall(function() humanoid:SetStateEnabled(state, false) end)
        end
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Anchored = true
                obj.CanCollide = false
                obj.CanTouch = false
                obj.CanQuery = false
                obj.Massless = true
            elseif obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        local animation = Instance.new("Animation")
        animation.Name = "InfernityGhostWalk"
        animation.AnimationId = (humanoid.RigType == Enum.HumanoidRigType.R15) and WALK_ANIMATION_R15 or WALK_ANIMATION_R6
        local success, track = pcall(function() return animator:LoadAnimation(animation) end)
        if success and track then
            walkTrack = track
            walkTrack.Looped = true
            walkTrack.Priority = Enum.AnimationPriority.Movement
        end
        return true
    end
    local function updateFakeAnimation(realHumanoid)
        if not walkTrack then return end
        local moving = realHumanoid.MoveDirection.Magnitude > 0.05
        if moving then
            if not walkTrack.IsPlaying then walkTrack:Play(0.12) end
            walkTrack:AdjustSpeed(math.clamp(realHumanoid.WalkSpeed / 16, 0.5, 2))
        else
            if walkTrack.IsPlaying then walkTrack:Stop(0.12) end
        end
    end
    local function updateCameraAndGhost()
        if not isGhost or not fakeModel or not LocalPlayer.Character then return end
        local realChar = LocalPlayer.Character
        local realRoot = realChar:FindFirstChild("HumanoidRootPart")
        if not realRoot or not platform then return end
        local fakeHumanoid = fakeModel:FindFirstChildOfClass("Humanoid")
        if fakeHumanoid and workspace.CurrentCamera.CameraSubject ~= fakeHumanoid then
            workspace.CurrentCamera.CameraSubject = fakeHumanoid
        end
        local currentPos = realRoot.Position
        realRoot.AssemblyLinearVelocity = Vector3.new(
            realRoot.AssemblyLinearVelocity.X, 0, realRoot.AssemblyLinearVelocity.Z)
        platform.CFrame = CFrame.new(currentPos.X, targetY - PLATFORM_OFFSET, currentPos.Z)
        fakeModel:PivotTo(CFrame.new(currentPos.X, targetY + HEIGHT, currentPos.Z) * realRoot.CFrame.Rotation)
        local realHumanoid = realChar:FindFirstChildOfClass("Humanoid")
        if realHumanoid then updateFakeAnimation(realHumanoid) end
    end
    local function stopGhost()
        if not isGhost then return end
        isGhost = false
        RunService:UnbindFromRenderStep("InfernityGhostCameraFix")
        if camLockConnection then camLockConnection:Disconnect(); camLockConnection = nil end
        stopGhostNoclip()
        if walkTrack then pcall(function() walkTrack:Stop(0.1) end); walkTrack = nil end
        local realChar = LocalPlayer.Character
        local realRoot = realChar and realChar:FindFirstChild("HumanoidRootPart")
        local realHumanoid = realChar and realChar:FindFirstChildOfClass("Humanoid")
        if realHumanoid then realHumanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end
        if realRoot and fakeModel then
            local fakeRoot = fakeModel:FindFirstChild("HumanoidRootPart")
            if fakeRoot then realRoot.CFrame = fakeRoot.CFrame end
        end
        if realChar then
            for _, obj in ipairs(realChar:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Transparency = 0
                    obj.CanTouch = true
                    obj.CanQuery = true
                    obj.CanCollide = true
                end
            end
            if realHumanoid then workspace.CurrentCamera.CameraSubject = realHumanoid end
        end
        if fakeModel then fakeModel:Destroy(); fakeModel = nil end
        if platform then platform:Destroy(); platform = nil end
    end
    local function startGhost()
        local realChar = LocalPlayer.Character
        if not realChar then return end
        local realRoot = realChar:FindFirstChild("HumanoidRootPart")
        local realHumanoid = realChar:FindFirstChildOfClass("Humanoid")
        if not realRoot or not realHumanoid then return end
        isGhost = true
        realHumanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        local startCFrame = realRoot.CFrame
        targetY = startCFrame.Y - HEIGHT
        platform = Instance.new("Part")
        platform.Name = "InfernityGhostPlatform"
        platform.Size = Vector3.new(10, 1, 10)
        platform.Anchored = true
        platform.CanCollide = true
        platform.CanTouch = false
        platform.CanQuery = false
        platform.Transparency = 1
        platform.Parent = workspace
        realChar.Archivable = true
        for _, desc in ipairs(realChar:GetDescendants()) do desc.Archivable = true end
        local success, clonedChar = pcall(function() return realChar:Clone() end)
        if not success or not clonedChar then stopGhost(); return end
        fakeModel = clonedChar
        fakeModel.Name = "InfernityGhostVisual"
        for _, obj in ipairs(fakeModel:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then obj:Destroy() end
        end
        fakeModel.Parent = workspace
        local fakeRoot = fakeModel:FindFirstChild("HumanoidRootPart")
        local fakeHumanoid = fakeModel:FindFirstChildOfClass("Humanoid")
        if not fakeRoot or not fakeHumanoid then stopGhost(); return end
        fakeModel.PrimaryPart = fakeRoot
        if not setupFakeCharacter(fakeModel) then stopGhost(); return end
        fakeModel:PivotTo(startCFrame)
        for _, obj in ipairs(realChar:GetDescendants()) do
            if obj:IsA("BasePart") then obj.Transparency = 1 end
        end
        startGhostNoclip()
        realRoot.CFrame = CFrame.new(startCFrame.X, targetY, startCFrame.Z) * startCFrame.Rotation
        workspace.CurrentCamera.CameraSubject = fakeHumanoid
        camLockConnection = workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            if isGhost and fakeHumanoid and workspace.CurrentCamera.CameraSubject ~= fakeHumanoid then
                workspace.CurrentCamera.CameraSubject = fakeHumanoid
            end
        end)
        RunService:BindToRenderStep("InfernityGhostCameraFix", Enum.RenderPriority.Last.Value, updateCameraAndGhost)
    end
    o.startGhost = startGhost
    o.stopGhost = stopGhost
    o.isGhostActive = function() return isGhost end
    handleReady(LocalPlayer.CharacterAdded:Connect(function()
        if isGhost then stopGhost() end
    end))
end
do
    local NOME_FAKE = "@souzadevz"
    local bindings = {}
    local elapsed = 0
    local function bind(obj, prop)
        if not obj or bindings[obj] then return end
        local ok, original = pcall(function() return obj[prop] end)
        if not ok or type(original) ~= "string" then return end
        local entry = { original = original, prop = prop, writing = false }
        bindings[obj] = entry
        local function enforce()
            if entry.writing or not T.camuflarNickEnabled or o.destroyed or not obj.Parent then return end
            local text = obj[prop]
            if text == NOME_FAKE then return end
            entry.original = text
            entry.writing = true
            obj[prop] = NOME_FAKE
            entry.writing = false
        end
        entry.connection = obj:GetPropertyChangedSignal(prop):Connect(function() pcall(enforce) end)
        enforce()
    end
    local function discover()
        for obj, entry in pairs(bindings) do
            if not obj.Parent then
                entry.connection:Disconnect()
                bindings[obj] = nil
            end
        end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        local inventory = pg and pg:FindFirstChild("InventoryUI")
        local frame = inventory and inventory:FindFirstChild("InvFrame")
        local personal = frame and frame:FindFirstChild("InvPessoal")
        local name = personal and personal:FindFirstChild("BTxt")
        if name and (name:IsA("TextLabel") or name:IsA("TextButton") or name:IsA("TextBox")) then
            bind(name, "Text")
        end
        local hum = isCValid()
        if hum then bind(hum, "DisplayName") end
    end
    local function restore()
        for obj, entry in pairs(bindings) do
            entry.connection:Disconnect()
            if obj.Parent then pcall(function() obj[entry.prop] = entry.original end) end
        end
        table.clear(bindings)
    end
    function o.setCamuflarNick(v)
        T.camuflarNickEnabled = v == true
        if T.camuflarNickEnabled and not o.destroyed then
            discover()
        else
            restore()
        end
    end
    handleReady(RunService.Heartbeat:Connect(function(dt)
        if not T.camuflarNickEnabled or o.destroyed then return end
        elapsed = elapsed + dt
        if elapsed >= 0.35 then elapsed = 0; pcall(discover) end
    end))
end
do
    local acc = 0
    local function autoCinto()
        local st = LocalPlayer:FindFirstChild("Status")
        local cinto = st and st:FindFirstChild("Cinto")
        if not cinto or cinto.Value then return end
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local seat = hum and hum.SeatPart
        if not seat or seat.Name ~= "DriveSeat" then return end
        cinto.Value = true
        pcall(function()
            LocalPlayer.PlayerGui.OrpheusCarInterface.Velocimetro.Icons.Cinto.Visible = true
        end)
        pcall(function()
            local sound = seat:FindFirstChild("ColocaCinto")
            if sound then sound:Play() end
        end)
    end
    handleReady(RunService.Heartbeat:Connect(function(dt)
        if not T.autoCintoEnabled then return end
        acc = acc + dt
        if acc < 0.3 then return end
        acc = 0
        pcall(autoCinto)
    end))
end
local function Dz(hum)
    if type(getconnections) ~= "function" then return nil end
    if type(debug) ~= "table" or type(debug.getupvalue) ~= "function" then return nil end
    for _, conn in ipairs(getconnections(RunService.Stepped)) do
        local fn = conn.Function
        if type(fn) == "function" then
            local hit, carState
            for i = 1, 8 do
                local ok, up = pcall(debug.getupvalue, fn, i)
                if not ok then break end
                if up == hum then hit = true end
                if type(up) == "table" and up.RemapMultiplier ~= nil and type(up.BuildHPCache) == "function" then
                    carState = up
                end
            end
            if hit and carState then return carState end
        end
    end
    return nil
end
local function rz()
    local hum = isCValid()
    local seat = hum and hum.SeatPart
    if not seat or seat.Name ~= "DriveSeat" then return nil end
    local carros = workspace:FindFirstChild("CarrosSpawnados")
    if not carros then return nil end
    local p = seat
    while p and p.Parent ~= carros do p = p.Parent end
    return p
end
do
    local carCfg = {
        carro = nil, originais = {}, raiz = nil, assento = nil,
        relativoAssento = nil, altura = nil, piso = nil, raycast = nil,
        velocidade = 0, frente = nil, personagemAtivo = false,
        altitude = nil, vFlyAtivo = false, vFlyReduzidoAte = 0,
    }
    local function findSeat(car)
        local seat = car:FindFirstChild("DriveSeat", true) or car:FindFirstChildWhichIsA("VehicleSeat", true)
        return (seat and seat.AssemblyRootPart) or car.PrimaryPart or seat, seat
    end
    local function restaurarNoclipCar()
        for part, v in pairs(carCfg.originais) do
            if part.Parent then pcall(function() part.CanCollide = v end) end
        end
        table.clear(carCfg.originais)
        if carCfg.personagemAtivo and not T.noclipEnabled then pcall(sz, false) end
        carCfg.carro, carCfg.raiz, carCfg.assento = nil, nil, nil
        carCfg.relativoAssento, carCfg.altura, carCfg.piso, carCfg.raycast = nil, nil, nil, nil
        carCfg.velocidade, carCfg.frente, carCfg.personagemAtivo = 0, nil, false
        carCfg.altitude, carCfg.vFlyAtivo, carCfg.vFlyReduzidoAte = nil, false, 0
    end
    local function prepararNoclipCar(car)
        local raiz, seat = findSeat(car)
        if not raiz or not seat then return end
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = { car, LocalPlayer.Character }
        local hit = workspace:Raycast(raiz.Position + Vector3.new(0, 20, 0), Vector3.new(0, -120, 0), rp)
        carCfg.raiz = raiz
        carCfg.assento = seat
        carCfg.relativoAssento = ((raiz.CFrame - raiz.Position)):ToObjectSpace(seat.CFrame - seat.Position)
        carCfg.raycast = rp
        carCfg.piso = hit and hit.Position.Y or (raiz.Position.Y - 3)
        carCfg.altura = hit and math.max(1, raiz.Position.Y - hit.Position.Y) or 3
        local fwd = Vector3.new(seat.CFrame.LookVector.X, 0, seat.CFrame.LookVector.Z)
        carCfg.frente = fwd.Magnitude > 0 and fwd.Unit or Vector3.new(0, 0, -1)
        carCfg.altitude = raiz.Position.Y
        carCfg.velocidade = fwd.Magnitude > 0 and raiz.AssemblyLinearVelocity:Dot(fwd.Unit) or 0
    end
    local function max(a, b, d)
        if a < b then return math.min(a + d, b) end
        return math.max(a - d, b)
    end
    local function tickCar(dt)
        local raiz, seat = carCfg.raiz, carCfg.assento
        local rp, altura, piso = carCfg.raycast, carCfg.altura, carCfg.piso
        local rel = carCfg.relativoAssento
        if not raiz or not raiz.Parent or not seat or not seat.Parent or not rp or not altura or not piso or not rel then return end
        local step = math.min(dt or 0.016666, 0.1)
        local flying = T.vFlyEnabled
        local unstable = false
        if flying and not carCfg.vFlyAtivo then
            carCfg.altitude = raiz.Position.Y
            carCfg.vFlyReduzidoAte = os.clock() + 0.6
            carCfg.velocidade = math.clamp(carCfg.velocidade, -24, 36)
        elseif not flying and carCfg.vFlyAtivo then
            local hit = workspace:Raycast(raiz.Position + Vector3.new(0, 20, 0), Vector3.new(0, -520, 0), rp)
            if hit then
                piso = hit.Position.Y
                carCfg.piso = piso
            end
        end
        carCfg.vFlyAtivo = flying
        local vertAdj = 0
        if flying then
            if step >= 0.05 or raiz.Anchored or raiz.AssemblyLinearVelocity.Magnitude < 12 then
                carCfg.vFlyReduzidoAte = os.clock() + 0.6
            end
        else
            local scanStart = Vector3.new(raiz.Position.X, piso + 20, raiz.Position.Z)
            local hit = workspace:Raycast(scanStart, Vector3.new(0, -60, 0), rp)
            if hit and hit.Position.Y - piso <= 4 then
                piso = hit.Position.Y
                carCfg.piso = piso
            end
            vertAdj = (piso + altura) - raiz.Position.Y
            unstable = math.abs(vertAdj) > 1
            if unstable then vertAdj = math.clamp(vertAdj, -20 * step, 20 * step) end
        end
        local fwd = carCfg.frente or Vector3.new(0, 0, -1)
        local verticalVel = 0
        if fwd.Magnitude > 0.001 then
            fwd = fwd.Unit
            local throttle = seat.ThrottleFloat
            local steer = seat.SteerFloat
            if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then throttle = 1
            elseif UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then throttle = -1 end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then steer = -1
            elseif UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then steer = 1 end
            local unblocked = isUpdateInstancePropertiesEValid()
            local boost = math.clamp(T.boostFactor, 1, 999)
            local vMax
            if flying then vMax = T.vFlyHorizontalSpeed * boost
            else vMax = unstable and 260 or (unblocked and 999 or 180) * boost end
            local vMin = flying and (vMax * 0.65) or (unstable and 120 or (150 * boost))
            local target = throttle > 0.05 and vMax or (throttle < -0.05 and -vMin or 0)
            local accel = (math.abs(throttle) > 0.05 and 130 or 200) * step
            carCfg.velocidade = max(carCfg.velocidade, target, accel)
            if math.abs(steer) > 0.05 and math.abs(carCfg.velocidade) > 0.5 then
                local sign = carCfg.velocidade >= 0 and 1 or -1
                local ang = ((-steer * sign) * math.rad(85)) * step
                fwd = CFrame.Angles(0, ang, 0):VectorToWorldSpace(fwd)
            end
            carCfg.frente = fwd.Unit
            if flying then
                local vInput = 0
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vInput = 1
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vInput = -1 end
                local vCap = T.vFlyVerticalSpeed * boost
                if vInput ~= 0 then
                    verticalVel = vInput * vCap
                    carCfg.altitude = raiz.Position.Y + verticalVel * step
                else
                    local diff = (carCfg.altitude or raiz.Position.Y) - raiz.Position.Y
                    verticalVel = math.clamp(diff * 10, -vCap, vCap)
                end
            end
            local look = CFrame.lookAt(Vector3.zero, fwd.Unit, Vector3.yAxis)
            local rot = look * rel:Inverse()
            if flying then
                raiz.CFrame = CFrame.new(raiz.Position + Vector3.new(0, vertAdj, 0)) * rot
            elseif math.abs(vertAdj) > 0.01 then
                raiz.CFrame = raiz.CFrame + Vector3.new(0, vertAdj, 0)
            end
            if fwd.Magnitude > 0.001 then
                raiz.AssemblyLinearVelocity = fwd.Unit * carCfg.velocidade + Vector3.new(0, verticalVel, 0)
            else
                raiz.AssemblyLinearVelocity = Vector3.new(0, verticalVel, 0)
            end
            raiz.AssemblyAngularVelocity = Vector3.zero
        end
    end
    local function aplicarNoclipCar()
        if not T.noclipCarEnabled and not T.vFlyEnabled then
            restaurarNoclipCar()
            return
        end
        local car = rz()
        if car ~= carCfg.carro then
            restaurarNoclipCar()
            carCfg.carro = car
            if car then prepararNoclipCar(car) end
        end
        if not car then return end
        sz(true)
        carCfg.personagemAtivo = true
        for _, p in ipairs(car:GetDescendants()) do
            if p:IsA("BasePart") then
                if carCfg.originais[p] == nil then carCfg.originais[p] = p.CanCollide end
                if p.CanCollide then p.CanCollide = false end
            end
        end
    end
    o.aplicarNoclipCar = aplicarNoclipCar
    o.restaurarNoclipCar = restaurarNoclipCar
    handleReady(RunService.Stepped:Connect(function()
        if not o.destroyed then pcall(aplicarNoclipCar) end
    end))
    handleReady(RunService.Heartbeat:Connect(function(dt)
        if not o.destroyed and (T.noclipCarEnabled or T.vFlyEnabled) then pcall(tickCar, dt) end
    end))
end
local function hz(hum)
    local st = Dz(hum)
    if not st then return false end
    st.RemapMultiplier = math.clamp(T.boostFactor, 1, 999)
    pcall(function() st:BuildHPCache() end)
    pcall(function()
        if st.SpeedLimit ~= nil then st.SpeedLimit = 999 end
        if st.MaxSpeed ~= nil then st.MaxSpeed = 999 end
        if st.TopSpeed ~= nil then st.TopSpeed = 999 end
        if st.SpeedCap ~= nil then st.SpeedCap = 999 end
    end)
    return true
end
o.hz = hz
task.spawn(function()
    local lastCar
    while not o.destroyed do
        local car = rz()
        if car then o.lastDrivenCar = car end
        if car and car ~= lastCar then
            local hum = isCValid()
            if hum then hz(hum) end
            lastCar = car
        elseif not car then
            lastCar = nil
        end
        task.wait(0.5)
    end
end)
do
    local MAX = 1500
    local green = Color3.fromRGB(70, 190, 120)
    local yellow = Color3.fromRGB(232, 190, 70)
    local red = Color3.fromRGB(232, 92, 84)
    local bg = Color3.fromRGB(22, 14, 34)
    local border = Color3.fromRGB(100, 60, 160)
    local track = Color3.fromRGB(40, 26, 60)
    local textCol = Color3.fromRGB(240, 230, 255)
    local muted = Color3.fromRGB(170, 140, 210)
    local fontName = "rbxasset://fonts/families/Nunito.json"
    local boldFont = Font.new(fontName, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    local regFont = Font.new(fontName, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    local W, Hh = 208, 64
    local O = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local S_ = {
        gui = nil, frame = nil, fill = nil, percentLabel = nil, valueLabel = nil,
        carLabel = nil, uiScale = nil, vidaConn = nil, car = nil,
        maxVida = MAX, savedPosition = nil, painel = nil,
    }
    o.durHUD = S_
    local function mk(kind, props, parent)
        local obj = Instance.new(kind)
        for k, v in pairs(props) do obj[k] = v end
        obj.Parent = parent
        return obj
    end
    local function getParent() return LocalPlayer:WaitForChild("PlayerGui") end
    local function colorFor(pct)
        if pct <= 20 then return red end
        if pct <= 50 then return yellow end
        return green
    end
    local function vpSize()
        local cam = workspace.CurrentCamera
        return cam and cam.ViewportSize or Vector2.new(800, 600)
    end
    local function updateScale()
        if not S_.uiScale then return end
        local vp = vpSize()
        S_.uiScale.Scale = math.clamp(vp.X / 1280, 0.85, 1.1)
    end
    local function defaultPos()
        local vp = vpSize()
        local yy = math.max(40, (vp.Y - Hh) - 150)
        return UDim2.fromOffset(14, yy)
    end
    local function setVal(v)
        if not S_.frame then return end
        if v > S_.maxVida then S_.maxVida = v end
        local pct = math.clamp((v / S_.maxVida) * 100, 0, 100)
        local col = colorFor(pct)
        S_.percentLabel.Text = string.format("%d%%", math.floor(pct + 0.5))
        S_.percentLabel.TextColor3 = col
        S_.valueLabel.Text = string.format("%d / %d", math.floor(v + 0.5), math.floor(S_.maxVida + 0.5))
        TweenService:Create(S_.fill, O, { Size = UDim2.new(pct / 100, 0, 1, 0), BackgroundColor3 = col }):Play()
    end
    local function create()
        if S_.gui and S_.gui.Parent then return end
        local gui = mk("ScreenGui", {
            Name = "InfernityDurabilidade", ResetOnSpawn = false,
            IgnoreGuiInset = true, DisplayOrder = 9999,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        }, getParent())
        local frame = mk("Frame", {
            Name = "HUD", Active = true, AnchorPoint = Vector2.new(0, 0),
            Position = S_.savedPosition or defaultPos(),
            Size = UDim2.fromOffset(W, Hh),
            BackgroundColor3 = bg, BackgroundTransparency = 0.08,
            BorderSizePixel = 0, Visible = false,
        }, gui)
        S_.uiScale = mk("UIScale", { Scale = 1 }, frame)
        mk("UICorner", { CornerRadius = UDim.new(0, 10) }, frame)
        mk("UIStroke", { Color = border, Transparency = 0.2, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, frame)
        mk("UIPadding", {
            PaddingTop = UDim.new(0, 9), PaddingBottom = UDim.new(0, 9),
            PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 11),
        }, frame)
        S_.carLabel = mk("TextLabel", {
            Name = "Carro", Position = UDim2.fromOffset(0, 0),
            Size = UDim2.new(1, -46, 0, 15), BackgroundTransparency = 1,
            Text = "Veiculo", TextColor3 = textCol, TextSize = 14,
            FontFace = boldFont, TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }, frame)
        S_.percentLabel = mk("TextLabel", {
            Name = "Percent", AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(46, 15),
            BackgroundTransparency = 1, Text = "--%", TextColor3 = green,
            TextSize = 15, FontFace = boldFont,
            TextXAlignment = Enum.TextXAlignment.Right,
        }, frame)
        local bar = mk("Frame", {
            Name = "Barra", Position = UDim2.fromOffset(0, 24),
            Size = UDim2.new(1, 0, 0, 9), BackgroundColor3 = track,
            BorderSizePixel = 0, ClipsDescendants = true,
        }, frame)
        mk("UICorner", { CornerRadius = UDim.new(1, 0) }, bar)
        S_.fill = mk("Frame", { Name = "Fill", Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = green, BorderSizePixel = 0 }, bar)
        mk("UICorner", { CornerRadius = UDim.new(1, 0) }, S_.fill)
        S_.valueLabel = mk("TextLabel", {
            Name = "Valor", Position = UDim2.fromOffset(0, 37),
            Size = UDim2.new(1, 0, 0, 12), BackgroundTransparency = 1,
            Text = "-- / --", TextColor3 = muted, TextSize = 12,
            FontFace = regFont, TextXAlignment = Enum.TextXAlignment.Left,
        }, frame)
        S_.gui = gui
        S_.frame = frame
        updateScale()
        handleReady((workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function()
            updateScale()
            local cam = workspace.CurrentCamera
            if cam then handleReady((cam:GetPropertyChangedSignal("ViewportSize")):Connect(updateScale)) end
        end))
        local cam = workspace.CurrentCamera
        if cam then handleReady((cam:GetPropertyChangedSignal("ViewportSize")):Connect(updateScale)) end
    end
    o.vidaDoCarro = function(car)
        local body = car:FindFirstChild("Body")
        local paint = body and body:FindFirstChild("Pintura")
        local life = paint and paint:FindFirstChild("LifeController")
        return life and life:FindFirstChild("Vida")
    end
    local function getMeuCarro()
        local hum = isCValid()
        local seat = hum and hum.SeatPart
        if not seat then return nil end
        local carros = workspace:FindFirstChild("CarrosSpawnados")
        if not carros then return nil end
        local p = seat
        while p and p.Parent do
            if p.Parent == carros then return p end
            p = p.Parent
        end
        return nil
    end
    local function desconectar()
        if S_.vidaConn then S_.vidaConn:Disconnect(); S_.vidaConn = nil end
        S_.car = nil
        if S_.painel then S_.painel:SetVisible(false) end
    end
    local function conectar(car)
        local vida = o.vidaDoCarro(car)
        if not vida then return end
        if S_.vidaConn then S_.vidaConn:Disconnect() end
        S_.car = car
        S_.maxVida = math.max(MAX, vida.Value)
        if S_.carLabel then S_.carLabel.Text = car.Name end
        if S_.painel then S_.painel:SetVisible(true) end
        setVal(vida.Value)
        S_.vidaConn = vida:GetPropertyChangedSignal("Value"):Connect(function() setVal(vida.Value) end)
    end
    function o.ativarDurabilidade()
        create()
        S_.frame.Visible = true
        o.durabilidadeRunId = o.durabilidadeRunId + 1
        local runId = o.durabilidadeRunId
        task.spawn(function()
            while T.durabilidadeHudEnabled and not o.destroyed and o.durabilidadeRunId == runId do
                local car = getMeuCarro()
                if car ~= S_.car then
                    if car and o.vidaDoCarro(car) then pcall(conectar, car)
                    else pcall(desconectar); if S_.frame then S_.frame.Visible = false end end
                elseif car and not S_.vidaConn then
                    pcall(conectar, car)
                end
                if S_.frame then S_.frame.Visible = car ~= nil end
                task.wait(0.3)
            end
        end)
    end
    function o.desativarDurabilidade()
        o.durabilidadeRunId = o.durabilidadeRunId + 1
        pcall(desconectar)
        if S_.frame then S_.frame.Visible = false end
    end
    function o.destruirDurabilidade()
        pcall(desconectar)
        if S_.gui then pcall(function() S_.gui:Destroy() end) end
        S_.gui, S_.frame, S_.fill = nil, nil, nil
    end
end
task.spawn(function()
    while not o.destroyed do
        if T.monitorarStaff then
            local count, nomes = 0, {}
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and Jz.Admin(plr) then
                    count += 1
                    table.insert(nomes, plr.Name)
                end
            end
            o.staffCount = count
            o.staffNames = nomes
        end
        task.wait(1)
    end
end)
do
    local connection, humanoid, originalAutoRotate
    local function release()
        local previous, saved = humanoid, originalAutoRotate
        humanoid, originalAutoRotate = nil, nil
        if previous then pcall(function() previous.AutoRotate = saved end) end
    end
    local function busy()
        return o.travelBusy or (o.travel and o.travel.owner)
            or T.flyEnabled or T.ghostEnabled or T.autoColetaEnabled
            or T.farmPartesEnabled or T.autoFarmLixeiroEnabled
            or T.autoFarmPescaEnabled
            or o.robberyStarting
            or (o.robbery and (o.robbery.enabled or o.robbery.paused))
            or (o.isGhostActive and o.isGhostActive())
    end
    local function step(dt)
        if o.destroyed or not T.spinEnabled or busy() then release(); return end
        local character = LocalPlayer.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        local hum = character and character:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 or root.Anchored or hum.Sit or hum.PlatformStand then
            release(); return
        end
        if humanoid ~= hum then
            release()
            humanoid, originalAutoRotate = hum, hum.AutoRotate
            hum.AutoRotate = false
        end
        if type(dt) ~= "number" or dt ~= dt or dt <= 0 or dt == math.huge then return end
        local delta = math.rad(T.spinSpeed) * math.min(dt, 1 / 15)
        root.CFrame = root.CFrame * CFrame.Angles(0, delta, 0)
    end
    function o.setSpinSpeed(value)
        value = tonumber(value)
        if not value or value ~= value or math.abs(value) == math.huge then return end
        T.spinSpeed = math.clamp(value, 45, 3600)
    end
    function o.setSpinPlayer(value)
        T.spinEnabled = value == true and not o.destroyed
        if o.spinControl then o.spinControl:Set(T.spinEnabled, true) end
        if o.spinSpeedControl then o.spinSpeedControl:SetVisible(T.spinEnabled) end
        if not T.spinEnabled then
            if connection then connection:Disconnect(); connection = nil end
            release()
        elseif not connection then
            connection = RunService.Heartbeat:Connect(function(dt)
                local ok = pcall(step, dt)
                if not ok then
                    o.setSpinPlayer(false)
                    Xz("Spin Player pausado: personagem indisponivel.")
                end
            end)
        end
    end
    o.cleanupSpinPlayer = function() o.setSpinPlayer(false) end
    handleReady(LocalPlayer.CharacterAdded:Connect(release))
end
do
    local overlay
    local function finite(value)
        return type(value) == "number" and value == value and math.abs(value) < 10000000
    end
    function o.renderESPLine(line, from, to, color, thickness)
        if not line or not line.Parent then return false end
        if not from or not to or not finite(from.X) or not finite(from.Y)
            or not finite(to.X) or not finite(to.Y) then
            line.Visible = false
            return false
        end
        local dx, dy = to.X - from.X, to.Y - from.Y
        local length = math.sqrt(dx * dx + dy * dy)
        if length < 0.1 then line.Visible = false; return false end
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.Position = UDim2.fromOffset((from.X + to.X) * 0.5, (from.Y + to.Y) * 0.5)
        line.Size = UDim2.fromOffset(length, thickness or 1.5)
        line.Rotation = math.deg(math.atan2(dy, dx))
        line.BackgroundColor3 = color
        line.Visible = true
        return true
    end
    local function getOverlay()
        if o.destroyed then return nil end
        if overlay and overlay.Parent then return overlay end
        local parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if type(gethui) == "function" then
            local ok, hidden = pcall(gethui)
            if ok and hidden then parent = hidden end
        end
        if not parent then return nil end
        overlay = Instance.new("ScreenGui")
        overlay.Name = "InfernityESPOverlay"
        overlay.IgnoreGuiInset = true
        overlay.ResetOnSpawn = false
        overlay.DisplayOrder = 2
        overlay.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        pcall(function() overlay.ScreenInsets = Enum.ScreenInsets.None end)
        if type(protect_gui) == "function" then pcall(protect_gui, overlay) end
        overlay.Parent = parent
        return overlay
    end
    function o.newESPTracer()
        local parent = getOverlay()
        if not parent then return nil end
        local line = Instance.new("Frame")
        line.Name = "Tracer"
        line.BorderSizePixel = 0
        line.BackgroundTransparency = 0.12
        line.Active = false
        line.Visible = false
        line.Parent = parent
        return line
    end
    function o.setESPTracer(value)
        T.tracer = value == true
        if not T.tracer then
            for _, bundle in pairs(T.bundles) do
                if bundle.tracer then bundle.tracer.Visible = false end
            end
        end
    end
    function o.cleanupESPTracer()
        if overlay then pcall(function() overlay:Destroy() end); overlay = nil end
    end
end
local wz = { medido = false, drawing = false, texto = false }
function wz.set(obj, prop, val) return pcall(function() obj[prop] = val end) end
function wz.medir()
    if wz.medido then return wz end
    if Drawing == nil or type(Drawing.new) ~= "function" then return wz end
    local ok, sq = pcall(Drawing.new, "Square")
    if not ok then return wz end
    wz.drawing = true
    wz.filled = wz.set(sq, "Filled", false)
    wz.thickness = wz.set(sq, "Thickness", 1)
    pcall(function() sq:Remove() end)
    local ok2, txt = pcall(Drawing.new, "Text")
    if ok2 then
        wz.texto = true
        wz.center = wz.set(txt, "Center", true)
        wz.outline = wz.set(txt, "Outline", true)
        wz.outlineColor = wz.set(txt, "OutlineColor", Color3.new())
        wz.font = wz.set(txt, "Font", 2)
        pcall(function() txt.Text = "MMM" end)
        local ok3, tb = pcall(function() return txt.TextBounds end)
        wz.textBounds = ok3 and (typeof(tb) == "Vector2" and tb.X > 0)
        pcall(function() txt:Remove() end)
    end
    local ok4, tr = pcall(Drawing.new, "Triangle")
    wz.triangle = ok4 == true
    if ok4 then pcall(function() tr:Remove() end) end
    wz.medido = true
    return wz
end
function wz.ok() return (wz.medir()).drawing end
local function az(kind)
    if not wz.ok() then return nil end
    if kind == "Triangle" and not wz.triangle then return nil end
    local ok, obj = pcall(function() return Drawing.new(kind) end)
    if not ok then return nil end
    wz.set(obj, "Visible", false)
    wz.set(obj, "Color", Color3.fromRGB(170, 70, 255))
    wz.set(obj, "Transparency", 1)
    wz.set(obj, "Thickness", 1)
    return obj
end
local function iz(col)
    if not wz.ok() or not wz.texto then return nil end
    local ok, obj = pcall(function() return Drawing.new("Text") end)
    if not ok then return nil end
    wz.set(obj, "Visible", false)
    wz.set(obj, "Color", col or Color3.fromRGB(170, 70, 255))
    wz.set(obj, "Transparency", 1)
    wz.set(obj, "Size", 13)
    if wz.center then wz.set(obj, "Center", true) end
    if wz.outline then wz.set(obj, "Outline", true) end
    if wz.outlineColor then wz.set(obj, "OutlineColor", Color3.new(0, 0, 0)) end
    if wz.font then wz.set(obj, "Font", 2) end
    return obj
end
local function larguraText(obj)
    if not obj then return 0 end
    if wz.textBounds then
        local ok, tb = pcall(function() return obj.TextBounds end)
        if ok and tb then return tb.X end
    end
    local ok, txt = pcall(function() return obj.Text end)
    if not ok or type(txt) ~= "string" then return 0 end
    local ok2, sz = pcall(function() return obj.Size end)
    return (#txt * (ok2 and sz or 13)) * 0.52
end
local dz = {
    { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
    { "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
    { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
    { "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
    { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" },
}
local Gz = {
    { "Head", "Torso" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" },
    { "Torso", "Left Leg" }, { "Torso", "Right Leg" },
}
local tz = #dz
local Kz = { { 1, 2 }, { 1, 3 }, { 1, 5 }, { 2, 4 }, { 2, 6 }, { 3, 4 }, { 3, 7 }, { 4, 8 }, { 5, 6 }, { 5, 7 }, { 6, 8 }, { 7, 8 } }
local CF, YF, gF, mF = 300, 0.016666, 0.033333, 0.05
local EF, MF = 4, 5
local HF = function(prev, now, interval) if prev <= 0 or now - prev > interval then return now + interval end return prev + interval end
local function AF(plr)
    local b2 = {
        player = plr, box = nil, name = nil, distance = nil, item = nil, team = nil,
        lines = {}, tracer = nil, arrow = nil, box3dLines = {}, highlight = nil,
        character = nil, humanoid = nil, root = nil,
        bodyParts = {}, skeletonPairs = {},
        relationshipColor = nil, relationshipLabel = "",
        nextVisualUpdate = 0, nextSkeletonUpdate = 0,
    }
    T.bundles[plr] = b2
    return b2
end
function o.prepareESPBundle(b2, now)
    if now < (b2.nextDrawingRetry or 0) then return end
    local missing = false
    if T.box and not b2.box then
        b2.box = az("Square")
        if b2.box then
            b2.box.Color = b2.relationshipColor or Color3.fromRGB(170, 70, 255)
            if wz.filled then b2.box.Filled = false end
        end
        missing = missing or b2.box == nil
    end
    for _, field in ipairs({"name", "distance", "item", "team"}) do
        local enabled = (field == "item" and T.heldItem) or (field == "team" and T.teamTag)
            or (field == "name" and T.name) or (field == "distance" and T.distance)
        if enabled and not b2[field] then
            b2[field] = iz(b2.relationshipColor)
            missing = missing or b2[field] == nil
        end
    end
    if T.skeleton and #b2.lines < tz then
        for index = #b2.lines + 1, tz do
            local line = az("Line")
            if not line then missing = true; break end
            line.Color = b2.relationshipColor or Color3.fromRGB(170, 70, 255)
            b2.lines[index] = line
        end
    end
    b2.nextDrawingRetry = missing and (now + 1) or 0
end
local function FF(b2)
    if b2.box then b2.box.Visible = false end
    if b2.name then b2.name.Visible = false end
    if b2.distance then b2.distance.Visible = false end
    if b2.item then b2.item.Visible = false end
    if b2.team then b2.team.Visible = false end
    if b2.tracer then b2.tracer.Visible = false end
    if b2.arrow then b2.arrow.Visible = false end
    for _, l in ipairs(b2.lines) do l.Visible = false end
    for _, l in ipairs(b2.box3dLines) do l.Visible = false end
end
local function uF(b2)
    FF(b2)
    if b2.highlight then b2.highlight.Enabled = false end
end
local function qF(b2)
    if not b2 then return end
    local function h(obj) if obj then pcall(function() obj:Remove() end) end end
    h(b2.box); h(b2.name); h(b2.distance); h(b2.item); h(b2.team)
    if b2.tracer then pcall(function() b2.tracer:Destroy() end); b2.tracer = nil end
    h(b2.arrow)
    for _, l in ipairs(b2.lines) do h(l) end
    for _, l in ipairs(b2.box3dLines) do h(l) end
    if b2.highlight then pcall(function() b2.highlight:Destroy() end); b2.highlight = nil end
end
o.qF = qF
local function PF_all()
    for _, b2 in pairs(T.bundles) do uF(b2) end
end
o.PF = PF_all
local function zF(cam, pos)
    local s, onScreen = cam:WorldToViewportPoint(pos)
    return Vector2.new(s.X, s.Y), onScreen, s.Z
end
local function oF(b2)
    if b2.tracer and b2.tracer.Parent then return b2.tracer end
    b2.tracer = o.newESPTracer()
    return b2.tracer
end
local function TF(b2)
    if b2.arrow then return b2.arrow end
    b2.arrow = az("Triangle")
    if b2.arrow then
        if wz.filled then b2.arrow.Filled = true end
        if wz.thickness then b2.arrow.Thickness = 1 end
        b2.arrow.Color = b2.relationshipColor or Color3.fromRGB(170, 70, 255)
    end
    return b2.arrow
end
local function fF(b2)
    if #b2.box3dLines > 0 then return b2.box3dLines end
    for _ = 1, #Kz do
        local l = az("Line")
        if l then
            if wz.thickness then l.Thickness = 1 end
            l.Color = b2.relationshipColor or Color3.fromRGB(170, 70, 255)
            table.insert(b2.box3dLines, l)
        end
    end
    return b2.box3dLines
end
local function RF(b2, char)
    local hl = b2.highlight
    if not hl or not hl.Parent then
        local ok, newHl = pcall(function()
            local h = Instance.new("Highlight")
            h.Name = "InfernityESP_" .. tostring(b2.player.UserId)
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.FillTransparency = 0.78
            h.OutlineTransparency = 0
            h.Parent = workspace.CurrentCamera or workspace
            return h
        end)
        if not ok then return nil end
        hl = newHl
        b2.highlight = hl
    elseif hl.Parent ~= (workspace.CurrentCamera or workspace) then
        hl.Parent = workspace.CurrentCamera or workspace
    end
    local col = b2.relationshipColor or Color3.fromRGB(170, 70, 255)
    hl.Adornee = char
    hl.FillColor = col
    hl.OutlineColor = col
    return hl
end
local function QF(b2, cam, screenPos, z)
    local arrow = TF(b2)
    if not arrow then return end
    local vp = cam.ViewportSize
    local center = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
    local dir = screenPos - center
    if z <= 0 then dir = -dir end
    if dir.Magnitude < 0.001 then dir = Vector2.new(0, -1) end
    local unit = dir.Unit
    local radius = math.max(40, math.min(vp.X, vp.Y) * 0.42)
    local tip = center + unit * radius
    local back = tip - unit * 14
    local perp = Vector2.new(-unit.Y, unit.X) * 8
    arrow.PointA = tip
    arrow.PointB = back + perp
    arrow.PointC = back - perp
    arrow.Visible = true
end
local function VF(b2, char, hum, root)
    if b2.character == char and b2.humanoid == hum and b2.root == root then return end
    b2.character, b2.humanoid, b2.root = char, hum, root
    table.clear(b2.bodyParts)
    table.clear(b2.skeletonPairs)
    for _, p in ipairs(char:GetChildren()) do
        if p:IsA("BasePart") then table.insert(b2.bodyParts, p) end
    end
    local pairsList = (hum.RigType == Enum.HumanoidRigType.R15) and dz or Gz
    for _, pr in ipairs(pairsList) do
        table.insert(b2.skeletonPairs, { char:FindFirstChild(pr[1]), char:FindFirstChild(pr[2]) })
    end
end
local function pF(plr)
    local t = plr.Team
    local name = t and t.Name or nil
    if Jz.Admin(plr) and name ~= "STAFF" then
        return name and ("STAFF | " .. name) or "STAFF"
    end
    return name
end
local function IF(plr)
    local t = plr.Team
    local ok, col = pcall(function() return t.TeamColor.Color end)
    return (ok and col) or Color3.fromRGB(170, 70, 255)
end
local function OF(plr, b2)
    local col, suffix = Jz.Appearance(plr)
    b2.relationshipLabel = suffix
    if b2.relationshipColor == col then return end
    b2.relationshipColor = col
    if b2.box then b2.box.Color = col end
    if b2.name then b2.name.Color = col end
    if b2.distance then b2.distance.Color = col end
    if b2.item then b2.item.Color = col end
    if b2.tracer then b2.tracer.BackgroundColor3 = col end
    if b2.arrow then b2.arrow.Color = col end
    if b2.highlight then
        b2.highlight.FillColor = col
        b2.highlight.OutlineColor = col
    end
    for _, l in ipairs(b2.lines) do if l then l.Color = col end end
    for _, l in ipairs(b2.box3dLines) do if l then l.Color = col end end
end
local function XF(plr, b2, cam, myPos, now)
    local char = plr.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hum or hum.Health <= 0 or not root then
        b2.character = nil
        b2.nextVisualUpdate = now + mF
        uF(b2)
        return
    end
    VF(b2, char, hum, root)
    local dist = (root.Position - myPos).Magnitude
    if dist > T.maxDistance then
        b2.nextVisualUpdate = now + mF
        uF(b2)
        return
    end
    OF(plr, b2)
    o.prepareESPBundle(b2, now)
    if T.highlight then
        local hl = RF(b2, char)
        if hl then hl.Enabled = true end
    elseif b2.highlight then b2.highlight.Enabled = false end
    local screenPos, onScreen, z = zF(cam, root.Position)
    if not onScreen or z <= 0 then
        b2.nextVisualUpdate = now + mF
        FF(b2)
        if T.arrow then QF(b2, cam, screenPos, z) end
        return
    end
    local close = dist <= CF
    local interval = close and YF or gF
    b2.nextVisualUpdate = HF(b2.nextVisualUpdate, now, interval)
    if b2.arrow then b2.arrow.Visible = false end
    local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
    local anyOnScreen = false
    local screenCorners, zCorners = {}, {}
    if T.box or T.name or T.distance or T.heldItem or T.box3d or T.teamTag then
        local bbMin, bbMax
        for _, p in ipairs(b2.bodyParts) do
            if p.Parent == char then
                local half = p.Size * 0.5
                local a, b2v = p.Position - half, p.Position + half
                if bbMin then
                    bbMin = Vector3.new(math.min(bbMin.X, a.X), math.min(bbMin.Y, a.Y), math.min(bbMin.Z, a.Z))
                    bbMax = Vector3.new(math.max(bbMax.X, b2v.X), math.max(bbMax.Y, b2v.Y), math.max(bbMax.Z, b2v.Z))
                else
                    bbMin, bbMax = a, b2v
                end
            end
        end
        if bbMin then
            local idx = 0
            for xi = 0, 1 do for yi = 0, 1 do for zi = 0, 1 do
                idx = idx + 1
                local corner = Vector3.new(xi == 0 and bbMin.X or bbMax.X, yi == 0 and bbMin.Y or bbMax.Y, zi == 0 and bbMin.Z or bbMax.Z)
                local sp, onS, zc = zF(cam, corner)
                screenCorners[idx] = sp
                zCorners[idx] = zc
                if zc > 0.5 then
                    anyOnScreen = true
                    minX = math.min(minX, sp.X); minY = math.min(minY, sp.Y)
                    maxX = math.max(maxX, sp.X); maxY = math.max(maxY, sp.Y)
                end
            end end end
        end
        if anyOnScreen then
            local vp = cam.ViewportSize
            minX = math.clamp(minX, -32, vp.X + 32)
            maxX = math.clamp(maxX, -32, vp.X + 32)
            minY = math.clamp(minY, -32, vp.Y + 32)
            maxY = math.clamp(maxY, -32, vp.Y + 32)
            if maxX - minX < 1 or maxY - minY < 1 then anyOnScreen = false end
        end
    end
    if T.box and b2.box then
        if anyOnScreen then
            b2.box.Position = Vector2.new(minX, minY)
            b2.box.Size = Vector2.new(maxX - minX, maxY - minY)
            b2.box.Visible = true
        else b2.box.Visible = false end
    elseif b2.box then b2.box.Visible = false end
    if T.name and b2.name then
        if anyOnScreen then
            b2.name.Text = plr.Name .. b2.relationshipLabel
            b2.name.Position = Vector2.new((minX + maxX) / 2, minY - 18)
            b2.name.Visible = true
        else b2.name.Visible = false end
    elseif b2.name then b2.name.Visible = false end
    if T.teamTag and b2.team then
        local teamName = anyOnScreen and pF(plr) or nil
        if teamName then
            b2.team.Text = teamName
            if Jz.Admin(plr) and plr.Team and plr.Team.Name == "STAFF" then
                b2.team.Color = Color3.fromRGB(255, 200, 50)
            else
                b2.team.Color = IF(plr)
            end
            b2.team.Position = Vector2.new((minX + maxX) / 2, (T.name and (b2.name and b2.name.Visible)) and (minY - 32) or (minY - 18))
            b2.team.Visible = true
        else b2.team.Visible = false end
    elseif b2.team then b2.team.Visible = false end
    if T.distance and b2.distance then
        if anyOnScreen then
            b2.distance.Text = string.format("%dm", math.floor(dist))
            if wz.center then b2.distance.Center = true end
            b2.distance.Position = Vector2.new((minX + maxX) / 2, maxY + 3)
            b2.distance.Visible = true
        else b2.distance.Visible = false end
    elseif b2.distance then b2.distance.Visible = false end
    if T.heldItem and b2.item then
        local c2 = b2.character or plr.Character
        local tool = anyOnScreen and (c2 and c2:FindFirstChildOfClass("Tool"))
        if tool then
            b2.item.Text = tool.Name
            local cx = (minX + maxX) / 2
            if T.distance and (b2.distance and b2.distance.Visible) then
                local dw = larguraText(b2.distance)
                local iw = larguraText(b2.item)
                local startX = cx - ((dw + MF) + iw) / 2
                if wz.center then b2.distance.Center = false end
                b2.distance.Position = Vector2.new(startX, maxY + 3)
                if wz.center then b2.item.Center = false end
                b2.item.Position = Vector2.new((startX + dw) + MF, maxY + 3)
            else
                if wz.center then b2.item.Center = true end
                b2.item.Position = Vector2.new(cx, maxY + 3)
            end
            b2.item.Visible = true
        else b2.item.Visible = false end
    elseif b2.item then b2.item.Visible = false end
    if T.tracer then
        local tr = oF(b2)
        if tr then
            local vp = cam.ViewportSize
            local finish = anyOnScreen and Vector2.new((minX + maxX) * 0.5, (minY + maxY) * 0.5) or screenPos
            if vp.X > 0 and vp.Y > 0 then
                local endpoint = Vector2.new(math.clamp(finish.X, 0, vp.X), math.clamp(finish.Y, 0, vp.Y))
                o.renderESPLine(tr, Vector2.new(vp.X * 0.5, 4), endpoint,
                    b2.relationshipColor or Color3.fromRGB(170, 70, 255), 1.4)
            else tr.Visible = false end
        end
    elseif b2.tracer then b2.tracer.Visible = false end
    if T.box3d then
        local lines = fF(b2)
        for i, pr in ipairs(Kz) do
            local l = lines[i]
            local p1, p2 = screenCorners[pr[1]], screenCorners[pr[2]]
            local z1, z2 = zCorners[pr[1]], zCorners[pr[2]]
            if l and p1 and p2 and z1 and z2 and z1 > 0.5 and z2 > 0.5 then
                l.From = p1; l.To = p2; l.Visible = true
            elseif l then l.Visible = false end
        end
    else
        for _, l in ipairs(b2.box3dLines) do l.Visible = false end
    end
    if not T.skeleton then
        for _, l in ipairs(b2.lines) do l.Visible = false end
    elseif now >= b2.nextSkeletonUpdate then
        local interval = close and YF or gF
        b2.nextSkeletonUpdate = HF(b2.nextSkeletonUpdate, now, interval)
        for i, l in ipairs(b2.lines) do
            local pr = b2.skeletonPairs[i]
            if pr and l then
                local p1, p2 = pr[1], pr[2]
                if p1 and p2 and p1.Parent == char and p2.Parent == char then
                    local s1, on1, z1 = zF(cam, p1.Position)
                    local s2, on2, z2 = zF(cam, p2.Position)
                    if on1 and on2 and z1 > 0.5 and z2 > 0.5 then
                        l.From = s1; l.To = s2; l.Visible = true
                    else l.Visible = false end
                else l.Visible = false end
            elseif l then l.Visible = false end
        end
    end
end
handleReady(Players.PlayerRemoving:Connect(function(plr)
    local b2 = T.bundles[plr]
    if b2 then qF(b2); T.bundles[plr] = nil end
end))
local BF = false
handleReady(RunService.RenderStepped:Connect(function()
    if not T.espEnabled then
        if BF then PF_all() end
        BF = false
        return
    end
    BF = true
    local cam = workspace.CurrentCamera
    if not cam then PF_all(); return end
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local myPos = root and root.Position or cam.CFrame.Position
    local list = Players:GetPlayers()
    local now = os.clock()
    local budget = EF
    for _, plr in ipairs(list) do
        if plr ~= LocalPlayer then
            local b2 = T.bundles[plr]
            if not b2 and budget > 0 then
                local ok, res = pcall(AF, plr)
                if ok then b2 = res end
                budget = budget - 1
            end
            if b2 and now >= b2.nextVisualUpdate then
                local ok = pcall(XF, plr, b2, cam, myPos, now)
                if not ok then
                    b2.nextVisualUpdate = now + 0.5
                    pcall(uF, b2)
                end
            end
        end
    end
end))
local SF = {
    Cabeca = { "Head" },
    Tronco = { "Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart" },
}
local function eF(char)
    local list = SF[T.aimbotBodyPart] or SF.Cabeca
    for _, n in ipairs(list) do
        local p = char:FindFirstChild(n)
        if p and p:IsA("BasePart") then return p end
    end
    return char:FindFirstChild("Head")
end
local function temLinhaDeVisao(cam, target, char)
    local from = cam.CFrame.Position
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = { LocalPlayer.Character, char, cam }
    local hit = workspace:Raycast(from, target.Position - from, rp)
    return hit == nil
end
local function getClosestTarget(cam, maxFov, maxDist)
    local myPos = cam.CFrame.Position
    local center = cam.ViewportSize / 2
    local best, bestD = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and not Jz.Protected(plr) then
            local char = plr.Character
            local part = char and eF(char)
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if part and hum and hum.Health > 0 and (part.Position - myPos).Magnitude <= maxDist then
                local sp, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen and sp.Z > 0 then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if d <= maxFov and d < bestD then
                        if not T.aimbotWallCheck or temLinhaDeVisao(cam, part, char) then
                            best, bestD = part, d
                        end
                    end
                end
            end
        end
    end
    return best
end
local aimbotConnection = nil
local function aimbotLoop()
    if aimbotConnection then return end
    aimbotConnection = RunService.RenderStepped:Connect(function()
        if not T.aimbotEnabled then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return end
        if T.aimbotMode == "Legit" then
            local tool = char:FindFirstChildOfClass("Tool")
            if not tool then return end
        end
        local target = getClosestTarget(cam, T.aimbotFov, T.aimbotDistance)
        if not target then return end
        local myPos = cam.CFrame.Position
        local targetPos = target.Position
        if T.aimbotMode == "Rage" then
            cam.CFrame = CFrame.new(myPos, targetPos)
        else
            local currentLook = cam.CFrame.LookVector
            local desiredLook = (targetPos - myPos).Unit
            local smooth = math.clamp(T.aimbotSmoothness, 0.01, 1)
            local factor = math.clamp(smooth * 8, 0.02, 0.35)
            local dot = currentLook:Dot(desiredLook)
            if dot > 0.998 then factor = 0.6 end
            local newLook = currentLook:Lerp(desiredLook, factor)
            cam.CFrame = CFrame.new(myPos, myPos + newLook)
        end
    end)
end
local function stopAimbot()
    if aimbotConnection then aimbotConnection:Disconnect(); aimbotConnection = nil end
end
o.aimbotLoop = aimbotLoop
o.stopAimbot = stopAimbot
do
    local lastClick, warned = -math.huge, false
    local function visible(gui)
        local node = gui
        while node do
            if node:IsA("GuiObject") and not node.Visible then return false end
            if node:IsA("ScreenGui") and not node.Enabled then return false end
            node = node.Parent
        end
        return true
    end
    local function findGame()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        local root = pg and pg:FindFirstChild("Lockpick", true)
        if not root or not visible(root) then return nil end
        local inner = root:FindFirstChild("Lockpick")
        if not inner or not inner:IsA("GuiObject") then inner = root end
        local block = inner:FindFirstChild("Bloco", true)
        local goal = inner:FindFirstChild("Objetivo", true)
        local button = inner:FindFirstChild("Btn", true)
        if not block or not goal or not button or not block:IsA("GuiObject")
            or not goal:IsA("GuiObject") or not button:IsA("GuiButton") then return nil end
        if not visible(block) or not visible(goal) or not visible(button) or not button.Active then return nil end
        if block.AbsoluteSize.X <= 0 or goal.AbsoluteSize.Y <= 0 then return nil end
        return block, goal, button
    end
    local function aligned(block, goal)
        local bp, bs = block.AbsolutePosition, block.AbsoluteSize
        local gp, gs = goal.AbsolutePosition, goal.AbsoluteSize
        local cx, cy = bp.X + bs.X * 0.5, bp.Y + bs.Y * 0.5
        local padX = math.min(gs.X * 0.12, 4)
        local padY = math.min(gs.Y * 0.12, 4)
        return cx >= gp.X + padX and cx <= gp.X + gs.X - padX
            and cy >= gp.Y + padY and cy <= gp.Y + gs.Y - padY
    end
    local function activate(button)
        if type(getconnections) == "function" then
            for _, name in ipairs({ "Activated", "MouseButton1Click" }) do
                local ok, connections = pcall(getconnections, button[name])
                if ok and type(connections) == "table" then
                    local count = 0
                    for _, conn in ipairs(connections) do
                        if conn.Enabled ~= false and conn.ForeignState ~= true then
                            if type(conn.Fire) == "function" then
                                if pcall(function() conn:Fire() end) then count = count + 1 end
                            elseif type(conn.Function) == "function" then
                                local callback = conn.Function
                                task.spawn(function() pcall(callback) end)
                                count = count + 1
                            end
                        end
                    end
                    if count > 0 then return true end
                end
            end
        end
        if type(firesignal) == "function" then
            return pcall(firesignal, button.Activated)
        end
        return false
    end
    function o.setPerfectLockpick(v)
        T.perfectLockpick = v == true
        lastClick, warned = -math.huge, false
    end
    handleReady(RunService.RenderStepped:Connect(function()
        if not T.perfectLockpick or o.destroyed or os.clock() - lastClick < 0.16 then return end
        local ok, block, goal, button = pcall(findGame)
        if not ok or not block or not aligned(block, goal) then return end
        lastClick = os.clock()
        local fired, result = pcall(activate, button)
        if (not fired or not result) and not warned then
            warned = true
            Xz("Auto Lockpick: este executor nao disponibiliza acionamento de botoes.")
        end
    end))
end
do
    local I = {}
    o.interact = I
    function I.position(prompt)
        local parent = prompt and prompt.Parent
        if not parent then return nil end
        if parent:IsA("Attachment") then return parent.WorldPosition end
        if parent:IsA("BasePart") then return parent.Position end
        if parent:IsA("Model") then return parent:GetPivot().Position end
        local part = parent:FindFirstAncestorWhichIsA("BasePart")
        return part and part.Position
    end
    function I.prompt(prompt, active, nativeOnly)
        local root = isRoot()
        local position = I.position(prompt)
        if not root or not position or not prompt.Enabled then return false end
        if (root.Position - position).Magnitude > prompt.MaxActivationDistance then return false end
        if active and not active() then return false end
        if not nativeOnly and type(fireproximityprompt) == "function" then
            local sent = pcall(fireproximityprompt, prompt, math.max(0.1, prompt.HoldDuration))
            if sent then return true end
        end
        local began = pcall(function() prompt:InputHoldBegin() end)
        if not began then return false end
        local deadline = os.clock() + math.max(prompt.HoldDuration, 0) + 0.1
        repeat
            if not prompt.Parent or not prompt.Enabled or (active and not active()) then
                pcall(function() prompt:InputHoldEnd() end)
                return false
            end
            task.wait(0.04)
        until os.clock() >= deadline
        return pcall(function() prompt:InputHoldEnd() end)
    end
    function o.teleportCharacter(cf)
        local char, root = LocalPlayer.Character, isRoot()
        if not char or not root or root.Anchored then return false end
        local offset = root.CFrame:ToObjectSpace(char:GetPivot())
        char:PivotTo(cf * offset)
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        return true
    end
    local M = { owner = nil, token = 0 }
    o.travel = M
    function M.cancel(owner)
        if owner == nil or owner == M.owner then M.token = M.token + 1 end
    end
    function M.to(owner, destination, active)
        if M.owner then return false, "Outro deslocamento esta em andamento." end
        local char, root, hum = LocalPlayer.Character, isRoot(), isCValid()
        if not char or not root or not hum or hum.Health <= 0 then return false, "Personagem indisponivel." end
        if hum.SeatPart then return false, "Saia do assento antes do deslocamento." end
        if T.flyEnabled or T.ghostEnabled then return false, "Desative Fly e Ghost antes do deslocamento." end
        M.owner, M.token = owner, M.token + 1
        local token = M.token
        o.travelBusy = true
        o.noclip.acquire("travel")
        local function running()
            return not o.destroyed and M.token == token and char == LocalPlayer.Character
                and root.Parent and hum.Health > 0 and (not active or active())
        end
        local function getDestination()
            if type(destination) == "function" then return destination() end
            return destination
        end
        local ok, success, message = pcall(function()
            local first = getDestination()
            if not first then return false, "Destino indisponivel." end
            if not running() or not o.teleportCharacter(CFrame.new(first)) then return false, "TP indisponivel." end
            task.wait(0.25)
            if not running() then return false, "TP cancelado." end
            if (root.Position - first).Magnitude > 6 then return false, "O jogo recusou o TP direto." end
            return true
        end)
        if root.Parent then root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero end
        o.noclip.release("travel")
        M.owner, o.travelBusy = nil, false
        if not ok then return false, "Falha no deslocamento: " .. tostring(success) end
        return success, message
    end
end
do
    local function rootsFor(obj)
        local roots, seen = {}, {}
        local parts = obj:IsA("BasePart") and { obj } or obj:GetDescendants()
        for _, part in ipairs(parts) do
            if part:IsA("BasePart") then
                if part.Anchored then return nil, "O objeto continua fixado pelo servidor." end
                local root = part.AssemblyRootPart or part
                if root ~= obj and not root:IsDescendantOf(obj) then return nil, "O objeto esta ligado a outra estrutura." end
                if root.Anchored then return nil, "A estrutura continua fixada pelo servidor." end
                if not seen[root] then seen[root] = true; roots[#roots + 1] = root end
            end
        end
        return roots
    end
    local function canMove(obj)
        if not obj or not obj.Parent or not obj:IsDescendantOf(workspace) then return false, "Objeto indisponivel." end
        local roots, reason = rootsFor(obj)
        if not roots then return false, reason end
        if #roots == 0 then return false, "Objeto sem partes fisicas." end
        if type(isnetworkowner) ~= "function" then return false, "O executor nao informa o controle fisico deste objeto." end
        for _, root in ipairs(roots) do
            local ok, owned = pcall(isnetworkowner, root)
            if not ok or owned ~= true then return false, "O servidor nao concedeu controle fisico deste objeto." end
        end
        return true, roots
    end
    o.worldMove = { canMove = canMove }
    function o.worldMove.move(obj, destination, active)
        local allowed, roots = canMove(obj)
        if not allowed then return false, roots end
        if o.destroyed or (active and not active()) then return false, "Acao cancelada." end
        for _, root in ipairs(roots) do root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero end
        if obj:IsA("Model") then
            obj:PivotTo(destination)
        elseif obj:IsA("BasePart") then
            obj.CFrame = destination
        else
            local handle = obj:IsA("Tool") and obj:FindFirstChild("Handle")
            if not handle then return false, "Objeto sem modelo movivel." end
            handle.CFrame = destination
        end
        task.wait(0.4)
        if not obj.Parent or o.destroyed or (active and not active()) then return false, "Acao interrompida." end
        local pivot = obj:IsA("Model") and obj:GetPivot()
            or (obj:IsA("BasePart") and obj.CFrame) or obj:FindFirstChild("Handle").CFrame
        if (pivot.Position - destination.Position).Magnitude > 5 then return false, "O jogo recusou o movimento do objeto." end
        return true
    end
    function o.worldMove.toPosition(obj, reference, position, active)
        local delta = position - reference.Position
        local pivot = obj:IsA("Model") and obj:GetPivot() or reference.CFrame
        return o.worldMove.move(obj, pivot + delta, active)
    end
end
local ZF, DF, rF, hF, jF, WF = 20, 14, 1.5, D, 18, 65
local WHITELIST_ARMAS = {
    ninja = true, ak47 = true, fal = true, fuzil = true, glock = true,
    oit_o = true, oit_o_ = true, submetralhadora = true, usps = true, uzi = true,
    barret = true, fuzilhollow = true, fuzilphantom = true,
    fuziltrovao = true, fuziltrovao_ = true, g3 = true,
    ptdragon = true, ptneon = true, ptnk = true,
    armapdsecreta = true, fuzilninja = true, fuzilpascoa = true,
    natalina = true, ptninja = true, ptpascoa = true,
}
local function normalizarNome(nome)
    if not nome then return "" end
    local n = tostring(nome)
    n = n:gsub("[áàãâä]", "a"):gsub("[éèêë]", "e"):gsub("[íìîï]", "i")
    n = n:gsub("[óòõôö]", "o"):gsub("[úùûü]", "u"):gsub("ç", "c")
    return n:lower():gsub("[^%w]", "")
end
local function ehArmaPermitida(nome)
    local key = normalizarNome(nome)
    if key == "" then return false end
    if WHITELIST_ARMAS[key] then return true end
    for arma in pairs(WHITELIST_ARMAS) do
        if (#arma >= 4 and key:find(arma, 1, true)) or (#arma <= 3 and key:match("^" .. arma .. "%d*$")) then return true end
    end
    return false
end
o.ehArmaPermitida = ehArmaPermitida
local POSICAO_RETORNO = Vector3.new(-821.86, 129.42, -4681.15)
local GF
do
    local inventoryPoll = 0.35
    local inventoryBaseline, warmUntil = nil, os.clock() + 0.75
    local enabled = true
    local function status(message)
        o.coletaStatus = tostring(message)
        if o.coletaStatusLabel then pcall(function() o.coletaStatusLabel:Set(o.coletaStatus, true) end) end
    end
    local function textWeapon(text)
        local name = normalizarNome(text)
        return ehArmaPermitida(name) or name == "arma" or name == "weapon" or name == "gun"
    end
    local function itemName(obj)
        for _, field in ipairs({ "WeaponName", "ItemName", "NomeArma", "NomeItem", "Nome", "Name", "Arma", "Item" }) do
            local value = obj:GetAttribute(field)
            if type(value) == "string" and textWeapon(value) then return value end
            local child = obj:FindFirstChild(field)
            if child and child:IsA("StringValue") and textWeapon(child.Value) then return child.Value end
        end
        if obj:IsA("StringValue") and textWeapon(obj.Value) then return obj.Value end
        if obj:IsA("ObjectValue") and obj.Value then
            local reference = obj.Value
            if textWeapon(reference.Name) then return reference.Name end
        end
        if textWeapon(obj.Name) then return obj.Name end
        if obj:GetAttribute("IsWeapon") == true or obj:GetAttribute("Weapon") == true then return obj.Name end
        for _, field in ipairs({ "ItemType", "Category", "Type" }) do
            local value = normalizarNome(obj:GetAttribute(field))
            if value == "arma" or value == "weapon" or value == "gun" then return obj.Name end
        end
        if obj:IsA("Tool") then
            for _, field in ipairs({ "Ammo", "Mag", "Magazine", "GunSettings", "ACS_Settings", "WeaponConfig" }) do
                if obj:FindFirstChild(field, true) then return obj.Name end
            end
        end
    end
    local function weapon(obj)
        if itemName(obj) then return true end
        for _, child in ipairs(obj:GetDescendants()) do
            if itemName(child) then return true end
            if child:IsA("ProximityPrompt") then
                local text = (child.ActionText .. " " .. child.ObjectText):lower()
                if textWeapon(child.ObjectText) or text:find("%f[%w]arma%f[%W]") or text:find("%f[%w]weapon%f[%W]") then return true end
            end
        end
        return false
    end
    local function quantity(obj)
        if obj:IsA("NumberValue") or obj:IsA("IntValue") then return math.max(0, obj.Value) end
        if obj:IsA("BoolValue") then return obj.Value and 1 or 0 end
        for _, name in ipairs({ "Quantity", "Quantidade", "Amount", "Count", "Stack" }) do
            local value = tonumber(obj:GetAttribute(name))
            local child = obj:FindFirstChild(name)
            if not value and child and (child:IsA("NumberValue") or child:IsA("IntValue")) then value = child.Value end
            if value then return math.max(0, value) end
        end
        return 1
    end
    local function inventoryRoots()
        local roots, seen = {}, {}
        local function add(root)
            if root and not seen[root] then seen[root] = true; roots[#roots + 1] = root end
        end
        for _, parent in pairs({ LocalPlayer, LocalPlayer:FindFirstChild("Status"), LocalPlayer:FindFirstChild("Data"), LocalPlayer:FindFirstChild("PlayerData") }) do
            for _, name in ipairs({ "Inv", "Inventory", "Inventario", "Inventário", "InventoryData", "Mochila", "Items", "Itens", "Armas", "Weapons" }) do
                add(parent:FindFirstChild(name))
            end
        end
        for _, name in ipairs({ "Inventories", "Inventarios", "InventoryData" }) do
            local parent = ReplicatedStorage:FindFirstChild(name)
            if parent then add(parent:FindFirstChild(tostring(LocalPlayer.UserId)) or parent:FindFirstChild(LocalPlayer.Name)) end
        end
        return roots
    end
    local function snapshot()
        local counts = {}
        local function keyFor(name)
            local key = normalizarNome(name)
            return key == "ninja" and "fuzilninja" or key
        end
        for _, parent in pairs({ LocalPlayer.Character, LocalPlayer:FindFirstChild("Backpack") }) do
            for _, tool in ipairs(parent:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = itemName(tool)
                    if name then local key = keyFor(name); counts[key] = (counts[key] or 0) + 1 end
                end
            end
        end
        for _, root in ipairs(inventoryRoots()) do
            local backend = {}
            local function visit(node)
                local name = itemName(node)
                if name then
                    local key = keyFor(name)
                    backend[key] = (backend[key] or 0) + quantity(node)
                else
                    for _, child in ipairs(node:GetChildren()) do visit(child) end
                end
            end
            for _, child in ipairs(root:GetChildren()) do visit(child) end
            for key, count in pairs(backend) do counts[key] = math.max(counts[key] or 0, count) end
        end
        return counts
    end
    local function gained(before, current)
        current = current or snapshot()
        for key, count in pairs(current) do if count > (before[key] or 0) then return true, key end end
        return false
    end
    local function partFor(obj)
        if obj:IsA("BasePart") then return obj end
        return (obj:IsA("Model") and obj.PrimaryPart) or obj:FindFirstChildWhichIsA("BasePart", true)
    end
    local records = setmetatable({}, { __mode = "k" })
    local queued = setmetatable({}, { __mode = "k" })
    local queue, head, tail = {}, 1, 0
    local folders, characters = {}, {}
    local indexStarted, demandUntil, rootsAt = false, 0, -math.huge
    local folderNames = { "DropadosInv", "Drops", "ItensDropados", "ItensNoChao", "ItemsDrop", "DropsInv", "ArmasDropadas" }
    local function enqueue(obj)
        if not obj or queued[obj] then return end
        tail = tail + 1; queue[tail] = obj; queued[obj] = true
    end
    local function excluded(obj)
        local own = LocalPlayer.Character
        if own and (obj == own or obj:IsDescendantOf(own)) then return true end
        for _, char in ipairs(characters) do
            if obj == char or obj:IsDescendantOf(char) then return true end
        end
        return false
    end
    local function inScope(obj)
        if #folders == 0 then return obj:IsDescendantOf(workspace) end
        for _, folder in ipairs(folders) do
            if obj == folder or obj:IsDescendantOf(folder) then return true end
        end
        return false
    end
    local function addRecord(obj, prompt, evidence)
        if not obj or excluded(obj) or not inScope(obj) then return end
        if not (obj:IsA("Model") or obj:IsA("Tool") or obj:IsA("BasePart")) then return end
        local name = itemName(obj)
        if not name and not evidence then return end
        local part = partFor(obj)
        if not part then return end
        local parent = obj.Parent
        for _ = 1, 8 do
            if not parent or parent == workspace then break end
            if records[parent] then
                if prompt then records[parent].prompt = prompt end
                return
            end
            parent = parent.Parent
        end
        local existing = records[obj]
        records[obj] = {
            item = obj, parte = part, prompt = prompt or (existing and existing.prompt),
            nome = name or (prompt and prompt.ObjectText ~= "" and prompt.ObjectText) or obj.Name,
        }
    end
    local function inspect(obj)
        if excluded(obj) or not inScope(obj) then return end
        if obj:IsA("ProximityPrompt") then
            if not obj.Enabled or obj.MaxActivationDistance <= 0 then return end
            local parent = obj.Parent
            if parent and parent:IsA("Attachment") then parent = parent.Parent end
            if not parent then return end
            local candidate, cursor = parent, parent
            for _ = 1, 10 do
                if not cursor or cursor == workspace or cursor:IsA("Folder") then break end
                if (cursor:IsA("Model") or cursor:IsA("Tool")) and itemName(cursor) then candidate = cursor; break end
                cursor = cursor.Parent
            end
            local text = (obj.ActionText .. " " .. obj.ObjectText):lower()
            local evidence = textWeapon(obj.ObjectText) or text:find("%f[%w]arma%f[%W]") or text:find("%f[%w]weapon%f[%W]")
            if candidate == parent and evidence then
                local model = parent:FindFirstAncestorWhichIsA("Model")
                if model and model.Parent and not excluded(model) and inScope(model) then
                    local isDropModel = false
                    for _, folder in ipairs(folders) do
                        if model.Parent == folder then isDropModel = true; break end
                    end
                    if not isDropModel and #folders == 0 then
                        local children = model:GetChildren()
                        if #children <= 24 and not model:FindFirstChildOfClass("Humanoid") then
                            isDropModel = true
                            for _, child in ipairs(children) do
                                if child:IsA("Folder") or child:IsA("Model") then isDropModel = false; break end
                            end
                        end
                    end
                    if isDropModel then candidate = model end
                end
            end
            addRecord(candidate, obj, evidence)
        elseif obj:IsA("Model") or obj:IsA("Tool") or obj:IsA("BasePart") then
            addRecord(obj)
        end
    end
    local function updateRoots()
        characters = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then characters[#characters + 1] = player.Character end
        end
        local newFolders = {}
        for _, name in ipairs(folderNames) do
            local folder = workspace:FindFirstChild(name)
            if folder then
                newFolders[#newFolders + 1] = folder
                if not table.find(folders, folder) then enqueue(folder) end
            end
        end
        local fallback = #newFolders == 0 and (not indexStarted or #folders > 0)
        folders, indexStarted, rootsAt = newFolders, true, os.clock()
        if fallback then enqueue(workspace) end
    end
    handleReady(workspace.DescendantAdded:Connect(function(obj)
        if not indexStarted or not inScope(obj) or excluded(obj) then return end
        enqueue(obj)
        local parent = obj.Parent
        for _ = 1, 4 do
            if not parent or parent == workspace or parent:IsA("Folder") then break end
            enqueue(parent); parent = parent.Parent
        end
    end))
    handleReady(workspace.ChildAdded:Connect(function(obj)
        if table.find(folderNames, obj.Name) then rootsAt = -math.huge end
    end))
    task.spawn(function()
        while enabled and not o.destroyed do
            if T.autoColetaEnabled or T.coletaHudEnabled or os.clock() < demandUntil then
                local ok, reason = pcall(function()
                    if os.clock() - rootsAt >= 3 then updateRoots() end
                    local processed, deadline = 0, os.clock() + 0.004
                    while head <= tail and processed < 120 and os.clock() < deadline do
                        local obj = queue[head]; queue[head] = nil; head = head + 1
                        queued[obj] = nil; processed = processed + 1
                        if obj and (obj == workspace or obj.Parent) and not excluded(obj) then
                            if obj ~= workspace then inspect(obj) end
                            if obj == workspace or obj:IsA("Folder") or obj:IsA("Model") or obj:IsA("Tool") or obj:IsA("BasePart") or obj:IsA("Attachment") then
                                local children = obj:GetChildren()
                                for i, child in ipairs(children) do
                                    enqueue(child)
                                    if i % 120 == 0 then task.wait(); if not enabled or o.destroyed then return end end
                                end
                            end
                        end
                    end
                    if head > tail then queue, head, tail = {}, 1, 0 end
                    o.dropIndexBusy = head <= tail
                end)
                if not ok then status("Falha ao indexar drops: " .. tostring(reason)) end
                task.wait(o.dropIndexBusy and 0.03 or 0.15)
            else task.wait(0.2) end
        end
    end)
    local function refreshDrops()
        demandUntil = os.clock() + 3
        if not indexStarted then o.dropIndexBusy = true end
        characters = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then characters[#characters + 1] = player.Character end
        end
        local root, out = isRoot(), {}
        if not root then return out end
        for obj, record in pairs(records) do
            if not obj.Parent or not record.parte.Parent or not obj:IsDescendantOf(workspace) or excluded(obj) or not inScope(obj) then
                records[obj] = nil
            else
                local nested, parent = false, obj.Parent
                for _ = 1, 8 do
                    if not parent or parent == workspace then break end
                    if records[parent] then nested = true; break end
                    parent = parent.Parent
                end
                if not nested then
                    record.distancia = (root.Position - record.parte.Position).Magnitude
                    out[#out + 1] = record
                end
            end
        end
        table.sort(out, function(a, b) return a.distancia < b.distancia end)
        return out
    end
    o.listDrops, o.isWeaponObject, o.inventoryWeaponSnapshot = refreshDrops, weapon, snapshot
    local function returnToBase(active)
        status("Arma recebida; retornando ao ponto")
        local returned, reason = o.travel.to("collection", POSICAO_RETORNO, active)
        status(returned and "Retorno concluido" or (reason or "Retorno interrompido"))
        return returned
    end
    local function useTarget(target, active, nativeOnly)
        local prompt = target.prompt
        if not prompt or not prompt.Parent then prompt = target.item:FindFirstChildWhichIsA("ProximityPrompt", true) end
        if prompt and prompt.Enabled then return o.interact.prompt(prompt, active, nativeOnly) end
        local click = target.item:FindFirstChildWhichIsA("ClickDetector", true)
        if click and type(fireclickdetector) == "function" then return pcall(fireclickdetector, click) end
        local handle = target.item:FindFirstChild("Handle", true) or target.parte
        local root = isRoot()
        if root and handle and type(firetouchinterest) == "function" then
            pcall(firetouchinterest, root, handle, 0); task.wait(0.1)
            return pcall(firetouchinterest, root, handle, 1)
        end
        return false
    end
    GF = function(target, checkDone, pullOverride)
        if o.collectionBusy or o.travel.owner then return false, "Aguarde a acao atual." end
        if not target or not target.item or not target.parte or not target.item.Parent or not target.parte.Parent then return false, "Item indisponivel." end
        local snapshotOK, before = pcall(snapshot)
        if not snapshotOK then return false, "Inventario indisponivel: " .. tostring(before) end
        o.collectionBusy = true
        o.itemTeleportRunId = o.itemTeleportRunId + 1
        local run, char = o.itemTeleportRunId, LocalPlayer.Character
        local interacted = false
        local function active() return enabled and not o.destroyed and run == o.itemTeleportRunId and LocalPlayer.Character == char end
        local function received()
            if checkDone then return checkDone() end
            return gained(before) or (interacted and not target.item:IsDescendantOf(workspace))
        end
        local ok, success, message = pcall(function()
            status("Coletando " .. tostring(target.nome or target.item.Name))
            if not checkDone and (pullOverride == true or (pullOverride == nil and T.pullWeaponsEnabled)) then
                local root = isRoot()
                if not root then return false, "Personagem indisponivel." end
                local point = root.Position + root.CFrame.LookVector * 3 + Vector3.new(0, -1, 0)
                local moved, why = o.worldMove.toPosition(target.item, target.parte, point, active)
                if not moved then return false, why end
            else
                local function destination()
                    if not target.item.Parent or not target.parte.Parent then return nil end
                    local prompt = target.prompt or target.item:FindFirstChildWhichIsA("ProximityPrompt", true)
                    local position = prompt and o.interact.position(prompt) or target.parte.Position
                    local above = target.parte.Size.Y * 0.5 + 3
                    if prompt then above = math.min(above, prompt.MaxActivationDistance * 0.65) end
                    return position and position + Vector3.new(0, above, 0)
                end
                local arrived, why = o.travel.to("collection", destination, function() return active() and not received() end)
                if not arrived and not received() then return false, why end
            end
            for attempt = 1, 5 do
                if not active() or received() or not target.item.Parent then break end
                interacted = useTarget(target, active, attempt % 2 == 0) or interacted
                local deadline = os.clock() + 0.6
                repeat task.wait(0.1) until not active() or received() or os.clock() >= deadline
            end
            if not active() then return false, "Coleta cancelada." end
            local acknowledgeUntil = os.clock() + 3
            while active() and not received() and os.clock() < acknowledgeUntil do task.wait(0.1) end
            if not active() then return false, "Coleta cancelada." end
            if not received() then return false, "O jogo nao confirmou a arma nos dados do inventario." end
            inventoryBaseline = snapshot()
            if not checkDone and T.returnOnWeaponPickup ~= false then
                local returned = returnToBase(active)
                if not returned then return false, o.coletaStatus end
            end
            return true, "Arma recebida."
        end)
        o.collectionBusy = false
        if not ok then status("Falha na coleta: " .. tostring(success)); return false, o.coletaStatus end
        if not success then status(message or "Coleta interrompida") end
        return success, message
    end
    o.coletarItem = GF
    function o.stopAutoColeta()
        T.autoColetaEnabled = false
        o.coletaRunId, o.itemTeleportRunId = o.coletaRunId + 1, o.itemTeleportRunId + 1
        o.travel.cancel("collection")
        if o.coletaControl then o.coletaControl:Set(false, true) end
    end
    function o.startAutoColeta()
        if T.autoFarmLixeiroEnabled and o.startLixeiro then o.startLixeiro(false) end
        if o.collectionWorker and o.collectionWorker.running and T.autoColetaEnabled then return end
        if o.startPesca and T.autoFarmPescaEnabled then o.startPesca(false) end
        T.autoColetaEnabled, o.coletaRunId = true, o.coletaRunId + 1
        local run, worker = o.coletaRunId, { running = true }
        o.collectionWorker = worker
        if o.coletaControl then o.coletaControl:Set(true, true) end
        task.spawn(function()
            local ok, reason = pcall(function()
                local retryAfter = setmetatable({}, { __mode = "k" })
                while enabled and T.autoColetaEnabled and not o.destroyed and o.coletaRunId == run do
                    if not o.collectionBusy and not o.travel.owner then
                        local target
                        for _, candidate in ipairs(refreshDrops()) do
                            if (retryAfter[candidate.item] or 0) <= os.clock() then target = candidate; break end
                        end
                        if target then
                            local collected, why = GF(target)
                            if not collected then
                                retryAfter[target.item] = os.clock() + 4
                                status(why or "Coleta recusada")
                            end
                        else status("Aguardando arma dropada carregada no mapa") end
                    end
                    task.wait(math.max(0.25, tonumber(T.autoColetaCooldown) or 0.35))
                end
            end)
            worker.running = false
            if not ok and o.coletaRunId == run then
                T.autoColetaEnabled = false
                if o.coletaControl then o.coletaControl:Set(false, true) end
                status("Erro na Auto Coleta: " .. tostring(reason))
                Xz(o.coletaStatus)
            end
        end)
    end
    local function manualReturn()
        if o.collectionBusy or o.destroyed or T.returnOnWeaponPickup == false then return end
        o.collectionBusy = true
        if T.autoFarmLixeiroEnabled and o.startLixeiro then o.startLixeiro(false) end
        if T.autoFarmPescaEnabled and o.startPesca then o.startPesca(false) end
        if T.farmPartesEnabled and o.pararFarmPartes then o.pararFarmPartes() end
        o.travel.cancel()
        o.itemTeleportRunId = o.itemTeleportRunId + 1
        local run, char = o.itemTeleportRunId, LocalPlayer.Character
        task.spawn(function()
            local function active() return enabled and not o.destroyed and T.returnOnWeaponPickup ~= false and o.itemTeleportRunId == run and LocalPlayer.Character == char end
            local deadline = os.clock() + 3
            while o.travel.owner and active() and os.clock() < deadline do task.wait(0.05) end
            local ok, reason = pcall(function() if active() then returnToBase(active) end end)
            o.collectionBusy = false
            if not ok then status("Erro no retorno: " .. tostring(reason)) end
        end)
    end
    task.spawn(function()
        while enabled and not o.destroyed do
            task.wait(inventoryPoll)
            local ok, current = pcall(snapshot)
            if ok then
                local previous = inventoryBaseline
                inventoryBaseline = current
                if previous and os.clock() >= warmUntil and gained(previous, current) and not o.collectionBusy then manualReturn() end
            end
        end
    end)
    handleReady(LocalPlayer.CharacterAdded:Connect(function()
        inventoryBaseline, warmUntil = nil, os.clock() + 0.75
    end))
    inventoryBaseline = snapshot()
    function o.cleanupCollection() enabled = false; o.stopAutoColeta() end
end
do
    local hudGui = Instance.new("ScreenGui")
    hudGui.Name = "InfernityColetaHUD"
    hudGui.ResetOnSpawn = false
    hudGui.IgnoreGuiInset = true
    hudGui.DisplayOrder = 9997
    if protect_gui then pcall(protect_gui, hudGui) end
    hudGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    o.coletaHudGui = hudGui
    local frame = Instance.new("Frame")
    frame.Name = "ColetaHUD"
    frame.AnchorPoint = Vector2.new(1, 0)
    frame.Position = UDim2.new(1, -20, 0, 100)
    frame.Size = UDim2.fromOffset(280, 320)
    frame.BackgroundColor3 = Color3.fromRGB(22, 14, 34)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Visible = false
    frame.Parent = hudGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
    local fs = Instance.new("UIStroke"); fs.Color = Color3.fromRGB(100, 60, 160); fs.Thickness = 1; fs.Parent = frame
    local header = Instance.new("Frame", frame)
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundTransparency = 1
    local title = Instance.new("TextLabel", header)
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromOffset(14, 0)
    title.Size = UDim2.new(1, -90, 1, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = "Armas no chao"
    title.TextColor3 = Color3.fromRGB(240, 230, 255)
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    local countLbl = Instance.new("TextLabel", header)
    countLbl.AnchorPoint = Vector2.new(1, 0.5)
    countLbl.Position = UDim2.new(1, -14, 0.5, 0)
    countLbl.Size = UDim2.fromOffset(80, 20)
    countLbl.BackgroundTransparency = 1
    countLbl.Font = Enum.Font.Gotham
    countLbl.Text = "0"
    countLbl.TextColor3 = Color3.fromRGB(170, 140, 210)
    countLbl.TextSize = 11
    countLbl.TextXAlignment = Enum.TextXAlignment.Right
    local list = Instance.new("ScrollingFrame", frame)
    list.BackgroundTransparency = 1
    list.BorderSizePixel = 0
    list.Position = UDim2.fromOffset(10, 38)
    list.Size = UDim2.new(1, -20, 1, -48)
    list.ScrollBarThickness = 3
    list.ScrollBarImageColor3 = Color3.fromRGB(168, 100, 255)
    list.CanvasSize = UDim2.new()
    list.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local ll = Instance.new("UIListLayout")
    ll.Padding = UDim.new(0, 5)
    ll.SortOrder = Enum.SortOrder.LayoutOrder
    ll.Parent = list
    local emptyMsg = Instance.new("TextLabel", list)
    emptyMsg.Name = "EmptyMsg"
    emptyMsg.Size = UDim2.new(1, 0, 0, 30)
    emptyMsg.BackgroundTransparency = 1
    emptyMsg.Font = Enum.Font.Gotham
    emptyMsg.Text = "Nenhuma arma dropada"
    emptyMsg.TextColor3 = Color3.fromRGB(170, 140, 210)
    emptyMsg.TextSize = 12
    emptyMsg.Visible = true
    local rows = {}
    local function makeRow(i)
            local row = Instance.new("Frame", list)
            row.Size = UDim2.new(1, -4, 0, 34)
            row.BackgroundColor3 = Color3.fromRGB(32, 20, 50)
            row.BorderSizePixel = 0
            row.LayoutOrder = i
            Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
            local label = Instance.new("TextLabel", row)
            label.Position = UDim2.fromOffset(9, 0)
            label.Size = UDim2.new(1, -62, 1, 0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.Gotham
            label.Text = ""
            label.TextColor3 = Color3.fromRGB(240, 230, 255)
            label.TextSize = 11
            label.TextTruncate = Enum.TextTruncate.AtEnd
            label.TextXAlignment = Enum.TextXAlignment.Left
            local tp = Instance.new("TextButton", row)
            tp.AnchorPoint = Vector2.new(1, 0.5)
            tp.Position = UDim2.new(1, -5, 0.5, 0)
            tp.Size = UDim2.fromOffset(42, 24)
            tp.BackgroundColor3 = Color3.fromRGB(168, 100, 255)
            tp.Font = Enum.Font.GothamBold
            tp.Text = "TP"
            tp.TextColor3 = Color3.fromRGB(18, 10, 30)
            tp.TextSize = 11
            tp.AutoButtonColor = false
            Instance.new("UICorner", tp).CornerRadius = UDim.new(0, 5)
            local entry = { frame = row, label = label, button = tp }
            rows[i] = entry
            handleReady(tp.Activated:Connect(function()
                local current = entry.target
                if entry.busy or not current or not current.item.Parent then return end
                entry.busy, tp.Text = true, "..."
                task.spawn(function()
                    local ok, success, reason = pcall(o.coletarItem, current)
                    entry.busy, tp.Text = false, "TP"
                    if not ok or not success then Xz(ok and (reason or "Coleta recusada") or tostring(success)) end
                end)
            end))
            return entry
    end
    local function refresh()
        local drops = o.listDrops and o.listDrops() or {}
        local shown = math.min(#drops, 20)
        countLbl.Text = tostring(#drops)
        emptyMsg.Visible = shown == 0
        emptyMsg.Text = o.dropIndexBusy and "Buscando armas carregadas..." or "Nenhuma arma dropada"
        for i = 1, shown do
            local entry = rows[i] or makeRow(i)
            local d = drops[i]
            entry.target = d
            entry.frame.Visible = true
            entry.label.Text = string.format("%s - %dm", tostring(d.nome), math.floor(d.distancia + 0.5))
        end
        for i = shown + 1, #rows do rows[i].target = nil; rows[i].frame.Visible = false end
    end
    function o.setColetaHudVisible(v)
        T.coletaHudEnabled = v == true
        frame.Visible = T.coletaHudEnabled
        if frame.Visible then
            emptyMsg.Text = "Buscando armas carregadas..."
            task.defer(function() if frame.Visible and not o.destroyed then pcall(refresh) end end)
        end
    end
    task.spawn(function()
        while not o.destroyed do
            if frame.Visible then pcall(refresh) end
            task.wait(0.6)
        end
    end)
end
do
    local function tF()
        local folder = workspace:FindFirstChild("FarmPartesDeArma")
        folder = folder and folder:FindFirstChild("Locais")
        if not folder then return nil end
        for _, obj in ipairs(folder:GetChildren()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("GUI") then return obj end
        end
        local root = isRoot()
        if not root then return nil end
        local best, bestD
        for _, obj in ipairs(folder:GetChildren()) do
            local prompt = obj:IsA("BasePart") and obj:FindFirstChild("Interagir")
            if prompt and prompt.Enabled then
                local d = (root.Position - obj.Position).Magnitude
                if not bestD or d < bestD then best, bestD = obj, d end
            end
        end
        return best
    end
    local function KF()
        o.farmPartesRunId = o.farmPartesRunId + 1
        o.itemTeleportRunId = o.itemTeleportRunId + 1
        if o.travel then o.travel.cancel("collection") end
        T.farmPartesEnabled = false
    end
    local Cf = 15
    local function Yf()
        if T.flyEnabled then T.flyEnabled = false; pcall(xz) end
        o.farmPartesRunId = o.farmPartesRunId + 1
        local runId = o.farmPartesRunId
        local count = 0
        local hadNoclip = T.noclipEnabled
        if not hadNoclip then T.noclipEnabled = true; pcall(Nz) end
        while T.farmPartesEnabled and not o.destroyed and runId == o.farmPartesRunId do
            local alvo = tF()
            if not alvo then
                task.wait(1)
            else
                local target = alvo
                local reached = GF({ item = target, parte = target }, function() return tF() ~= target end)
                if runId ~= o.farmPartesRunId then break end
                local moved = reached and tF() ~= target
                if moved then count = count + 1 end
                local wait = moved and Cf or 1
                local deadline = os.clock() + wait
                while os.clock() < deadline do
                    if not T.farmPartesEnabled or o.destroyed or runId ~= o.farmPartesRunId then break end
                    task.wait(0.2)
                end
            end
        end
        if runId == o.farmPartesRunId then
            T.farmPartesEnabled = false
            o.farmPartesColetadas = count
        end
        if not hadNoclip and (not T.farmPartesEnabled or runId == o.farmPartesRunId) then
            T.noclipEnabled = false
            pcall(Nz)
        end
        return count
    end
    o.iniciarFarmPartes = Yf
    o.pararFarmPartes = KF
end
do
    local P2 = 10
    local LIXEIRO_TP = Vector3.new(-1216.14, 129.42, -5183.68)
    local function getTeam() return LocalPlayer.Team and LocalPlayer.Team.Name or nil end
    local function getLevel()
        local ns = LocalPlayer:FindFirstChild("NewStats")
        local lv = ns and ns:FindFirstChild("Level")
        return lv and tonumber(lv.Value) or 0
    end
    local function getEmpregos()
        local ok, mod = pcall(function() return require(ReplicatedStorage.Mercadinho.PrefModule) end)
        if not ok or type(mod) ~= "table" or type(mod.Empregos) ~= "table" then return {} end
        local list = {}
        for name, data in pairs(mod.Empregos) do
            table.insert(list, { nome = name, level = tonumber(data.Level) or 0, salario = tonumber(data.Salario) or 0 })
        end
        table.sort(list, function(a, b2)
            if a.level == b2.level then return a.nome < b2.nome end
            return a.level < b2.level
        end)
        return list
    end
    local function getLixoCount()
        local inv = LocalPlayer:FindFirstChild("Inv")
        local count = 0
        if inv then
            for _, v in ipairs(inv:GetChildren()) do
                if v.Name == "Saco de Lixo" then count = count + 1 end
            end
        end
        return count
    end
    local function getMoneySafe()
        local ls = LocalPlayer:FindFirstChild("leaderstats")
        local d = ls and ls:FindFirstChild("Dinheiro")
        return d and tonumber(d.Value) or nil
    end
    local function getLixeiroEmp()
        for _, e in ipairs(getEmpregos()) do
            if string.lower(e.nome) == "lixeiro" then return e end
        end
        return { nome = "Lixeiro", level = 1, salario = 0 }
    end
    local function setFarmStatus(msg) o.garbageFarmStatus = tostring(msg or "") end
    local function isRun(runId) return T.autoFarmLixeiroEnabled and not o.destroyed and o.garbageFarmRunId == runId end
    local function wait2(t, runId)
        local deadline = os.clock() + math.max(0, t or 0)
        repeat
            if not isRun(runId) then return false end
            task.wait(math.min(0.1, math.max(0.01, deadline - os.clock())))
        until os.clock() >= deadline
        return isRun(runId)
    end
    local function sendJobSelect(remote, emp)
        remote:FireServer(emp.nome, emp.level, true)
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        local lx = pg and pg:FindFirstChild("LixeiroUI")
        local frame = lx and lx:FindFirstChild("LixeiroFrame")
        if frame and frame.Visible then frame.Visible = false end
    end
    local function trySelectLixeiro(runId)
        if getTeam() == "Lixeiro" then return true end
        local merc = ReplicatedStorage:FindFirstChild("Mercadinho")
        local remote = merc and merc:FindFirstChild("PrefRemote")
        if not remote or not remote:IsA("RemoteEvent") then
            setFarmStatus("PrefRemote nao encontrado")
            return false
        end
        local emp = getLixeiroEmp()
        if getLevel() < emp.level then return false end
        setFarmStatus("Selecionando lixeiro...")
        remote:FireServer(emp.nome, emp.level)
        wait2(0.25, runId)
        if not isRun(runId) then return false end
        sendJobSelect(remote, emp)
        local deadline = os.clock() + P2
        repeat
            if not isRun(runId) then return false end
            if getTeam() == "Lixeiro" then
                wait2(1.2, runId)
                return true
            end
            task.wait(0.15)
        until os.clock() >= deadline
        return false
    end
    local function isLixoPart(part, prompt)
        return part and part.Parent and part:IsA("BasePart") and part.Name == "Lixo"
            and part.Transparency < 0.95
            and (prompt and prompt.Parent == part and prompt:IsA("ProximityPrompt") and prompt.Enabled)
    end
    local function scanLixos()
        local root = isRoot()
        local folder = workspace:FindFirstChild("Lixeiro")
        local list = {}
        if not root or not folder then return list end
        for _, part in ipairs(folder:GetChildren()) do
            local prompt = part:FindFirstChild("PegarLixo")
            if isLixoPart(part, prompt) then
                table.insert(list, { parte = part, prompt = prompt, posicao = part.Position, distancia = (part.Position - root.Position).Magnitude })
            end
        end
        table.sort(list, function(a, b3) return a.distancia < b3.distancia end)
        return list
    end
    local function inRange(root, part, prompt)
        if not root or not part or not part.Parent then return false end
        local maxD = prompt and math.max(2.5, prompt.MaxActivationDistance - 0.65) or 4.25
        return (root.Position - part.Position).Magnitude <= maxD
    end
    local function teleportTo(part, prompt, runId)
        local root = isRoot()
        if not root or not part or not part.Parent or not isRun(runId) then return false end
        if inRange(root, part, prompt) then return true end
        local position = prompt and o.interact.position(prompt) or part.Position
        if not position then return false end
        local above = math.min(part.Size.Y * 0.5 + 2.5, prompt and prompt.MaxActivationDistance * 0.6 or 3)
        local moved, reason = o.travel.to("garbage", position + Vector3.new(0, above, 0), function()
            return isRun(runId) and part.Parent ~= nil and (not prompt or prompt.Parent ~= nil)
        end)
        if not moved then setFarmStatus(reason or "TP interrompido"); return false end
        return inRange(isRoot(), part, prompt)
    end
    local function firePrompt(prompt, force)
        if not prompt or not prompt.Parent or not prompt.Enabled then return false end
        if not force and type(fireproximityprompt) == "function" then
            return pcall(fireproximityprompt, prompt, 0)
        end
        return pcall(function()
            prompt:InputHoldBegin()
            task.wait(math.max(0.15, prompt.HoldDuration + 0.1))
            prompt:InputHoldEnd()
        end)
    end
    local function collectOne(part, prompt, runId)
        local before = getLixoCount()
        for attempt = 1, 3 do
            if not isRun(runId) or not isLixoPart(part, prompt) then
                return not part.Parent or part.Transparency >= 0.95
            end
            local root = isRoot()
            if not inRange(root, part, prompt) then return false end
            firePrompt(prompt, attempt > 1)
            local deadline = os.clock() + 2.75
            repeat
                if not isRun(runId) then return false end
                if not part.Parent or part.Transparency >= 0.95 or getLixoCount() > before then return true end
                task.wait(0.1)
            until os.clock() >= deadline
        end
        return false
    end
    local function findDelivery()
        local folder = workspace:FindFirstChild("EntregaLixo")
        local lixeira = folder and folder:FindFirstChild("Lixeira")
        local prompt = lixeira and lixeira:FindFirstChild("EntregarLixo")
        if lixeira and lixeira:IsA("BasePart") and prompt and prompt:IsA("ProximityPrompt") then
            return lixeira, prompt
        end
        return nil, nil
    end
    local function deliverLixos(count, runId)
        local part, prompt = findDelivery()
        if not part or not prompt then return false end
        setFarmStatus(string.format("%d/%d coletados; indo entregar...", count, count))
        if not teleportTo(part, prompt, runId) then
            if not isRun(runId) then return false end
            return false
        end
        local beforeCount = getLixoCount()
        local beforeMoney = getMoneySafe()
        for attempt = 1, 3 do
            if not isRun(runId) then return false end
            firePrompt(prompt, attempt > 1)
            local deadline = os.clock() + 4
            repeat
                if not isRun(runId) then return false end
                local nowCount = getLixoCount()
                local nowMoney = getMoneySafe()
                if (beforeCount > 0 and nowCount < beforeCount) or (beforeMoney and nowMoney and nowMoney > beforeMoney) then
                    return true
                end
                task.wait(0.15)
            until os.clock() >= deadline
        end
        return false
    end
    function o.teleportLixeiro(active)
        return o.travel.to("garbage", LIXEIRO_TP, active)
    end
    local function farmLoop(runId)
        local deadline = os.clock() + 3
        while o.travel.owner and isRun(runId) and os.clock() < deadline do task.wait(0.05) end
        if not isRun(runId) then return end
        setFarmStatus("TP para o ponto do lixeiro...")
        local moved, reason = o.teleportLixeiro(function() return isRun(runId) end)
        if not moved then
            setFarmStatus(reason or "TP recusado")
            T.autoFarmLixeiroEnabled = false
            if o.lixeiroControl then o.lixeiroControl:Set(false, true) end
            Xz(o.garbageFarmStatus)
            return
        end
        while isRun(runId) do
            if not trySelectLixeiro(runId) then
                wait2(2, runId)
            else
                local goal = math.clamp(math.floor(tonumber(T.autoFarmLixeiroQuantidade) or 20), 1, 20)
                local collected = 0
                while isRun(runId) and getTeam() == "Lixeiro" and collected < goal do
                    local list = scanLixos()
                    if #list == 0 then
                        setFarmStatus(string.format("Coletados %d/%d; aguardando...", collected, goal))
                        wait2(1.25, runId)
                    else
                        local target = list[1]
                        if teleportTo(target.parte, target.prompt, runId) then
                            if collectOne(target.parte, target.prompt, runId) then
                                collected = collected + 1
                                wait2(0.45, runId)
                            else
                                if not isRun(runId) then break end
                                wait2(0.35, runId)
                            end
                        else
                            if not isRun(runId) then break end
                            wait2(0.4, runId)
                        end
                    end
                end
                if not isRun(runId) then break end
                if getTeam() ~= "Lixeiro" then
                    setFarmStatus("Emprego alterado; retomando...")
                elseif collected >= goal then
                    while isRun(runId) and not deliverLixos(collected, runId) do
                        wait2(1, runId)
                    end
                    if isRun(runId) then wait2(1.25, runId) end
                end
            end
        end
    end
    local function startLixeiro(enable)
        T.autoFarmLixeiroEnabled = enable == true
        o.garbageFarmRunId = o.garbageFarmRunId + 1
        local runId = o.garbageFarmRunId
        o.travel.cancel("garbage")
        if T.autoFarmLixeiroEnabled then
            if o.stopAutoColeta then o.stopAutoColeta() end
            if T.autoFarmPescaEnabled and o.startPesca then o.startPesca(false) end
            if T.farmPartesEnabled and o.pararFarmPartes then o.pararFarmPartes() end
            setFarmStatus("Verificando emprego...")
            task.spawn(function()
                local ok, err = pcall(farmLoop, runId)
                if not ok and isRun(runId) then
                    setFarmStatus("Erro: " .. tostring(err))
                    T.autoFarmLixeiroEnabled = false
                    o.garbageFarmRunId = o.garbageFarmRunId + 1
                    if o.lixeiroControl then o.lixeiroControl:Set(false, true) end
                end
            end)
        else
            setFarmStatus("Auto Farm parado.")
            o.travel.cancel("garbage")
        end
    end
    o.startLixeiro = startLixeiro
end
do
    local PESCA_TP = Vector3.new(-2593.61, 122.34, -3044.99)
    local function normalize(text) return tostring(text or ""):lower():gsub("[^%w]", "") end
    local function isRun(runId)
        return T.autoFarmPescaEnabled and not o.destroyed and o.pescaRunId == runId
    end
    local function fishingPrompt(prompt)
        local text = normalize(prompt.Name .. " " .. prompt.ActionText .. " " .. prompt.ObjectText)
        return text:find("pesc", 1, true) or text:find("fishing", 1, true) or text:find("fish", 1, true)
    end
    local function findRod()
        local containers = { LocalPlayer.Character, LocalPlayer:FindFirstChild("Backpack") }
        for _, container in pairs(containers) do
            for _, tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = normalize(tool.Name)
                    if name:find("varadepesca", 1, true) or name == "vara" or name:find("fishingrod", 1, true)
                        or name:find("fishingpole", 1, true) then return tool end
                end
            end
        end
    end
    local function farmLoop(session)
        while isRun(session) do
            local char, root = LocalPlayer.Character, isRoot()
            if not root then task.wait(0.3) else
                o.pescaStatus = "Indo ao ponto de pesca"
                local moved, reason = o.travel.to("fishing", PESCA_TP, function() return isRun(session) end)
                if not moved then
                    o.pescaStatus = reason or "Deslocamento interrompido"
                    if isRun(session) then Xz(o.pescaStatus) end
                    break
                end
                local prompts, nextScan, nextCast = {}, 0, 0
                while isRun(session) and LocalPlayer.Character == char do
                    root = isRoot()
                    if not root or (root.Position - PESCA_TP).Magnitude > 8 then
                        o.pescaStatus = "Voce saiu do ponto; farm pausado"
                        break
                    end
                    if os.clock() >= nextScan then
                        nextScan, prompts = os.clock() + 2, {}
                        for _, prompt in ipairs(workspace:GetDescendants()) do
                            if prompt:IsA("ProximityPrompt") and prompt.Enabled and fishingPrompt(prompt) then
                                local position = o.interact.position(prompt)
                                if position and (position - root.Position).Magnitude <= prompt.MaxActivationDistance then
                                    prompts[#prompts + 1] = prompt
                                end
                            end
                        end
                    end
                    local used = false
                    if not o.actionsBusy then
                        for _, prompt in ipairs(prompts) do
                            if not isRun(session) then break end
                            if prompt.Parent then
                                used = o.interact.prompt(prompt, function() return isRun(session) end) or used
                            end
                        end
                        if not used and os.clock() >= nextCast then
                            local rod, hum = findRod(), isCValid()
                            if rod and hum and rod.Enabled then
                                if rod.Parent ~= char then hum:EquipTool(rod); task.wait(0.15) end
                                if isRun(session) and rod.Parent == char then
                                    rod:Activate()
                                    nextCast, used = os.clock() + 1.5, true
                                end
                            end
                        end
                    end
                    o.pescaStatus = used and "Pescando" or "Aguardando vara ou interacao de pesca"
                    task.wait(0.35)
                end
                if LocalPlayer.Character == char then break end
            end
        end
        if o.pescaRunId == session then
            T.autoFarmPescaEnabled = false
            if o.pescaControl then o.pescaControl:Set(false, true) end
        end
    end
    function o.startPesca(enabled)
        o.pescaRunId = o.pescaRunId + 1
        T.autoFarmPescaEnabled = enabled == true
        o.travel.cancel("fishing")
        if o.pescaControl then o.pescaControl:Set(T.autoFarmPescaEnabled, true) end
        if not T.autoFarmPescaEnabled then o.pescaStatus = "Parado"; return end
        if o.stopAutoColeta then o.stopAutoColeta() end
        if T.autoFarmLixeiroEnabled and o.startLixeiro then o.startLixeiro(false) end
        local session = o.pescaRunId
        task.spawn(function()
            while o.travel.owner and isRun(session) do task.wait(0.05) end
            local ok, reason = pcall(farmLoop, session)
            if not ok and o.pescaRunId == session then
                T.autoFarmPescaEnabled, o.pescaStatus = false, "Falha: " .. tostring(reason)
                if o.pescaControl then o.pescaControl:Set(false, true) end
                Xz(o.pescaStatus)
            end
        end)
    end
end
do
    local tracerColors = {
        { "Ciano", Color3.fromRGB(0, 255, 255) },
        { "Verde", Color3.fromRGB(60, 255, 90) },
        { "Rosa", Color3.fromRGB(255, 60, 190) },
        { "Roxo", Color3.fromRGB(160, 70, 255) },
        { "Vermelho", Color3.fromRGB(255, 45, 45) },
        { "Azul", Color3.fromRGB(70, 130, 255) },
        { "Laranja", Color3.fromRGB(255, 145, 30) },
        { "Branco", Color3.fromRGB(240, 240, 240) },
        { "Amarelo", Color3.fromRGB(255, 230, 60) },
        { "VerdeLimao", Color3.fromRGB(180, 255, 0) },
        { "Magenta", Color3.fromRGB(255, 0, 200) },
        { "Turquesa", Color3.fromRGB(0, 200, 180) },
        { "Arco-iris", nil },
    }
    local corBalaOriginal = nil
    local function getCorBala()
        local cfg = LocalPlayer:FindFirstChild("OrpheusGunCFG")
        local cb = cfg and cfg:FindFirstChild("CorBala")
        if cb and corBalaOriginal == nil then corBalaOriginal = cb.Color end
        return cb
    end
    local function aplicarCorBala()
        local cor = getCorBala()
        if not cor then return end
        if not T.armaTracer then
            if corBalaOriginal then pcall(function() cor.Color = corBalaOriginal end) end
            return
        end
        if T.armaTracerCor == "Arco-iris" then
            cor.Color = Color3.fromHSV((os.clock() * 0.25) % 1, 1, 1)
            return
        end
        for _, g in ipairs(tracerColors) do
            if g[1] == T.armaTracerCor and g[2] then
                cor.Color = g[2]
                return
            end
        end
    end
    o.restaurarArmas = function()
        pcall(aplicarCorBala)
        local cor = getCorBala()
        if cor and corBalaOriginal then pcall(function() cor.Color = corBalaOriginal end) end
    end
    handleReady(RunService.RenderStepped:Connect(function()
        if o.destroyed then return end
        if not T.armaTracer then return end
        pcall(aplicarCorBala)
    end))
end
do
    local originals = setmetatable({}, { __mode = "k" })
    local generation, writing, elapsed = 0, false, 0
    local lightingObjects = setmetatable({}, { __mode = "k" })
    local bright = {
        Brightness = 2, ClockTime = 14, GlobalShadows = false,
        Ambient = Color3.fromRGB(255, 255, 255),
        OutdoorAmbient = Color3.fromRGB(255, 255, 255),
        FogStart = 0, FogEnd = 1000000, ExposureCompensation = 0,
    }
    local function desiredFor(obj)
        local desired = {}
        if obj == Lighting then
            if T.fullbright then
                for prop, value in pairs(bright) do desired[prop] = value end
            elseif T.noLag then
                desired.GlobalShadows = false
            end
        elseif obj:IsA("Atmosphere") and T.fullbright then
            desired.Density, desired.Haze, desired.Glare = 0, 0, 0
        elseif obj:IsA("PostEffect") then
            if T.fullbright or T.noLag then desired.Enabled = false end
        elseif T.noLag then
            if obj:IsA("Terrain") then
                desired.WaterWaveSize, desired.WaterWaveSpeed = 0, 0
                desired.WaterReflectance, desired.Decoration = 0, false
            elseif obj:IsA("BasePart") then
                desired.CastShadow, desired.Reflectance = false, 0
                desired.Material = Enum.Material.SmoothPlastic
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
                or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                desired.Enabled = false
            end
        end
        return desired
    end
    local function apply(obj)
        if not obj.Parent and obj ~= Lighting then return end
        local desired = desiredFor(obj)
        if obj:IsA("PostEffect") or obj:IsA("Atmosphere") then lightingObjects[obj] = true end
        local saved = originals[obj]
        local wasWriting = writing
        writing = true
        if saved then
            for prop, entry in pairs(saved) do
                if desired[prop] == nil then
                    pcall(function() obj[prop] = entry.original end)
                    saved[prop] = nil
                end
            end
        end
        for prop, value in pairs(desired) do
            local ok, current = pcall(function() return obj[prop] end)
            if ok then
                saved = saved or {}
                if not saved[prop] then saved[prop] = { original = current } end
                saved[prop].applied = value
                if current ~= value then pcall(function() obj[prop] = value end) end
            end
        end
        writing = wasWriting
        originals[obj] = saved and next(saved) and saved or nil
    end
    local function refresh()
        generation = generation + 1
        local run = generation
        apply(Lighting)
        local objects, seen = {}, {}
        local function add(obj)
            if not seen[obj] then seen[obj] = true; objects[#objects + 1] = obj end
        end
        for obj in pairs(originals) do add(obj) end
        if T.fullbright or T.noLag then
            for _, obj in ipairs(Lighting:GetDescendants()) do add(obj) end
            local cam = workspace.CurrentCamera
            if cam then for _, obj in ipairs(cam:GetDescendants()) do add(obj) end end
        end
        if T.noLag then
            for _, obj in ipairs(workspace:GetDescendants()) do add(obj) end
        end
        task.spawn(function()
            for index, obj in ipairs(objects) do
                if o.destroyed or generation ~= run then return end
                pcall(apply, obj)
                if index % 150 == 0 then task.wait() end
            end
        end)
    end
    function o.setFullbright(v)
        T.fullbright = v == true
        refresh()
    end
    function o.setNoLag(v)
        T.noLag = v == true
        refresh()
    end
    function o.restoreGraphics()
        generation = generation + 1
        T.fullbright, T.noLag = false, false
        local objects = {}
        for obj in pairs(originals) do objects[#objects + 1] = obj end
        for _, obj in ipairs(objects) do pcall(apply, obj) end
    end
    handleReady(Lighting.Changed:Connect(function(prop)
        if writing or o.destroyed or not (T.fullbright or T.noLag) then return end
        local saved = originals[Lighting]
        if saved and saved[prop] then
            local ok, value = pcall(function() return Lighting[prop] end)
            if ok and value ~= saved[prop].applied then saved[prop].original = value end
        end
        pcall(apply, Lighting)
    end))
    local function onAdded(obj)
        if not o.destroyed and (T.fullbright or T.noLag) then
            task.defer(function()
                if not o.destroyed then pcall(apply, obj) end
            end)
        end
    end
    handleReady(workspace.DescendantAdded:Connect(onAdded))
    handleReady(Lighting.DescendantAdded:Connect(onAdded))
    handleReady(RunService.Heartbeat:Connect(function(dt)
        if o.destroyed or not (T.fullbright or T.noLag) then return end
        elapsed = elapsed + dt
        if elapsed < 0.25 then return end
        elapsed = 0
        pcall(apply, Lighting)
        for obj in pairs(lightingObjects) do if obj.Parent then pcall(apply, obj) end end
    end))
end
local function Wz(dt)
    if o.destroyed then return end
    local hum = isCValid()
    if hum then
        if T.spoofWalkEnabled then
            local ws = math.min(T.spoofWalkSpeed, 28)
            if hum.WalkSpeed ~= ws then hum.WalkSpeed = ws end
        end
    end
    pcall(o.updateJumpPower, hum)
    if o.travelBusy then return end
    if o.robbery and (o.robbery.enabled or o.robbery.paused) then return end
    pcall(Fz, dt)
    if T.noclipEnabled then
        pcall(Nz)
        if not T.flyEnabled then pcall(ez) end
    end
    if T.flyEnabled or yz then pcall(xz, dt) end
end
handleReady(RunService.Heartbeat:Connect(Wz))
handleReady(RunService.Stepped:Connect(function()
    if not o.destroyed then pcall(o.noclip.step) end
end))
do
    local G = { records = {}, byCar = {}, byLabel = {}, selected = nil,
        ids = setmetatable({}, { __mode = "k" }), nextId = 0, esp = {}, busy = false,
        cancelToken = 0, actionToken = 0 }
    o.garage = G
    local elapsed, visualElapsed, optionKey = 0, 0, ""
    local function active()
        return not o.destroyed and (not G.busy or G.cancelToken == G.actionToken)
    end
    function G.cancel() G.cancelToken = G.cancelToken + 1 end
    local function valid(record)
        return record and record.car.Parent and record.seat.Parent and record.root.Parent
            and record.car:IsDescendantOf(workspace) and record.seat:IsDescendantOf(record.car)
            and record.root:IsDescendantOf(record.car)
    end
    function G.isEmpty(record)
        if not valid(record) then return false end
        for _, seat in ipairs(record.car:GetDescendants()) do
            if (seat:IsA("Seat") or seat:IsA("VehicleSeat")) and seat.Occupant then return false end
        end
        return true
    end
    function G.isStopped(record)
        if not valid(record) then return false end
        local velocity = record.root.AssemblyLinearVelocity or Vector3.zero
        local rotation = record.root.AssemblyAngularVelocity or Vector3.zero
        return velocity.Magnitude <= 0.25 and rotation.Magnitude <= 0.15
    end
    function G.isEligible(record) return G.isEmpty(record) and G.isStopped(record) end
    local function setStatus()
        local record, root = G.selected, isRoot()
        local text = "Selecione um carro carregado"
        if valid(record) then
            local distance = root and math.floor((record.root.Position - root.Position).Magnitude) or 0
            text = record.label .. " | " .. distance .. " studs"
        end
        if G.status then pcall(function() G.status:Set(text, true) end) end
    end
    function G.select(record)
        G.selected = valid(record) and record or nil
        if G.dropdown then
            pcall(function() G.dropdown:Set(G.selected and G.selected.label or nil, true) end)
        end
        setStatus()
    end
    function G.nearest()
        local root, best, distance = isRoot(), nil, math.huge
        if not root then return end
        for _, record in ipairs(G.records) do
            if valid(record) and G.isEligible(record) then
                local d = (record.root.Position - root.Position).Magnitude
                if d < distance then best, distance = record, d end
            end
        end
        G.select(best)
        if not best then Xz("Nenhum carro vazio e parado carregado por perto.") end
    end
    local function removeESP(car)
        local entry = G.esp[car]
        if not entry then return end
        pcall(function() entry.billboard:Destroy() end)
        pcall(function() entry.highlight:Destroy() end)
        G.esp[car] = nil
    end
    function G.clearESP()
        local cars = {}
        for car in pairs(G.esp) do cars[#cars + 1] = car end
        for _, car in ipairs(cars) do removeESP(car) end
    end
    function G.refresh()
        local folder = workspace:FindFirstChild("CarrosSpawnados")
        local records, byCar, byLabel, labels = {}, {}, {}, {}
        if folder then
            for _, seat in ipairs(folder:GetDescendants()) do
                if seat:IsA("VehicleSeat") or (seat:IsA("Seat") and seat.Name == "DriveSeat") then
                    local node, car = seat.Parent, nil
                    while node and node ~= folder do
                        if node:IsA("Model") then car = node end
                        node = node.Parent
                    end
                    if node == folder and car and byCar[car] and seat.Name == "DriveSeat"
                        and byCar[car].seat.Name ~= "DriveSeat" then
                        local root = seat.AssemblyRootPart
                        if not root or not root:IsDescendantOf(car) then root = car.PrimaryPart or seat end
                        byCar[car].seat, byCar[car].root = seat, root
                    elseif node == folder and car and not byCar[car] then
                        if not G.ids[car] then G.nextId = G.nextId + 1; G.ids[car] = G.nextId end
                        local root = seat.AssemblyRootPart
                        if not root or not root:IsDescendantOf(car) then root = car.PrimaryPart or seat end
                        local record = { car = car, seat = seat, root = root,
                            label = string.format("[%03d] %s", G.ids[car], car.Name) }
                        byCar[car], byLabel[record.label] = record, record
                        records[#records + 1] = record
                    end
                end
            end
        end
        local filtered = {}
        byCar, byLabel = {}, {}
        for _, record in ipairs(records) do
            if G.isEligible(record) then
                filtered[#filtered + 1] = record
                byCar[record.car], byLabel[record.label] = record, record
            end
        end
        records = filtered
        table.sort(records, function(a, b) return G.ids[a.car] < G.ids[b.car] end)
        for _, record in ipairs(records) do labels[#labels + 1] = record.label end
        local previous = G.selected and G.selected.car
        G.records, G.byCar, G.byLabel = records, byCar, byLabel
        G.selected = previous and byCar[previous] or nil
        for car in pairs(G.esp) do if not byCar[car] then removeESP(car) end end
        local key = table.concat(labels, "\n")
        if G.dropdown and key ~= optionKey then
            optionKey = key
            G.dropdown:SetOptions(labels)
            G.dropdown:Set(G.selected and G.selected.label or nil, true)
        end
        setStatus()
    end
    function G.current()
        G.refresh()
        local hum = isCValid()
        local seat = hum and hum.SeatPart
        if seat then
            for _, record in ipairs(G.records) do
                if seat:IsDescendantOf(record.car) then G.select(record); return end
            end
        end
        Xz("Voce nao esta sentado em um carro carregado.")
    end
    local function target()
        if not valid(G.selected) then return nil, "Selecione um carro na lista." end
        if not G.isEligible(G.selected) then return nil, "O carro deixou de estar vazio ou parado; atualize a lista." end
        return G.selected
    end
    local function moveCharacter(cf)
        return o.teleportCharacter(cf)
    end
    local function leaveSeat(hum)
        if not hum then return false end
        if not hum.SeatPart then return true end
        pcall(function()
            local status = LocalPlayer:FindFirstChild("Status")
            local belt = status and status:FindFirstChild("Cinto")
            if belt then belt.Value = false end
        end)
        hum.Sit = false
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
        local deadline = os.clock() + 1
        repeat
            if not hum.SeatPart then return true end
            task.wait(0.05)
        until os.clock() >= deadline
        return hum.SeatPart == nil
    end
    local function occupiedByOther(record, hum)
        for _, obj in ipairs(record.car:GetDescendants()) do
            if (obj:IsA("Seat") or obj:IsA("VehicleSeat")) and obj.Occupant and obj.Occupant ~= hum then
                return true
            end
        end
        return false
    end
    local function enter(record)
        local hum = isCValid()
        if not hum or hum.Health <= 0 then return false, "Personagem indisponivel." end
        if not valid(record) then return false, "O carro saiu da area carregada." end
        if record.seat.Occupant and record.seat.Occupant ~= hum then return false, "O motorista esta ocupado." end
        if hum.SeatPart == record.seat then return true end
        if not leaveSeat(hum) then return false, "Nao foi possivel sair do assento atual." end
        if not active() then return false, "Acao interrompida." end
        moveCharacter(record.seat.CFrame * CFrame.new(-4, 2, 0))
        task.wait(0.12)
        if not valid(record) or not active() then return false, "O carro nao esta disponivel." end
        record.seat:Sit(hum)
        local deadline = os.clock() + 1.6
        repeat
            if hum.SeatPart == record.seat then return true end
            if not active() or not valid(record) then break end
            task.wait(0.05)
        until os.clock() >= deadline
        return false, "O jogo recusou a entrada no carro. Verifique a trava e o assento."
    end
    local function controlled(record)
        if record.root.Anchored then return false, "O carro esta ancorado." end
        local hum = isCValid()
        if occupiedByOther(record, hum) then return false, "O carro tem outro ocupante." end
        if type(isnetworkowner) == "function" then
            local ok, owned = pcall(isnetworkowner, record.root)
            if ok then return owned == true, "O jogo nao concedeu controle fisico do carro." end
        end
        return hum and hum.SeatPart == record.seat, "Entre no carro antes de usar esta acao."
    end
    local function brake(record)
        for _, part in ipairs(record.car:GetDescendants()) do
            if part:IsA("BasePart") and not part.Anchored then
                part.AssemblyLinearVelocity, part.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
            end
        end
    end
    local function moveCar(record, cf)
        brake(record)
        record.car:PivotTo(cf)
        brake(record)
    end
    local function spot(record, origin)
        local box, size = record.car:GetBoundingBox()
        local pivot = record.car:GetPivot()
        local relative = pivot:ToObjectSpace(box)
        local _, yaw = origin:ToOrientation()
        local rotation = CFrame.Angles(0, yaw, 0)
        local distance = math.max(size.X, size.Z) * 0.5 + 9
        local ray = RaycastParams.new()
        ray.FilterType = Enum.RaycastFilterType.Exclude
        ray.FilterDescendantsInstances = { record.car, LocalPlayer.Character }
        local overlap = OverlapParams.new()
        overlap.FilterType = Enum.RaycastFilterType.Exclude
        overlap.FilterDescendantsInstances = ray.FilterDescendantsInstances
        for _, offset in ipairs({ Vector3.new(0, 0, -distance), Vector3.new(distance, 0, 0),
            Vector3.new(-distance, 0, 0), Vector3.new(0, 0, distance) }) do
            local position = origin:PointToWorldSpace(offset)
            local floor = workspace:Raycast(position + Vector3.new(0, 30, 0), Vector3.new(0, -100, 0), ray)
            if floor and floor.Normal.Y >= 0.75 then
                local candidateBox = CFrame.new(position.X, floor.Position.Y + size.Y * 0.5 + 0.5, position.Z) * rotation
                local blocked = false
                for _, part in ipairs(workspace:GetPartBoundsInBox(candidateBox, size * 0.94, overlap)) do
                    if part.CanCollide then blocked = true; break end
                end
                if not blocked then return candidateBox * relative:Inverse() end
            end
        end
        return nil
    end
    function G.teleport()
        local record, msg = target()
        if not record then return false, msg end
        local hum = isCValid()
        if not hum or not leaveSeat(hum) then return false, "Saia do assento antes de teleportar." end
        if not valid(record) or not active() then return false, "O carro nao esta disponivel." end
        moveCharacter(record.seat.CFrame * CFrame.new(-6, 2, 0))
        return true, "Voce esta ao lado do carro selecionado."
    end
    function G.enter()
        local record, msg = target()
        if not record then return false, msg end
        local root = isRoot()
        local origin = root and root.CFrame
        local ok, message = enter(record)
        if not ok and origin and leaveSeat(isCValid()) then moveCharacter(origin) end
        return ok, ok and "Entrada no carro confirmada." or message
    end
    function G.pull()
        local record, reason = target()
        if not record then return false, reason end
        local root = isRoot()
        if not root then return false, "Personagem indisponivel." end
        if not G.isEligible(record) then return false, "Somente carros vazios e parados podem ser puxados." end
        local destination = spot(record, root.CFrame)
        if not destination then return false, "Nao ha espaco livre perto de voce." end
        local moved, message = o.worldMove.move(record.car, destination, function()
            return active() and valid(record) and G.isEmpty(record)
        end)
        if not moved then return false, message end
        return true, "Carro trazido para perto de voce."
    end
    function G.unflip()
        local record, msg = target()
        if not record then return false, msg end
        local owned, why = controlled(record)
        if not owned then return false, why end
        local pivot = record.car:GetPivot()
        local _, yaw = pivot:ToOrientation()
        moveCar(record, CFrame.new(pivot.Position + Vector3.new(0, 3, 0)) * CFrame.Angles(0, yaw, 0))
        task.wait(0.35)
        if not valid(record) or record.car:GetPivot().UpVector.Y < 0.7 then
            return false, "O jogo nao confirmou a nova posicao do carro."
        end
        return true, "Carro colocado em pe."
    end
    function G.stop()
        local record, msg = target()
        if not record then return false, msg end
        local owned, why = controlled(record)
        if not owned then return false, why end
        brake(record)
        return true, "Carro freado."
    end
    function G.exit()
        return leaveSeat(isCValid()), "Saida do assento solicitada."
    end
    function G.run(action)
        if G.busy or o.destroyed then Xz("Aguarde a acao atual terminar."); return end
        G.busy = true
        G.actionToken = G.cancelToken
        local token = G.actionToken
        local belt = T.autoCintoEnabled
        T.autoCintoEnabled = false
        task.spawn(function()
            local ok, success, msg = pcall(action)
            G.busy = false
            if not o.destroyed then
                if token == G.cancelToken then T.autoCintoEnabled = belt end
                Xz(ok and (msg or (success and "Acao concluida." or "Acao recusada."))
                    or ("Falha na acao: " .. tostring(success)))
            end
        end)
    end
    local function updateESP()
        if not T.carEspEnabled then G.clearESP(); return end
        local root = isRoot()
        if not root then return end
        for _, record in ipairs(G.records) do
            if valid(record) then
                local entry = G.esp[record.car]
                if not entry then
                    local gui = Instance.new("BillboardGui")
                    gui.Name, gui.Adornee = "VT_CAR_ESP", record.root
                    gui.Size, gui.StudsOffsetWorldSpace = UDim2.fromOffset(250, 42), Vector3.new(0, 5, 0)
                    gui.AlwaysOnTop, gui.ResetOnSpawn = true, false
                    gui.Parent = LocalPlayer:FindFirstChild("PlayerGui")
                    local text = Instance.new("TextLabel")
                    text.Size, text.BackgroundTransparency = UDim2.fromScale(1, 1), 1
                    text.Font, text.TextSize, text.TextStrokeTransparency = Enum.Font.GothamBold, 13, 0.25
                    text.TextWrapped, text.Parent = true, gui
                    local highlight = Instance.new("Highlight")
                    highlight.Name, highlight.Adornee = "VT_CAR_HIGHLIGHT", record.car
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.FillTransparency, highlight.OutlineTransparency = 0.9, 0
                    highlight.Parent = record.car
                    entry = { billboard = gui, text = text, highlight = highlight }
                    G.esp[record.car] = entry
                end
                local distance = (record.root.Position - root.Position).Magnitude
                local show = distance <= T.carEspDistance
                local color = G.selected and G.selected.car == record.car
                    and Color3.fromRGB(60, 220, 255) or Color3.fromRGB(180, 100, 255)
                entry.billboard.Enabled, entry.highlight.Enabled = show, show
                entry.billboard.MaxDistance = T.carEspDistance
                entry.text.Text, entry.text.TextColor3 = record.label .. "\n" .. math.floor(distance) .. " studs", color
                entry.highlight.FillColor, entry.highlight.OutlineColor = color, color
            end
        end
    end
    function G.setESP(v)
        T.carEspEnabled = v == true
        if not T.carEspEnabled then G.clearESP() else G.refresh(); pcall(updateESP) end
    end
    function G.cleanup()
        G.cancel()
        T.carEspEnabled = false
        G.clearESP()
    end
    handleReady(RunService.Heartbeat:Connect(function(dt)
        if o.destroyed then return end
        elapsed, visualElapsed = elapsed + dt, visualElapsed + dt
        if elapsed >= 1.5 and not G.busy then elapsed = 0; pcall(G.refresh) end
        if visualElapsed >= 0.15 then visualElapsed = 0; pcall(updateESP); setStatus() end
    end))
end
do
    local token = 0
    local definitions = {
        health = { label = "Vida", missing = "Tenha bandagem ou kit medico no inventario.",
            items = { "bandagem", "bandage", "medkit", "kitmedico", "kitdeprimeirossocorros", "firstaid", "curativo", "medicamento" },
            kinds = { "health", "heal", "cura", "medic", "medical" } },
        thirst = { label = "Sede", missing = "Tenha agua ou bebida no inventario.",
            items = { "agua", "water", "garrafadeagua", "suco", "juice", "refrigerante", "soda", "energetico", "bebida", "drink" },
            kinds = { "thirst", "sede", "drink", "bebida", "hydration" },
            stats = { sede = true, thirst = true, hydration = true, hidratacao = true } },
        hunger = { label = "Fome", missing = "Tenha comida no inventario.",
            items = { "pao", "hamburguer", "hamburger", "burger", "sanduiche", "sandwich", "pizza", "marmita", "coxinha", "hotdog", "comida", "food", "lanche", "banana", "maca", "biscoito", "snack" },
            kinds = { "hunger", "fome", "food", "comida" },
            stats = { fome = true, hunger = true, food = true, alimentacao = true, saciedade = true } },
    }
    local function normalize(text)
        text = tostring(text or ""):lower()
        for from, to in pairs({ ["á"] = "a", ["à"] = "a", ["ã"] = "a", ["â"] = "a",
            ["é"] = "e", ["ê"] = "e", ["í"] = "i", ["ó"] = "o", ["ô"] = "o", ["õ"] = "o", ["ú"] = "u", ["ç"] = "c" }) do
            text = text:gsub(from, to)
        end
        return text:gsub("[^%w]", "")
    end
    local function maximum(source, name)
        local max = tonumber(source:GetAttribute("Max")) or tonumber(source:GetAttribute("Maximum"))
            or tonumber(source:GetAttribute("MaxValue"))
        if not max and source.Parent then
            local sibling = source.Parent:FindFirstChild("Max" .. name) or source.Parent:FindFirstChild(name .. "Max")
            if sibling and (sibling:IsA("NumberValue") or sibling:IsA("IntValue")) then max = sibling.Value end
            max = max or tonumber(source.Parent:GetAttribute("Max" .. name))
        end
        if source:GetAttribute("Normalized") == true then max = 1 end
        return max and max > 0 and max or 100
    end
    local function readStat(kind)
        if kind == "health" then
            local hum = isCValid()
            if hum then return hum.Health, hum.MaxHealth end
            return nil
        end
        local aliases = definitions[kind].stats
        local containers = { LocalPlayer }
        local char = LocalPlayer.Character
        if char then containers[#containers + 1] = char end
        for _, name in ipairs({ "Status", "Stats", "Data", "PlayerData", "leaderstats" }) do
            local container = LocalPlayer:FindFirstChild(name)
            if container then containers[#containers + 1] = container end
        end
        for _, container in ipairs(containers) do
            for name, value in pairs(container:GetAttributes()) do
                if aliases[normalize(name)] and type(value) == "number" then
                    local max = tonumber(container:GetAttribute("Max" .. name)) or tonumber(container:GetAttribute(name .. "Max")) or 100
                    return value, max
                end
            end
            if container ~= LocalPlayer and container ~= char then
                for _, value in ipairs(container:GetDescendants()) do
                    if (value:IsA("NumberValue") or value:IsA("IntValue")) and aliases[normalize(value.Name)] then
                        return value.Value, maximum(value, value.Name)
                    end
                end
            end
        end
    end
    local function score(tool, kind)
        local definition = definitions[kind]
        for _, attribute in ipairs({ "ConsumableType", "ItemType", "Category", "Type" }) do
            local value = normalize(tool:GetAttribute(attribute))
            for _, expected in ipairs(definition.kinds) do if value == expected then return 3 end end
        end
        local name = normalize(tool.Name)
        for _, expected in ipairs(definition.items) do
            if name == expected then return 2 end
            if #expected >= 4 and name:find(expected, 1, true) then return 1 end
        end
        return 0
    end
    local function findTool(kind)
        local best, bestScore = nil, 0
        for _, container in pairs({ LocalPlayer.Character, LocalPlayer:FindFirstChild("Backpack") }) do
            for _, tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") and tool.Enabled then
                    local value = score(tool, kind)
                    if value > bestScore then best, bestScore = tool, value end
                end
            end
        end
        return best
    end
    local function full(value, max) return value and max and max > 0 and value >= max * 0.995 end
    local function consume(kind, run)
        local char, hum = LocalPlayer.Character, isCValid()
        if not char or not hum or hum.Health <= 0 then return false, "Personagem indisponivel." end
        local function active() return token == run and not o.destroyed and LocalPlayer.Character == char and hum.Health > 0 end
        local used, deadline = 0, os.clock() + 65
        while active() and os.clock() < deadline and used < 25 do
            local value, max = readStat(kind)
            if full(value, max) then return true, definitions[kind].label .. " preenchida." end
            local tool = findTool(kind)
            if not tool then
                return false, used == 0 and definitions[kind].missing or "Os consumiveis acabaram antes de completar a barra."
            end
            if tool.Parent ~= char then hum:EquipTool(tool); task.wait(0.2) end
            if not active() then break end
            if tool.Parent ~= char then return false, "O jogo nao equipou o consumivel." end
            local sent, reason = pcall(function() tool:Activate() end)
            if not sent then return false, "Nao foi possivel usar o item: " .. tostring(reason) end
            used = used + 1
            local changed, endTime = false, os.clock() + 6
            repeat
                task.wait(0.1)
                if not active() then break end
                local nextValue = readStat(kind)
                if value and nextValue and nextValue > value + 0.001 then changed = true; break end
                if not tool.Parent then break end
            until os.clock() >= endTime
            if tool.Parent then pcall(function() tool:Deactivate() end) end
            if not active() then break end
            local after, maximumValue = readStat(kind)
            if full(after, maximumValue) then return true, definitions[kind].label .. " preenchida." end
            if not value then return false, "Uso solicitado; a barra nao esta disponivel para confirmar o consumo." end
            if not changed and after and after <= value then
                return false, "O item nao alterou a barra. Ele pode exigir uma interacao propria do jogo."
            end
            task.wait(0.6)
        end
        return false, active() and "Preenchimento interrompido por limite de tentativas." or "Uso de consumiveis cancelado."
    end
    function o.cancelQuickActions() token = token + 1 end
    function o.useConsumable(kind)
        if not definitions[kind] then return false end
        if o.actionsBusy then Xz("Aguarde o consumo atual terminar."); return false end
        token, o.actionsBusy = token + 1, true
        local run, char, hum = token, LocalPlayer.Character, isCValid()
        local previous = char and char:FindFirstChildOfClass("Tool")
        task.spawn(function()
            local ok, success, message = pcall(consume, kind, run)
            if LocalPlayer.Character == char and hum and hum.Parent and hum.Health > 0 then
                if previous and previous.Parent and previous.Parent ~= char then pcall(function() hum:EquipTool(previous) end) end
            end
            o.actionsBusy = false
            if not o.destroyed then Xz(ok and message or ("Falha ao usar consumivel: " .. tostring(success))) end
        end)
        return true
    end
    o.readNeed = readStat
end
do
    o.createRobberyController = function(host)
local BUILD = "FARM-R4"
local CONFIG = {
    INICIAR_AUTO_ROUBO = false,
    INICIAR_POR_BAIXO = false,
    AUTO_TROCAR_SERVIDOR = false,
    MIN_POLICIAIS = 4, 
    MIN_POLICIAIS_CASSINO = 5,
    BANCO_CENTRAL = Vector3.new(-634.49, 108.45, -2675.41),
    RAIO_BANCO_CENTRAL = 180,
    POSICAO_CASSINO = nil, 
    INICIAR_GHOST = false,
    MODO_ECONOMICO = false,
    SOMENTE_BOLSAS = false,
    FPS_ECONOMICO = 30,
    CASSINO_PROFUNDO = false,
    PROFUNDIDADE_CASSINO = 60, 
    TEMPO_SEM_PROGRESSO = 40,
    FALHAS_ANTES_DE_TROCAR_LOCAL = 3,
    REAVALIAR_LOCAL_APOS = 90,
    CACHE_LISTA_SERVIDORES = 45,
    INTERVALO_CONTINUAR_BUSCA = 2,
    EQUIPES_POLICIA = {"policia", "police", "policial", "pm", "pc", "pf", "prf", "bope", "rota", "choque", "pmesp", "pmerj", "pmmg", "gcm", "gm", "guardacivil", "guardamunicipal", "guardametropolitana"},
    NOMES = { 
        "moneybag", "cashbag", "bagmoney", "bolsadedinheiro", "bolsadinheiro",
        "sacodedinheiro", "sacodinheiro", "sacodegrana", "malote",
        "moneydrop", "cashdrop", "dinheirodropado", "pilhadedinheiro", "cashpile",
    },
    LOCAIS = {"cassino", "casino", "joalheria", "jewelry", "jewellery", "banco", "bank", "roubo", "robbery"},
    ROTA = { 
    },
    PROFUNDIDADE = 4,
    DISTANCIA_NORMAL = 2.5,
    TENTATIVAS_POR_BOLSA = 2,
    TEMPO_CONFIRMACAO = 2,
    PAUSA_ENTRE_TENTATIVAS = 0.35,
    REVISITAR_APOS_FALHA = 12,
    REVISITAR_APOS_SINAL = 4,
    ESPERA_CARREGAMENTO_ROTA = 2,
    ESPERA_INICIAL_SERVIDOR = 12,
    SEGUNDOS_SEM_BOLSAS = 8,
    INTERVALO_BUSCA_SERVIDOR = 15,
    TIMEOUT_TROCA_SERVIDOR = 20,
    MAX_PAGINAS_SERVIDORES = 5,
    EVITAR_SERVIDOR_POR = 1800,
}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local World = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
while not player do task.wait(0.1); player = Players.LocalPlayer end
local env = (type(getgenv) == "function" and getgenv()) or _G
if type(env.__VT_AUTO_ROUBO_CLEANUP) == "function" then
    pcall(env.__VT_AUTO_ROUBO_CLEANUP)
end
local executor = {
    prompt = fireproximityprompt or env.fireproximityprompt,
    touch = firetouchinterest or env.firetouchinterest,
    click = fireclickdetector or env.fireclickdetector,
}
local app = {
    enabled = false, below = CONFIG.INICIAR_POR_BAIXO, returnOnStop = false, destroyed = false,
    autoHop = CONFIG.AUTO_TROCAR_SERVIDOR, autoStartPending = CONFIG.INICIAR_AUTO_ROUBO,
    startedAt = 0, emptySince = nil, nextHopAt = 0, routeChecks = 0,
    hopJob = nil, visitedServers = {}, paused = false,
    locationBlocked = {}, collectionProgress = {},
    policeCount = 0, policeEverReady = false, policeConnections = {},
    location = "cassino", locationDone = {}, locationVisited = {}, locationCounts = {},
    totalCount = 0, ghostEnabled = CONFIG.INICIAR_GHOST,
    economyEnabled = CONFIG.MODO_ECONOMICO, onlyBags = CONFIG.SOMENTE_BOLSAS,
    fpsLimit = CONFIG.FPS_ECONOMICO, deepCasino = CONFIG.CASSINO_PROFUNDO,
    leavingPlayers = setmetatable({}, {__mode = "k"}),
    generation = 0, indexed = false, routeIndex = 0,
    registry = {}, cooldowns = setmetatable({}, {__mode = "k"}),
    connections = {}, collisions = {}, status = "Desligado", count = 0,
}
local gui, panel, statusLabel, countLabel, autoButton, belowButton, returnButton, hopButton, ghostButton, reopen
local setEnabled, destroy, pauseForPolice, startGhost, stopGhost, refreshUI
local ui = {}
local function connect(signal, fn)
    local c = signal:Connect(fn)
    app.connections[#app.connections + 1] = c
    return c
end
local function status(text)
    if app.status == text then return end
    app.status = text
    if statusLabel then statusLabel.Text = text end
    if refreshUI then refreshUI() end
end
local function normalize(text)
    local s = tostring(text or ""):lower()
    for accented, plain in pairs({["á"]="a",["à"]="a",["ã"]="a",["â"]="a",["é"]="e",["ê"]="e",["í"]="i",["ó"]="o",["ô"]="o",["õ"]="o",["ú"]="u",["ç"]="c",["Á"]="a",["À"]="a",["Ã"]="a",["Â"]="a",["É"]="e",["Ê"]="e",["Í"]="i",["Ó"]="o",["Ô"]="o",["Õ"]="o",["Ú"]="u",["Ç"]="c"}) do
        s = s:gsub(accented, plain)
    end
    return (s:gsub("[^%w]", ""))
end
local function containsAny(text, list)
    for _, term in ipairs(list) do
        local normalized = normalize(term)
        if normalized ~= "" and text:find(normalized, 1, true) then return true end
    end
    return false
end
local function requiredPolice(location)
    if type(location) == "table" then location = location.location end
    return (location or app.location) == "banco" and CONFIG.MIN_POLICIAIS or CONFIG.MIN_POLICIAIS_CASSINO
end
local function locationName(location)
    return (location or app.location) == "banco" and "Banco Central" or "Cassino"
end
local function renderCounts()
    if countLabel then countLabel.Text = locationName() .. " | Bolsas: " .. app.count .. " | Policiais: " .. app.policeCount .. "/" .. requiredPolice() end
    if refreshUI then refreshUI() end
end
local function isLocationBlocked(location)
    local deadline = app.locationBlocked[location]
    if deadline and os.clock() >= deadline then app.locationBlocked[location] = nil; return false end
    return deadline ~= nil
end
local function chooseLocation(count)
    if not isLocationBlocked(app.location) and not app.locationDone[app.location] and count >= requiredPolice() then return app.location end
    for _, location in ipairs({"cassino", "banco"}) do
        if not isLocationBlocked(location) and not app.locationDone[location] and count >= requiredPolice(location) then
            if pauseForPolice then pauseForPolice() end
            app.location = location
            app.emptySince, app.routeChecks = nil, 0
            renderCounts()
            return location
        end
    end
    return nil
end
local function isPoliceTeam(team)
    if not team then return false end
    local name = normalize(team.Name)
    local prefix = tostring(team.Name or ""):lower():match("%a+") or ""
    for _, alias in ipairs(CONFIG.EQUIPES_POLICIA) do
        local key = normalize(alias)
        if key ~= "" and (name == key or (#key >= 5 and name:find(key, 1, true))
            or (#key <= 4 and prefix == key)) then return true end
    end
    return false
end
local function refreshPoliceCount()
    local count = 0
    for _, member in ipairs(Players:GetPlayers()) do
        if not app.leavingPlayers[member] and member.Neutral ~= true and isPoliceTeam(member.Team) then count = count + 1 end
    end
    app.policeCount = count
    if count >= CONFIG.MIN_POLICIAIS and app.enabled then app.policeEverReady = true end
    if count < requiredPolice() and app.enabled and pauseForPolice then pauseForPolice() end
    renderCounts()
    return count
end
local function hasRequiredPolice(location)
    return refreshPoliceCount() >= requiredPolice(location)
end
local function watchPolicePlayer(member)
    if app.policeConnections[member] then return end
    app.leavingPlayers[member] = nil
    app.policeConnections[member] = {
        member:GetPropertyChangedSignal("Team"):Connect(refreshPoliceCount),
        member:GetPropertyChangedSignal("Neutral"):Connect(refreshPoliceCount),
    }
end
local function removePolicePlayer(member)
    app.leavingPlayers[member] = true
    for _, c in ipairs(app.policeConnections[member] or {}) do c:Disconnect() end
    app.policeConnections[member] = nil
    refreshPoliceCount()
end
local function policeHopReady()
    if refreshPoliceCount() >= CONFIG.MIN_POLICIAIS then return false, 0 end
    if app.policeEverReady then return true, 0 end
    local remaining = math.max(0, math.ceil(app.startedAt + CONFIG.ESPERA_INICIAL_SERVIDOR - os.clock()))
    return remaining == 0, remaining
end
local function collectorKind(obj)
    if obj:IsA("ProximityPrompt") then return "prompt" end
    if obj:IsA("TouchTransmitter") then return "touch" end
    if obj:IsA("ClickDetector") then return "click" end
    return nil
end
local function inWorld(obj)
    return obj and obj.Parent ~= nil and obj:IsDescendantOf(World)
end
local function rootAndHumanoid()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if hum and root and hum.Health > 0 then return root, hum, char end
    return nil
end
local function unavailable(obj)
    for _, key in ipairs({"Collected", "IsCollected", "Coletado"}) do
        if obj:GetAttribute(key) == true then return true end
    end
    for _, key in ipairs({"Available", "Disponivel", "Disponível"}) do
        if obj:GetAttribute(key) == false then return true end
    end
    return false
end
local function classify(handle)
    if not inWorld(handle) then return nil end
    local kind = collectorKind(handle)
    if not kind or (kind == "prompt" and not handle.Enabled) then return nil end
    local attachment, part, nearestModel, namedObject, location = nil, nil, nil, nil, false
    local names, node = {}, handle.Parent
    while node and node ~= World do
        if node:IsA("Tool") or (node:IsA("Model") and node:FindFirstChildOfClass("Humanoid")) then
            return nil
        end
        local name = normalize(node.Name)
        names[#names + 1] = name
        if containsAny(name, CONFIG.LOCAIS) then location = true end
        if not attachment and node:IsA("Attachment") then attachment = node end
        if not part and node:IsA("BasePart") then part = node end
        if not nearestModel and node:IsA("Model") then nearestModel = node end
        if not namedObject and (node:IsA("Model") or node:IsA("BasePart")) and containsAny(name, CONFIG.NOMES) then
            namedObject = node
        end
        node = node.Parent
    end
    local promptText = kind == "prompt" and normalize(handle.ActionText .. " " .. handle.ObjectText) or ""
    local specific = namedObject ~= nil or containsAny(promptText, CONFIG.NOMES)
    local moneyText = promptText:find("dinheiro", 1, true) or promptText:find("money", 1, true) or promptText:find("cash", 1, true)
    local collectText = containsAny(promptText, {"pegar", "coletar", "recolher", "collect", "take", "grab", "pickup"})
    local genericObject = false
    for _, name in ipairs(names) do
        if name == "dinheiro" or name == "money" or name == "cash" or name == "bolsa" or name == "bag" then
            genericObject = true
        end
    end
    if not (specific or (moneyText and collectText) or (location and genericObject)) then return nil end
    if not part and nearestModel then part = nearestModel.PrimaryPart or nearestModel:FindFirstChildWhichIsA("BasePart", true) end
    if not part or not inWorld(part) then return nil end
    local object = namedObject or part
    if unavailable(object) or unavailable(part) then return nil end
    local position = attachment and attachment.WorldPosition or part.Position
    local locationKey = (position - CONFIG.BANCO_CENTRAL).Magnitude <= CONFIG.RAIO_BANCO_CENTRAL and "banco" or "cassino"
    return {
        handle = handle, kind = kind, part = part, object = object,
        location = locationKey,
        anchor = attachment or part,
        label = namedObject and namedObject.Name or (kind == "prompt" and handle.ObjectText ~= "" and handle.ObjectText) or part.Name,
    }
end
local function positionOf(target)
    if not inWorld(target.anchor) then return nil end
    if target.anchor:IsA("Attachment") then return target.anchor.WorldPosition end
    return target.anchor.Position
end
local function resolved(target)
    return not inWorld(target.handle) or not inWorld(target.object) or unavailable(target.object)
        or (target.kind == "prompt" and not target.handle.Enabled)
end
local function chooseTarget()
    local root = rootAndHumanoid()
    local best, distance, count, objects = nil, math.huge, 0, {}
    local counts = {cassino = 0, banco = 0}
    local priority = {prompt = 3, touch = 2, click = 1}
    for handle in pairs(app.registry) do
        local target = classify(handle)
        if target then
            local current = objects[target.object]
            if not current or priority[target.kind] > priority[current.kind] then objects[target.object] = target end
        end
    end
    for _, target in pairs(objects) do
        counts[target.location] = counts[target.location] + 1
        if target.location == app.location then count = count + 1 end
        local pos = positionOf(target)
        if target.location == app.location and root and pos and (app.cooldowns[target.handle] or 0) <= os.clock() then
            local d = (pos - root.Position).Magnitude
            if d < distance then best, distance = target, d end
        end
    end
    app.count, app.totalCount, app.locationCounts = count, counts.cassino + counts.banco, counts
    if app.performance then app.performance.targets(objects) end
    renderCounts()
    return best
end
local function running(id)
    return not app.destroyed and app.enabled and app.generation == id
end
local function waitActive(seconds, id, needsPolice)
    local finish = os.clock() + seconds
    repeat
        if not running(id) or not rootAndHumanoid() then return false end
        if needsPolice and not hasRequiredPolice() then return false end
        if os.clock() >= finish then return true end
        task.wait(0.05)
    until false
end
local function cancelHeldPrompt()
    if app.heldPrompt then
        local prompt = app.heldPrompt
        app.heldPrompt, app.heldPromptId = nil, nil
        pcall(function() prompt:InputHoldEnd() end)
    end
end
pauseForPolice = function()
    cancelHeldPrompt()
    local hold = app.hold
    if hold then
        hold.position = (hold.target and positionOf(hold.target)) or hold.position
        hold.target = nil
    end
end
local function releaseHold()
    app.hold = nil
    cancelHeldPrompt()
    for part, collision in pairs(app.collisions) do
        pcall(function() part.CanCollide = collision end)
    end
    app.collisions = {}
end
local function applyNoCollision(char)
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            if app.collisions[part] == nil then app.collisions[part] = part.CanCollide end
            part.CanCollide = false
        end
    end
end
do
    local LocalPlayer, workspace, o = player, World, app
    local function handleReady(connection)
        app.connections[#app.connections + 1] = connection
        return connection
    end
do
    local HEIGHT = 10
    local PLATFORM_OFFSET = 3.5
    local WALK_ANIMATION_R15 = "rbxassetid://507777826"
    local WALK_ANIMATION_R6 = "rbxassetid://180426354"
    local isGhost = false
    local ghostCharacter = nil
    local fakeModel = nil
    local platform = nil
    local walkTrack = nil
    local camLockConnection = nil
    local ghostNoclipEnabled = false
    local changedParts = {}
    local targetY = 0
    local ghostNoclipLoop = nil
    local RENDER_BINDING = "VT_AutoRouboGhostCameraFix"
    local overlapParams = OverlapParams.new()
    overlapParams.FilterType = Enum.RaycastFilterType.Exclude
    local function clearGhostObstacles(cf)
        local char = ghostCharacter
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        overlapParams.FilterDescendantsInstances = { char, fakeModel, platform }
        local parts = workspace:GetPartBoundsInBox(cf or root.CFrame, Vector3.new(4, 6, 4), overlapParams)
        for _, part in ipairs(parts) do
            if part:IsA("BasePart") and part.Parent and part ~= platform and part.CanCollide then
                if changedParts[part] == nil then changedParts[part] = true end
                part.CanCollide = false
            end
        end
    end
    local function startGhostNoclip()
        if ghostNoclipEnabled then return end
        ghostNoclipEnabled = true
        table.clear(changedParts)
        ghostNoclipLoop = RunService.Stepped:Connect(function()
            if ghostNoclipEnabled then clearGhostObstacles() end
        end)
    end
    local function stopGhostNoclip()
        ghostNoclipEnabled = false
        if ghostNoclipLoop then ghostNoclipLoop:Disconnect(); ghostNoclipLoop = nil end
        for part in pairs(changedParts) do
            if part and part.Parent and part ~= platform then part.CanCollide = true end
        end
        table.clear(changedParts)
    end
    local function setupFakeCharacter(model)
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        humanoid.AutoRotate = false
        humanoid.PlatformStand = true
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        for _, state in ipairs({ Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Ragdoll,
            Enum.HumanoidStateType.Jumping, Enum.HumanoidStateType.Climbing,
            Enum.HumanoidStateType.Swimming, Enum.HumanoidStateType.Freefall,
            Enum.HumanoidStateType.Flying }) do
            pcall(function() humanoid:SetStateEnabled(state, false) end)
        end
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Anchored = true
                obj.CanCollide = false
                obj.CanTouch = false
                obj.CanQuery = false
                obj.Massless = true
            elseif obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        local animation = Instance.new("Animation")
        animation.Name = "InfernityGhostWalk"
        animation.AnimationId = (humanoid.RigType == Enum.HumanoidRigType.R15) and WALK_ANIMATION_R15 or WALK_ANIMATION_R6
        local success, track = pcall(function() return animator:LoadAnimation(animation) end)
        if success and track then
            walkTrack = track
            walkTrack.Looped = true
            walkTrack.Priority = Enum.AnimationPriority.Movement
        end
        return true
    end
    local function updateFakeAnimation(realHumanoid)
        if not walkTrack then return end
        local moving = realHumanoid.MoveDirection.Magnitude > 0.05
        if moving then
            if not walkTrack.IsPlaying then walkTrack:Play(0.12) end
            walkTrack:AdjustSpeed(math.clamp(realHumanoid.WalkSpeed / 16, 0.5, 2))
        else
            if walkTrack.IsPlaying then walkTrack:Stop(0.12) end
        end
    end
    local function updateCameraAndGhost()
        if not isGhost or not fakeModel or LocalPlayer.Character ~= ghostCharacter then return end
        local realChar = ghostCharacter
        local realRoot = realChar:FindFirstChild("HumanoidRootPart")
        if not realRoot or not platform then return end
        local fakeHumanoid = fakeModel:FindFirstChildOfClass("Humanoid")
        if fakeHumanoid and workspace.CurrentCamera.CameraSubject ~= fakeHumanoid then
            workspace.CurrentCamera.CameraSubject = fakeHumanoid
        end
        local currentPos = realRoot.Position
        realRoot.AssemblyLinearVelocity = Vector3.new(
            realRoot.AssemblyLinearVelocity.X, 0, realRoot.AssemblyLinearVelocity.Z)
        platform.CFrame = CFrame.new(currentPos.X, targetY - PLATFORM_OFFSET, currentPos.Z)
        fakeModel:PivotTo(CFrame.new(currentPos.X, targetY + HEIGHT, currentPos.Z) * realRoot.CFrame.Rotation)
        local realHumanoid = realChar:FindFirstChildOfClass("Humanoid")
        if realHumanoid then updateFakeAnimation(realHumanoid) end
    end
    local function stopGhost()
        if not isGhost then return end
        isGhost = false
        RunService:UnbindFromRenderStep(RENDER_BINDING)
        if camLockConnection then camLockConnection:Disconnect(); camLockConnection = nil end
        stopGhostNoclip()
        if walkTrack then pcall(function() walkTrack:Stop(0.1) end); walkTrack = nil end
        local realChar = ghostCharacter
        local realRoot = realChar and realChar:FindFirstChild("HumanoidRootPart")
        local realHumanoid = realChar and realChar:FindFirstChildOfClass("Humanoid")
        if realHumanoid then realHumanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end
        if realRoot and fakeModel then
            local fakeRoot = fakeModel:FindFirstChild("HumanoidRootPart")
            if fakeRoot then realRoot.CFrame = fakeRoot.CFrame end
        end
        if realChar then
            for _, obj in ipairs(realChar:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Transparency = 0
                    obj.CanTouch = true
                    obj.CanQuery = true
                    obj.CanCollide = true
                end
            end
            if realHumanoid and LocalPlayer.Character == realChar then workspace.CurrentCamera.CameraSubject = realHumanoid end
        end
        if fakeModel then fakeModel:Destroy(); fakeModel = nil end
        if platform then platform:Destroy(); platform = nil end
        HEIGHT, o.ghostHeight = 10, 10
        ghostCharacter = nil
    end
    local function startGhost()
        local realChar = LocalPlayer.Character
        if not realChar then return end
        local realRoot = realChar:FindFirstChild("HumanoidRootPart")
        local realHumanoid = realChar:FindFirstChildOfClass("Humanoid")
        if not realRoot or not realHumanoid or isGhost then return end
        ghostCharacter = realChar
        isGhost = true
        realHumanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        local startCFrame = realRoot.CFrame
        targetY = startCFrame.Y - HEIGHT
        platform = Instance.new("Part")
        platform.Name = "InfernityGhostPlatform"
        platform.Size = Vector3.new(10, 1, 10)
        platform.Anchored = true
        platform.CanCollide = true
        platform.CanTouch = false
        platform.CanQuery = false
        platform.Transparency = 1
        platform.CFrame = CFrame.new(startCFrame.X, targetY - PLATFORM_OFFSET, startCFrame.Z)
        platform.Parent = workspace
        realChar.Archivable = true
        for _, desc in ipairs(realChar:GetDescendants()) do desc.Archivable = true end
        local success, clonedChar = pcall(function() return realChar:Clone() end)
        if not success or not clonedChar then stopGhost(); return end
        fakeModel = clonedChar
        fakeModel.Name = "InfernityGhostVisual"
        for _, obj in ipairs(fakeModel:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then obj:Destroy()
            elseif obj:IsA("BasePart") then obj.LocalTransparencyModifier = 0 end
        end
        fakeModel.Parent = workspace
        local fakeRoot = fakeModel:FindFirstChild("HumanoidRootPart")
        local fakeHumanoid = fakeModel:FindFirstChildOfClass("Humanoid")
        if not fakeRoot or not fakeHumanoid then stopGhost(); return end
        fakeModel.PrimaryPart = fakeRoot
        if not setupFakeCharacter(fakeModel) then stopGhost(); return end
        fakeModel:PivotTo(startCFrame)
        for _, obj in ipairs(realChar:GetDescendants()) do
            if obj:IsA("BasePart") then obj.Transparency = 1 end
        end
        startGhostNoclip()
        clearGhostObstacles(CFrame.new(startCFrame.X, targetY, startCFrame.Z) * startCFrame.Rotation)
        realRoot.AssemblyLinearVelocity = Vector3.zero
        realRoot.AssemblyAngularVelocity = Vector3.zero
        realRoot.CFrame = CFrame.new(startCFrame.X, targetY, startCFrame.Z) * startCFrame.Rotation
        workspace.CurrentCamera.CameraSubject = fakeHumanoid
        camLockConnection = workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            if isGhost and fakeHumanoid and workspace.CurrentCamera.CameraSubject ~= fakeHumanoid then
                workspace.CurrentCamera.CameraSubject = fakeHumanoid
            end
        end)
        RunService:BindToRenderStep(RENDER_BINDING, Enum.RenderPriority.Last.Value, updateCameraAndGhost)
    end
    o.ghostHeight = HEIGHT
    o.setGhostHeight = function(height)
        HEIGHT = math.clamp(tonumber(height) or 10, 0.1, math.max(40, CONFIG.PROFUNDIDADE_CASSINO + CONFIG.DISTANCIA_NORMAL))
        o.ghostHeight = HEIGHT
    end
    o.moveGhostRoot = function(cf, prepareDestination)
        if not isGhost or ghostCharacter ~= LocalPlayer.Character or not platform or not platform.Parent or not fakeModel or not fakeModel.Parent then return false end
        local root = ghostCharacter:FindFirstChild("HumanoidRootPart")
        if not root or not root.Parent then return false end
        targetY = cf.Y
        platform.CFrame = CFrame.new(cf.X, targetY - PLATFORM_OFFSET, cf.Z)
        fakeModel:PivotTo(CFrame.new(cf.X, targetY + HEIGHT, cf.Z) * cf.Rotation)
        if prepareDestination then clearGhostObstacles(cf) end
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = cf
        return true
    end
    o.getGhostSurfaceCFrame = function()
        if not isGhost or ghostCharacter ~= LocalPlayer.Character then return nil end
        local root = ghostCharacter:FindFirstChild("HumanoidRootPart")
        if root then return CFrame.new(root.Position.X, targetY + HEIGHT, root.Position.Z) * root.CFrame.Rotation end
    end
    o.startGhost = startGhost
    o.stopGhost = stopGhost
    o.isGhostActive = function() return isGhost end
    handleReady(LocalPlayer.CharacterAdded:Connect(function()
        if isGhost then stopGhost() end
    end))
end
end
local function restoreGhostState()
    local saved = app.savedGhostState
    app.savedGhostState = nil
    if not saved then return end
    for obj, properties in pairs(saved.objects) do
        pcall(function()
            obj.Archivable = properties.archivable
            if properties.transparency ~= nil then
                obj.Transparency = properties.transparency
                obj.CanCollide, obj.CanTouch, obj.CanQuery = properties.collide, properties.touch, properties.query
            end
        end)
    end
    if saved.humanoid and saved.jumping ~= nil then
        pcall(function() saved.humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, saved.jumping) end)
    end
end
stopGhost = function()
    local ok, err = pcall(app.stopGhost)
    restoreGhostState()
    if not ok then warn("[VT GHOST] Erro ao encerrar: " .. tostring(err)) end
    if refreshUI then refreshUI() end
end
startGhost = function()
    if not app.ghostEnabled then return false end
    if app.isGhostActive() then return true end
    if World:FindFirstChild("InfernityGhostVisual") then
        app.ghostError = "Outro Ghost ativo; desligue o Ghost do menu principal"
        return false
    end
    local root, humanoid, character = rootAndHumanoid()
    if not root then app.ghostError = "Aguarde o personagem carregar"; return false end
    local saved = {objects = {}, humanoid = humanoid}
    saved.objects[character] = {archivable = character.Archivable}
    for _, obj in ipairs(character:GetDescendants()) do
        local properties = {archivable = obj.Archivable}
        if obj:IsA("BasePart") then
            properties.transparency, properties.collide, properties.touch, properties.query = obj.Transparency, obj.CanCollide, obj.CanTouch, obj.CanQuery
        end
        saved.objects[obj] = properties
    end
    local captured, jumping = pcall(function() return humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) end)
    if captured then saved.jumping = jumping end
    app.savedGhostState = saved
    local ok, err = pcall(app.startGhost)
    if not ok or not app.isGhostActive() then
        stopGhost()
        app.ghostError = tostring(err or "personagem indisponivel")
        warn("[VT GHOST] Falha ao iniciar o bloco fornecido: " .. app.ghostError)
        return false
    end
    app.ghostError = nil
    if refreshUI then refreshUI() end
    return true
end
local function beginHold(target, explicitPosition, id)
    if not hasRequiredPolice(target) then return false, "Policiais abaixo do minimo deste local" end
    releaseHold()
    local root, hum, char = rootAndHumanoid()
    local pos = explicitPosition or (target and positionOf(target))
    if not root or not pos then return false, "Personagem/alvo indisponivel" end
    local offset = Vector3.new(0, 0, 0)
    local below = app.below or app.ghostEnabled
    local ghostHeight = 10
    if app.ghostEnabled then
        local surfaceOffset = target and CONFIG.DISTANCIA_NORMAL or 0
        local range
        if target and (target.kind == "prompt" or target.kind == "click") then
            range = target.handle.MaxActivationDistance
            if type(range) == "number" and range <= 0 then return false, "Bolsa sem alcance de interacao" end
        end
        if target and target.location == "cassino" and app.deepCasino then
            local depth = 10 - surfaceOffset
            if type(range) == "number" then
                depth = math.min(CONFIG.PROFUNDIDADE_CASSINO, range * 0.85)
            end
            ghostHeight = surfaceOffset + depth
        end
        offset = Vector3.new(0, surfaceOffset - ghostHeight, 0)
    elseif target then
        local distance = below and CONFIG.PROFUNDIDADE or CONFIG.DISTANCIA_NORMAL
        if target.kind == "prompt" then
            local range = target.handle.MaxActivationDistance
            if range <= 0 then return false, "Bolsa sem alcance de interacao" end
            distance = math.min(distance, range * 0.7)
        end
        offset = Vector3.new(0, below and -distance or distance, 0)
    end
    if (pos + offset).Y <= World.FallenPartsDestroyHeight + 10 then
        return false, "Destino abaixo do limite de queda do mapa"
    end
    if app.ghostEnabled then app.setGhostHeight(ghostHeight) end
    if app.ghostEnabled and not startGhost() then
        if app.enabled then setEnabled(false) end
        status(app.ghostError or "Ghost nao iniciou; auto roubo pausado")
        return false, "Ghost nao iniciou"
    end
    app.hold = {root = root, char = char, hum = hum, target = target, position = pos, offset = offset,
        depth = -offset.Y, usesGhost = app.ghostEnabled, below = (target ~= nil and below) or app.ghostEnabled, id = id}
    if app.hold.below and not app.hold.usesGhost then applyNoCollision(char) end
    local cf = CFrame.new(pos + offset) * root.CFrame.Rotation
    if app.hold.usesGhost then
        if not app.moveGhostRoot(cf, true) then
            setEnabled(false)
            status("Ghost perdeu o personagem; coleta pausada")
            return false, "Ghost indisponivel"
        end
    else
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = cf
    end
    return true
end
local function maintainHold()
    local hold = app.hold
    local alive = hold and (running(hold.id) or (app.paused and hold.paused and not app.destroyed))
    if not alive or player.Character ~= hold.char or not hold.root.Parent or hold.hum.Health <= 0 then return end
    local pos = hold.target and positionOf(hold.target) or hold.position
    if not pos then return end
    local cf = CFrame.new(pos + hold.offset) * hold.root.CFrame.Rotation
    if hold.usesGhost then
        if not app.moveGhostRoot(cf, false) then
            setEnabled(false, "stop")
            status("Ghost interrompido; coleta pausada")
        end
        return
    end
    if hold.below then applyNoCollision(hold.char) end
    hold.root.AssemblyLinearVelocity = Vector3.zero
    hold.root.AssemblyAngularVelocity = Vector3.zero
    hold.root.CFrame = cf
end
local function interact(target, id)
    if not running(id) or resolved(target) then return false, "Alvo indisponivel" end
    if not hasRequiredPolice(target) then return false, "Policiais abaixo do minimo deste local" end
    if target.kind == "prompt" then
        local prompt = target.handle
        if type(executor.prompt) == "function" then
            local ok = pcall(executor.prompt, prompt, prompt.HoldDuration)
            return ok, ok and "Interacao enviada" or "Acionamento do prompt falhou"
        end
        app.heldPrompt, app.heldPromptId = prompt, id
        local ok = pcall(function() prompt:InputHoldBegin() end)
        if not ok then app.heldPrompt, app.heldPromptId = nil, nil; return false, "Prompt nao aceitou a interacao" end
        local completed = waitActive(prompt.HoldDuration + 0.15, id, true)
        if app.heldPrompt == prompt and app.heldPromptId == id then
            app.heldPrompt, app.heldPromptId = nil, nil
            pcall(function() prompt:InputHoldEnd() end)
        end
        return completed, "Interacao por prompt"
    elseif target.kind == "touch" then
        local root = rootAndHumanoid()
        if not root then return false, "Personagem indisponivel" end
        if type(executor.touch) == "function" then
            local ok = pcall(executor.touch, root, target.part, 0)
            local completed = waitActive(0.1, id, true)
            pcall(executor.touch, root, target.part, 1)
            return ok and completed, "Interacao por toque"
        end
        if app.below or app.ghostEnabled then return false, "Coleta por baixo requer suporte a toque do executor" end
        root.CFrame = CFrame.new(target.part.Position) * root.CFrame.Rotation
        if app.hold then app.hold.offset = Vector3.zero end
        return waitActive(0.25, id, true), "Aguardando contato com a bolsa"
    end
    if type(executor.click) ~= "function" then return false, "Executor sem suporte a ClickDetector" end
    local ok = pcall(executor.click, target.handle)
    return ok, "Interacao por clique"
end
local function collectTarget(target, id)
    local held, message = beginHold(target, nil, id)
    if not held then return false, message end
    for _ = 1, CONFIG.TENTATIVAS_POR_BOLSA do
        if not waitActive(0.15, id, true) then return false, "Interrompido" end
        if resolved(target) then return true, "Bolsa indisponivel" end
        status("Coletando: " .. target.label)
        local sent, reason = interact(target, id)
        if not running(id) then return false, "Interrompido" end
        if not hasRequiredPolice(target) then return false, "Policiais abaixo do minimo deste local" end
        if not sent then return false, reason end
        local deadline = os.clock() + CONFIG.TEMPO_CONFIRMACAO
        repeat
            if resolved(target) then return true, "Alvo retirado/desativado; buscando proximo" end
            if not waitActive(0.1, id, true) then return false, "Interrompido" end
        until os.clock() >= deadline
        if not waitActive(CONFIG.PAUSA_ENTRE_TENTATIVAS, id, true) then return false, "Interrompido" end
    end
    return false, "Coleta nao confirmada; nova tentativa depois"
end
local function recordCollectionOutcome(target, ok)
    local location, now = target.location, os.clock()
    local progress = app.collectionProgress[location]
    if not progress then progress = {at = now, failures = 0}; app.collectionProgress[location] = progress end
    if ok then
        progress.at, progress.failures = now, 0
        app.locationBlocked[location] = nil
        return false
    end
    progress.failures = progress.failures + 1
    if progress.failures >= CONFIG.FALHAS_ANTES_DE_TROCAR_LOCAL
        and now - progress.at >= CONFIG.TEMPO_SEM_PROGRESSO then
        app.locationBlocked[location] = now + CONFIG.REAVALIAR_LOCAL_APOS
        app.locationDone[location] = true
        pauseForPolice()
        status(locationName(location) .. ": sem progresso; verificando outro local/servidor")
        return true
    end
    return false
end
local historyKey = "VT_AUTO_ROUBO_SERVER_HISTORY_V1"
local function saveServerHistory()
    pcall(function()
        TeleportService:SetTeleportSetting(historyKey, HttpService:JSONEncode({place = tostring(game.PlaceId), jobs = app.visitedServers}))
    end)
end
local function loadServerHistory()
    local now = os.time()
    local ok, raw = pcall(function() return TeleportService:GetTeleportSetting(historyKey) end)
    if ok and type(raw) == "string" then
        local decoded, data = pcall(function() return HttpService:JSONDecode(raw) end)
        if decoded and type(data) == "table" and data.place == tostring(game.PlaceId) and type(data.jobs) == "table" then
            for job, stamp in pairs(data.jobs) do
                if type(job) == "string" and type(stamp) == "number" and stamp <= now and now - stamp < CONFIG.EVITAR_SERVIDOR_POR then
                    app.visitedServers[job] = stamp
                end
            end
        end
    end
    if type(game.JobId) == "string" and game.JobId ~= "" then app.visitedServers[game.JobId] = now end
    saveServerHistory()
end
local function canHop(id)
    return running(id) and app.autoHop
end
local function fetchServerPage(url)
    local req = request or http_request or env.request or env.http_request
        or (syn and syn.request) or (http and http.request)
    local body
    if type(req) == "function" then
        local ok, result = pcall(req, {Url = url, Method = "GET", Headers = {Accept = "application/json"}})
        if not ok or type(result) ~= "table" then return nil, "Falha HTTP na lista de servidores", CONFIG.INTERVALO_BUSCA_SERVIDOR end
        local code = tonumber(result.StatusCode or result.status_code or 200)
        if code == 429 then
            local headers = result.Headers or result.headers or {}
            local retry = type(headers) == "table" and tonumber(headers["Retry-After"] or headers["retry-after"])
            return nil, "Lista de servidores limitada; aguardando", math.max(60, retry or 60)
        end
        if result.Success == false or not code or code < 200 or code >= 300 then
            return nil, "Lista de servidores: HTTP " .. tostring(code), CONFIG.INTERVALO_BUSCA_SERVIDOR
        end
        body = result.Body or result.body
    else
        local ok, result = pcall(function() return game:HttpGet(url) end)
        if not ok then
            local limited = tostring(result):find("429", 1, true)
            return nil, "Nao foi possivel consultar servidores", limited and 60 or CONFIG.INTERVALO_BUSCA_SERVIDOR
        end
        body = result
    end
    if type(body) ~= "string" then return nil, "Lista de servidores sem resposta valida", CONFIG.INTERVALO_BUSCA_SERVIDOR end
    local ok, data = pcall(function() return HttpService:JSONDecode(body) end)
    if not ok or type(data) ~= "table" or type(data.data) ~= "table" then
        return nil, "Lista de servidores invalida", CONFIG.INTERVALO_BUSCA_SERVIDOR
    end
    return data
end
local serverSearch = {
    cursor = nil, order = "Desc", seen = {}, page = 0,
    failed = {}, reusable = nil, http = nil, pool = nil,
}
local function resetServerPages()
    serverSearch.cursor, serverSearch.seen, serverSearch.page = nil, {}, 0
    serverSearch.reusable = nil
    serverSearch.order = "Desc"
end
local function selectServer(records, allowRecentVisit)
    local available, bestPopulation, oldest, oldestStamp = {}, -1, nil, math.huge
    local now = os.time()
    for job, untilTime in pairs(serverSearch.failed) do
        if untilTime <= now then serverSearch.failed[job] = nil end
    end
    for _, server in ipairs(records) do
        if type(server) == "table" then
            local job = server.id
            local playing, capacity = tonumber(server.playing), tonumber(server.maxPlayers)
            if type(job) == "string" and job ~= "" and job ~= game.JobId
                and playing and capacity and playing >= CONFIG.MIN_POLICIAIS
                and playing < capacity and not serverSearch.failed[job] then
                local stamp = tonumber(app.visitedServers[job])
                if not stamp or stamp > now or now - stamp >= CONFIG.EVITAR_SERVIDOR_POR then
                    if playing > bestPopulation then available, bestPopulation = {}, playing end
                    if playing == bestPopulation then available[#available + 1] = job end
                elseif allowRecentVisit and now - stamp >= 60 and stamp < oldestStamp then
                    oldest, oldestStamp = job, stamp
                end
            end
        end
    end
    if #available > 0 then return available[math.random(1, #available)] end
    return oldest, oldestStamp
end
local function queryServerPage(url, id, job)
    local function alive()
        return canHop(id) and (not job or app.hopJob == job)
    end
    local previous = serverSearch.http
    if previous and not previous.done then
        local cancelled = previous.thread and type(task.cancel) == "function"
            and pcall(task.cancel, previous.thread)
        if not cancelled then
            return nil, "Consulta HTTP anterior ainda pendente", CONFIG.INTERVALO_BUSCA_SERVIDOR
        end
    end
    local ticket = {done = false}
    serverSearch.http = ticket
    ticket.thread = task.spawn(function()
        ticket.ok, ticket.data, ticket.message, ticket.retry = pcall(fetchServerPage, url)
        ticket.done = true
    end)
    local deadline = os.clock() + 12
    while not ticket.done and alive() and os.clock() < deadline do
        task.wait(0.05)
    end
    if not ticket.done then
        local cancelled = ticket.thread and type(task.cancel) == "function"
            and pcall(task.cancel, ticket.thread)
        if cancelled and serverSearch.http == ticket then serverSearch.http = nil end
        return nil, alive() and "Consulta expirou; tentando novamente" or "Busca cancelada",
            CONFIG.INTERVALO_BUSCA_SERVIDOR
    end
    if serverSearch.http == ticket then serverSearch.http = nil end
    if not alive() then return nil, "Busca cancelada" end
    if not ticket.ok then
        return nil, "Erro na consulta de servidores", CONFIG.INTERVALO_BUSCA_SERVIDOR
    end
    return ticket.data, ticket.message, ticket.retry
end
local function takeCachedServer()
    local pool = serverSearch.pool
    if not pool or os.clock() >= pool.expires then serverSearch.pool = nil; return nil end
    local selected = selectServer(pool.records)
    if not selected then serverSearch.pool = nil; return nil end
    for index = #pool.records, 1, -1 do
        if pool.records[index].id == selected then table.remove(pool.records, index) end
    end
    return selected
end
local function findOtherServer(id)
    if not canHop(id) then return nil, "Busca cancelada" end
    local cached = takeCachedServer()
    if cached then return cached end
    local job = app.hopJob
    if serverSearch.reusable and serverSearch.failed[serverSearch.reusable.id] then
        serverSearch.reusable = nil
    end
    for index = 1, CONFIG.MAX_PAGINAS_SERVIDORES do
        if not canHop(id) or (job and app.hopJob ~= job) then return nil, "Busca cancelada" end
        local cursor = serverSearch.cursor
        local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId)
            .. "/servers/Public?sortOrder=" .. serverSearch.order
            .. "&limit=100&excludeFullGames=true"
        if cursor then url = url .. "&cursor=" .. HttpService:UrlEncode(cursor) end
        status("Buscando servidores; pagina " .. (serverSearch.page + 1))
        local data, message, retry = queryServerPage(url, id, job)
        if not canHop(id) or (job and app.hopJob ~= job) then return nil, "Busca cancelada" end
        if not data then
            if cursor and type(message) == "string" and message:find("HTTP 400", 1, true) then
                resetServerPages()
            end
            return nil, message, retry
        end
        serverSearch.page = serverSearch.page + 1
        serverSearch.pool = {records = {}, expires = os.clock() + CONFIG.CACHE_LISTA_SERVIDORES}
        for _, record in ipairs(data.data) do
            if type(record) == "table" then serverSearch.pool.records[#serverSearch.pool.records + 1] = record end
        end
        local selected = takeCachedServer()
        if not selected then
            local candidate, stamp = selectServer(data.data, true)
            local old = serverSearch.reusable
            if candidate and (not old or stamp < old.stamp) then
                serverSearch.reusable = {id = candidate, stamp = stamp}
            end
        end
        local nextCursor = data.nextPageCursor
        local complete = type(nextCursor) ~= "string" or nextCursor == ""
            or nextCursor == "null" or nextCursor == cursor or serverSearch.seen[nextCursor]
        local reusable = complete and serverSearch.reusable
        if complete then
            resetServerPages()
        else
            serverSearch.seen[nextCursor] = true
            serverSearch.cursor = nextCursor
        end
        if selected then return selected end
        if complete then
            if reusable and not serverSearch.failed[reusable.id] and reusable.id ~= game.JobId then
                return reusable.id
            end
            return nil, "Nenhum destino com vaga; lista sera atualizada",
                CONFIG.INTERVALO_BUSCA_SERVIDOR
        end
        if index < CONFIG.MAX_PAGINAS_SERVIDORES and not waitActive(0.75, id) then
            return nil, "Busca cancelada"
        end
    end
    return nil, "Continuando a busca nas proximas paginas", CONFIG.INTERVALO_CONTINUAR_BUSCA
end
local function onTeleportFailed(who, result, message, placeId, options)
    local job = app.hopJob
    if who ~= player or not job or not job.destination or tonumber(placeId) ~= game.PlaceId then return end
    if options then
        local ok, destination = pcall(function() return options.ServerInstanceId end)
        if ok and type(destination) == "string" and destination ~= "" and destination ~= job.destination then return end
    end
    job.error = tostring(message or result or "Falha ao entrar no servidor")
end
local function requestServerHop(id, reason)
    if not canHop(id) or app.hopJob then return end
    if os.clock() < app.nextHopAt then
        status("Nova busca de servidor em " .. math.ceil(app.nextHopAt - os.clock()) .. "s")
        return
    end
    local job = {token = id, reason = reason or "empty"}
    app.hopJob = job
    status(job.reason == "police" and ("Policiais " .. app.policeCount .. "/" .. CONFIG.MIN_POLICIAIS .. "; procurando outro servidor...") or "Sem bolsas; procurando outro servidor...")
    local searchOK, destination, message, retry = pcall(findOtherServer, id)
    if not searchOK then
        warn("[VT AUTO SERVER] " .. tostring(destination))
        destination, message, retry = nil, "Busca reiniciada apos erro", CONFIG.INTERVALO_BUSCA_SERVIDOR
        resetServerPages()
    end
    if not canHop(id) or app.hopJob ~= job then
        if app.hopJob == job then app.hopJob = nil end
        return
    end
    if not destination then
        app.hopJob = nil
        app.nextHopAt = os.clock() + (retry or CONFIG.INTERVALO_BUSCA_SERVIDOR)
        status(message or "Servidor indisponivel; tentando depois")
        return
    end
    local policeReady = refreshPoliceCount() >= CONFIG.MIN_POLICIAIS
    if job.reason == "police" and policeReady then
        app.hopJob = nil
        status("Minimo de policiais restabelecido; retomando coleta")
        return
    elseif not policeReady then
        job.reason = "police"
    end
    chooseTarget()
    if policeReady then
        for _, location in ipairs({"cassino", "banco"}) do
            if not isLocationBlocked(location) and (app.locationCounts[location] or 0) > 0 and app.policeCount >= requiredPolice(location) then
                app.locationDone[location] = nil
                chooseLocation(app.policeCount)
                app.hopJob, app.emptySince, app.routeChecks = nil, nil, 0
                status("Bolsas disponiveis em " .. locationName(location) .. "; continuando coleta")
                return
            end
        end
    end
    job.destination = destination
    serverSearch.failed[destination] = os.time() + 90 
    saveServerHistory()
    if not canHop(id) or app.hopJob ~= job then return end
    status("Entrando em outro servidor...")
    local deadline = os.clock() + CONFIG.TIMEOUT_TROCA_SERVIDOR
    local teleportThread = task.spawn(function()
        local ok, err = pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, destination, player) end)
        if not ok and app.hopJob == job then job.error = tostring(err) end
    end)
    while canHop(id) and app.hopJob == job and not job.error and os.clock() < deadline do
        if not waitActive(0.1, id) then break end
    end
    if teleportThread and type(task.cancel) == "function" then pcall(task.cancel, teleportThread) end
    if app.hopJob ~= job then return end
    app.hopJob = nil
    if not canHop(id) then return end
    app.nextHopAt = os.clock() + CONFIG.INTERVALO_BUSCA_SERVIDOR
    status(job.error and "Troca falhou; tentando outro servidor depois" or "Troca nao confirmou; tentando depois")
    if job.error then warn("[VT AUTO SERVER] " .. job.error) end
end
local function emptyServerReady()
    if app.count > 0 or (app.location == "cassino" and app.routeChecks < #CONFIG.ROTA) then return false end
    local now = os.clock()
    if not app.emptySince then app.emptySince = now end
    local deadline = math.max(app.startedAt + CONFIG.ESPERA_INICIAL_SERVIDOR, app.emptySince + CONFIG.SEGUNDOS_SEM_BOLSAS)
    return now >= deadline, math.max(0, math.ceil(deadline - now))
end
local function updateButtons()
    if refreshUI then refreshUI() end
end
local function reopenAvailableLocation(count)
    for _, location in ipairs({"cassino", "banco"}) do
        if not isLocationBlocked(location) and (app.locationCounts[location] or 0) > 0 and count >= requiredPolice(location) then
            app.locationDone[location] = nil
            return chooseLocation(count)
        end
    end
    return nil
end
local function visitCurrentLocation(id)
    local location = app.location
    if app.locationVisited[location] then return true end
    local pos = location == "banco" and CONFIG.BANCO_CENTRAL or CONFIG.POSICAO_CASSINO
    if pos then
        status("Indo para " .. locationName(location) .. "; carregando bolsas...")
        local ok = beginHold(nil, pos, id)
        if not ok or not waitActive(CONFIG.ESPERA_CARREGAMENTO_ROTA, id, true) then return false end
    end
    if not running(id) or not hasRequiredPolice(location) then return false end
    app.locationVisited[location] = true
    app.emptySince = nil
    return true
end
local function worker(id)
    while running(id) do
        if not rootAndHumanoid() then
            setEnabled(false)
            status("Personagem indisponivel; ative novamente apos renascer")
            return
        end
        local count = refreshPoliceCount()
        local ac = app.acRuntime
        if count < CONFIG.MIN_POLICIAIS then
            local ready, remaining = policeHopReady()
            if app.autoHop and ready then requestServerHop(id, "police")
            else
                status("Coleta pausada: policiais " .. count .. "/" .. CONFIG.MIN_POLICIAIS
                    .. (app.autoHop and ("; verificando entrada por " .. remaining .. "s") or "; troca desligada"))
            end
            if not waitActive(0.2, id) then return end
        elseif not chooseLocation(count) then
            chooseTarget()
            if not reopenAvailableLocation(count) then
                if app.autoHop then requestServerHop(id, "completed")
                else status("Locais permitidos finalizados; troca desligada") end
                if not waitActive(0.4, id) then return end
            end
        elseif not ac or ac.destroyed then
            setEnabled(false); status("AC indisponivel neste executor; auto roubo parado"); return
        elseif ac.acAplicando then
            status("Aguardando rotina AC antes de teleportar...")
            if not waitActive(0.1, id) then return end
        elseif (ac.acSilenciados or 0) <= 0 then
            setEnabled(false); status("AC nao encontrado; auto roubo parado")
            warn("[VT AC] " .. ac.acStatus)
            if ac.acUltimoErro then warn("[VT AC] " .. ac.acUltimoErro) end
            return
        elseif app.ghostEnabled and not app.isGhostActive() then
            if not startGhost() then
                setEnabled(false)
                status(app.ghostError or "Ghost nao iniciou; auto roubo pausado")
                return
            end
        elseif not app.indexed then
            status("Indexando objetos...")
            if not waitActive(0.2, id) then return end
        elseif not app.locationVisited[app.location] then
            visitCurrentLocation(id)
            if not waitActive(0.1, id) then return end
        else
            local target = chooseTarget()
            if app.count > 0 then app.emptySince = nil end
            if target then
                if not app.collectionProgress[target.location] then
                    app.collectionProgress[target.location] = {at = os.clock(), failures = 0}
                end
                local ok, message = collectTarget(target, id)
                if not running(id) then return end
                if not hasRequiredPolice(target) then pauseForPolice()
                else
                    if app.hold and app.hold.id == id then
                        app.hold.position = positionOf(target) or app.hold.position
                        app.hold.target = nil
                    end
                    app.cooldowns[target.handle] = os.clock() + (ok and CONFIG.REVISITAR_APOS_SINAL or CONFIG.REVISITAR_APOS_FALHA)
                    if not recordCollectionOutcome(target, ok) then status(locationName() .. ": " .. message) end
                    if not waitActive(0.4, id) then return end
                end
            elseif app.count == 0 then
                if not app.emptySince then app.emptySince = os.clock() end
                local ready, remaining = emptyServerReady()
                if ready then
                    app.locationDone[app.location] = true
                    app.emptySince = nil
                    pauseForPolice()
                    status(locationName() .. " finalizado; verificando proximo local")
                elseif app.location == "cassino" and app.routeChecks < #CONFIG.ROTA then
                    app.routeIndex = app.routeIndex % #CONFIG.ROTA + 1
                    status("Visitando ponto " .. app.routeIndex .. " da rota do cassino")
                    local held = beginHold(nil, CONFIG.ROTA[app.routeIndex], id)
                    if held and waitActive(CONFIG.ESPERA_CARREGAMENTO_ROTA, id, true) then app.routeChecks = app.routeChecks + 1
                    elseif not running(id) then return end
                else
                    status(locationName() .. ": sem bolsas; confirmando por " .. tostring(remaining or 0) .. "s")
                    if not waitActive(0.5, id) then return end
                end
            else
                status(locationName() .. ": aguardando cooldown das bolsas")
                if not waitActive(0.4, id) then return end
            end
        end
    end
end
setEnabled = function(value, reason)
    if app.destroyed then return end
    app.ghostRequest = (app.ghostRequest or 0) + 1
    app.ghostPending = false
    app.autoStartPending = false
    if value == app.enabled and not (app.paused and not value and reason ~= "pause") then return end
    if not value and reason == "pause" then
        local root, hum, char = rootAndHumanoid()
        app.enabled, app.paused, app.pausedAt = false, true, os.clock()
        app.generation = app.generation + 1
        app.hopJob = nil
        cancelHeldPrompt()
        if root and (app.hold or app.isGhostActive()) then
            local hold = app.hold or {root = root, hum = hum, char = char,
                usesGhost = app.isGhostActive(), below = app.below or app.isGhostActive()}
            hold.target, hold.position, hold.offset = nil, root.Position, Vector3.zero
            hold.id, hold.paused = app.generation, true
            app.hold = hold
        end
        updateButtons()
        status("Pausado no local; retome sem retornar ao inicio")
        return
    end
    if value then
        local root, _, char = rootAndHumanoid()
        if not root then status("Aguarde o personagem carregar"); return end
        local ac = app.acRuntime
        if not ac or ac.destroyed then status("AC indisponivel neste executor; auto roubo nao iniciado"); return end
        if not ac.acAplicando and (ac.acSilenciados or 0) <= 0 and ac.acReaplicar then ac.acReaplicar("ativacao") end
        local resuming = app.paused and app.originCharacter == char
        if resuming then
            local elapsed = math.max(0, os.clock() - (app.pausedAt or os.clock()))
            app.startedAt = app.startedAt + elapsed
            if app.emptySince then app.emptySince = app.emptySince + elapsed end
            for _, progress in pairs(app.collectionProgress) do progress.at = progress.at + elapsed end
        else
            app.origin, app.originCharacter = app.getGhostSurfaceCFrame() or root.CFrame, char
            app.startedAt, app.emptySince, app.routeChecks = os.clock(), nil, 0
            app.location, app.locationDone, app.locationVisited, app.locationCounts = "cassino", {}, {}, {}
            app.locationBlocked, app.collectionProgress = {}, {}
            app.policeEverReady = false
        end
        app.hopJob = nil
        app.enabled, app.paused, app.pausedAt = true, false, nil
        app.generation = app.generation + 1
        local id = app.generation
        if app.hold then app.hold.id, app.hold.paused = id, nil end
        updateButtons()
        task.spawn(function()
            local ok, err = pcall(worker, id)
            if not ok and running(id) then
                setEnabled(false)
                status("Erro: " .. tostring(err):sub(1, 100))
                warn("[VT AUTO ROUBO] " .. tostring(err))
            end
        end)
    else
        app.enabled, app.paused, app.pausedAt = false, false, nil
        app.generation = app.generation + 1
        app.hopJob, app.emptySince, app.routeChecks = nil, nil, 0
        local ghostSurface = app.getGhostSurfaceCFrame()
        if stopGhost then stopGhost() end
        local lastHold = app.hold
        local lastPosition = lastHold and ((lastHold.target and positionOf(lastHold.target)) or lastHold.position)
        releaseHold()
        local root, _, char = rootAndHumanoid()
        if reason ~= "mode" and app.returnOnStop and root and app.origin and char == app.originCharacter then
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            root.CFrame = app.origin
        elseif root and lastHold and lastHold.below and lastPosition and char == lastHold.char then
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            root.CFrame = (lastHold.usesGhost and ghostSurface)
                or (CFrame.new(lastPosition + Vector3.new(0, CONFIG.DISTANCIA_NORMAL, 0)) * root.CFrame.Rotation)
        end
        app.origin, app.originCharacter = nil, nil
        updateButtons()
        status("Desligado")
    end
end
local function setGhostEnabled(value)
    if app.destroyed then return end
    local resume = app.enabled
    if app.paused then
        app.paused, app.pausedAt = false, nil
        releaseHold()
    end
    if resume then setEnabled(false, "mode") end
    app.ghostRequest = (app.ghostRequest or 0) + 1
    local requestId = app.ghostRequest
    app.ghostPending = false
    app.ghostEnabled = value == true
    if app.ghostEnabled then app.below = true else stopGhost() end
    if resume then
        setEnabled(true)
    elseif app.ghostEnabled then
        app.ghostPending = true
        status("Ativando Ghost...")
        task.spawn(function()
            local ac = app.acRuntime
            while ac and ac.acAplicando and not app.destroyed and app.ghostEnabled and app.ghostRequest == requestId do
                task.wait(0.1)
            end
            if app.destroyed or not app.ghostEnabled or app.ghostRequest ~= requestId then return end
            if app.enabled then return end
            app.ghostPending = false
            if startGhost() then status("Ghost ativo; auto roubo pausado")
            else app.ghostEnabled = false; status(app.ghostError or "Nao foi possivel iniciar o Ghost") end
            updateButtons()
        end)
    else
        status("Ghost desligado")
    end
    updateButtons()
end
local function toggleBelow()
    local value, resume = not app.below, app.enabled
    if app.paused then
        app.paused, app.pausedAt = false, nil
        releaseHold()
    end
    if resume then setEnabled(false, "mode") end
    app.below = value
    if not value then
        app.ghostRequest = (app.ghostRequest or 0) + 1
        app.ghostEnabled = false
        stopGhost()
    end
    if resume then setEnabled(true) end
    updateButtons()
end
local function startAutomatically()
    if not app.autoStartPending or app.destroyed then return end
    status("Aguardando personagem para iniciar automaticamente...")
    task.spawn(function()
        while not app.destroyed and app.autoStartPending do
            if rootAndHumanoid() then
                setEnabled(true)
                return
            end
            task.wait(0.1)
        end
    end)
end
local function diagnostic()
    local root = rootAndHumanoid()
    if not root then status("Aguarde o personagem carregar"); return end
    warn("[VT AC] " .. (app.acRuntime and app.acRuntime.acStatus or "Recursos do AC indisponiveis neste executor"))
    if app.acRuntime and app.acRuntime.acUltimoErro then warn("[VT AC] " .. app.acRuntime.acUltimoErro) end
    warn("[VT POLICIA] " .. refreshPoliceCount() .. "/" .. requiredPolice() .. " policiais em " .. locationName() .. "; equipes do servidor:")
    local teamCounts = {}
    for _, member in ipairs(Players:GetPlayers()) do
        if not app.leavingPlayers[member] then
            local name = member.Team and member.Team.Name or "Sem equipe"
            local entry = teamCounts[name]
            if not entry then entry = {total = 0, counted = 0, neutral = 0}; teamCounts[name] = entry end
            entry.total = entry.total + 1
            if member.Neutral == true then entry.neutral = entry.neutral + 1
            elseif isPoliceTeam(member.Team) then entry.counted = entry.counted + 1 end
        end
    end
    for name, entry in pairs(teamCounts) do
        print("[VT EQUIPE] " .. name .. " | jogadores=" .. entry.total
            .. " | contados=" .. entry.counted .. " | neutros=" .. entry.neutral)
    end
    local nearby = {}
    for handle in pairs(app.registry) do
        if inWorld(handle) then
            local node, part = handle.Parent, nil
            while node and node ~= World and not part do
                if node:IsA("BasePart") then part = node
                elseif node:IsA("Model") then part = node.PrimaryPart or node:FindFirstChildWhichIsA("BasePart", true) end
                node = node.Parent
            end
            if part then
                local distance = (part.Position - root.Position).Magnitude
                if distance <= 150 then nearby[#nearby + 1] = {handle = handle, distance = distance} end
            end
        end
    end
    table.sort(nearby, function(a, b) return a.distance < b.distance end)
    warn("[VT AUTO ROUBO] Interacoes a ate 150 studs. Proximo de uma bolsa, copie estas linhas para ajustar a deteccao:")
    for i = 1, math.min(#nearby, 50) do
        local entry = nearby[i]
        local h = entry.handle
        local text = h:IsA("ProximityPrompt") and (" | acao=" .. h.ActionText .. " | objeto=" .. h.ObjectText) or ""
        print(string.format("[VT] %.1f studs | %s | %s%s", entry.distance, h.ClassName, h:GetFullName(), text))
    end
    status("Diagnostico: " .. math.min(#nearby, 50) .. " interacoes no console")
end
refreshUI = function()
    if host.onRobberyUpdate then host.onRobberyUpdate(app) end
end
destroy = function()
    if app.destroyed then return end
    setEnabled(false, "mode")
    app.destroyed = true
    app.generation = app.generation + 1
    stopGhost()
    releaseHold()
    for _, connection in ipairs(app.connections) do pcall(function() connection:Disconnect() end) end
    for _, group in pairs(app.policeConnections) do
        for _, connection in ipairs(group) do pcall(function() connection:Disconnect() end) end
    end
    app.connections, app.policeConnections, app.registry = {}, {}, {}
    if env.__VT_AUTO_ROUBO_CLEANUP == destroy then env.__VT_AUTO_ROUBO_CLEANUP = nil end
end
local initialDepth = CONFIG.PROFUNDIDADE_CASSINO
app.setEnabled, app.cleanup, app.diagnostic = setEnabled, destroy, diagnostic
app.depthLimit = initialDepth
function app.setOption(key, value)
    local allowed = {ghostEnabled=true, below=true, autoHop=true, deepCasino=true, returnOnStop=true}
    if not allowed[key] or app.destroyed then return end
    local resume = app.enabled
    if key == "autoHop" or key == "returnOnStop" then
        app[key] = value == true
        if key == "autoHop" and not app.autoHop then app.hopJob = nil end
        updateButtons()
        return
    end
    if app.enabled or app.paused then setEnabled(false, "mode") end
    app[key] = value == true
    if key == "ghostEnabled" and app.ghostEnabled then app.below = true end
    if key == "below" and not app.below then app.ghostEnabled = false end
    if resume then setEnabled(true, "resume") end
    updateButtons()
end
function app.setDepth(value)
    CONFIG.PROFUNDIDADE_CASSINO = math.clamp(math.floor(tonumber(value) or initialDepth),1,120)
    app.depthLimit = CONFIG.PROFUNDIDADE_CASSINO
    updateButtons()
end
function app.resetSettings()
    setEnabled(false, "mode")
    app.ghostEnabled, app.below, app.autoHop, app.deepCasino, app.returnOnStop = false,false,false,false,false
    app.setDepth(initialDepth)
    updateButtons()
end
app.acRuntime = host.acRuntime
loadServerHistory()
env.__VT_AUTO_ROUBO_CLEANUP = destroy
connect(player.CharacterRemoving, function()
    if app.enabled or app.paused then setEnabled(false,"character") end
    stopGhost()
    status("Personagem saiu; ative novamente apos renascer")
end)
connect(player.CharacterAdded, function() stopGhost() end)
connect(RunService.Stepped, maintainHold)
connect(TeleportService.TeleportInitFailed, onTeleportFailed)
connect(Players.PlayerAdded, function(member) watchPolicePlayer(member); refreshPoliceCount() end)
connect(Players.PlayerRemoving, removePolicePlayer)
for _, member in ipairs(Players:GetPlayers()) do watchPolicePlayer(member) end
refreshPoliceCount()
connect(World.DescendantAdded, function(obj) if collectorKind(obj) then app.registry[obj]=true end end)
connect(World.DescendantRemoving, function(obj) app.registry[obj],app.cooldowns[obj]=nil,nil end)
task.spawn(function()
    for index,obj in ipairs(World:GetDescendants()) do
        if app.destroyed then return end
        if collectorKind(obj) and inWorld(obj) then app.registry[obj]=true end
        if index%200==0 then task.wait() end
    end
    app.indexed=true
    if not app.destroyed then chooseTarget() end
end)
task.spawn(function()
    while not app.destroyed do
        refreshPoliceCount()
        if app.indexed then chooseTarget() end
        task.wait(1)
    end
end)
return app
    end
end
do
    local generation = 0
    local pressedHumanoid
    local function update(message)
        o.antiAFKStatus = message
        if o.antiAFKStatusControl then o.antiAFKStatusControl:Set(message, true) end
    end
    local function release()
        local hum = pressedHumanoid
        pressedHumanoid = nil
        if hum then pcall(function() hum.Jump = false end) end
    end
    local function busy()
        return o.travelBusy or (o.travel and o.travel.owner) or o.collectionBusy
            or T.flyEnabled or T.ghostEnabled or T.autoColetaEnabled
            or T.farmPartesEnabled or T.autoFarmLixeiroEnabled
            or T.autoFarmPescaEnabled or o.robberyStarting
            or (o.robbery and (o.robbery.enabled or o.robbery.paused))
            or (o.isGhostActive and o.isGhostActive())
    end
    function o.setAntiAFK(value)
        local enabled = value == true and not o.destroyed
        if enabled and T.antiAFKEnabled then return end
        generation = generation + 1
        release()
        T.antiAFKEnabled = enabled
        if o.antiAFKControl then o.antiAFKControl:Set(enabled, true) end
        if not enabled then update("Desligado"); return end
        local token = generation
        local function current()
            return token == generation and T.antiAFKEnabled and not o.destroyed
        end
        local function pulse()
            if not current() then return end
            local delay = 5
            local ok = pcall(function()
                local hum, root = isCValid(), isRoot()
                if busy() then
                    update("Ativo: pulo adiado durante o farm/Ghost")
                elseif not hum or not root or hum.Health <= 0 or root.Anchored
                    or hum.Sit or hum.PlatformStand or hum.FloorMaterial == Enum.Material.Air
                    or not hum:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
                    update("Ativo: aguardando personagem no chao")
                elseif hum.Jump then
                    delay = 60
                    update("Ativo: personagem ja esta pulando")
                else
                    pressedHumanoid = hum
                    hum.Jump = true
                    delay = 60
                    update("Ativo: proximo pulo em 1 minuto")
                    task.delay(0.15, function()
                        if token == generation and pressedHumanoid == hum then release() end
                    end)
                end
            end)
            if not ok then update("Ativo: aguardando personagem disponivel") end
            if current() then task.delay(delay, pulse) end
        end
        update("Ativo: proximo pulo em 1 minuto")
        task.delay(60, pulse)
    end
    o.cleanupAntiAFK = function() o.setAntiAFK(false) end
end
do
    local switching = false
    local uiCache = {}
    local function toggle(control, value)
        if not control then return end
        if control:Get() ~= value then control:Set(value, true) end
    end
    local function label(field, value)
        local control = o[field]
        if control and uiCache[field] ~= value then
            uiCache[field] = value
            control:Set(value, true)
        end
    end
    function o.syncFarmControls()
        toggle(o.coletaControl, T.autoColetaEnabled)
        toggle(o.partesControl, T.farmPartesEnabled)
        toggle(o.lixeiroControl, T.autoFarmLixeiroEnabled)
        toggle(o.pescaControl, T.autoFarmPescaEnabled)
        toggle(o.ghostControl, T.ghostEnabled)
        toggle(o.flyControl, T.flyEnabled)
        label("garbageStatusControl", o.garbageFarmStatus or "Parado")
        label("fishingStatusControl", o.pescaStatus or "Parado")
        label("partsStatusControl", "Partes coletadas: "..tostring(o.farmPartesColetadas or 0))
    end
    function o.onRobberyUpdate(runtime)
        if o.destroyed then return end
        runtime = runtime or o.robbery
        if not runtime then return end
        T.autoRobberyEnabled = runtime.enabled or o.robberyStarting ~= nil
        toggle(o.robberyControl, T.autoRobberyEnabled)
        toggle(o.robberyGhostControl, runtime.ghostEnabled)
        toggle(o.robberyBelowControl, runtime.below)
        toggle(o.robberyHopControl, runtime.autoHop)
        toggle(o.robberyDeepControl, runtime.deepCasino)
        toggle(o.robberyReturnControl, runtime.returnOnStop)
        if o.robberyDepthControl and o.robberyDepthControl:Get() ~= runtime.depthLimit then
            o.robberyDepthControl:Set(runtime.depthLimit, true)
        end
        label("robberyStatusControl", runtime.status or "Desligado")
    end
    function o.stopRobbery(reason)
        o.robberyStartToken = (o.robberyStartToken or 0) + 1
        o.robberyStarting = nil
        T.autoRobberyEnabled = false
        if o.robbery then
            if o.robbery.enabled or o.robbery.paused then o.robbery.setEnabled(false, reason or "mode") end
            o.onRobberyUpdate(o.robbery)
        end
    end
    function o.claimFarm(mode)
        if o.destroyed then return false end
        if switching then return true end
        switching = true
        if mode ~= "robbery" then pcall(o.stopRobbery, "mode") end
        if mode ~= "items" and T.autoColetaEnabled and o.stopAutoColeta then pcall(o.stopAutoColeta) end
        if mode ~= "parts" and T.farmPartesEnabled and o.pararFarmPartes then pcall(o.pararFarmPartes) end
        if mode ~= "garbage" and T.autoFarmLixeiroEnabled and o.startLixeiro then pcall(o.startLixeiro, false) end
        if mode ~= "fishing" and T.autoFarmPescaEnabled and o.startPesca then pcall(o.startPesca, false) end
        if o.travel then o.travel.cancel() end
        T.flyEnabled, T.ghostEnabled = false, false
        if o.stopGhost then pcall(o.stopGhost) end
        switching = false
        o.syncFarmControls()
        return true
    end
    local function wrapStart(name, mode, noArgument)
        local original = o[name]
        if not original then return end
        o[name] = function(value, ...)
            if (noArgument or value == true) and not switching then
                if not o.claimFarm(mode) then return end
            end
            return original(value, ...)
        end
    end
    wrapStart("startAutoColeta", "items", true)
    wrapStart("startLixeiro", "garbage")
    wrapStart("startPesca", "fishing")
    local runParts, stopParts = o.iniciarFarmPartes, o.pararFarmPartes
    local partsToken = 0
    o.pararFarmPartes = function()
        partsToken = partsToken + 1
        if stopParts then stopParts() end
        toggle(o.partesControl, false)
    end
    function o.startPartes(value)
        if not value then o.pararFarmPartes(); return end
        if T.farmPartesEnabled or not o.claimFarm("parts") then return end
        partsToken = partsToken + 1
        local token = partsToken
        T.farmPartesEnabled = true
        toggle(o.partesControl, true)
        task.spawn(function()
            if token ~= partsToken or o.destroyed or not T.farmPartesEnabled then return end
            local ok, result = pcall(runParts)
            if token ~= partsToken or o.destroyed then return end
            T.farmPartesEnabled = false
            toggle(o.partesControl, false)
            if not ok then Xz("Farm Partes: "..tostring(result)) end
            o.syncFarmControls()
        end)
    end
    function o.startRobbery(value)
        if not o.robbery or o.destroyed then return end
        if not value then
            o.robberyStartToken = (o.robberyStartToken or 0) + 1
            o.robberyStarting = nil
            if o.robbery.enabled then o.robbery.setEnabled(false, "pause") end
            o.onRobberyUpdate(o.robbery)
            return
        end
        if o.robbery.enabled or o.robberyStarting then return end
        if not o.claimFarm("robbery") then return end
        o.robberyStartToken = (o.robberyStartToken or 0) + 1
        local token = o.robberyStartToken
        o.robberyStarting = token
        o.onRobberyUpdate(o.robbery)
        task.spawn(function()
            while o.travel and o.travel.owner and token == o.robberyStartToken and not o.destroyed do task.wait(0.05) end
            if token ~= o.robberyStartToken or o.destroyed then return end
            o.robbery.setEnabled(true, "resume")
            if o.robberyStarting == token then o.robberyStarting = nil end
            o.onRobberyUpdate(o.robbery)
        end)
    end
    function o.stopFarms()
        o.claimFarm("none")
        Xz("Todos os farms foram parados.")
    end
    local originalTeleport = o.teleportCharacter
    if originalTeleport then
        o.teleportCharacter = function(...)
            if o.robbery and (o.robbery.enabled or o.robbery.paused or o.robberyStarting) then o.stopRobbery("mode") end
            return originalTeleport(...)
        end
    end
    local originalGhost = o.startGhost
    o.startGhost = function(...)
        if o.robbery and (o.robbery.enabled or o.robbery.paused or o.robberyStarting) then o.stopRobbery("mode") end
        if o.isGhostActive and o.isGhostActive() then return end
        return originalGhost(...)
    end
    local elapsed = 0
    handleReady(RunService.Heartbeat:Connect(function(dt)
        if o.destroyed then return end
        elapsed = elapsed + dt
        if elapsed < 0.5 then return end
        elapsed = 0
        o.syncFarmControls()
        if o.config then o.config.sync() end
    end))
end
o.robbery = o.createRobberyController(o)
do
    local cfg = {entries = {}, byKey = {}, revision = 0, applying = false, booted = false}
    o.config = cfg
    local userId = tostring(LocalPlayer.UserId)
    local gameId = tostring(game.GameId ~= 0 and game.GameId or game.PlaceId)
    local folder = "InfernityHub"
    local path = folder .. "/menu_config_" .. userId .. "_" .. gameId .. ".json"
    local fs = {
        read = readfile or C.readfile, write = writefile or C.writefile,
        exists = isfile or C.isfile, isFolder = isfolder or C.isfolder,
        makeFolder = makefolder or C.makefolder,
    }
    local scales = {aimbotSmoothness = 100, autoColetaCooldown = 1000, boostFactor = 100}
    local farmKeys = {
        "autoRobberyEnabled", "autoColetaEnabled", "farmPartesEnabled",
        "autoFarmLixeiroEnabled", "autoFarmPescaEnabled",
    }
    local features = {
        spoofWalkEnabled=true, spoofJumpEnabled=true, noclipEnabled=true,
        flyEnabled=true, ghostEnabled=true, spinEnabled=true, fullbright=true, noLag=true,
        espEnabled=true, aimbotEnabled=true, armaTracer=true,
        coletaHudEnabled=true, perfectLockpick=true, camuflarNickEnabled=true,
        antiAFKEnabled=true, durabilidadeHudEnabled=true, autoCintoEnabled=true,
        noclipCarEnabled=true, vFlyEnabled=true, carEspEnabled=true,
    }
    local needsCharacter = {
        spoofWalkEnabled=true, spoofJumpEnabled=true, noclipEnabled=true,
        flyEnabled=true, ghostEnabled=true, spinEnabled=true, antiAFKEnabled=true,
        noclipCarEnabled=true, vFlyEnabled=true,
    }
    for _, key in ipairs(farmKeys) do features[key], needsCharacter[key] = true, true end
    local function status(message)
        cfg.status = message
        if o.configStatusControl then o.configStatusControl:Set(message, true) end
    end
    function cfg.cancelPendingLoad()
        cfg.revision = cfg.revision + 1
        if cfg.pending then
            cfg.pending = false
            status("Carregamento cancelado pela alteração manual. Salve quando terminar.")
        end
    end
    local function valueOf(entry)
        local suffix = entry.key:match("^robbery%.(.+)$")
        local value
        if suffix then value = o.robbery and o.robbery[suffix]
        else value = T[entry.key] end
        if type(value) == "number" then value = value * (scales[entry.key] or 1) end
        return value
    end
    local function valid(entry, value)
        if entry.kind == "Toggle" then
            if type(value) == "boolean" then return value end
        elseif entry.kind == "Slider" then
            if type(value) == "number" and value == value and math.abs(value) < math.huge then
                local number = math.clamp(value, entry.min, entry.max)
                local step = entry.step
                return math.clamp(math.round((number - entry.min) / step) * step + entry.min, entry.min, entry.max)
            end
        elseif entry.kind == "Dropdown" and type(value) == "string" then
            if table.find(entry.options, value) then return value end
        end
        return nil
    end
    function o.configControl(section, kind, key, spec)
        assert(not cfg.byKey[key], "Preferência duplicada: " .. key)
        local callback = spec.Callback
        spec.Callback = function(value, ...)
            if o.destroyed then return end
            if not cfg.applying then cfg.cancelPendingLoad() end
            return callback(value, ...)
        end
        local control = section[kind](section, spec)
        local entry = {
            key = key, kind = kind, control = control, callback = callback,
            default = spec.Default,
            min = spec.Min, max = spec.Max, step = spec.Step or 1, options = spec.Options,
        }
        if kind == "Toggle" then entry.default = false end
        cfg.entries[#cfg.entries + 1], cfg.byKey[key] = entry, entry
        return control
    end
    local function normalized(input)
        local values = {}
        for _, entry in ipairs(cfg.entries) do
            local value = valid(entry, input[entry.key])
            if value == nil then value = entry.default end
            values[entry.key] = value
        end
        local selected
        for _, key in ipairs(farmKeys) do
            if values[key] then
                if selected then values[key] = false else selected = key end
            end
        end
        if selected then values.flyEnabled, values.ghostEnabled = false, false end
        if values["robbery.ghostEnabled"] then values["robbery.below"] = true end
        return values
    end
    function cfg.sync()
        for _, entry in ipairs(cfg.entries) do
            local value = valid(entry, valueOf(entry))
            if value ~= nil and entry.control:Get() ~= value then entry.control:Set(value, true) end
        end
    end
    function cfg.collect()
        local values = {}
        for _, entry in ipairs(cfg.entries) do
            local value = valid(entry, valueOf(entry))
            if value == nil then value = entry.default end
            values[entry.key] = value
        end
        return normalized(values)
    end
    function cfg.apply(input)
        local values, failures = normalized(input), 0
        cfg.applying = true
        local function applyEntry(entry)
            local value = values[entry.key]
            entry.control:Set(value, true)
            local ok = pcall(entry.callback, value)
            if not ok then failures = failures + 1 end
        end
        for _, entry in ipairs(cfg.entries) do
            if entry.kind ~= "Toggle" then applyEntry(entry) end
        end
        for _, entry in ipairs(cfg.entries) do
            if entry.kind == "Toggle" and not features[entry.key] then applyEntry(entry) end
        end
        for _, entry in ipairs(cfg.entries) do
            if features[entry.key] and not table.find(farmKeys, entry.key) then applyEntry(entry) end
        end
        for _, key in ipairs(farmKeys) do
            if cfg.byKey[key] and not values[key] then applyEntry(cfg.byKey[key]) end
        end
        for _, key in ipairs(farmKeys) do
            if cfg.byKey[key] and values[key] then applyEntry(cfg.byKey[key]) end
        end
        cfg.applying = false
        cfg.sync()
        return failures == 0, failures
    end
    function cfg.resetValues()
        cfg.cancelPendingLoad()
        cfg.apply({})
        status("Tudo desligado. Clique em Salvar configuração para guardar este estado.")
    end
    local function decode(raw)
        if type(raw) ~= "string" or #raw > 65536 then return nil end
        local ok, data = pcall(HttpService.JSONDecode, HttpService, raw)
        if not ok or type(data) ~= "table" or data.version ~= 1
            or data.userId ~= userId or data.gameId ~= gameId or type(data.settings) ~= "table" then
            return nil
        end
        return normalized(data.settings)
    end
    local function readRaw(filename)
        if type(fs.read) ~= "function" then return nil, "unsupported" end
        if type(fs.exists) == "function" then
            local checked, exists = pcall(fs.exists, filename)
            if checked and not exists then return nil, "missing" end
        end
        local ok, raw = pcall(fs.read, filename)
        if not ok then return nil, "read" end
        return raw, nil
    end
    function cfg.save()
        if o.destroyed then return false end
        cfg.cancelPendingLoad()
        if type(fs.read) ~= "function" or type(fs.write) ~= "function" then
            status("Este executor não oferece leitura e gravação de configurações.")
            Xz(cfg.status)
            return false
        end
        local ok, raw = pcall(HttpService.JSONEncode, HttpService, {
            version = 1, userId = userId, gameId = gameId, settings = cfg.collect(),
        })
        if not ok then status("Não foi possível preparar a configuração."); Xz(cfg.status); return false end
        if type(fs.makeFolder) == "function" then
            local exists = false
            if type(fs.isFolder) == "function" then
                local checked, found = pcall(fs.isFolder, folder)
                exists = checked and found == true
            end
            if not exists then pcall(fs.makeFolder, folder) end
        end
        local previous = readRaw(path)
        if previous and decode(previous) then
            if not pcall(fs.write, path .. ".bak", previous) then
                status("Falha ao guardar a cópia anterior. Configuração preservada.")
                Xz(cfg.status)
                return false
            end
        else previous = nil end
        local written = pcall(fs.write, path, raw)
        local verified = written and readRaw(path)
        if not written or verified ~= raw then
            if previous then pcall(fs.write, path, previous) end
            status("Não foi possível confirmar a gravação. Tente salvar novamente.")
            Xz(cfg.status)
            return false
        end
        if not previous then pcall(fs.write, path .. ".bak", raw) end
        status("Configuração salva. Será carregada automaticamente nesta conta e neste jogo.")
        Xz("Configuração salva com sucesso.")
        return true
    end
    function cfg.boot()
        if cfg.booted or o.destroyed then return end
        cfg.booted = true
        local revision = cfg.revision
        local raw, reason = readRaw(path)
        local values = raw and decode(raw)
        local backup = false
        if not values and reason ~= "unsupported" then
            local old = readRaw(path .. ".bak")
            values = old and decode(old)
            backup = values ~= nil
        end
        if not values then
            if reason == "unsupported" then status("Tudo desligado. Leitura de configuração indisponível neste executor.")
            elseif raw then status("Configuração inválida. Tudo inicia desligado; salve uma nova configuração.")
            elseif reason == "read" then status("Não foi possível ler a configuração. Tudo inicia desligado.")
            else status("Nenhuma configuração salva. Tudo inicia desligado.") end
            return
        end
        local characterRequired = false
        for key in pairs(needsCharacter) do if values[key] then characterRequired = true; break end end
        if o.destroyed or cfg.revision ~= revision then return end
        cfg.pending = true
        if characterRequired then
            status("Configuração encontrada. Aguardando o personagem carregar...")
            while not o.destroyed and cfg.revision == revision do
                local humanoid, root = isCValid(), isRoot()
                if root and humanoid and humanoid.Health > 0 then break end
                task.wait(0.25)
            end
        end
        if o.destroyed or cfg.revision ~= revision then return end
        cfg.pending = false
        local ok = cfg.apply(values)
        if ok then
            status(backup and "Configuração recuperada da cópia anterior. Salve para confirmar."
                or "Configuração salva carregada.")
        else status("Preferências carregadas; uma função não iniciou. Confira os toggles antes de salvar.") end
    end
end
local W = InfernityUI:CreateWindow({Title="Infernity Hub",Theme="Crimson",Width=780,Height=510,Keybind=Enum.KeyCode.Insert,})
W.gui=W.Gui
W.Breadcrumb.RichText=true
W.Breadcrumb.Text='<font color="#E32636">I</font><font color="#FFFFFF">nfernity </font><font color="#E32636">H</font><font color="#FFFFFF">ub</font>'
W.Breadcrumb.Font=Enum.Font.GothamBold
W.Breadcrumb.TextSize=16
W.Breadcrumb.Position=UDim2.fromOffset(14,4)
W.Breadcrumb.Size=UDim2.new(1,-175,0,24)
W.Description.Text=""
W.root=W.Root
W.maid={Add=function(_,item) if typeof(item)=="RBXScriptConnection" then table.insert(W.Connections,item) end return item end}
W.Closed=Instance.new("BindableEvent")
local originalDestroy=W.Destroy
function W:Destroy(...) if not self.Destroyed then self.Closed:Fire() end; return originalDestroy(self,...) end
function W:SetVisible(v) self:Toggle(v) end
local originalTab=W.CreateTab
function W:CreateTab(opts)
    local tab=originalTab(self,{Title=opts.Name,Category=opts.Name,Icon=opts.Icon,Description="Infernity Hub"})
    function tab:SetColumns(n) self._columns=n end
    local originalSection=tab.CreateSection
    function tab:CreateSection(o)
        local section=originalSection(self,{Title=o.Name or "Geral",Side=(#self.Sections%2==0) and "Left" or "Right",FullWidth=self._columns==1})
        section.header=section.Header
        section.title=section.Header:FindFirstChildWhichIsA("TextLabel")
        section.body=section.Frame
        function section:SetCollapsed(v) self.Collapsed=v==true; self.Frame.Visible=not self.Collapsed end
        local function convert(o)
            local t={};for k,v in pairs(o or {}) do t[k]=v end
            t.Title=t.Name or t.Title
            return t
        end
        function section:Toggle(o) return self:AddToggle(convert(o)) end
        function section:Slider(o) return self:AddSlider(convert(o)) end
        function section:Button(o) return self:AddButton(convert(o)) end
        function section:Dropdown(o)
            local spec=convert(o)
            if not spec.Options or #spec.Options==0 then spec.Options={"Nenhum"} end
            if not table.find(spec.Options,spec.Default) then spec.Default=spec.Options[1] end
            local c=self:AddDropdown(spec)
            function c:SetOptions(values)
                if type(values)~="table" or #values==0 then return end
                self._available=values
            end
            local originalSet=c.Set
            function c:Set(v,silent)
                if v==nil then return self end
                if self._available and not table.find(self._available,v) then return self end
                return originalSet(self,v,silent)
            end
            return c
        end
        function section:Label(o)
            local c=self:AddLabel({Title=o.Name or o.Text or ""})
            function c:SetName(v) self:SetText(v) end
            return c
        end
        function section:Paragraph(o)
            local c=self:AddLabel({Title=(o.Name or "").."  "..(o.Text or "")})
            function c:SetDesc(v) self:SetText((o.Name or "").."  "..tostring(v)) end
            function c:SetName(v) self:SetText(tostring(v)) end
            return c
        end
        function section:Grid(o) return self end
        return section
    end
    function tab:Reflow() end
    return tab
end
local VTUI={Discord="https://discord.gg/infernityhub",Accent=Color3.fromRGB(220,35,52),SetReducedMotion=function() end}
local S={Notify=function(_,opts) W:Notify({Title=opts.Title or opts.Description or "Infernity Hub",Duration=opts.Duration}) end,Destroy=function() end,Cleanup=function() end}
o.mainPortal={Destroy=function() W:Destroy() end}
local tabPlayer = W:CreateTab({ Name = "PLAYER", Icon = "user" })
tabPlayer:SetColumns(2)
local secP = tabPlayer:CreateSection({ Name = "Movimento" })
o.configControl(secP, "Toggle", "spoofWalkEnabled", { Name = "WalkSpeed", Default = false, Callback = function(v) T.spoofWalkEnabled = v end })
o.configControl(secP, "Slider", "spoofWalkSpeed", { Name = "Velocidade", Min = 16, Max = 250, Default = 40, Callback = function(v) T.spoofWalkSpeed = v end })
o.configControl(secP, "Toggle", "spoofJumpEnabled", { Name = "JumpPower", Default = false, Callback = function(v) o.setJumpPower(v) end })
o.configControl(secP, "Slider", "spoofJumpPower", { Name = "Forca Jump", Min = 50, Max = 150, Default = 90, Callback = function(v) T.spoofJumpPower = v; o.updateJumpPower(isCValid()) end })
local secPM = tabPlayer:CreateSection({ Name = "Movimento Extra" })
o.configControl(secPM, "Toggle", "noclipEnabled", { Name = "Noclip", Default = false, Callback = function(v) T.noclipEnabled = v; pcall(Nz) end })
o.flyControl = o.configControl(secPM, "Toggle", "flyEnabled", { Name = "Fly", Default = false, Callback = function(v) if v then if o.stopRobbery then o.stopRobbery("mode") end end; T.flyEnabled = v end })
o.configControl(secPM, "Slider", "flySpeed", { Name = "Vel. Fly", Min = 16, Max = 100, Default = 60, Callback = function(v) T.flySpeed = math.clamp(v, 16, 100) end })
o.ghostControl = o.configControl(secPM, "Toggle", "ghostEnabled", { Name = "Ghost Mode", Default = false, Callback = function(v) T.ghostEnabled = v; if v then pcall(o.startGhost) else pcall(o.stopGhost) end end })
o.spinControl = o.configControl(secPM, "Toggle", "spinEnabled", {Name="Spin Player", Default=false,
    Callback=function(value) o.setSpinPlayer(value) end})
o.spinSpeedControl = o.configControl(secPM, "Slider", "spinSpeed", {Name="Vel. do giro", Min=45, Max=3600, Default=720, Suffix="°/s",
    Callback=function(value) o.setSpinSpeed(value) end})
o.spinSpeedControl:SetVisible(false)
local secPW = tabPlayer:CreateSection({ Name = "Mundo" })
o.configControl(secPW, "Toggle", "fullbright", { Name = "Fullbright", Default = false, Callback = function(v) o.setFullbright(v) end })
o.configControl(secPW, "Toggle", "noLag", { Name = "No Lag", Default = false, Callback = function(v) o.setNoLag(v) end })
local tabESP = W:CreateTab({ Name = "ESP", Icon = "eye" })
tabESP:SetColumns(2)
local secE = tabESP:CreateSection({ Name = "ESP" })
o.configControl(secE, "Toggle", "espEnabled", { Name = "Ativar ESP", Default = false, Callback = function(v) T.espEnabled = v; if not v then pcall(PF_all) end end })
o.configControl(secE, "Slider", "maxDistance", { Name = "Distancia Max", Min = 100, Max = 5000, Default = 1500, Callback = function(v) T.maxDistance = v end })
local secEV = tabESP:CreateSection({ Name = "Visual" })
o.configControl(secEV, "Toggle", "box", { Name = "Caixa 2D", Default = false, Callback = function(v) T.box = v end })
o.configControl(secEV, "Toggle", "box3d", { Name = "Caixa 3D", Default = false, Callback = function(v) T.box3d = v end })
o.configControl(secEV, "Toggle", "name", { Name = "Nome", Default = false, Callback = function(v) T.name = v end })
o.configControl(secEV, "Toggle", "distance", { Name = "Distancia", Default = false, Callback = function(v) T.distance = v end })
o.configControl(secEV, "Toggle", "heldItem", { Name = "Item na mao", Default = false, Callback = function(v) T.heldItem = v end })
o.configControl(secEV, "Toggle", "skeleton", { Name = "Esqueleto", Default = false, Callback = function(v) T.skeleton = v end })
o.configControl(secEV, "Toggle", "highlight", { Name = "Highlight", Default = false, Callback = function(v) T.highlight = v end })
o.configControl(secEV, "Toggle", "tracer", { Name = "Tracer", Default = false, Callback = function(v) o.setESPTracer(v) end })
o.configControl(secEV, "Toggle", "arrow", { Name = "Seta fora da tela", Default = false, Callback = function(v) T.arrow = v end })
o.configControl(secEV, "Toggle", "teamTag", { Name = "Times", Default = false, Callback = function(v) T.teamTag = v end })
local tabAim = W:CreateTab({ Name = "AIMBOT", Icon = "crosshair" })
tabAim:SetColumns(2)
local secA = tabAim:CreateSection({ Name = "Aimbot" })
o.configControl(secA, "Toggle", "aimbotEnabled", { Name = "Ativar Aimbot", Default = false, Callback = function(v) T.aimbotEnabled = v; if v then pcall(aimbotLoop) else pcall(stopAimbot) end end })
o.configControl(secA, "Dropdown", "aimbotMode", { Name = "Modo", Options = { "Legit", "Rage" }, Default = "Legit", Callback = function(v) T.aimbotMode = v end })
o.configControl(secA, "Slider", "aimbotFov", { Name = "FOV", Min = 10, Max = 600, Default = 120, Callback = function(v) T.aimbotFov = v end })
o.configControl(secA, "Slider", "aimbotDistance", { Name = "Distancia", Min = 50, Max = 1000, Default = 500, Callback = function(v) T.aimbotDistance = v end })
o.configControl(secA, "Slider", "aimbotSmoothness", { Name = "Suavidade", Min = 1, Max = 100, Default = 15, Callback = function(v) T.aimbotSmoothness = v / 100 end })
o.configControl(secA, "Dropdown", "aimbotBodyPart", { Name = "Parte corpo", Options = { "Cabeca", "Tronco" }, Default = "Cabeca", Callback = function(v) T.aimbotBodyPart = v end })
local secAF = tabAim:CreateSection({ Name = "Filtros" })
o.configControl(secAF, "Toggle", "aimbotWallCheck", { Name = "Wall Check", Default=false, Callback = function(v) T.aimbotWallCheck = v end })
o.configControl(secAF, "Toggle", "friendCheck", { Name = "Friend Check", Default=false, Callback = function(v) T.friendCheck = v end })
o.configControl(secAF, "Toggle", "adminCheck", { Name = "Staff Check", Default=false, Callback = function(v) T.adminCheck = v end })
local tabWpn = W:CreateTab({ Name = "WEAPONS", Icon = "zap" })
tabWpn:SetColumns(2)
local secWT = tabWpn:CreateSection({ Name = "Tracer" })
o.configControl(secWT, "Toggle", "armaTracer", { Name = "Tracer Neon", Default = false, Callback = function(v) T.armaTracer = v end })
o.configControl(secWT, "Dropdown", "armaTracerCor", { Name = "Cor", Options = { "Ciano", "Verde", "Rosa", "Roxo", "Vermelho", "Azul", "Laranja", "Branco", "Amarelo", "Arco-iris" }, Default = "Ciano", Callback = function(v) T.armaTracerCor = v end })
do
    local tabFarm = W:CreateTab({Name="FARM", Icon="sprout"})
    tabFarm:SetColumns(2)
    local function fold(name, column)
        local section = tabFarm:CreateSection({Name=name, Column=column, Collapsible=true})
        local arrow = Instance.new("TextLabel")
        arrow.Name = "CollapseHint"
        arrow.AnchorPoint = Vector2.new(1, 0.5)
        arrow.Position = UDim2.new(1, -2, 0.5, 1)
        arrow.Size = UDim2.fromOffset(18, 18)
        arrow.BackgroundTransparency = 1
        arrow.Text = "›"
        arrow.TextSize = 19
        arrow.FontFace = section.title.FontFace
        arrow.TextColor3 = Color3.fromRGB(163, 154, 185)
        arrow.ZIndex = 3
        arrow.Parent = section.header
        local setCollapsed = section.SetCollapsed
        function section:SetCollapsed(value)
            setCollapsed(self, value)
            arrow.Rotation = self.Collapsed and 0 or 90
            return self
        end
        section:SetCollapsed(true)
        return section
    end
    local main = tabFarm:CreateSection({Name="Automação", Column=1})
    o.robberyControl = o.configControl(main, "Toggle", "autoRobberyEnabled", {Name="Auto Roubo", Default=false,
        Callback=function(value) o.startRobbery(value) end})
    o.coletaControl = o.configControl(main, "Toggle", "autoColetaEnabled", {Name="Auto Coleta", Default=false, Callback=function(value)
        if value then pcall(o.startAutoColeta) else pcall(o.stopAutoColeta) end
    end})
    o.partesControl = o.configControl(main, "Toggle", "farmPartesEnabled", {Name="Farm Partes", Default=false,
        Callback=function(value) o.startPartes(value) end})
    o.lixeiroControl = o.configControl(main, "Toggle", "autoFarmLixeiroEnabled", {Name="Farm Lixeiro", Default=false,
        Callback=function(value) if o.startLixeiro then o.startLixeiro(value) end end})
    o.pescaControl = o.configControl(main, "Toggle", "autoFarmPescaEnabled", {Name="Farm Pesca", Default=false,
        Callback=function(value) if o.startPesca then o.startPesca(value) end end})
    main:Button({Name="Parar todos os farms", Icon="square", Callback=function() o.stopFarms() end})
    local robbery = fold("Auto Roubo · ajustes", 2)
    o.robberyGhostControl = o.configControl(robbery, "Toggle", "robbery.ghostEnabled", {Name="Ghost original", Default=false,
        Callback=function(value) o.robbery.setOption("ghostEnabled", value) end})
    o.robberyBelowControl = o.configControl(robbery, "Toggle", "robbery.below", {Name="Coletar por baixo", Default=false,
        Callback=function(value) o.robbery.setOption("below", value) end})
    o.robberyHopControl = o.configControl(robbery, "Toggle", "robbery.autoHop", {Name="Trocar de servidor", Default=false,
        Callback=function(value) o.robbery.setOption("autoHop", value) end})
    o.robberyDeepControl = o.configControl(robbery, "Toggle", "robbery.deepCasino", {Name="Cassino profundo", Default=false,
        Callback=function(value) o.robbery.setOption("deepCasino", value) end})
    o.robberyDepthControl = o.configControl(robbery, "Slider", "robbery.depthLimit", {Name="Profundidade cassino", Min=1, Max=120, Default=60, Suffix=" studs",
        Callback=function(value) o.robbery.setDepth(value) end})
    o.robberyReturnControl = o.configControl(robbery, "Toggle", "robbery.returnOnStop", {Name="Retornar ao encerrar", Default=false,
        Callback=function(value) o.robbery.setOption("returnOnStop", value) end})
    robbery:Button({Name="Encerrar coleta", Icon="square", Callback=function() o.stopRobbery("stop") end})
    local collection = fold("Coleta · ajustes", 2)
    o.retornoControl = o.configControl(collection, "Toggle", "returnOnWeaponPickup", {Name="Retornar após coletar", Default=false,
        Callback=function(value) T.returnOnWeaponPickup = value end})
    o.configControl(collection, "Toggle", "pullWeaponsEnabled", {Name="Puxar armas", Default=false,
        Callback=function(value) T.pullWeaponsEnabled = value end})
    o.configControl(collection, "Toggle", "coletaHudEnabled", {Name="HUD de itens", Default=false, Callback=function(value)
        T.coletaHudEnabled = value
        if o.setColetaHudVisible then o.setColetaHudVisible(value) end
    end})
    o.configControl(collection, "Slider", "autoColetaCooldown", {Name="Intervalo de busca", Min=100, Max=2000, Default=350, Suffix=" ms",
        Callback=function(value) T.autoColetaCooldown = value / 1000 end})
    collection:Button({Name="Puxar arma próxima", Icon="magnet", Callback=function()
        task.spawn(function()
            local drops = o.listDrops()
            if not drops[1] then Xz("Nenhuma arma dropada carregada."); return end
            local ok, success, message = pcall(o.coletarItem, drops[1], nil, true)
            if not ok or not success then Xz(ok and message or tostring(success)) end
        end)
    end})
    local garbage = fold("Lixeiro · ajustes", 2)
    o.configControl(garbage, "Slider", "autoFarmLixeiroQuantidade", {Name="Lixos por entrega", Min=1, Max=20, Default=20,
        Callback=function(value) T.autoFarmLixeiroQuantidade = value end})
    garbage:Button({Name="Ir ao lixeiro", Icon="map-pin", Callback=function()
        o.claimFarm("manual")
        task.spawn(function()
            local ok, success, reason = pcall(o.teleportLixeiro)
            if not ok or not success then Xz(ok and (reason or "TP recusado") or tostring(success)) end
        end)
    end})
    local progress = fold("Progresso dos farms", 2)
    o.robberyStatusControl = progress:Paragraph({Name="Auto Roubo", Text="Desligado"})
    o.coletaStatusLabel = progress:Paragraph({Name="Coleta", Text="Aguardando coleta"})
    o.partsStatusControl = progress:Paragraph({Name="Partes", Text="Partes coletadas: 0"})
    o.garbageStatusControl = progress:Paragraph({Name="Lixeiro", Text="Parado"})
    o.fishingStatusControl = progress:Paragraph({Name="Pesca", Text="Parado"})
    o.onRobberyUpdate(o.robbery)
    o.syncFarmControls()
end
local tabMisc = W:CreateTab({ Name = "MISC", Icon = "settings" })
tabMisc:SetColumns(2)
local secME = tabMisc:CreateSection({ Name = "Extras" })
o.configControl(secME, "Toggle", "perfectLockpick", { Name = "Auto Lockpick Completo", Default = false, Callback = function(v) o.setPerfectLockpick(v) end })
o.configControl(secME, "Toggle", "camuflarNickEnabled", { Name = "Camuflar Nick", Default = false, Callback = function(v) if o.setCamuflarNick then o.setCamuflarNick(v) end end })
o.antiAFKControl = o.configControl(secME, "Toggle", "antiAFKEnabled", {Name="Anti-AFK", Default=false,
    Callback=function(value) o.setAntiAFK(value) end})
local secMA = tabMisc:CreateSection({ Name = "Acoes" })
secMA:Button({ Name = "Curar", Callback = function() o.useConsumable("health") end })
secMA:Button({ Name = "Encher Sede", Callback = function() o.useConsumable("thirst") end })
secMA:Button({ Name = "Encher Fome", Callback = function() o.useConsumable("hunger") end })
local tabCar = W:CreateTab({ Name = "VEICULO", Icon = "car" })
tabCar:SetColumns(2)
local secC = tabCar:CreateSection({ Name = "Veiculo" })
o.configControl(secC, "Toggle", "durabilidadeHudEnabled", { Name = "Durabilidade HUD", Default = false, Callback = function(v)
    T.durabilidadeHudEnabled = v
    if v then pcall(o.ativarDurabilidade) else pcall(o.desativarDurabilidade) end
end })
o.configControl(secC, "Toggle", "autoCintoEnabled", { Name = "Cinto Auto", Default = false, Callback = function(v) T.autoCintoEnabled = v end })
local secCM = tabCar:CreateSection({ Name = "Movimento" })
o.configControl(secCM, "Toggle", "noclipCarEnabled", { Name = "Noclip Car", Default = false, Callback = function(v)
    T.noclipCarEnabled = v
    if o.aplicarNoclipCar then pcall(o.aplicarNoclipCar) end
end })
o.configControl(secCM, "Toggle", "vFlyEnabled", { Name = "VFly", Default = false, Callback = function(v)
    T.vFlyEnabled = v
    if o.aplicarNoclipCar then pcall(o.aplicarNoclipCar) end
end })
o.configControl(secCM, "Slider", "vFlyHorizontalSpeed", { Name = "VFly Horiz", Min = 20, Max = 500, Default = 60, Callback = function(v) T.vFlyHorizontalSpeed = v end })
o.configControl(secCM, "Slider", "vFlyVerticalSpeed", { Name = "VFly Vert", Min = 10, Max = 300, Default = 30, Callback = function(v) T.vFlyVerticalSpeed = v end })
o.configControl(secCM, "Slider", "boostFactor", { Name = "Boost %", Min = 100, Max = 500, Default = 100, Callback = function(v)
    T.boostFactor = v / 100
    local hum = isCValid()
    if hum then pcall(hz, hum) end
end })
do
    local tabGar = W:CreateTab({ Name = "GARAGEM", Icon = "car-front" })
    tabGar:SetColumns(2)
    local G = o.garage
    local list = tabGar:CreateSection({ Name = "Selecionar Veiculo" })
    G.dropdown = list:Dropdown({ Name = "Carro", Options = {}, Search = true, Placeholder = "Selecione",
        Callback = function(label) G.select(G.byLabel[label]) end })
    G.status = list:Label({ Name = "Somente carros vazios e parados" })
    list:Button({ Name = "Atualizar Lista", Callback = function() G.refresh(); Xz(#G.records .. " carro(s) vazio(s) e parado(s).") end })
    list:Button({ Name = "Mais Proximo Vazio/Parado", Callback = function() G.refresh(); G.nearest() end })
    local visuals = tabGar:CreateSection({ Name = "ESP Car" })
    o.configControl(visuals, "Toggle", "carEspEnabled", { Name = "ESP dos Carros", Default = false, Callback = function(v) G.setESP(v) end })
    o.configControl(visuals, "Slider", "carEspDistance", { Name = "Distancia ESP Car", Min = 100, Max = 5000, Default = 1500,
        Callback = function(v) T.carEspDistance = v end })
    local actions = tabGar:CreateSection({ Name = "Interagir com o Selecionado" })
    actions:Button({ Name = "TP ate o Carro", Callback = function() G.run(G.teleport) end })
    actions:Button({ Name = "Entrar no Carro", Callback = function() G.run(G.enter) end })
    actions:Button({ Name = "Puxar Carro ate Mim", Callback = function() G.run(G.pull) end })
    actions:Button({ Name = "Desvirar Carro", Callback = function() G.run(G.unflip) end })
    actions:Button({ Name = "Frear Carro", Callback = function() G.run(G.stop) end })
    actions:Button({ Name = "Sair do Carro", Callback = function() G.run(G.exit) end })
    local current = tabGar:CreateSection({ Name = "Carro Atual" })
    current:Button({ Name = "Reparar Carro", Callback = function()
        local car = rz()
        if not car then Xz("Voce nao esta em um carro."); return end
        local vida = o.vidaDoCarro and o.vidaDoCarro(car)
        if vida and (vida:IsA("NumberValue") or vida:IsA("IntValue")) then
            vida.Value = math.max(vida.Value, 1500)
            Xz("Vida do carro atualizada.")
        else Xz("Vida do carro nao encontrada.") end
    end })
    G.refresh()
end
local tabCfg = W:CreateTab({ Name = "CONFIG", Icon = "wrench" })
tabCfg:SetColumns(2)
local secCfgSave = tabCfg:CreateSection({Name="Preferências"})
secCfgSave:Paragraph({Name="Seu menu, do seu jeito", Text="Sem configuração salva, tudo inicia desligado. Salve para lembrar as funções e os ajustes desta conta."})
secCfgSave:Button({Name="Salvar configuração", Icon="save", Callback=function() o.config.save() end})
o.configStatusControl = secCfgSave:Paragraph({Name="Configuração", Text="Verificando preferências salvas..."})
local secCfgS = tabCfg:CreateSection({ Name = "Atalhos" })
secCfgS:Paragraph({Name="Comandos do menu",Text="INSERT: abrir e fechar o menu\nF: Fly | N: Noclip"})
local secCfgA = tabCfg:CreateSection({ Name = "Acoes" })
secCfgA:Button({ Name = "Resetar Menu", Callback = function()
    if o.setSpinPlayer then o.setSpinPlayer(false) end
    if o.stopRobbery then o.stopRobbery("mode") end
    if o.robbery then o.robbery.resetSettings() end
    if o.setAntiAFK then o.setAntiAFK(false) end
    for k, v in pairs(T) do
        if type(v) == "boolean" then T[k] = false end
    end
    if o.travel then o.travel.cancel() end
    if o.cancelQuickActions then o.cancelQuickActions() end
    if o.noclip then o.noclip.restore() end
    if o.retornoControl then o.retornoControl:Set(false, true) end
    T.spinSpeed = 720
    if o.spinSpeedControl then o.spinSpeedControl:Set(720, true) end
    T.spoofWalkSpeed = 40
    T.spoofJumpPower = 90
    T.flySpeed = 60
    T.maxDistance = P
    T.aimbotFov = 120
    T.aimbotDistance = 500
    T.aimbotSmoothness = 0.15
    T.vFlyHorizontalSpeed = 60
    T.vFlyVerticalSpeed = 30
    T.autoColetaCooldown = 0.35
    T.autoFarmLixeiroQuantidade = 20
    T.boostFactor = 1
    T.carEspDistance = 1500
    if o.restoreJumpPower then pcall(o.restoreJumpPower) end
    if o.restoreGraphics then pcall(o.restoreGraphics) end
    if o.setPerfectLockpick then pcall(o.setPerfectLockpick, false) end
    if o.garage then pcall(o.garage.cancel); pcall(o.garage.setESP, false) end
    if o.stopAutoColeta then pcall(o.stopAutoColeta) end
    if o.pararFarmPartes then pcall(o.pararFarmPartes) end
    if o.startLixeiro then pcall(o.startLixeiro, false) end
    if o.startPesca then pcall(o.startPesca, false) end
    if o.stopGhost then pcall(o.stopGhost) end
    if o.setCamuflarNick then pcall(o.setCamuflarNick, false) end
    if o.restaurarNoclipCar then pcall(o.restaurarNoclipCar) end
    if o.setColetaHudVisible then pcall(o.setColetaHudVisible, false) end
    if o.stopAimbot then pcall(stopAimbot) end
    if PF_all then pcall(PF_all) end
    pcall(Nz)
    o.config.resetValues()
    Xz("Menu resetado; configuração salva mantida até você salvar novamente.")
end })
secCfgA:Button({ Name = "Rejoin (Mesmo servidor)", Callback = function()
    Xz("Rejoinando...")
    task.spawn(function()
        pcall(function()
            if #Players:GetPlayers() <= 1 or game.JobId == "" then
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            else
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            end
        end)
    end)
end })
secCfgA:Button({ Name = "Server Hop", Callback = function()
    Xz("Procurando servidor...")
    task.spawn(function()
        local ok, body = pcall(function()
            return game:HttpGet(string.format(
                "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true",
                game.PlaceId))
        end)
        if not ok or type(body) ~= "string" then Xz("Falha ao buscar servidores"); return end
        local dec, data = pcall(function() return HttpService:JSONDecode(body) end)
        if not dec or not data or not data.data then Xz("Lista invalida"); return end
        local candidatos = {}
        for _, s in ipairs(data.data) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then
                table.insert(candidatos, s)
            end
        end
        if #candidatos == 0 then Xz("Sem servidores abertos"); return end
        local alvo = candidatos[math.random(1, #candidatos)]
        pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, alvo.id, LocalPlayer)
        end)
    end)
end })
secCfgA:Button({ Name = "Fechar Menu", Callback = function()
    pcall(function() W:SetVisible(false) end)
    Xz("INSERT para reabrir")
end })
local secCfgVisual = tabCfg:CreateSection({ Name = "Aparência e Sistema" })
o.configControl(secCfgVisual, "Toggle", "reducedMotion", { Name = "Animação reduzida", Default = false,
    Callback = function(value) T.reducedMotion = value; VTUI.SetReducedMotion(value) end })
secCfgVisual:Button({ Name = "Copiar Link do Discord", Icon = "link", Callback = function()
    local clipboard = setclipboard or toclipboard or (syn and syn.setclipboard)
    if clipboard and pcall(clipboard, VTUI.Discord) then Xz("Link do Discord copiado.")
    else Xz(VTUI.Discord) end
end })
secCfgVisual:Button({ Name = "Destruir Menu", Icon = "trash-2", Callback = function() o.mainPortal:Destroy() end })
do
    local about=W:CreateTab({Name="SOBRE",Icon="info"})
    about:SetColumns(1)
    local credits=about:CreateSection({Name="Infernity Hub"})
    credits:Paragraph({Name="Proprietários",Text="souzadevz e makiro6283"})
    credits:Paragraph({Name="Discord",Text="https://discord.gg/infernityhub"})
    credits:Button({Name="Copiar Discord",Callback=function()
        if setclipboard then pcall(setclipboard,"https://discord.gg/infernityhub") end
    end})
end
do
    local Watermark = Instance.new("TextLabel")
    Watermark.Name = "InfernityStatus"
    Watermark.Parent = W.gui
    Watermark.Size = UDim2.new(1, -24, 0, 32)
    Watermark.AnchorPoint = Vector2.new(0.5, 1)
    Watermark.Position = UDim2.new(0.5, 0, 1, -18)
    local watermarkLimit = Instance.new("UISizeConstraint")
    watermarkLimit.MaxSize = Vector2.new(330, 32)
    watermarkLimit.Parent = Watermark
    Watermark.BackgroundColor3 = Color3.fromRGB(17, 17, 19)
    Watermark.BackgroundTransparency = 0.12
    Watermark.BorderSizePixel = 0
    Watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
    Watermark.Font = Enum.Font.GothamMedium
    Watermark.TextSize = 11
    Watermark.Text = "INFERNITY HUB  •  INSERT para abrir"
    Instance.new("UICorner", Watermark).CornerRadius = UDim.new(0, 10)
    local border = Instance.new("UIStroke")
    border.Color, border.Transparency, border.Parent = VTUI.Accent, 0.7, Watermark
    local elapsed, frames = 0, 0
    W.maid:Add(RunService.RenderStepped:Connect(function(dt)
        if W.Destroyed then return end
        frames, elapsed = frames + 1, elapsed + dt
        if elapsed < 1 then return end
        Watermark.Text = string.format("INFERNITY HUB  •  %d FPS  •  INSERT para abrir", math.floor(frames / elapsed + 0.5))
        elapsed, frames = 0, 0
    end))
end
handleReady(UserInputService.InputBegan:Connect(function(input, gp)
    if gp or o.destroyed then return end
    if input.KeyCode == T.flyKeybind then
        o.config.cancelPendingLoad()
        if not T.flyEnabled and o.stopRobbery then o.stopRobbery("mode") end
        T.flyEnabled = not T.flyEnabled
        Xz(T.flyEnabled and "Fly ON" or "Fly OFF")
    elseif input.KeyCode == T.noclipKeybind then
        o.config.cancelPendingLoad()
        T.noclipEnabled = not T.noclipEnabled
        pcall(Nz)
        Xz(T.noclipEnabled and "Noclip ON" or "Noclip OFF")
    end
end))
C.__INFERNITY_HUB_WINDOW = W
C.__INFERNITY_HUB_BUILD = "menu-v9"
C.__INFERNITY_HUB_CLEANUP = function()
    o.destroyed = true
    o.robberyStartToken = (o.robberyStartToken or 0) + 1
    o.robberyStarting = nil
    if o.cleanupAntiAFK then pcall(o.cleanupAntiAFK) end
    if o.cleanupSpinPlayer then pcall(o.cleanupSpinPlayer) end
    if o.cleanupESPTracer then pcall(o.cleanupESPTracer) end
    if o.robbery then pcall(o.robbery.cleanup) end
    if o.acRuntime then o.acRuntime.destroyed = true end
    if o.travel then o.travel.cancel() end
    if o.cancelQuickActions then o.cancelQuickActions() end
    if o.noclip then o.noclip.restore() end
    if o.restoreJumpPower then pcall(o.restoreJumpPower) end
    if o.restoreGraphics then pcall(o.restoreGraphics) end
    if o.setPerfectLockpick then pcall(o.setPerfectLockpick, false) end
    if o.garage then pcall(o.garage.cleanup) end
    C.__INFERNITY_HUB_RUNTIME = nil
    T.autoColetaEnabled = false
    if o.cleanupCollection then pcall(o.cleanupCollection) end
    if o.pararFarmPartes then pcall(o.pararFarmPartes) end
    if o.startLixeiro then pcall(o.startLixeiro, false) end
    if o.startPesca then pcall(o.startPesca, false) end
    if o.stopGhost then pcall(o.stopGhost) end
    if o.setCamuflarNick then pcall(o.setCamuflarNick, false) end
    if o.restaurarNoclipCar then pcall(o.restaurarNoclipCar) end
    if o.stopAimbot then pcall(stopAimbot) end
    if PF_all then pcall(PF_all) end
    if o.coletaHudGui then pcall(function() o.coletaHudGui:Destroy() end) end
    if o.destruirDurabilidade then pcall(o.destruirDurabilidade) end
    for _, conn in ipairs(o.connections) do
        pcall(function() conn:Disconnect() end)
    end
    o.connections = {}
    for plr in pairs(T.bundles) do
        pcall(qF, T.bundles[plr])
        T.bundles[plr] = nil
    end
    pcall(function() W:Destroy() end)
    pcall(function() S:Destroy() end)
    C.__INFERNITY_HUB_WINDOW = nil
    C.__INFERNITY_HUB_CLEANUP = nil
    print("[INFERNITY HUB] Unloaded")
end
W.maid:Add(W.Closed.Event:Connect(function()
    if o.destroyed then return end
    task.defer(function()
        if not o.destroyed and C.__INFERNITY_HUB_WINDOW == W and C.__INFERNITY_HUB_CLEANUP then
            C.__INFERNITY_HUB_CLEANUP()
        end
    end)
end))
S:Notify({Title = "Bem-vindo", Description = "INFERNITY HUB carregado com sucesso.", Icon = "crown", Tone = "Success", Duration = 5})
print("[INFERNITY HUB] Carregado - FARM / ANTI-AFK / ABOUT")
print("[INFERNITY HUB] INSERT = menu | F = fly | N = noclip")
task.defer(function() if not o.destroyed then o.config.boot() end end)
