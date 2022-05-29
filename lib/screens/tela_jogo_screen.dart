import 'package:atipico_game/components/game_session.dart';
import 'package:atipico_game/components/gradient_text.dart';
import 'package:flutter/material.dart';

class TelaJogoScreen extends StatefulWidget {
  const TelaJogoScreen({Key? key}) : super(key: key);

  @override
  State<TelaJogoScreen> createState() => _TelaJogoScreenState();
}

class _TelaJogoScreenState extends State<TelaJogoScreen> {
  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;

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
        ],
      ),
    );
  }
}
