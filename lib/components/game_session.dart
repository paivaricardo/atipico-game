// ignore_for_file: unnecessary_getters_setters

import 'dart:math';

class GameSession {
  static int _maxScore = 0;

  static int get maxScore => _maxScore;

  static set maxScore(int value) {
    if (_maxScore < value) {
      _maxScore = value;
    }
  }

  static int score = 0;

  static int _dificuldade = 1;

  static int get dificuldade => _dificuldade;

  static set dificuldade(int value) {
    _dificuldade = value;

    if (_dificuldade < 0) {
      _dificuldade = 0;
    } else if (_dificuldade > 9) {
      _dificuldade = 9;
    }
  }

  static int tentativasRestantes = 3;

  static void reset () {
    score = 0;
    _dificuldade = 1;
    tentativasRestantes = 3;
  }

  // Função que fornece as dimensões para matriz para a seleção das imagens, de acordo com a dificuldade atual do jogo. Parâmetro fornecido em forma de lista List<int>, sendo que o índice 0 corresponde ao número de linhas, e o índice 1 corresponde ao número de colunas. Por enquanto, o jogo trabalha com matrizes quadradas
  static List<int> fornecerDimensoesMatriz() {
    if (dificuldade >= 1 && dificuldade <= 3) {
      return [3, 3];
    } else if (dificuldade >= 4 && dificuldade <= 7) {
      return [4, 4];
    } else {
      return [5, 5];
    }
  }

  // Função que fornece aleatoriamente a posição da imagem alternativa do jogo, a que deve ser selecionada pelo jogador. Parâmetro fornecido em forma de lista List<int>, sendo que o índice 0 corresponde ao número da linha em que se encontra a imagem alternativa, e o índice 1 corresponde ao número da coluna.
  static List<int> fornecerPosImgAlt() {
    List<int> dimensoesMatriz = fornecerDimensoesMatriz();

  //  Agora, buscar um número aleatório variando entre 1 e a dimensão máxima da matriz
    int posicaoLinha = Random().nextInt(dimensoesMatriz[0]) + 1;
    int posicaoColuna = Random().nextInt(dimensoesMatriz[1]) + 1;

    return [posicaoLinha, posicaoColuna];

  }
}
