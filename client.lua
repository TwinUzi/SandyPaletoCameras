EToToggleCam = 0
SelectedCam = 1
paletobankcam1 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -115.6349, 6472.7, 32.507, 180.0, 180.0, 25.0, 50 * 1.0)
paletobankcam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -103.0123, 6467.674, 32.87, 180.0, 180.0, 25.0, 50 * 1.0)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        CurrPedCoord = GetEntityCoords(GetPlayerPed())
        CameraFeedToggleCoords = {1842.458, 3691.421, 34.20258}
        --print(CurrPedCoord)
        if (CurrPedCoord.x>1840) and (CurrPedCoord.x<1844) then
            if (CurrPedCoord.y>3691) and (CurrPedCoord.y<3693) then
                EToToggleCam = 1
            end
        else
            EToToggleCam = 0
        end
    end 
end)

Citizen.CreateThread(function()
    while true do
        Wait(2500)
        print(CurrPedCoord)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if (EToToggleCam>0) then
            local pickupButton = {
                ["label"] = "Watch Security Cam",
                ["button"] = "~INPUT_DETONATE~" --[[
                    local buttonsToDraw = {
                    {
                        ["label"] = "Watch Security Cam",
                        ["button"] = "~INPUT_DETONATE~",
                    }
                }]]
            }
            local CamSelectorBack = {
                ["label"] = "Previous",
                ["button"] = "~INPUT_VEH_RADIO_WHEEL~"
            }
            local CamSelectorNext = {
                ["label"] = "Next",
                ["button"] = "~INPUT_VEH_HORN~"
            }
            local buttonsToDraw = {
                {
                    ["label"] = "Exit Cam",
                    ["button"] = "~INPUT_FRONTEND_RRIGHT~",
                }
            }
            table.insert(buttonsToDraw, CamSelectorNext)
            table.insert(buttonsToDraw, CamSelectorBack)
            table.insert(buttonsToDraw, pickupButton)
            Citizen.CreateThread(function()
                local instructionScaleform = RequestScaleformMovie("instructional_buttons")
            
                while not HasScaleformMovieLoaded(instructionScaleform) do
                    Wait(0)
                end
            
                PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
                PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
                PushScaleformMovieFunctionParameterBool(0)
                PopScaleformMovieFunctionVoid()
            
                for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
                    PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
                    PushScaleformMovieFunctionParameterInt(buttonIndex - 1)
                
                    PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
                    PushScaleformMovieFunctionParameterString(buttonValues["label"])
                    PopScaleformMovieFunctionVoid()
                end
            
                PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
                PushScaleformMovieFunctionParameterInt(-1)
                PopScaleformMovieFunctionVoid()
                DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
            end)
        end
    end
    end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if (EToToggleCam>0) then
            if (IsDisabledControlPressed(1, 47)) then
                RenderFirstCamera()
                Wait(250)
            end
            if (IsDisabledControlPressed(1,194)) then
                SetFocusEntity(GetPlayerPed())
                SetCamActive(paletobankcam1, false)
                RenderScriptCams(false, true, 0, false, true)
                SetCamAffectsAiming(paletobankcam1, true)
                Wait(250)
            end
            if (IsDisabledControlPressed(1, 46)) then
                SelectedCam = SelectedCam + 1
                RenderFirstCamera()
                Wait(250)
            end
            if (IsDisabledControlPressed(1, 52)) then
                SelectedCam = SelectedCam - 1
                RenderFirstCamera()
                Wait(250)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do Wait(10000) print("Selected Cam:"..SelectedCam) end 
end)

function RenderFirstCamera()
    Citizen.CreateThread(function()
        if (SelectedCam==1) then
            SetCamActive(paletobankcam2, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam2, true)
            SetCamActive(paletobankcam2, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam2, true)
            SetCamActive(paletobankcam2, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam2, true)
            paletobankcam1 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -115.6349, 6472.7, 32.507, 180.0, 180.0, 25.0, 50 * 1.0)
            SetCamActive(paletobankcam1, true)
            RenderScriptCams(true, false, 0, true, false)
            SetCamAffectsAiming(paletobankcam1, false)
            focusentpaletobankcam1 = CreateObject(
                GetHashKey('prop_cs_fork'), 
                -115.6349, 
                6472.7, 
                32.507, 
                true, 
                true, 
                true
            )
            SetFocusEntity(focusentpaletobankcam1)
        end
        if (SelectedCam==2) then
            SetCamActive(paletobankcam1, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam1, true)
            SetCamActive(paletobankcam1, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam1, true)
            SetCamActive(paletobankcam1, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam1, true)
            paletobankcam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -103.0123, 6467.674, 32.87, -10.0, 0.0, 40.0, 50 * 1.0)
            SetCamActive(paletobankcam2, true)
            RenderScriptCams(true, false, 0, true, false)
            SetCamAffectsAiming(paletobankcam2, false)
            focusentpaletobankcam2 = CreateObject(
                GetHashKey('prop_cs_fork'), 
                -115.6349, 
                6472.7, 
                32.507, 
                true, 
                true, 
                true
            )
            SetFocusEntity(focusentpaletobankcam2)
        end
        if (SelectedCam==3) then
            SetCamActive(paletobankcam2, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam2, true)
            SetCamActive(paletobankcam2, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam2, true)
            SetCamActive(paletobankcam2, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam2, true)
            paletobankcam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1171.36, 2706.987, 39.0, -10.0, 0.0, -115.0, 50 * 1.0)
            SetCamActive(paletobankcam3, true)
            RenderScriptCams(true, false, 0, true, false)
            SetCamAffectsAiming(paletobankcam3, false)
            focusentpaletobankcam3 = CreateObject(
                GetHashKey('prop_cs_fork'), 
                1175.49, 
                2706.904, 
                36, 
                true, 
                true, 
                true
            )
            SetFocusEntity(focusentpaletobankcam3)
        end
        if (SelectedCam==4) then
            SetCamActive(paletobankcam3, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam3, true)
            SetCamActive(paletobankcam3, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam3, true)
            SetCamActive(paletobankcam3, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam3, true)
            paletobankcam4 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1178.987, 2710.681, 39.5, -20.0, 0.0, 75.0, 50 * 1.0)
            SetCamActive(paletobankcam4, true)
            RenderScriptCams(true, false, 0, true, false)
            SetCamAffectsAiming(paletobankcam4, false)
            focusentpaletobankcam4 = CreateObject(
                GetHashKey('prop_cs_fork'), 
                1175.49, 
                2706.904, 
                36, 
                true, 
                true, 
                true
            )
            SetFocusEntity(focusentpaletobankcam4)
        end
        if (SelectedCam==5) then
            SetCamActive(paletobankcam4, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam4, true)
            SetCamActive(paletobankcam4, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam4, true)
            SetCamActive(paletobankcam4, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam4, true)
            paletobankcam5 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -2962.215, 486.5627, 17.0, -15.0, 0.0, 150.0, 50 * 1.0)
            SetCamActive(paletobankcam5, true)
            RenderScriptCams(true, false, 0, true, false)
            SetCamAffectsAiming(paletobankcam5, false)
            focusentpaletobankcam5 = CreateObject(
                GetHashKey('prop_cs_fork'), 
                -2962.215, 
                486.5627, 
                25.0, 
                true, 
                true, 
                true
            )
            SetFocusEntity(focusentpaletobankcam5) 
        end
        if (SelectedCam==6) then
            SetCamActive(paletobankcam5, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam5, true)
            SetCamActive(paletobankcam5, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam5, true)
            SetCamActive(paletobankcam5, false)
            RenderScriptCams(false, true, 0, false, true)
            SetCamAffectsAiming(paletobankcam5, true)
            paletobankcam6 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -2958.793, 478.884, 17.0, -15.0, 0.0, -20.0, 50 * 1.0)
            SetCamActive(paletobankcam6, true)
            RenderScriptCams(true, false, 0, true, false)
            SetCamAffectsAiming(paletobankcam6, false)
            focusentpaletobankcam6 = CreateObject(
                GetHashKey('prop_cs_fork'), 
                -2962.215, 
                486.5627, 
                25.0, 
                true, 
                true, 
                true
            )
            SetFocusEntity(focusentpaletobankcam6) 
        end
        if (SelectedCam>6) then
            SelectedCam = 1
        end
        if (SelectedCam<1) then
            SelectedCam = 6
        end
        Citizen.Wait(200)
    end)
end