import 'package:fello/games.dart';
import 'package:fello/newsscreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {'page': News(), 'title': "News"},
      {'page': Games(), 'title': "Games"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              flex: 12,
              child: _pages[_selectedPageIndex]['page'],
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey[350],
                    offset: Offset(0, -2),
                    blurRadius: 0.0046 * constraints.maxHeight)
              ]),
              padding:
                  EdgeInsets.fromLTRB(0, 0, 0, 0.00309 * constraints.maxHeight),
              child: BottomNavigationBar(
                s: _selectedPageIndex,
                changeselected: _selectPage,
              ),
            ))
          ],
        );
      }),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  final Function changeselected;
  final int s;
  const BottomNavigationBar({
    Key key,
    this.s,
    this.changeselected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print("Bottom navigation ");
        print("height is ${constraints.maxHeight}");
        print("width is ${constraints.maxWidth}");
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => this.changeselected(0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Divider(
                          height: 0.09 * constraints.maxHeight,
                          thickness: 0.011 * constraints.maxWidth,
                          color: this.s == 0 ? Colors.blue : Colors.white),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.near_me,
                        color: this.s==0?Colors.blue : Colors.grey,
                      ),
                    ),
                    Text(
                      "News",
                      style: TextStyle(
                          color: this.s == 0 ? Colors.blue : Colors.grey,
                          fontSize: 0.27 * constraints.maxHeight,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: InkWell(
                  onTap: () {
                    this.changeselected(1);
                  },
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Divider(
                            height: 0.09 * constraints.maxHeight,
                            thickness: 0.011 * constraints.maxWidth,
                            color: this.s == 1 ? Colors.blue : Colors.white),
                      ),
                      Expanded(
                        child: Icon(Icons.games,color: this.s==1?Colors.blue : Colors.grey,),
                      ),
                      Text(
                        "Games",
                        style: TextStyle(
                            color: this.s == 1 ? Colors.blue : Colors.grey,
                            fontSize: 0.27 * constraints.maxHeight,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
