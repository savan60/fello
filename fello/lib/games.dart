import 'dart:async';

import 'package:flutter/material.dart';

class Games extends StatefulWidget {
  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  double _ironManAlignment = 100;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
       
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          bottom: _ironManAlignment,
          left: 90,
          child: Container(
            height: 250,
            width: 150,
            child: Image.asset('assets/images/ironman.png'),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 32),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.blue,
            ),

            child: InkWell(
                onTap: () {
                  _flyIronMan();
                },
                child: Text('Jump',style: TextStyle(color: Colors.white),)),
            // textColor: Colors.white,
          ),
        )
      ],
    );
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 1);
    return Timer(_duration, down);
  }

  void down() {
    flag = false;
    setState(() {
      _ironManAlignment = 100;
    });
  }

  void _flyIronMan() {
    flag = true;
    setState(() {
      _ironManAlignment = 220;
    });
    _loadWidget();
  }
}
