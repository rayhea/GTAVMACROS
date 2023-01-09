# GTA ONLINE MACROS

Its a Script written in Autohotkey for GTA V Online.
It does not hack/temper game or its files in any shape or form, it just automate key strokes.
This Hotkeys only works when game is in focus.

## Disclaimer

GTAVMACROS offers many features but at the cost of tons of changes to game settings such as you may have to play in medium graphics windowed mode so proceed further only if you want to.
And also it is not guarantee to work properly even after making all the changes given below.

## About AutoHotkey 

It's a free and open source scripting language that lets you create keyboard shortcuts or hotkeys, macros and some automation in any Windows program.

## Credits

There are many ideas taken from many scripts, some links are commented out in code if you want to check but special thanks to 
- [2called_chaos](https://www.reddit.com/r/gtaonline/comments/bokair/i_polished_my_gtao_autohotkey_script_for_you_guys/)
- [KeyMash](https://www.autohotkey.com/board/topic/149458-gta-online-quick-menu-macros/)

## Installation

 Install AutoHotkey from folder \setup\AutoHotkey\AutoHotkey_1.1.36.02_setup.exe
or Download and install the latest AutoHotkey v1.1 64 bit from [official website.](https://www.autohotkey.com/download/)

## Necessary Changes

| <ins>In Game Settings</ins>|   |
| :-- | :-- |
| **Settings >> Graphics**|   |
| DirectX Version | DirectX 11 |
| Screen Type | Windowed |
| Resolution | 1366x768 |
| Aspect Ratio | Auto |
| Pause Game On Focus Loss | Off |
| Texture Quality | Normal |
| Post Fx | (Not Very High) |
| **Settings >> Keyboard/Mouse**|  |
| Mouse Input Method | Windows |
| **Settings >> Key Bindings >> General**| |
| Pause | n |
| Toggle Special Ability| i  |
| **Settings >> Key Bindings >> Weapons Select** |  |
| Weapon Wheel | \ |
| Select Shotgun   | 7 |
| Select Heavy Weapon | 8 |
| Select Special Weapon | 9 |
| Select Pistol | 3 |
| Select SMG | 4 |
| Select Assualt Riffle | 5 |
| Select Sniper Riffle | 6 |
| **Settings >> Key Bindings >> Vehicle General** |  |
| Previous Vehicle Weapon  | Scroll Down |
| **Settings >> Key Bindings >> GTA Online** |  |
| Text Chat Everyone | u |
| Text Chat Team | y |
| Push to Talk | t |
| Drop Weapon | Numpad/ |
| Drop Ammunition | Numpad\* |
| Toggle Helmet Visor | Numpad- |
|**<ins>In Game Phone Settings**</ins>||
| Theme | Blue |
| Background | Green Triangles |
|**<ins>In Discord User Settings >> Game Overlay**</ins> ||
|Toggle Overlay Lock| Numpad Dot |
> Note :- Weapon Wheel is still Tab while Script is running but it is necessary to remove Shift + Tab weapon swap lag while quickly selecting from weapon wheel.

## To Run
 Double click on GTAVMACROS.ahk to run the Script.  
*Note :- temp folder and GTAVMACROS.ahk should be in same directory/parent folder.*

## Important Notes
- If there is any trouble with hotkeys or mic then check if it is disabled or not in Scripts Menu.
- If mouse or keyboard does not respond press Ctl + Alt + Del then cancel and right click the H icon in tray to reload the script .
- Always Exit the Script from Tray after playing.
- To stop unwanted action, press Esc or Right Mouse button.
- Some Keys have different function depending on key presses i.e. single, double or hold press.

## Hotkeys

Modifying keys are not recommended for those who dont know AHK language but here is a quick tip.
- Open \temp\lib\mapping.ahk using text editor.
- To change keybind, find that key or label and replace the third parameter of assign function with that key and do check for duplication.
- To disable keybind, comment out kStash Object by placing ; in front.*

### Script Hotkeys (works in any program)
------------

#### AppsKey. 
- Single Press to turn Hotkeys On/Off.  
 *Note :- Works only when game is focus.*
- Double Press to Reload Script (indicated by beep sound).
- Long Press to Terminate Script.  
*Note :- Double/Long Press AppsKey works in Any Window just in case.*

#### Script Sound "/"
- Double Press to enable or disable sound from Script.

#### Script Menu "`"
- Single press to Toggle Window focus Between Game and Gui.
- Hold press to Show/Hide Gui.  
 *Note :- this window can blocks pixel/image detection on screen so close it whenever not in need.*

#### Microphone Mute ";"
- Select the modes from script menu i.e. Disabled, ToggleMute, HoldToTalk, TapToTalk.  
 *Note :- when Script is terminated, it unmutes the current muted microphone.* 

#### Crosshair "Numpad +"
- Single press to Toggle Crosshair On/Off.
- Double press to Toggle Animation when Left mouse button is pressed.

#### Terminate / Suspend
- To terminate GTA5.exe, press Alt+End just like Alt+F4 but faster.
- To Empty Public Session, double press "End" (10 sec. freeze, same as Suspend from Resource Monitor).

### Escape Menu Hotkeys
------------

#### Expanded Map On/Off  "F1"
#### Voice Chat On/Off  "F2"  
*Note :- don't use F1,F2 frequently because it blocks keyboard and mouse input while changing settings.*

### Interaction Menu Hotkeys
------------

#### Drop BullShark   "F3"
#### Drop Armor      "F4"
#### Equip Armor     "F5"
#### Eat Snack     "F6"
- Single Press to Eat 2 Snacks.
- Hold Press to keep eating Snacks.

####  Return Vehicle    "o"
- If you are MC president then vehicle get return from MC menu.
#### Personal Vehicle  "p"

#### Change Outfit     "F12"
- Single Press for Outfit Menu.
- And later single press within 2-3 secs to change Outfit when in Outfit menu.

#### Head Accessories  "Numpad-" 
- Single Press to toggle Visor
- Double Press to go to Helmet Menu
- Long Press to go to Mask Menu
- And later Single Press to change Helmet/Mask When in Helmet/Mask Menu.

#### Ceo/Mc key "-"
- Single Press to register as Ceo.
- Double Press to register as McPresident.
- After registering as Ceo/Mc President.
- Single Press/Double Press to retire Ceo/Mc President.
- Hold to toggle between Ceo & McPresident.
   
#### Ceo/Mc key "0" (No Action)
- It is similar to "-" key but without action. Necessary for the script to know players role whether it is ceo/mc or not.

#### Capslock 
- When it is single pressed and Capslock Led Lights up it lets the script know that player is a associate/member.
- Otherwise has no role or already is a ceo/mc.

#### Invite Key "="
- Single Press to send associate/member invite to crew.
- Double Press to send associate/member invite to friends.

### Phone Hotkey
------------

#### MazeBankDeposit "'"
- Single press to deposit money.
- Hold press to stop at option page.

### Phone Calls
------------

~~~
Call Mechanic          "F7"
Call MorsMutual        "F8"  
Call Pegasus           "F9"
Call Merryweather      "F10"
Call Lester            "F11"
~~~

*Note :- Hold Press "F11" to Remove Wanted Level by Lester. For the script to know the arrangement of contacts in phone, press Contacts Detect button in Script menu (open using "~") which is mentioned below in detail.*

### Special Dynamic Hotkey
------------

#### Custom Interaction menu 
 -  To assign key "," to any label in menu, Open interaction menu and select the label in menu
 -  And hold key "," till interaction menu closes then just Single press key "," to use.

#### Custom Phone Number
 -  To assign key "." to any contact in phone, Open phone and select the contact
 -  And hold key "." till phone closes then just Single press key "." to use.

### Gaming Mouse Hotkey
------------

#### Dynamic Weapon bind for below keys
- To bind below key to any weapon slot while ingame, press Tab & select the weapon slot from weapon wheel and press the below key to directly assign it.

*By default they are assigned to following weapons.*

~~~
SMG                    "F14"
Sniper Riffle          "F13" 
Heavy Weapons          "Mouse5"
Toggle Rifle and Hand  "Mouse4"
~~~

*Note :- if gaming mouse has 4 extra buttons, assign far away two keys to F14 and F13 and for 2 extra button gaming mouse no changes are required as Mouse5 and Mouse4 keys are defined. if two Mouse Button are assigned same weapon, when pressed furthest mouse button will scroll up and closest will scroll down the same weapon.*

### Overrided Existing Keys
------------

#### Middle Mouse
 - Hold Middle Mouse button to Zoom while using Sniper Scope.
 -  Single Press to Open Phone.

#### Left Control To Sneak
 -  Changed from Single Press to Hold Press.  
*Note :- To disable this, uncheck Hold Sneak in Script Menu.*

#### "v" key To Changes Camera View
 -  Now Just Toggle Betw' Third Person & First Person View.
 -  But its Necessary to be in 1st Third Person View (closest to player) to toggle at first.
 -  To Change View, Hold Press "v" it will cycle through all views then release the key at desired view.
 -  Double press to reset but be in 1st Third Person Field Of View .

#### Double press q To hold Down w  
   *Note:- Single Press q still changes radio station and Hold press q brings station wheel inside vehicle.*

#### Numpad Enter binded to Enter.

## Script Menu

![](https://github.com/rayhea/GTAVMACROS/blob/main/Script%20Menu.jpg?raw=true)

### Tab Main 
----------

#### Lucky Wheel Alarm
 -  Set Alarm For Lucky Wheel after pressing {E+Enter+S} to Spin Lucky Wheel.
 -  One beep sound Signifies Alarm Successfully set {E+Enter+S} & Two beeps is Alarm sound.
 -  Alarm goes off before 10 min & Repeats Every 10 min and also beeps when game is not running.  
   *Note :- Don't Press Other Keys, in between the Key's That Are Displayed To Interact/Spin Lucky Wheel {E+Enter+S}.*
 -  Progress bar in Script Menu shows remaining time to spin lucky wheel.  
   *Note :- timer run out 10 minutes early and progress bar acts as slider for user to set custom alarm.*

#### Settings
 -  Hotkey - to turn hotkey On/Off.
 -  Hold Sneak - to turn hold crouch On/Off.
 - Sound - to turn script sound On/Off.
 -  Confirm Kill/Suspend - to display yes/on dialog whenever you tried to terminate/Suspend GTA5.

#### Features
 -  Suspend button - to Empty public session works similar as suspend from resource monitor.
 -  Contacts Detect button - to detect the existing contacts in phone to configure phone hotkeys.
 -  UnStuck button - to release logical stuck keys.
   Quick Peek Open button - to Open Quick Peek.txt.

### Tab Misc 
------------

#### Phone Mode
 -  Select any Phone number and press Dial button to dial.

#### Chat Mode
 -  press y or u to select global or team chat to enter text.
 -  Double click on text or Multiple text Select by holding Ctrl or Shift then press Type button to post the text into chat box.
 -  Hold Type Button to Spam Multiple of selected text in chat box.  
   *Note :- To stop Spamming, press any key.*

#### Chat Edit
 -  To edit press Edit text when it turn lime it indicates that List Element are in Edit Mode.
 -  It allows to modifiy phone and chat elements.
 -  To delete Select elment and press Del and to move just drag element up/down.

#### Hacks
 -  Auto : if checked, the script cycles through hack until it is complete
 -  Detect Mode : Detects the hack 

*For faster response, select the hack from drop down list and uncheck Auto and press "k" respectively*

~~~
For fingerprint hack
press "k" for each fingerprint

For keypad hack
press "k" when dot's are blinking 

For retro fingerprint hack
press "k" for each fingerprint

For volt lab hack 
press "k" at start

Note :- for every hack, other keys must be untouched.
~~~

### Tab Sys 
------------

#### HotVoice Voice Commands (No Command Added)
 
#### Microphone
 - Manages default Microphone.
 - Has Extra Options to Toggle Mic in drop down menu.

#### Sounds
 - Manages default Speakers.
 - Has Volume Mixer.
