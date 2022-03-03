AetheryteTicketer = {}

local kinokoProject = {
  Addon  = {
      Folder =        "AetheryteTicketer",
      Name =          "Aetheryte Ticketer",
      Version =         "1.0(eod)",
      WARNING_J = { "minion標準のテレポの代わりにAetheryte Ticketerが有効になっています。",
                  "---------------------------------------------------------",
                  "[説明]",
                  "Aetheryte Ticketerはテレポのユーザー操作を再現します。",
                  "これにより転送網利用券を消費してテレポが可能になります。",
                  "---------------------------------------------------------",
                  "[使用方法]",
                  "このmoduleにオンオフの機能はありません。",
                  "テレポのウィンドウが開いているときはカーソルを動かさないようにしてください。",
                  "ログウィンドウに白い手のアイコンが表示されている状態が理想です。",
                  "一番最初は失敗することが多いですが、以降は安定します。",
                  "困ったらテレポウィンドウ閉じて下さい。moduleが初期化されます。",
                  "---------------------------------------------------------",
                  "[動作確認済みアドオン]",
                  "Madaoシリーズ(Fate,Gather)",
                  "minionデフォルトのGrind",
                  "Fishing Guide",
                  "Latty Questシリーズ",
                  "AH（一部機能は利用不可）",
                  "anon Leve Delivery",
                  "",
                  "[正常に動作しないアドオン]",
                  "Husband",
                  "Sebbs Gathering",
                  "Bottox",
                  "",
                  "ここに記載のないアドオンは未確認です",
                  "---------------------------------------------------------",
                  "[注意事項]",
                  "minionがサポートしていないため、選択項目の情報を取得できません。",
                  "そのため成功率は100％ではありません。",
                  "上記のため、ある程度の誤動作はご了承ください。",
                  "minion実装の可能性を考慮して、とくにアップデートの予定はありません",                  
                  "各拡張ごとのエーテライトは全て開放済みである必要があります",
                  "不要な場合は、フォルダごと削除するかprofilerでオフにしてください。",
                  "ハウジングエリアへのテレポはサポートしていません。",
                  "残念ながらAHのワンクリックテレポは正常に動作しません。",
                  "ただし、GCへの移動とMBモードでのテレポは動作します。",

      },
      WARNING_E = { "Aetheryte Ticketer is currently enabled.",
                  "---------------------------------------------------------",
                  "[Description]",
                  "Aetheryte Ticketer reproduces user operation in game of a teleport.",
                  "This allows teleport by consuming a Aetheryte ticket.",
                  "---------------------------------------------------------",
                  "[usage rules]",
                  "There is no on/off function for this module.",
                  "Do not move the cursor when the teleport window is open.",
                  "Ideally, a white hand icon should appear in the log window.",
                  "It often fails at the very beginning, but stabilizes thereafter.",
                  "If you have trouble,",
                  "close the teleport window; the module will be initialized.",
                  "---------------------------------------------------------",
                  "[Addons that have been tested]",
                  "Madao(Fate,Gather)",
                  "minion Grind",
                  "Fishing Guide",
                  "Latty Quest",
                  "AH（Some functions are not available）",
                  "anon Leve Delivery",
                  "",
                  "[Addons that do not work properly]",
                  "Husband",
                  "Sebbs Gathering",
                  "Bottox",
                  "",
                  "Addons not listed here have not been tested",
                  "---------------------------------------------------------",
                  "[precautions]",
                  "module cannot retrieve information on the selections",
                  "because minion does not support them.",
                  "Therefore, the success rate is not 100%.",
                  "This should originally be implemented by MINION.",
                  "Please allow for a certain degree of malfunction.",
                  "All aetherytes for each expansion to FFXIV must be open",
                  "If you do not need it,",
                  "delete the entire folder or turn it off in the profiler.",
                  "Teleport to housing areas is not supported.",
                  "Unfortunately, AH's one-click teleport does not work properly.",
                  "However, the transfer to GC and teleportation in MB mode will work.",
                                    
      },
      
  },
--  ---------------
  Menu = {
    Main = {
      Name =          "kinoko",
      Icon =          "love_mushroom.png",
      Id =            "kinoko",
      Tab =           ffxiv_kinoko_Menu,
    },
    Sub = {
      Name =          "AT",
      Icon =          "NR.png",
      Id =            "AetheryteTicketer",
      Tooltip =       "Open AetheryteTicketer",
    },
  },
--  ---------------
  Minion = {
      Folder =        "LuaMods",
  },
--  ---------------
  Windows = {
    MainWindows = {
      Name =          "AetheryteTicketer Main Windows",
      Open =          true,
      Option =        GUI.WindowFlags_ShowBorders 
                    + GUI.WindowFlags_AlwaysAutoResize
                    + GUI.WindowFlags_NoScrollbar,
      Visible =         false,
    },
  },
--  ---------------
  Update = {
      Pulse =         500,
      Timer =         0,
  },

}
  
-------------------
local gRegion = GetGameRegion()
local gstate = MGetGameState()
local language = GetGameLanguage()
---------------------------------------------------------------------------------------------------------------------------------------------------
-- Fonction Menu MMOMinion 
function AetheryteTicketer.Init()
  local Addon =     kinokoProject.Addon
  local Main =    kinokoProject.Menu.Main
  local Minion =    kinokoProject.Minion
  local Sub =     kinokoProject.Menu.Sub
  local Windows =   kinokoProject.Windows.MainWindows
  ----
  -- Menu
  if ffxiv_NotRelease_Menu == nil then
    local menuiconpath = GetStartupPath().. "\\"..Minion.Folder.."\\"..Addon.Folder.."\\image\\"..Main.Icon
    if FileExists(menuiconpath) then
      ffxiv_NotRelease_Menu = {
        ml_gui.ui_mgr:AddMember( { id = "FFXIV"..Main.Id.."##HEADER", expanded = false, name = Main.Name, texture = menuiconpath}, "FFXIVMINION##MENU_HEADER")
      }
    else
      d("["..Main.Name.."] - Main Menu - Icon Path Error")
      ffxiv_NotRelease_Menu = {
        ml_gui.ui_mgr:AddMember( { id = "FFXIV"..Main.Id.."##HEADER", expanded = false, name = Main.Name, texture = GetStartupPath().."\\GUI\\UI_Textures\\addon.png"}, "FFXIVMINION##MENU_HEADER")
      }
    end 
  end
  -- Sub Menu
  local iconpath = GetStartupPath().. "\\"..Minion.Folder.."\\"..Addon.Folder.."\\image\\"..Sub.Icon
  if FileExists(iconpath) then
    ml_gui.ui_mgr:AddSubMember( { id = "FFXIV"..Sub.Id.."##SubMenu", name = Sub.Name, onClick = function() Windows.Open = not Windows.Open end, tooltip = Sub.Tooltip, texture = iconpath}, "FFXIVMINION##MENU_HEADER", "FFXIV"..Main.Id.."##HEADER" )
  else
    d("["..Sub.Name.."] - Icon Path Error.")
    ml_gui.ui_mgr:AddSubMember( { id = "FFXIV"..Sub.Id.."##SubMenu", name = Sub.Name, onClick = function() Windows.Open = not Windows.Open end, tooltip = Sub.Tooltip}, "FFXIVMINION##MENU_HEADER", "FFXIV"..Main.Id.."##HEADER")
  end
end


---------------------------------------------------------------------------------------------------------------------------------------------------
-- 
function AetheryteTicketer.ModuleInit()
  local Windows = kinokoProject.Windows.MainWindows
  ----
  local menuTab = {
    name = "Aetheryte Ticketer",
    openWindow = function () Windows.Open = true end,
    isOpen = function () return Windows.Open end
  }
  table.insert(ml_global_information.menu.windows,menutab)
end
---------------------------------------------------------------------------------------------------------------------------------------------------
-- close
function AetheryteTicketer.SwitchOpen()
  kinokoProject.Windows.MainWindows.Open = not kinokoProject.Windows.MainWindows.Open
end

-------------------------------------------------------------------------------------------------------------------------------------------
-- call
function AetheryteTicketer.DrawCall()
  local Windows = kinokoProject.Windows.MainWindows
  local Addon = kinokoProject.Addon

if (Windows.Open) then
    GUI:SetNextWindowSize(280,350,GUI.SetCond_FirstUseEver)
    Windows.Visible, Windows.Open = GUI:Begin(Addon.Name.." - "..Addon.Version.."##MainWindows_begin", Windows.Open, Windows.Option)
    if (Windows.Visible) then
      GUI:Spacing()
      GUI:Separator()
      GUI:Spacing()
      GUI:BeginGroup()
      if language == 0 then
      GUI:TextColored(1,0,0,1,"重要なことなので必ずお読み下さい")
      for id, e in pairs(kinokoProject.Addon.WARNING_J) do
      GUI:Text(e)
      end
      else
      GUI:TextColored(1,0,0,1,"Please be sure to read this as it is important")
      for id, e in pairs(kinokoProject.Addon.WARNING_E) do
      GUI:Text(e)
      end
      end
      GUI:EndGroup()
      GUI:AlignFirstTextHeightToWidgets()
      GUI:Spacing()
      GUI:Separator()
      GUI:BeginGroup()
      GUI:Text("mushroom  v."..kinokoProject.Addon.Version)
      GUI:EndGroup()

-------------------------------------------------------------------------------------------------------------------------------------------
    end
    GUI:End()
  end
end


---------------------------------------------------------------------------------------------------------------------------------------------------
-- mein function
local pushkey = 0
local osukaisu = 0
local PTstep = 0
local lastUpdatePulse = 0

function Player:Teleport(tpid)
local tpid = tonumber(tpid) or 0
local otherindex = 0
local mori = {2,3,4,5,6,7}
local umi = {8,52,10,11,12,13,14,15,16,55}
local suna = {9,17,18,19,20,21,22,62}
local yuki = {70,23,71,72,73,74,75,76,77,78,79}
local aramigo = {104,98,99,100,101,102,103}
local doma = {111,105,106,107,108,109,110,128,127}
local dai1w = {133,134,137,138,139,140,141,161,144,145,146,142,143,147,148}
local irusa = {183,169,170,171,172,173}
local other = {24,182,166,167,168,174,175,179,180,181,176,177,178}
local house = {}
local aelist = Player:GetAetheryteList()

      if (table.valid(aelist)) then
      for id, e in pairs(aelist) do
        if e.price ~= 0 and e.territory == 339  or
           e.price ~= 0 and e.territory == 340 or
           e.price ~= 0 and e.territory == 341 or
           e.price ~= 0 and e.territory == 641 then
           otherindex = otherindex + 1
        end
       if e.price ~= 0 and e.territory == 339 then
          table.insert(house,id)
       end
       if e.price ~= 0 and e.territory == 340 then
          table.insert(house,id)
       end
       if e.price ~= 0 and e.territory == 341 then
          table.insert(house,id)
       end
       if e.price ~= 0 and e.territory == 641 then
          table.insert(house,id)
       end
       if otherindex == (#house) then
          table.sort(house)
       end
      end
      end
      if PTstep == 0 then
      for id, e in pairs(aelist) do
         --[[if e.isattuned == false then
         table.remove(mori,id)
         table.remove(umi,id)
         table.remove(suna,id)
         table.remove(yuki,id)
         table.remove(aramigo,id)
         table.remove(doma,id)
         table.remove(dai1w,id)
         table.remove(irusa,id)
         table.remove(other,id)
         end ]]        
         if id == tpid then
           for k,v in pairs(mori) do
           if tpid == v then
            if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 1
           end
           end
           for k,v in pairs(umi) do
           if tpid == v then
           if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 2
           end
           end
           for k,v in pairs(suna) do
           if tpid == v then
           if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 3
           end
           end
           for k,v in pairs(yuki) do
           if tpid == v then
           if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 4
           end
           end
           for k,v in pairs(aramigo) do
           if tpid == v then
           if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 5
           end
           end
           for k,v in pairs(doma) do
           if tpid == v then
           if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 6
           end
           end
           for k,v in pairs(dai1w) do
           if tpid == v then
           if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 7
           end
           end
           for k,v in pairs(irusa) do
           if tpid == v then
           if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 8
           end
           end
           for k,v in pairs(other) do
           if tpid == v then
            if IsControlOpen("OperationGuide") then
            pushkey = k + otherindex
            else
            PressKey(97)
            end
           PTstep = 9
           end
           end
           for k,v in pairs(house) do
           if tpid == v then
            if IsControlOpen("OperationGuide") then
            pushkey = k
            else
            PressKey(97)
            end
           PTstep = 9
           end
           end
         end
      end
      end
      if PTstep == 1 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,3)
      d("[AT]selectTab:1")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 1
      end
      end
      if PTstep == 2 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,2)
      d("[AT]selectTab:2")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 2
      end
      end
      if PTstep == 3 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,4)
      d("[AT]selectTab:3")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 3
      end
      end
      if PTstep == 4 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,5)
      d("[AT]selectTab:4")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 4
      end
      end
      if PTstep == 5 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,6)
      d("[AT]selectTab:5")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 5
      end
      end
      if PTstep == 6 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,7)
      d("[AT]selectTab:6")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 6
      end
      end
      if PTstep == 7 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,9)
      d("[AT]selectTab:7")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 7
      end
      end
      if PTstep == 8 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,8)
      d("[AT]selectTab:8")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 8
      end
      end
      if PTstep == 9 then
      if IsControlOpen("Teleport") then
      GetControl("Teleport"):PushButton(25,10)
      d("[AT]selectTab:9")
      osukaisu = 0
      PTstep = 10
      else
      ActionList:Get(5,7):Cast()
      PTstep = 9
      end
      end

      if PTstep == 10 then
        if IsControlOpen("Teleport") and not IsControlOpen("Tooltip") then
        PressKey(104)
        PTstep = 10
        elseif IsControlOpen("Teleport") and IsControlOpen("Tooltip") then
        PTstep = 11
        else
        PTstep = 0
        d("[AT]initialize")
        end
      end

      if PTstep == 11 then
        if IsControlOpen("Teleport") then
            if osukaisu == pushkey then
            PressKey(96)
            PTstep = 99
            else
            osukaisu = osukaisu + 1
            PressKey(98)
            PTstep = 11
            end
            d("[AT]Aetheryte.id:"..tpid.."/index:"..pushkey.."/Step:"..osukaisu.."/house:"..otherindex)   
         else
         PTstep = 0
         d("[AT]initialize")
         end
      end
    
      if PTstep == 99 then
        pushkey = 0
        osukaisu = 0
        PTstep = 100
      end
      if PTstep == 100 then
        if not IsControlOpen("OperationGuide") then
        PressKey(97)
        end      
        if GetChatLines()[table.maxn(GetChatLines())].timestamp < GetEorzeaTime().servertime - 10 then
        PTstep = 0
        d("[AT]initialize")
        end
      end
   return tpid
   end




function AetheryteTicketer.ATuse()
if (GetGameState() == FFXIV.GAMESTATE.INGAME and TimeSince(lastUpdatePulse) > 750) then
lastUpdatePulse = Now()
 Player:Teleport()
end
end
---------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------
-- Register
RegisterEventHandler("Module.Initalize",AetheryteTicketer.Init,"AetheryteTicketer.Init") 
RegisterEventHandler("Module.Initalize",AetheryteTicketer.ModuleInit,"AetheryteTicketer.ModuleInit")
RegisterEventHandler("Gameloop.Draw", AetheryteTicketer.DrawCall,"AetheryteTicketer.DrawCall")
RegisterEventHandler("Gameloop.Update", AetheryteTicketer.ATuse,"AetheryteTicketer.ATuse")
---------------------------------------------------------------------------------------------------------------------------------------------------
