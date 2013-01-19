import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xloadimage -onroot /home/dominik/.xmonad/background.png"
    xmproc <- spawnPipe "/usr/bin/xmobar /home/dominik/.xmobarrc"
    xmonad $ defaultConfig {
        terminal = "urxvt",
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig,
        logHook = dynamicLogWithPP xmobarPP { 
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "green" "" . shorten 50
        }
    }
