extends CanvasLayer

@onready var label = $Control/Label

var coin_amount: int = 0

func _ready():
	var coins: Array = get_tree().get_nodes_in_group("coins")
	for coin in coins:
		coin.coin_collected.connect(_on_coin_collected)

func _on_coin_collected():
	coin_amount += 1
	label.text = str(coin_amount)
	
