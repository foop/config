import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig
import XMonad.Actions.SpawnOn
import System.IO

myManageHook = composeAll . concat $ [
      [ className =? "Iceweasel"  --> doShift "2:web"  ],
      [ className =? "Eclipse"    --> doShift "3:dev1" ], 
      [ className =? "Evince"     --> doShift "4:doc"  ],
      [ className =? "Vlc"        --> doShift "6:mul"  ],
      [ className =? "Emacs"      --> doShift "7:org"  ],
      [ className =? "Skype"      --> doShift "8:comm" ],
      [ className =? "Icedove"    --> doShift "8:comm" ],
      [ className =? "Transmission-gtk" --> doShift "9:daem" ]
      ]

main = do 
    xmproc <- spawnPipe "/usr/bin/xmobar /home/dominik/.xmobarrc"
    xmonad $ defaultConfig {
        workspaces = [ "1:cont", "2:web", "3:dev1", "4:doc", "5:dev2","6:mul", "7:org",
                       "8:comm", "9:daem", "0:void"],
        manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig,
        startupHook = composeAll [
                        spawnOn "1:cont" "urxvtcd -e htop",
                        spawnOn "1:cont" "urxvtcd -e tail -f /var/log/syslog",
                        spawnOn "1:cont" "urxvtcd -e irssi",
                        spawnOn "1:cont" "urxvtcd",
                        spawnOn "2:web" "iceweasel",
                        spawnOn "7:org" "emacs ~/org/dailyImprovements/workFlow.org",
                        spawnOn "8:comm" "skype",
                        spawnOn "8:comm" "icedove"
                      ],
        layoutHook = avoidStruts $ layoutHook defaultConfig,
        logHook = dynamicLogWithPP xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "green" "" . shorten 50
            },
        terminal = "urxvtcd",
        modMask = mod4Mask --Rebind Mod to the Windows key
        }


