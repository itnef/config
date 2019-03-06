import XMonad
import qualified XMonad.Util.CustomKeys as C
import XMonad.Hooks.SetWMName
import XMonad.Actions.CycleWS
-- import XMonad.Actions.CycleRecentWS

main :: IO ()
main = xmonad $ defaultConfig
   { keys = C.customKeys delKeys insKeys
   , modMask = mod4Mask
   , startupHook = setWMName "LG3D"
   }
  where
    delKeys :: XConfig l -> [(KeyMask, KeySym)]
    delKeys XConfig { modMask = modm } = [ (modm, xK_b) ]

    insKeys :: XConfig l -> [((KeyMask, KeySym), X ())]
    insKeys conf@(XConfig { modMask = modm }) =
       [ ((modm, xK_Left), prevWS)
       , ((modm, xK_Right), nextWS)
       , ((mod1Mask .|. shiftMask, xK_Return ), spawn "lxterminal")
--       , ((modm, xK_grave), cycleRecentWS [] xK_Left xK_Right)
       , ((modm .|. shiftMask, xK_Left), shiftToPrev)
       , ((modm .|. shiftMask, xK_Right), shiftToNext) ]
