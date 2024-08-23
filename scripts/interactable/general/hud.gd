extends CanvasLayer

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
