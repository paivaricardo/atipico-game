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
  };
}
