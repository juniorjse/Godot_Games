# Sea Pirate Adventures

## Descrição
**Sea Pirate Adventures** é um jogo de ação e aventura onde o jogador assume o papel de um pirata explorador, enfrentando desafios em alto mar, ilhas perigosas e inimigos formidáveis. O jogo apresenta uma narrativa envolvente com cutscenes, múltiplas ilhas para explorar, inimigos variados e combates navais. O desenvolvimento foi realizado utilizando a engine Godot, com base em conceitos aprendidos em um curso introdutório, expandindo-os para criar mecânicas mais complexas.

## Funcionalidades Principais
- **Narrativa e Cutscenes**: Trama rica, com cutscenes interativas e diálogos envolventes.
- **Design de Níveis**: Ilhas variadas com desafios, armadilhas e inimigos únicos.
- **Transições de Cena com Efeitos Parallax**: Transições dinâmicas entre fases, com um efeito visual imersivo.
- **Interações Ambientais**: Elementos como palmeiras e barris se tornam interativos, proporcionando novas mecânicas.
- **Inimigos Inteligentes**: Inimigos detectam, perseguem e atacam o jogador com base na mecânica de detecção `DetectionArea`.
- **Combates Navais**: Enfrentamentos com inimigos que utilizam táticas marítimas e armas à distância.

## Implementação Técnica

### Engine Utilizada: Godot
O jogo foi desenvolvido na engine **Godot** e utiliza a linguagem **GDScript** para a programação. A organização hierárquica do jogo é feita por meio de nós e cenas, facilitando a construção e o gerenciamento dos elementos do jogo.

### Pacotes de Assets Utilizados
- **Kings and Pigs**
- **Pirate Bomb**
- **Treasure Hunters**

### Pacotes de Fontes
- **PressStart2P**: Utilizada nos diálogos das cutscenes.
- **ThaleahFat**: Utilizada para o score do jogador.
- **BitPotion**: Utilizada na cena de fim de jogo.

### Efeitos Sonoros
A trilha sonora e os efeitos sonoros foram gerados utilizando **MusicGen**, permitindo a criação de uma atmosfera sonora única e personalizada para o jogo.

### Interface do Jogo
- **Menu Principal**: O jogador pode iniciar uma nova aventura, continuar um jogo salvo ou sair do jogo.
- **Sistema de Salvamento**: O jogo verifica automaticamente a existência de um arquivo salvo e habilita a opção "Continuar" quando detectado.

## Mecânicas Avançadas

### Detecção de Inimigos
A classe `DetectionArea` permite que os inimigos detectem o jogador ao entrar em uma área de colisão. Quando detectado, o inimigo persegue o jogador até que ele saia da área.

### Interação com o Ambiente
- **Palmeiras e Barris**: Elementos interativos que impulsionam o jogador ao saltar sobre eles, abrindo novas estratégias e desafios.

### Desafios
- **Inimigos com Ataques à Distância**: Porcos inimigos utilizam canhões para atacar à distância.
- **Baleia Gigante**: Um inimigo com ataques fatais, exigindo que o jogador se esquive e o ataque no momento certo.

## Como Jogar
1. **Baixe o APK**: Instale o jogo em seu dispositivo Android.
2. **Inicie o Jogo**: Selecione "Nova Aventura" ou "Continuar" no menu inicial.
3. **Exploração**: Navegue pelas ilhas, enfrente inimigos e supere armadilhas para avançar na história.
