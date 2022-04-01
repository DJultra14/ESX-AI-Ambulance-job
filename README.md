# ESX-AI-Ambulance-job

--   _____ _____  ______       _______ ______ _____          ______     __        _____       _ _    _ _   _______ _____           __ _  _   
--   / ____|  __ \|  ____|   /\|__   __|  ____|  __ \        |  _ \ \   / /       |  __ \     | | |  | | | |__   __|  __ \     /\  /_ | || |  
--  | |    | |__) | |__     /  \  | |  | |__  | |  | |       | |_) \ \_/ /        | |  | |    | | |  | | |    | |  | |__) |   /  \  | | || |_ 
--  | |    |  _  /|  __|   / /\ \ | |  |  __| | |  | |       |  _ < \   /         | |  | |_   | | |  | | |    | |  |  _  /   / /\ \ | |__   _|
--  | |____| | \ \| |____ / ____ \| |  | |____| |__| |       | |_) | | |          | |__| | |__| | |__| | |____| |  | | \ \  / ____ \| |  | |  
--   \_____|_|  \_\______/_/    \_\_|  |______|_____/        |____/  |_|          |_____/ \____/ \____/|______|_|  |_|  \_\/_/    \_\_|  |_|  

This is a ESX job for the amabulance job that allows paramedics to go around and treat AI's for money
 
 animations and peds are chosen by random for the peds form the config.lua 
 
 Config = {}


Config.AmbulanceJobName = "ambulance" -- name of the job that has access
Config.Pay = 200 -- pay per revive
Config.Scenarios = {

    -- Can add extra location here 
    {
        Pos = {x = 255.139, y = -1400.731, z = 29.537},
        Problem = "ran over"
    },
    {
        Pos = {x = 238.139, y = -1195.731, z = 29.31},
        Problem = "ran over"
    },
    {
        Pos = {x = 158.139, y = -1004.51, z = 29.41},
        Problem = "ran over"
    },
    
   

}
-- Anaimations for the peds chosen by random
Config.Animations = {
    "WORLD_HUMAN_BUM_SLUMPED",
    "WORLD_HUMAN_SUNBATHE_BACK"
}
-- preds chosen by random
Config.Peds = {
    "a_f_y_beach_01",
    "a_f_m_fatbla_01",
    "a_f_m_skidrow_01",
    "a_f_y_bevhills_04",
    "a_m_m_beach_01",

}
