extends EnemyTemplate
class_name Whale

func _ready() -> void:
	randomize()
	drop_list = {
		"Heal Potion": [
			"res://assets/items/consumable/health_potion.png", #Image Path Type
			20,                                               #Drop Probability
			"Health",                                         #Type
			5,                                                #Value
			2                                                 #Sell Price
		], 
		
		"Mana Potion": [
			"res://assets/items/consumable/mana_potion.png", 
			15, 
			"Mana", 
			5, 
			5
		],
		
		"Whale Mouth": [
			"res://assets/items/resource/whale/whale_mouth.png",
			45,
			"Resource",
			{},
			2
		],
		
		"Whale Eye": [
			"res://assets/items/resource/whale/whale_eye.png",
			15,
			"Resource",
			{},
			6
		],
		
		"Whale Tail": [
			"res://assets/items/resource/whale/whale_tail.png",
			3, 
			"Resource",
			{},
			25
		],
		
		"Whale Mask": [
			"res://assets/items/equipment/whale_mask.png",
			3, 
			"Equipment",
			{
				"Mana": 5,
				"Magic Attack": 3
			},
			30
		]
	}
