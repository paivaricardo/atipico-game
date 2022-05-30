import 'package:atipico_game/components/game_session.dart';
import 'package:atipico_game/components/gradient_text.dart';
import 'package:atipico_game/components/image_retriever.dart';
import 'package:atipico_game/screens/game_over_screen.dart';
import 'package:flutter/material.dart';

class TelaJogoScreen extends StatefulWidget {
  const TelaJogoScreen({Key? key}) : super(key: key);

  @override
  State<TelaJogoScreen> createState() => _TelaJogoScreenState();
}

class _TelaJogoScreenState extends State<TelaJogoScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int dificuldadeSessaoJogo = GameSession.dificuldade;
    List<int> dimensoesMatriz = GameSession.fornecerDimensoesMatriz();
    List<int> localImagemAlt = GameSession.fornecerPosImgAlt();

    // DEBUG
    print("Dificuldade: " + dificuldadeSessaoJogo.toString());
    print("dimensoesMatriz: " + dimensoesMatriz.toString());
    print("localImagemAlt: " + localImagemAlt.toString());

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: screenWidth,
            child: Image.asset(
              'assets/img/fundo_atpc.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: GradientText(
              'Selecione a imagem... Atípica!',
              style: TextStyle(fontFamily: 'Lobster', fontSize: 28.0),
              gradient: RadialGradient(colors: <Color>[
                Color(0xfffed400),
                Color(0xffff9900),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: generateImageMatrix(
              dificuldadeSessaoJogo,
              dimensoesMatriz,
              localImagemAlt,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 128.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Score: ' + GameSession.score.toString(),
                style: TextStyle(
                    fontFamily: 'Farro',
                    color: Colors.amberAccent,
                    fontSize: 32.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  generateImageMatrix(
    int dificuldadeSessaoJogo,
    List<int> dimensoesMatriz,
    List<int> localImagemAlt,
  ) {
    Map<String, Image> imagensFornecidas = ImageRetriever.fornecerImagens();

    Image imagemPadrao = imagensFornecidas["imagemPadrao"]!;
    Image imagemAlt = imagensFornecidas["imagemAlt"]!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: dimensoesMatriz[0] * dimensoesMatriz[1],
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: dimensoesMatriz[1]),
        itemBuilder: (_, int index) {
          if (index + 1 ==
              (((localImagemAlt[0] - 1) * dimensoesMatriz[1]) +
                  localImagemAlt[1])) {
            return InkWell(
              onTap: () {
                setState(() {
                  GameSession.dificuldade++;
                  GameSession.score += GameSession.dificuldade * 10;

                  dificuldadeSessaoJogo = GameSession.dificuldade;
                  dimensoesMatriz = GameSession.fornecerDimensoesMatriz();
                  localImagemAlt = GameSession.fornecerPosImgAlt();

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(milliseconds: 400),
                    content: GradientText(
                      'Acertou!',
                      style: TextStyle(fontFamily: 'Lobster', fontSize: 24.0),
                      gradient: RadialGradient(colors: <Color>[
                        Color(0xfffed400),
                        Color(0xffff9900),
                      ]),
                    ),
                  ));
                });
              },
              child: Container(
                child: imagemAlt,
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                GameSession.tentativasRestantes--;

                if (GameSession.tentativasRestantes == 0) {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameOverScreen()));
                } else {
                  setState(() {
                    dificuldadeSessaoJogo = GameSession.dificuldade;
                    dimensoesMatriz = GameSession.fornecerDimensoesMatriz();
                    localImagemAlt = GameSession.fornecerPosImgAlt();

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 400),
                      // backgroundColor: Color(),
                      content: GradientText(
                        () {
                          if (GameSession.tentativasRestantes == 1) {
                            return 'Errou... resta apenas ' +
                                GameSession.tentativasRestantes.toString() +
                                ' tentativa. Cuidado!';
                          } else {
                            return 'Errou... restam ' +
                                GameSession.tentativasRestantes.toString() +
                                ' tentativas.';
                          }
                        }(),
                        style: const TextStyle(
                            fontFamily: 'Lobster', fontSize: 24.0),
                        gradient: const RadialGradient(colors: <Color>[
                          Color(0xfffed400),
                          Color(0xffff9900),
                        ]),
                      ),
                    ));
                  });
                }
              },
              child: Container(
                child: imagemPadrao,
              ),
            );
          }
        },
      ),
    );
  }
}
