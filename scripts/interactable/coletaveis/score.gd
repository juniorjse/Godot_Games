extends Label

func _process(_delta) -> void:
	var score = DataManagement.score  # Obtenha o valor do score

	# Verifique se o score é negativo e corrija se necessário
	if score < 0:
		DataManagement.score = 0  # Defina o score como zero na fonte de dados

	text = str(DataManagement.score)  # Converta o score em uma string e atribua à variável 'text'
