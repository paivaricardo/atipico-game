import 'package:atipico_game/components/gradient_text.dart';
import 'package:flutter/material.dart';

class DificuldadeScreen extends StatelessWidget {
  const DificuldadeScreen({Key? key}) : super(key: key);

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
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GradientText(
                  'Atípico!',
                  style: TextStyle(fontFamily: 'Lobster', fontSize: 92.0),
                  gradient: RadialGradient(colors: <Color>[
                    Color(0xfffed400),
                    Color(0xffff9900),
                  ]),
                ),
                Text('Dificuldade:', style: TextStyle(fontFamily: 'Farro', color: Colors.amberAccent, fontSize: 32.0),),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 5),
                          blurRadius: 7.5),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xffffdd2a),
                        Color(0xffe68902),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      minimumSize: MaterialStateProperty.all(Size(250, 60)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                      MaterialStateProperty.all(Colors.black12),
                    ),
                    child: Text(
                      'Fácil',
                      style: TextStyle(fontSize: 32.0, color: Colors.black87),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 5),
                          blurRadius: 7.5),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xffffdd2a),
                        Color(0xffe68902),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      minimumSize: MaterialStateProperty.all(Size(250, 60)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                      MaterialStateProperty.all(Colors.black12),
                    ),
                    child: Text(
                      'Moderado',
                      style: TextStyle(fontSize: 32.0, color: Colors.black87),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 5),
                          blurRadius: 7.5),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xffffdd2a),
                        Color(0xffe68902),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      minimumSize: MaterialStateProperty.all(Size(250, 60)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                      MaterialStateProperty.all(Colors.black12),
                    ),
                    child: Text(
                      'Difícil',
                      style: TextStyle(fontSize: 32.0, color: Colors.black87),
                    ),
                  ),
                ),
                Text('Pontuação mais alta:', style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 32.0),),
                Text('3235:', style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 32.0),),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.volume_up_rounded,
                  color: Colors.amber,
                ),
                onPressed: () { },
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(
                  Icons.settings_rounded,
                  color: Colors.amber,
                ),
                onPressed: () {},
              )),
        ],
      ),
    );
  }
}
