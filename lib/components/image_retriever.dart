import 'package:atipico_game/components/game_session.dart';
import 'package:atipico_game/components/image_generator.dart';
import 'package:flutter/material.dart';

class ImageRetriever {
  static Map<String, Image> fornecerImagens() {
    int dificuldadeJogo = GameSession.dificuldade;

    return ImageGenerator.gerarImagens(dificuldadeJogo);

  }
}
