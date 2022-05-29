# GameSession class

Essa classe controla a sessão jogo, por meio de seus atributos estáticos.

Funciona como um gerenciamento de estados rudimentar.

## Níveis de dificuldade

`static int dificuldade`

Na classe GameSession está armazenado um atributo INTEIRO contendo o nível de dificuldade do jogo, variando de 1 - 9, de acordo com o seguinte esquema:

- 1-3: fácil
- 4-6: médio
- 7-9: difícil

A cada rodada bem-sucedida, a dificuldade aumentará em um ponto, até chegar ao nível máximo (difícil), ocasião em que a dificuldade se manterá no nível difícil, até o final do jogo (quando o jogador errar).

O tamanho das matrizes para a seleção das imagens variará de acordo com o nível de dificuldade, de acordo com o seguinte esquema:

- 1-3: 3 x 3
- 4-6: 4 x 4
- 7-9: 5 x 5