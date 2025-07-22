---@diagnostic disable: name-style-check
---@meta director_helpers

---@class biome_entity
---@field prob number weight of this entity
---@field min_count number minimum count to spawn
---@field max_count number maximum count to spawn
---@field entity? string entity string to load
---@field entities? table<number, string | biome_entity_sub> a table of entity strings
---@field spawn_check? fun():boolean custom function to run for spawn requirement
---@field parallel? boolean requires parallel world to spawn
---@field ngpluslevel? number required ng+ level to spawn
---@field offset_y? number offset y to add
---@field offset_x? number offset x to add

---@class biome_entity_sub
---@field min_count? number minimum count to spawn
---@field max_count? number maximum count to spawn
---@field offset_y? number offset y to add
---@field offset_x? number offset x to add
---@field entity string entity string to load

---@class biome_entities
---@field total_prob number calculates total probability if 0, probably should be 0
---@field [number] biome_entity

---@class biome_pixelscene
---@field prob number weight of this scene
---@field material_file string path to pixelscene material file
---@field visual_file? string path to pixelscene visual file
---@field background_file? string path to pixelscene background file
---@field is_unique? number if this is `1` - will only load once, not persistent - resets on restart
---@field color_material? {string:string | string[]} a material table, defined like ["hex_color"] = "material" or ["hex_color"] = { "material1", "material2" }
---@field z_index? number z index of background, defaults to 50

---@class biome_pixelscenes
---@field total_prob number calculates total probability if 0, probably should be 0
---@field [number] biome_pixelscene

---@class biome_pixelscene_background
---@field prob number weight of this background
---@field sprite_file string a path to background
---@field z_index? number z index of this background, defaults to 40

---@class biome_pixelscene_backgrounds
---@field total_prob number calculates total probability if 0, probably should be 0
---@field [number] biome_pixelscene_background

---Initializes total probability for this biome entities
---
---Defined in `data/scripts/director_helpers.lua`
---@private
---@param value biome_entities | biome_pixelscenes | biome_pixelscene_backgrounds
---@param x number
function init_total_prob(value, x) end

---Picks random valid entry from biome entities
---
---Defined in `data/scripts/director_helpers.lua`
---@private
---@param what biome_entities
---@param x number
---@param y number
---@return biome_entity?
---@nodiscard
function random_from_table(what, x, y) end

---Loads an entity from biome entity data
---
---Defined in `data/scripts/director_helpers.lua`
---@private
---@param entity_data biome_entity
---@param x number x position to spawn
---@param y number y position to spawn
---@param rand_x? number x offset to spawn, defaults to 4
---@param rand_y? number y offset to spawn, default to 4
---@return number number returns 0 if fail and 1 if success (for some reason)
function entity_load_camera_bound(entity_data, x, y, rand_x, rand_y) end

---Loads `data/entities/items/pickup/heart.xml` (yes, literally just loads a heart)
---
---Defined in `data/scripts/director_helpers.lua`
---@param x number
---@param y number
function entity_load_stash(x, y) end

---Loads a random entity from biome entities table, adds +5 to x and y
---
---Defined in `data/scripts/director_helpers.lua`
---@param what biome_entities biome entities table
---@param x number x position to spawn, the function adds +5
---@param y number y position to spawn, the function adds +5
---@param rand_x? any x offset to load, defaults to 4
---@param rand_y? any y offset to load, defaults to 4
function spawn(what, x, y, rand_x, rand_y) end

---Loads a random entity from biome entities table, DOESN'T add +5 to x and y
---
---Defined in `data/scripts/director_helpers.lua`
---@param what biome_entities biome entities table
---@param x number x position to spawn
---@param y number y position to spawn
---@param rand_x? any x offset to load, defaults to 4
---@param rand_y? any y offset to load, defaults to 4
function spawn2(what, x, y, rand_x, rand_y) end

---Spawns everything in biome entities table
---
---Defined in `data/scripts/director_helpers.lua`
---@param what biome_entities biome entities table
---@param x number x position to spawn
---@param y number y position to spawn
---@param width number adds this number for every new spawn
function DEBUG_spawn_all(what, x, y, width) end

---Loads a random pixel scene from biome_pixelscenes
---
---Defined in `data/scripts/director_helpers.lua`
---@param what biome_pixelscenes biome pixelscenes to choose from
---@param x number x position
---@param y number y position
function load_random_pixel_scene(what, x, y) end

---Loads a random background from biome_pixelscene_backgrounds
---
---Defined in `data/scripts/director_helpers.lua`
---@param what biome_pixelscene_backgrounds biome backgrounds to choose from
---@param x number x position
---@param y number y position
function load_random_background_sprite(what, x, y) end

---An **awful** function that checks if the spawning entity is specified in entitities_to_randomize using scary string comparisons, and adds +4 to rand_x if it was found (cool, right?)
---
---Defined in `data/scripts/director_helpers.lua`
---@param what biome_entities biome entities table
---@param x number position x
---@param y number position y
---@param rand_x? number x offset to randomize, defaults to 0
---@param rand_y? number y offset to randomize, defaults to 0
---@param entities_to_randomize? string[]
function spawn_with_limited_random(what, x, y, rand_x, rand_y, entities_to_randomize) end

---Another vanilla centric function, does the same as `spawn` but with multiplied hp, only used in dragoncave, but it's not functional there since there are no enemies
---
---Defined in `data/scripts/director_helpers_design.lua`
---@private
---@deprecated
---@param what biome_entities biome entities table
---@param x number x position to spawn, the function adds +5
---@param y number y position to spawn, the function adds +5
---@param rand_x any x offset to load, defaults to 4
---@param rand_y any y offset to load, defaults to 4
---@param hp_multiplier number
---@param biome string
function spawn_hp_mult(what, x, y, rand_x, rand_y, hp_multiplier, biome) end

---Generates spell items to sell
---
---Defined in `data/scripts/items/generate_shop_item.lua`
---@param x number x position
---@param y number y position
---@param cheap_item? boolean is this item for sale? cost * 0.5
---@param biomeid_? number spell level, should be between 1 to 7 or 10, will calculate depending on the depth if not specified
---@param is_stealable? boolean is this item stealable
---@return entity_id spell_entity
function generate_shop_item(x, y, cheap_item, biomeid_, is_stealable) end

---Generates wand items to sell
---
---Defined in `data/scripts/items/generate_shop_item.lua`
---@param x number x position
---@param y number y position
---@param cheap_item? boolean is this item for sale?
---@param biomeid_? number wand level, between 1 to 6 (automatically clamped)
---@return entity_id wand_entity
function generate_shop_wand(x, y, cheap_item, biomeid_) end

---Spawns heart or chest, a default function for goodies
---
---Defined in `data/scripts/biome_scripts.lua`
---@param x number x position
---@param y number y position
function spawn_heart(x, y) end
