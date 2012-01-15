import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Actions.WindowGo
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle

myManageHook = composeAll [
    className =? "Unity-2d-panel"    --> doIgnore,
    className =? "Unity-2d-launcher" --> doFloat,
    appName   =? "Synapse"           --> doIgnore,
    isFullscreen --> doFullFloat
    ]

myLayoutHook = mkToggle (single REFLECTX) $ smartBorders $ layoutHook gnomeConfig

main = xmonad $ gnomeConfig {
	manageHook  = myManageHook <+> manageHook gnomeConfig,
	borderWidth = 1,
	focusedBorderColor = "#00a6c5",
	focusFollowsMouse  = False,
	layoutHook  = myLayoutHook,
	terminal    = "gnome-terminal",
	modMask     = mod4Mask
    }
    `additionalKeysP` [
       ("M-p",  spawn "synapse"),
       ("M-v",  raiseMaybe (spawn "gvim --servername GVIM") (className =? "Gvim")),
       ("M-t",  runOrRaise "gnome-terminal"                 (title     =? "Terminal")),
       ("M-e",  runOrRaise "thunderbird"                    (title     =? "Thunderbird")),
       ("M-i",  runOrRaiseNext "x-www-browser"              (className =? "X-www-browser")),
       ("M-g",  raise (title =? "Guard")),
       ("M-<Left>",  sendMessage $ Toggle REFLECTX)
     ]
