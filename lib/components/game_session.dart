class GameSession {

  static int tempMaxScore = 0;
  static int dificuldade = 1;

  static Map<String, int> fornecer_dimensoes_matriz() {
    if (dificuldade > 1 && dificuldade <= 3) {
      return {"linhas" : 3, "colunas" : 3};
    } else if (dificuldade >= 4 && dificuldade <= 7) {
      return {"linhas" : 4, "colunas" : 4};
    } else {
      return {"linhas" : 4, "colunas" : 4};
    }
  }

}