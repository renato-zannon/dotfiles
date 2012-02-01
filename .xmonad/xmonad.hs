import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Actions.WindowGo
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import XMonad.Hooks.ManageDocks

myManageHook = composeAll [
    appName   =? "Synapse"           --> doFloat,
    className =? "Unity-2d-panel"    --> doIgnore,
    className =? "Unity-2d-launcher" --> doFloat,
    isFullscreen --> doFullFloat
    ]

startup = spawn "sh ~/.xinitrc"

myLayoutHook = avoidStruts $ mkToggle (single REFLECTX) $ smartBorders $ layoutHook gnomeConfig

main = xmonad $ gnomeConfig {
	manageHook  = manageDocks <+> myManageHook <+> manageHook gnomeConfig,
	borderWidth = 1,
	focusedBorderColor = "#00a6c5",
	focusFollowsMouse  = False,
	layoutHook  = myLayoutHook,
	startupHook  = startup,
	terminal    = "urxvt",
	modMask     = mod4Mask
    }
    `additionalKeysP` [
       ("M-p",  spawn "synapse"),
       ("M-b",  sendMessage ToggleStruts),
       ("M-v",  runOrRaise "bin/transparent_gvim"       (className =? "Gvim")),
       ("M-t",  runOrRaise "urxvt"                      (title     =? "Terminal")),
       ("M-e",  runOrRaise "thunderbird"                (title     =? "Thunderbird")),
       ("M-i",  runOrRaiseNext "google-chrome"          (className =? "google-chrome")),
       ("M-g",  raise (title =? "Guard")),
       ("M-<Left>",  sendMessage $ Toggle REFLECTX)
     ]
