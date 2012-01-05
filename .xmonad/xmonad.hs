import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Actions.WindowGo

myManageHook = composeAll [
    className =? "Unity-2d-panel"    --> doIgnore,
    className =? "Unity-2d-launcher" --> doFloat,
    appName   =? "Synapse"           --> doIgnore
    ]

main = xmonad $ gnomeConfig {
	manageHook  = myManageHook <+> manageHook gnomeConfig,
	borderWidth = 0,
	layoutHook  = smartBorders $ layoutHook gnomeConfig,
	terminal    = "gnome-terminal",
	modMask     = mod4Mask
    }
    `additionalKeysP` [
       ("M-p",  spawn "synapse"),
       ("M-v",  raiseMaybe (spawn "gvim --servername GVIM") (className =? "Gvim")),
       ("M-t",  runOrRaise "gnome-terminal"                 (title     =? "Terminal")),
       ("M-e",  runOrRaise "thunderbird"                    (title     =? "Thunderbird")),
       ("M-b",  runOrRaise "x-www-browser"                  (className =? "X-www-browser")),
       ("M-g",  raise (title =? "Guard"))
     ]
