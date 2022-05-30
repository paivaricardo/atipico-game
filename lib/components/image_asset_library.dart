import 'package:atipico_game/components/image_asset_data_model.dart';

class ImageAssetLibrary {
  static Map<int, ImageAssetData> imageAssetList = {
    1: ImageAssetData(
      niveisDificuldade: [1, 2, 3],
      diretorioImgPrincipal: "assets/game_img/level_1/false_horse.png",
      diretorioImgAlt: "assets/game_img/level_1/true_horse.png",
    ),
    2: ImageAssetData(
      niveisDificuldade: [1, 2, 3],
      diretorioImgPrincipal: "assets/game_img/level_1/robot_false.png",
      diretorioImgAlt: "assets/game_img/level_1/robot_true.png",
    ),
    3: ImageAssetData(
      niveisDificuldade: [1, 2, 3],
      diretorioImgPrincipal: "assets/game_img/level_1/alien_true.png",
      diretorioImgAlt: "assets/game_img/level_1/alien_false.png",
    ),
    4: ImageAssetData(
      niveisDificuldade: [1, 2, 3],
      diretorioImgPrincipal: "assets/game_img/level_1/bee_true.png",
      diretorioImgAlt: "assets/game_img/level_1/bee_false.png",
    ),
    5: ImageAssetData(
      niveisDificuldade: [1, 2, 3],
      diretorioImgPrincipal: "assets/game_img/level_1/snail_true.png",
      diretorioImgAlt: "assets/game_img/level_1/snail_false.png",
    ),
    6: ImageAssetData(
      niveisDificuldade: [1, 2, 3],
      diretorioImgPrincipal: "assets/game_img/level_1/slug_true.png",
      diretorioImgAlt: "assets/game_img/level_1/slug_false.png",
    ),
  };
}
