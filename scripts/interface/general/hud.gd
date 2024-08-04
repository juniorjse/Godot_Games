extends CanvasLayer

#onready var equipment_container: Control = get_node("EquipmentContainer")
#onready var inventory_container: Control = get_node("InventoryContainer")
#onready var stats_container: Control = get_node("StatsContainer")
onready var bar_container: Control = get_node("BarContainer")

var can_show_container: bool = true

export(PackedScene) var dice_scene
export(PackedScene) var dialog_container
export(PackedScene) var shopping_container
export(PackedScene) var sell_shopping_container
func _ready():
	$faixa_preta.visible = false
func spawn_dialog(interactable, dialog_dict: Dictionary) -> void:
	var dialog = dialog_container.instance()
	var _finished: bool = dialog.connect("finished", interactable, "on_dialog_finished")
	dialog.dialog_list = dialog_dict
	hide_containers()
	add_child(dialog)
	
	
func spawn_shop(interactable, shop_dict: Dictionary) -> void:
	var shop: ShoppingContainer = shopping_container.instance()
	var _closed: bool = shop.connect("closed", interactable, "on_shop_closed")
	shop.shop_list = shop_dict
	add_child(shop)
	
	
func spawn_sell_shop(interactable) -> void:
	var sell_shop: SellContainer = sell_shopping_container.instance()
	var _closed: bool = sell_shop.connect("closed", interactable, "on_shop_closed")
	add_child(sell_shop)
	
	
func spawn_dice(enemy) -> void:
	var dice: Dice = dice_scene.instance()
	var _finished: bool = dice.connect("finished", enemy, "get_dice_value")
	add_child(dice)
	
	
#func _process(_delta: float) -> void:
#	if can_show_container:
##		show_inventory()
#		show_stats()
		
		
#func show_inventory() -> void:
#	if Input.is_action_just_pressed("inventory"):
##		hide_equipment_container()
#
#		inventory_container.is_visible = !inventory_container.is_visible
#		if inventory_container.is_visible:
#			inventory_container.animation.play("show_container")
#		else:
#			inventory_container.reset()
#			inventory_container.animation.play("hide_container")
##			equipment_container.animation.play("show_container")
#
#		if stats_container.is_visible:
#			stats_container.reset()
#			stats_container.is_visible = false
#			stats_container.animation.play("hide_container")
			
			
#func show_stats() -> void:
#	if Input.is_action_just_pressed("stats"):
##		hide_equipment_container()
#
#		stats_container.is_visible = !stats_container.is_visible
#		if stats_container.is_visible:
#			stats_container.animation.play("show_container")
#		else:
#			stats_container.reset()
#			stats_container.animation.play("hide_container")
##			equipment_container.animation.play("show_container")
#
#		if inventory_container.is_visible:
#			inventory_container.reset()
#			inventory_container.is_visible = false
#			inventory_container.animation.play("hide_container")
			
			
func hide_containers() -> void:
	
	$BarContainer.visible = false
	$score.visible = false
	$faixa_preta.visible = true
			
			
func normal_state() -> void:
	
	$BarContainer.visible = true
	$score.visible = true
	can_show_container = true
	bar_container.animation.play("show_container")
	$faixa_preta.visible = false
#	equipment_container.animation.play("show_container")
	
	
#func hide_equipment_container() -> void:
#	equipment_container.animation.play("hide_container")
