---@diagnostic disable: unused-local
---@meta

---@class action
---@field action fun(recursion: integer?, iter: integer?): iteration: integer?
---@field id string
---@field name string
---@field description string
---@field sprite string
---@field type integer
---@field recursive boolean?
---@field spawn_level string
---@field spawn_probability string
---@field spawn_requires_flag string?
---@field spawn_manual_unlock boolean?
---@field max_uses integer?
---@field custom_xml_file string?
---@field ai_never_uses boolean?
---@field never_unlimited boolean?
---@field is_dangerous_blast boolean?
---@field sound_loop_tag string?
---@field mana number?
---@field sprite_unidentified string?
---@field deck_index integer?
---@field uses_remaining integer?

---@class (exact) shot_ref
---@field state state
---@field num_of_cards_to_draw integer

---@class state
---@field action_id string
---@field action_name string
---@field action_description string
---@field action_sprite_filename string
---@field action_unidentified_sprite_filename string
---@field action_type integer
---@field action_spawn_level string
---@field action_spawn_probability string
---@field action_spawn_requires_flag string
---@field action_spawn_manual_unlock boolean
---@field action_max_uses integer
---@field custom_xml_file string
---@field action_mana_drain integer
---@field action_is_dangerous_blast boolean
---@field action_draw_many_count integer
---@field action_ai_never_uses boolean
---@field action_never_unlimited boolean
---@field state_shuffled boolean
---@field state_cards_drawn number
---@field state_discarded_action boolean
---@field state_destroyed_action boolean
---@field fire_rate_wait integer
---@field speed_multiplier number
---@field child_speed_multiplier number
---@field dampening number
---@field explosion_radius number
---@field spread_degrees number
---@field pattern_degrees integer
---@field screenshake number
---@field recoil number
---@field damage_melee_add number
---@field damage_projectile_add number
---@field damage_electricity_add number
---@field damage_fire_add number
---@field damage_explosion_add number
---@field damage_ice_add number
---@field damage_slice_add number
---@field damage_healing_add number
---@field damage_curse_add number
---@field damage_drill_add number
---@field damage_null_all number
---@field damage_critical_chance integer
---@field damage_critical_multiplier number
---@field explosion_damage_to_materials integer
---@field knockback_force number
---@field reload_time integer
---@field lightning_count integer
---@field material string
---@field material_amount integer
---@field trail_material string
---@field trail_material_amount integer
---@field bounces integer
---@field gravity number
---@field light number
---@field blood_count_multiplier number
---@field gore_particles number
---@field ragdoll_fx ragdoll_fx
---@field friendly_fire boolean
---@field physics_impulse_coeff number
---@field lifetime_add integer
---@field sprite string
---@field extra_entities string
---@field game_effect_entities string
---@field sound_loop_tag string
---@field projectile_file string

---@class (exact) shot_effects
---@field recoil_knockback number

ACTION_TYPE_PROJECTILE = 0
ACTION_TYPE_STATIC_PROJECTILE = 1
ACTION_TYPE_MODIFIER = 2
ACTION_TYPE_DRAW_MANY = 3
ACTION_TYPE_MATERIAL = 4
ACTION_TYPE_OTHER = 5
ACTION_TYPE_UTILITY = 6
ACTION_TYPE_PASSIVE = 7

---@type action[]
actions = {}
---@type table<string, fun()>
extra_modifiers = {}

ACTION_DRAW_RELOAD_TIME_INCREASE = 0
ACTION_MANA_DRAIN_DEFAULT = 10
ACTION_UNIDENTIFIED_SPRITE_DEFAULT = "data/ui_gfx/gun_actions/unidentified.png"

reflecting = false
---@type action?
current_action = nil

first_shot = true
reloading = false
start_reload = false
got_projectiles = false

state_from_game = nil

---@type action[]
discarded = {}

---@type action[]
deck = {}

---@type action[]
hand = {}

---@type state
c = {}
current_projectile = nil
current_reload_time = 0

---@type shot_effects
shot_effects = {}

---@type string[]
active_extra_modifiers = {}

mana = 0.0

state_shuffled = false
state_cards_drawn = 0
state_discarded_action = false
state_destroyed_action = false

playing_permanent_card = false

use_game_log = false

---@class gun
---@field reload_time integer

---@type gun
---@diagnostic disable-next-line: missing-fields
gun = {}
---@type integer
current_reload_time = gun.reload_time

-- Setup additional card-related variables

dont_draw_actions = false
force_stop_draws = false
shot_structure = {}
recursion_limit = 2

-- action effect reflection stuff

---@param state state
function reset_modifiers(state) end

---@param state state
function register_action(state) end

---@param effects state
function register_gunshoteffects(effects) end

---call this when current action changes
---@param action action
function set_current_action(action) end

---@param source action
---@param target action
function clone_action(source, target) end

---@param text string
function debug_print(text) end

---@param t action[]
function debug_print_action_table(t) end

function debug_print_deck() end
function debug_print_discarded() end
function debug_print_hand() end

-- various utilities

---@param num_of_cards_to_draw integer
---@return shot_ref
function create_shot(num_of_cards_to_draw) end

---@param shot shot_ref
---@param instant_reload_if_empty boolean
function draw_shot(shot, instant_reload_if_empty) end

--- helper functions. actions may call these ---

function order_deck() end

---@param action action
function play_action(action) end

---@param instant_reload_if_empty boolean
---@return boolean
function draw_action(instant_reload_if_empty) end

---@param action action
function handle_mana_addition(action) end

---@param how_many integer
---@param instant_reload_if_empty boolean
function draw_actions(how_many, instant_reload_if_empty) end

---@param entity_filename string
function add_projectile(entity_filename) end

---@param entity_filename string
---@param delay_frames integer
---@param action_draw_count integer
function add_projectile_trigger_timer(entity_filename, delay_frames, action_draw_count) end

---@param entity_filename string
---@param action_draw_count integer
function add_projectile_trigger_hit_world(entity_filename, action_draw_count) end

---@param entity_filename string
---@param action_draw_count integer
function add_projectile_trigger_death(entity_filename, action_draw_count) end

---@param name string
function baab_instruction(name) end

function move_discarded_to_deck() end

function move_hand_to_discarded() end

---@param data action
---@param rec_ integer
---@return integer
function check_recursion(data, rec_) end

--- exported functions. called by the C++ code -------------------------------------

---@type shot_ref?
root_shot = nil

---@param current_mana number
function _start_shot(current_mana) end

---@param can_reload_at_end boolean
function _draw_actions_for_shot(can_reload_at_end) end

---@return number
function _handle_reload() end

function _set_gun() end

function _set_gun2() end

---this can be used to build a new deck
---@param use_game_log_ boolean
function _clear_deck(use_game_log_) end

---this can be used to build a new deck
---@param action_id string
---@param inventoryitem_id integer
---@param uses_remaining integer
---@param is_identified boolean
function _add_card_to_deck(action_id, inventoryitem_id, uses_remaining, is_identified) end

---@param action_id string
function _play_permanent_card(action_id) end

---@param inventoryitem_id integer
---@param uses_remaining integer
function _change_action_uses_remaining(inventoryitem_id, uses_remaining) end

---@param name string
function _add_extra_modifier_to_shot(name) end

-- slot durabilities (in shots). -1 means infinite --

---@param current_slot_count integer
---@return integer
function _get_gun_slot_durability_default(current_slot_count) end

---@param current_slot_count any
---@return integer
function _get_gun_slot_durability_infinite(current_slot_count) end

function ConfigGunActionInfo_ReadToLua(
	action_id,
	action_name,
	action_description,
	action_sprite_filename,
	action_unidentified_sprite_filename,
	action_type,
	action_spawn_level,
	action_spawn_probability,
	action_spawn_requires_flag,
	action_spawn_manual_unlock,
	action_max_uses,
	custom_xml_file,
	action_mana_drain,
	action_is_dangerous_blast,
	action_draw_many_count,
	action_ai_never_uses,
	action_never_unlimited,
	state_shuffled,
	state_cards_drawn,
	state_discarded_action,
	state_destroyed_action,
	fire_rate_wait,
	speed_multiplier,
	child_speed_multiplier,
	dampening,
	explosion_radius,
	spread_degrees,
	pattern_degrees,
	screenshake,
	recoil,
	damage_melee_add,
	damage_projectile_add,
	damage_electricity_add,
	damage_fire_add,
	damage_explosion_add,
	damage_ice_add,
	damage_slice_add,
	damage_healing_add,
	damage_curse_add,
	damage_drill_add,
	damage_null_all,
	damage_critical_chance,
	damage_critical_multiplier,
	explosion_damage_to_materials,
	knockback_force,
	reload_time,
	lightning_count,
	material,
	material_amount,
	trail_material,
	trail_material_amount,
	bounces,
	gravity,
	light,
	blood_count_multiplier,
	gore_particles,
	ragdoll_fx,
	friendly_fire,
	physics_impulse_coeff,
	lifetime_add,
	sprite,
	extra_entities,
	game_effect_entities,
	sound_loop_tag,
	projectile_file
)
end

function ConfigGun_ReadToLua( actions_per_round, shuffle_deck_when_empty, reload_time, deck_capacity) end
