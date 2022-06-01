import 'dart:math';

import 'package:atipico_game/components/image_asset_data_model.dart';
import 'package:atipico_game/components/image_asset_library.dart';
import 'package:flutter/material.dart';

class ImageGenerator {
  // Atributo que define o modo de geração das imagens por parte do Image Generator. Valores possíveis: "asset", "procedural" e "mixed". Por enquanto, apenas o parâmetro "asset" é suportado. Futuras versões do jogo poderão fornecer a capacidade de geração procedural das imagens.
  static const String _imageGenerationMode = "asset";

  static Map<String, Image> gerarImagens(int dificuldade) {
    switch (_imageGenerationMode) {
      case "asset":
        return generateImagesFromAsset(dificuldade);
      default:
        return generateImagesFromAsset(dificuldade);
    }
  }

  static Map<String, Image> generateImagesFromAsset(int dificuldade) {
    final Map<int, ImageAssetData> imageAssetListRetrieved =
        ImageAssetLibrary.imageAssetList;

    List<ImageAssetData> filteredImages = <ImageAssetData>[];
    int contadorDificuldade = dificuldade;

    //  Fallback: se não econtrar uma imagem correspondente à dificuldade selecionada, procurar nas dificuldades inferiores, até encontrar uma imagem. Deve existir pelo menos uma imagem.
    do {
      filteredImages = imageAssetListRetrieved.values
          .where((ImageAssetData element) =>
              element.niveisDificuldade.contains(contadorDificuldade))
          .toList();

      contadorDificuldade--;
    } while (filteredImages.isEmpty && contadorDificuldade > 0);

    //  Obter um index aleatório, para selecionar imagens da lista
    final int randomElementIndex = Random().nextInt(filteredImages.length);

    // Selecionar uma imagem aleatória da lista filtrada, com base no índice aleatório anteriomente obtido
    final ImageAssetData imagemSelecionada = filteredImages[randomElementIndex];

    //  Gerar as imagens a ser retornadas com base na imagemSelecionada
    final Image imagemAssetRetornadaPadrao =
        Image.asset(imagemSelecionada.diretorioImgPrincipal);
    final Image imagemAssetRetornadaAlt =
        Image.asset(imagemSelecionada.diretorioImgAlt);

    return {
      "imagemPadrao": imagemAssetRetornadaPadrao,
      "imagemAlt": imagemAssetRetornadaAlt,
    };
  }
}
