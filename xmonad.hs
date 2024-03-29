import XMonad
import qualified XMonad.Util.CustomKeys as C
import XMonad.Actions.SwapWorkspaces

import qualified XMonad.StackSet as W
import XMonad.Hooks.SetWMName
import XMonad.Actions.CycleWS
-- Guide: https://betweentwocommits.com/blog/xmonad-layouts-guide
import XMonad.Layout.Grid
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
-- https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Layout-Spiral.html
-- import XMonad.Actions.CycleRecentWS
-- The cycling behvaiour of Alt-Tab (as opposed to most recent first) is extremely annoying and very nearly a deal-breaker.
-- Same goes for the annoying switching of the background window in Full view when moving the mouse from a floating window. When I focus the background, XMonad cycles to the window that happens to be the next one in the stack (I think), instead of just "doing nothing" (from my perspective). How can I prevent that!?!?!?
-- No one seems to be aware of the problem, a web search turns up nothing useful. Either ask the question on stackexchange,
-- find out how to implement it or use https://github.com/sagb/alttab ?

myManageHook = composeAll
  [ className =? "Gimp"   --> doFloat
  , className =? "Vlc"    --> doFloat
  , className =? "emacs"  --> doFloat
  , className =? "Pidgin" --> doFloat
  ]

myWorkspaces    = ["0", "1","2","3","4","5","6","7","8","9"]

myLayout = Tall 1 (3/100) (1/2) ||| Full ||| Mirror (Tall 1 (3/100) (3/5)) ||| Grid ||| spiral (6/7) ||| ThreeCol 1 (3/100) (1/2)

main :: IO ()
main = xmonad $ defaultConfig
   { keys = C.customKeys delKeys insKeys
--   , modMask = mod4Mask
   , startupHook = setWMName "LG3D"
   , manageHook  = myManageHook <+> manageHook defaultConfig
   , layoutHook  = myLayout
   , workspaces  = myWorkspaces
   }
  where
    delKeys :: XConfig l -> [(KeyMask, KeySym)]
    delKeys XConfig { modMask = modm } = [ (modm, xK_b), (modm .|. shiftMask, xK_q -- that's the last time you quit on me because Ctrl-Shift-Q was accidentally pressed
      )]
-- , (modm, xK_Tab) ]

    insKeys :: XConfig l -> [((KeyMask, KeySym), X ())]
    insKeys conf@(XConfig { modMask = modm }) =
       [ ((modm, xK_Left), prevWS)
       , ((modm, xK_Right), nextWS)
       , ((mod1Mask .|. shiftMask, xK_Return ), spawn "lxterminal")
--       , ((modm, xK_grave), cycleRecentWS [] xK_Left xK_Right)
       , ((modm .|. shiftMask, xK_Left), shiftToPrev)
       , ((modm .|. shiftMask, xK_Right), shiftToNext) ]
      ++ -- switch, move
      [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_0 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
      ++ -- swap
      [((modm .|. controlMask, k), windows $ swapWithCurrent i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_0 ..]]
