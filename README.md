# Sand.cc

<p align="center">
  <img src="https://i.postimg.cc/dt65c2T9/Untitled184-20261005185058.png" alt="idk" width="300">
</p>

<p align="center">"all I can really do is give your cpu a band-aid :/"</p>

*(Formerly "Optiz")*

<p align="center">A lightweight optimization script that makes your game run smoother and look cleaner. Sand.cc is the lighter, lazier cousin of <b>Gravel.cc</b> :3</p>

---

This is the official repository for Sand.cc!

Im mostly active on [YOUTUBE](https://youtube.com/@gpssickle?si=H0dugKCbTpV_yGK7) or [SCRIPTBLOX](https://scriptblox.com/u/Gpssickle) if you guys want to see my random scripts :3

**Warner**: Sand.cc is still underdevelopment so elements/feats can change or become missing/unavailable & bugs can occur. Some features can break gameplay, some can't... read the descriptions before toggling :p

---

# Loading Sand.cc

Raw Loadstring:

*(Cached by GitHub.)*
```lua
local SandCC = loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/Sand/main/Sand.lua"))({
    createwindui = true, -- true/false         / allow creating Wind UI (you'll need to rejoin and set the boolean to 'true' and rejoin if you need to change something)
    autoload = true, -- true/false            / allow autoloading
})
-- you can put this in your autoexecute folder if you wanna :p
-- also this script is underdevelopment like gravel.cc >_>
```

Sand.cc accepts a config table when you loadstring it. If you don't pass one, it falls back to `getgenv().cfg` or uses defaults.

**Note:** `createwindui` is read once on execution. If you want to change it later, you'll need to rejoin and re-execute the script.

---

API Loadstring:

*(Bypasses GitHub cache.)*
```lua
local a,b,c,g="/hm5650/Sand/","/Sand.lua",".github","https://"
local d=request({Url=`{g}api{c}.com/repos{a}contents{b}`,Headers={Accept=`application/vnd{c}.VERSION.raw`}})
if d.StatusCode~=200 then
    d.Body=game:HttpGet(`{g}raw{c}usercontent.com{a}refs/heads/main{b}`)
end
local e,f=loadstring(d.Body)
if not e then warn(f) else e() end
```

---

# Tabs TL;DR

A quick-reference of features that Sand.cc has :p

---

## Visuals Tab

- **Gray Sky** - Replaces sky, atmosphere and clouds with a flat gray skybox
- **Full Bright** - Bright, flat lighting with global shadows off
- **Simplify Lighting** - Soft shadows, environment lighting, fog and post-processing off
- **Remove Fog** - Pushes fog far away so it never shows
- **Remove Atmosphere** - Detaches Atmosphere objects from Lighting and Terrain
- **Kill Post Effects** - Force-disables every PostEffect (bloom, DOF, sun rays, etc.)
- **Kill Blur Only** - Disables only BlurEffect instances
- **Kill Lighting** - Strips lighting to bare minimum (no fog, shadows, post effects)
- **Freeze Time of Day** - Locks the clock to a fixed hour + slider
- **Remove Grass** - Turns terrain decoration (grass) off
- **Simplify Water** - Flattens water waves and removes reflections
- **Low Detail Models** - Forces every Model to cheapest levelOfDetail (StreamingMesh)
- **Smooth Plastic** - Every part (except characters) becomes SmoothPlastic with no reflectance
- **Grey-box Props** - Parts matching keywords become flat grey and lose decals
  - Editable keyword list (multi-line)
- **Low Poly Meshes** - Forces lowest mesh detail (RenderFidelity: Performance) on every MeshPart

---

## Textures & FX Tab

- **Hide Textures** - Makes decals and textures invisible (characters left alone)
  - Keep important textures toggle
  - Important texture keywords input
- **Remove SurfaceAppearance** - Detaches PBR texture maps from parts and meshes
- **Throttle Particles** - Switches particle emitters off (characters left alone)
  - Max particle emit rate slider
- **Remove Emitters** - Detaches ParticleEmitter, Trail, Fire, Smoke and Sparkles
- **Disable Trails** - Turns off Trail objects instead of destroying them
- **Disable Beams** - Turns off Beam objects instead of destroying them
- **Remove Beams** - Detaches Beam objects
- **Disable Lights** - Turns off PointLight, SpotLight and SurfaceLight
- **Disable Part Shadows** - Parts stop casting shadows
- **Hide SurfaceGuis** - Hides SurfaceGui elements in the world
- **Hide BillboardGuis** - Hides BillboardGui elements in the world
- **Disable Constraints** - Turns off align, hinge, rod and motor constraints
- **Disable Highlights** - Detaches Highlight instances from the world
- **Disable Selection Boxes** - Detaches SelectionBox and SelectionSphere instances
- **Remove GUI Effects** - Removes UIGradient, UIStroke and UIShadow from other ScreenGuis
- **Disable Fire/Smoke/Sparkles** - Turns off the old Fire, Smoke and Sparkles effects
- **Hide ForceField Bubbles** - Makes spawn ForceField bubbles invisible

---

## Performance Tab

- **Core Settings** - Lowest quality level, mesh/texture detail, always-on physics throttle
  - Quality level slider (1-21)
- **FPS Cap** - Sets the frame rate cap with setfpscap
  - FPS cap value slider (30-1000)
- **Memory Cleanup** - Runs garbage collection when script memory passes threshold
  - Cleanup threshold slider (25-1000 MB)
- **Adaptive Performance** - Lowers quality + shrinks max distance when FPS drops
  - Low FPS threshold slider
- **FPS Counter** - Small FPS label in top-left corner
- **Ping Counter** - Shows current ping below the FPS label
- **Update interval** - How often the periodic checks run (3-60 seconds)

---

## Workspace Tab

- **Freeze Distant Players** - Stops animations of other players beyond max distance
  - Also freeze players behind the camera toggle
  - Freeze check rate slider (0.1-5 seconds)
- **Anchor Distant Objects** - Anchors unanchored parts beyond max distance
  - Also anchor objects behind the camera toggle
- **Render Distance** - Hides parts beyond the render distance slider
  - Render distance slider (100-5000 studs)
- **Throttle Sounds** - Pauses sounds beyond max distance, turns them down past half
  - Max distance slider (20-500)
- **Hide Other Players** - Hides every other player's character parts
- **Hide Nametags** - Hides name/health displays above other players
- **Remove Player Accessories** - Detaches hats and accessories from other players
- **Remove Player Clothing** - Detaches shirts, pants and graphic shirts from other players
- **Hide Held Tools** - Detaches tools other players are holding from their characters
- **Freeze Other Animations** - Stops other players' animations entirely

---

## Network & UI Tab

- **Throttle Remote Events** - Drops FireServer calls above limit per remote (hooks __namecall)
  - Remote calls per second slider
- **Disable Core GUI** - Hides player list, emotes menu and health bar
- **Disable Bubble Chat** - Turns chat bubbles above heads off
- **Hide Chat Window** - Hides the Roblox chat window
- **Hide Floating UIs** - Disables all ScreenGuis except Sand.cc
- **Disable Explosions** - Detaches Explosion instances on spawn
- **Instant Debris Cleanup** - Detaches transient explosion effects on appearance
- **Mute All Sounds** - Mutes every Sound in the world
- **Mute Sound Groups** - Sets every SoundGroup volume to 0
- **Mute Ambient Sounds** - Mutes ambient SoundGroups and effects from SoundService
- **Mute Character Sounds** - Mutes footsteps and other sounds inside characters
- **Anti-AFK** - Prevents the 20-minute idle disconnect
- **Force No Transparency** - Forces full opacity on every base part

---

## Fast Flags Tab

- **Fast Flags JSON Input** - Paste a JSON dictionary of fast flags to inject
- **Apply Fast Flags** - Injects the flags (requires setfflag/getfflag)
- **Failed List** - Shows a list of failed FFlags
- **Restore Prev FFlags** - Puts every flag back to what it was before Sand touched it
- **Rejoin Server** - Teleports you back to this same server (useful after applying flags)
- **Presets** - Save, load, and delete fast flag presets in the sand pile
  - Preset name / search input (fuzzy matching supported)
  - Save/Overwrite button
  - Load button
  - Delete button
  - Autoload on Game button
  - Remove Autoload button
  - Save list display
  - Autoload list display

---

## Theme Tab

- **UI Theme Dropdown** - Pick a WindUI theme (Dark / Light / etc.)
- **UI Transparency Slider** - How transparent the window is (0 = solid, 1 = fully transparent)
- **Text Cursor Input** - The cursor shown in the RNG4 typing tag (default: `_`)
- **Text Cursor 2 Input** - The cursor shown when hidden (default: two spaces)
- **Background Music Toggle** - Plays Sugary Spire OST "Results!" :p
- **Reset Appearance Button** - Resets theme, transparency, cursors and BGM

---

## Config Tab

- **Save Name / Search Input** - Type a name to save, or part of one to find it (fuzzy matching)
- **Save/Overwrite** - Saves your settings under that name (blank = auto-named from the game)
- **Load** - Fuzzy finds the best match and applies it
- **Delete** - Yeets the save forever (exact match required)
- **Delete All Saves** - Permanently deletes EVERY save (with multi-step confirmation popups)
- **Autoload on Game** - Loads that save by itself whenever you execute Sand in this game
- **Remove Autoload** - Removes the autoload for this game
- **Saves List** - Shows all your saves (fuzzy searchable)
- **Autoload List** - Shows all autoloads
- **Protect Gravel.cc** - Stops Sand's features from touching Gravel.cc's ESP, highlights, rings, helper parts and GUIs
- **Enable Everything** - Turns on every feature
- **Disable Everything** - Turns off every feature
- **Reset to Defaults** - Same as Disable Everything but also resets all sliders/inputs
- **Unload Sand.cc** - Fully unloads the script (with a cool flash effect :3)

---

## About Tab

- Sand.cc branding
- Description text
- Note that Sand.cc pairs well with **Gravel.cc**
- Copy README.md URL button
- Copy Source URL button
- Also Try Out "Gravel.cc" button
- Credits section
- Updatelog section

---

# Saves

Sand.cc stores your settings as JSON files in:

```
Sand.cc/Saves/<name>.json
```

- Saves are named (or auto-named from the game if left blank).
- Autoload runs **at startup** if `autoload` is `true` (which is the default).
- The file is a plain JSON dictionary with one entry per setting.
- Deleting the folder or file just means you lose your saved preferences.

### Appearance

Theme, transparency, cursors and music are saved separately in:

```
Sand.cc/appearance.json
```

These save by themselves (debounced 1 second after the last change) and load automatically at startup.

### Autoload Memory

Autoload mappings (which save loads for which game) are stored in:

```
Sand.cc/assets/memory.json
```

- When you set an autoload, it remembers the game name and place ID.
- If the save is deleted, the autoload is automatically cleaned up.
- The autoload list shows all your game → save mappings, with a ✓ next to the current game.

---

# Presets

Fast Flags presets are stored in:

```
Sand.cc/presets.json
```

- Presets are saved as JSON dictionaries of fast flags.
- Fuzzy search is supported (typos are fine :v).
- Presets can be saved, loaded, deleted, and set to autoload from the Fast Flags tab.
- Preset autoloads are stored in:

```
Sand.cc/assets/preset_autoload.json
```

---

# Public API

When loaded, Sand.cc exposes a table via `getgenv().__SandCC` (and also returns it):

```lua
local SandCC = getgenv().__SandCC

SandCC.State            -- live table of every setting value
SandCC.set(key, value)  -- set a setting and sync the UI
SandCC.save(name)       -- save settings under that name
SandCC.load(name)       -- load a save by name (fuzzy)
SandCC.deleteSave(name) -- delete a save by name (exact)
SandCC.listSaves()      -- returns a table of all save names
SandCC.setAutoload(name)-- set that save to autoload for this game
SandCC.removeAutoload() -- remove the autoload for this game
SandCC.gravelLoaded()   -- returns true if Gravel.cc is loaded
SandCC.enableAll()      -- turn on every feature
SandCC.disableAll()     -- turn off every feature
SandCC.unload()         -- fully unload Sand.cc
SandCC.PolyWindow       -- the WindUI window object (if one was created)
```

---

# Quick Notes

- It's pairable with **Gravel.cc** (Protect Gravel.cc toggle is on by default).
- Some features hook `__namecall` (like Throttle Remote Events).. those can break gameplay.
- Some features are hidden behind `sethiddenproperty` (like Remove Grass) and will fall back gracefully.
- FPS Counter / Ping Counter use `Stats.Network.ServerStatsItem` and won't error on executors that block it.
- Saves use a **JSON dictionary** format so they're easy to read and edit.
- Fast Flags require `setfflag`/`getfflag` and most require a rejoin to take effect.
- Background music is downloaded and cached in `Sand.cc/assets/Music/RESULTS.mp3`.
- Gravel.cc protection can be toggled off if you want Sand to optimize Gravel's ESP/parts too.

---

**Sand.cc:**

<details>
  <summary>Active Tabs</summary>

  1. Visuals
  2. Textures & FX
  3. Performance
  4. Workspace
  5. Network & UI
  6. Fast Flags
  7. Theme
  8. Config
  9. About
</details>

<details>
  <summary>Files</summary>

  >Executor Workspace - your injector's workspace :p
  
  V
  
  >Sand.cc - stores saves, presets and assets here!
  
  V
  
  >Saves/<name>.json - your named saves live here
  
  V
  
  >appearance.json - theme, transparency, cursors and BGM saved here
  
  V
  
  >presets.json - your fast flag presets live here
  
  V
  
  >assets/memory.json - autoload mappings (game → save)
  
  V
  
  >assets/preset_autoload.json - fast flag preset autoloads
  
  V
  
  >assets/Music/RESULTS.mp3 - background music cache
</details>

---

***Gpssickle:***

<details>
  <summary>Links</summary>

  1. [YouTube; Main Channel](https://youtube.com/@gpssickle?si=9bBIhhY7-nt2Ot7J)
  2. [YouTube; Second Channel](https://www.youtube.com/@gpszickle)
  3. [RScripts](rscripts.net/@Gpssickle)
  4. [Scriptblox](https://scriptblox.com/u/Gpssickle)
  5. [Roblox](https://www.roblox.com/users/8517361356/profile)
</details>

---

<p align="center">
  <i>"type sheet"</i><br>
  ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ- Gpssickle
</p>
