import 'dart:async';

import 'package:atipico_game/components/game_session.dart';
import 'package:atipico_game/components/gradient_text.dart';
import 'package:atipico_game/components/image_retriever.dart';
import 'package:atipico_game/screens/game_over_screen.dart';
import 'package:flutter/material.dart';

class TelaJogoScreen extends StatefulWidget {
  int dificuldadeSelecionada;

  TelaJogoScreen({required this.dificuldadeSelecionada, Key? key}) : super(key: key);

  late GameSession gameSession = GameSession(dificuldadeSelecionada);

  @override
  State<TelaJogoScreen> createState() => _TelaJogoScreenState();
}

class _TelaJogoScreenState extends State<TelaJogoScreen> {
  // Temporizador do game
  Timer? temporizadorJogo;
  int tempoReferenciaTotalJogo = 15000;
  int tempoTotalJogoMilissegundos = 15000;
  int countDownMilissegundos = 15000;
  int bonusTempoRound = 2000;

  // Mensagens ao jogador
  bool messagePlayerVisibility = false;
  String messagePlayer = "";

  // Sessão de jogo, dificuldade, imagens e posições:
  late int dificuldadeSessaoJogo = widget.dificuldadeSelecionada;
  late List<int> dimensoesMatriz = widget.gameSession.fornecerDimensoesMatriz();
  late List<int> localImagemAlt = widget.gameSession.fornecerPosImgAlt();
  late Map<String, Image> imagensFornecidas = ImageRetriever.fornecerImagens(dificuldadeSessaoJogo);

  void initState() {
    super.initState();

    temporizadorJogo = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (countDownMilissegundos == 0) {
        timer.cancel();
        invokeGameOver();
      } else {
        setState(() {
          countDownMilissegundos -= 10;
        });
      }
    });
  }

  @override
  void dispose() {
    temporizadorJogo?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
              imagensFornecidas,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  buildComboTextWidget(),
                  Container(
                    height: 25,
                    child: Slider(
                      value: countDownMilissegundos.toDouble(),
                      onChanged: (value) {},
                      min: 0,
                      max: tempoTotalJogoMilissegundos.toDouble(),
                    ),
                  ),
                  buildWidgetTentativasRestantes(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Score: ' + widget.gameSession.score.toString(),
                      style: TextStyle(
                          fontFamily: 'Farro',
                          color: Colors.amberAccent,
                          fontSize: 32.0),
                    ),
                  ),
                ],
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
    Map<String, Image> imagensFornecidas,
  ) {
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
                invokeAcerto();
              },
              child: Container(
                child: imagemAlt,
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                invokeErro();
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

  void invokeErro() {
    widget.gameSession.comboChain = 0;
    widget.gameSession.tentativasRestantes--;

    if (widget.gameSession.tentativasRestantes == 0) {
      invokeGameOver();
    } else {
      setState(() {
        invokeNewRound();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 400),
          // backgroundColor: Color(),
          content: GradientText(
            () {
              if (widget.gameSession.tentativasRestantes == 1) {
                return 'Errou... resta apenas ' +
                    widget.gameSession.tentativasRestantes.toString() +
                    ' tentativa. Cuidado!';
              } else {
                return 'Errou... restam ' +
                    widget.gameSession.tentativasRestantes.toString() +
                    ' tentativas.';
              }
            }(),
            style: const TextStyle(fontFamily: 'Lobster', fontSize: 24.0),
            gradient: const RadialGradient(colors: <Color>[
              Color(0xfffed400),
              Color(0xffff9900),
            ]),
          ),
        ));
      });
    }
  }

  void invokeAcerto() {
    setState(() {
      widget.gameSession.dificuldade++;
      widget.gameSession.score += widget.gameSession.dificuldade * 10 * (widget.gameSession.comboChain <= 2.5 ? 1 : widget.gameSession.comboChain.toDouble()/2.5).toInt();
      widget.gameSession.comboChain++;

      incrementTimer();

      invokeNewRound();

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
  }

  void incrementTimer() {
    countDownMilissegundos += bonusTempoRound;

    if (countDownMilissegundos > tempoTotalJogoMilissegundos) {
      tempoTotalJogoMilissegundos = countDownMilissegundos;
    } else {
      if (tempoTotalJogoMilissegundos > tempoReferenciaTotalJogo &&
          countDownMilissegundos < tempoReferenciaTotalJogo) {
        tempoTotalJogoMilissegundos = tempoReferenciaTotalJogo;
      }
    }
  }

  void invokeNewRound() {
    dificuldadeSessaoJogo = widget.gameSession.dificuldade;
    dimensoesMatriz = widget.gameSession.fornecerDimensoesMatriz();
    localImagemAlt = widget.gameSession.fornecerPosImgAlt();
    imagensFornecidas = ImageRetriever.fornecerImagens(dificuldadeSessaoJogo);
  }

  void invokeGameOver() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GameOverScreen(gameSession: widget.gameSession,)));
  }

  Widget buildWidgetTentativasRestantes() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: () {
        List<Widget> indicadorTentativasRestantes = [];

        for (int i = 0; i < widget.gameSession.tentativasRestantes; i ++) {
          indicadorTentativasRestantes.add(
            Container(
              child: const Icon(Icons.favorite_rounded, color: Colors.red, size: 32.0,),
            )
          );
        }

        return indicadorTentativasRestantes;

      } (),
    );
  }

  Widget buildComboTextWidget() {
    return Visibility(
      visible: (widget.gameSession.comboChain > 1),
      child: Text(
        'Combo: ' + widget.gameSession.comboChain.toString() + " x",
        style: TextStyle(
            fontFamily: 'Farro',
            color: Colors.amberAccent,
            fontSize: 32.0),
      ),
    );
  }

  // Widget buildTextMensagemJogador() {
  //
  // }
}
