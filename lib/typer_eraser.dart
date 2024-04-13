import 'dart:async';

import 'package:computer_idle/data.dart';
import 'package:flutter/material.dart';


class MyTyperEraser extends StatefulWidget {
  const MyTyperEraser({super.key,
    required this.typer,
  });

  final bool typer;

  @override
  State<MyTyperEraser> createState() => _MyTyperEraserState();
}

class _MyTyperEraserState extends State<MyTyperEraser> {

  int baseLevelXp = 30;
  late Timer timer;
  int currWorkingId = 1000;
  double cellHeight = 30;

  runTimer(int id){
    if (timer.isActive && id == currWorkingId) {
      timer.cancel();
    } else {
      currWorkingId = id;
      timer.cancel();
      timer = Timer.periodic(
        Duration(milliseconds: typerData[id][typerCols['time']]),
        (_){
          if(typerData[id][typerCols['xp']] + 1 >= ((typerData[id][typerCols['level']]/10)+1) * baseLevelXp){
            typerData[id][typerCols['level']] += 1;
            typerData[id][typerCols['xp']] = 0;
          } else {
            typerData[id][typerCols['xp']] += 1;
          }
          typerData[id][typerCols['qty']] += 1;
          setState(() {
            typerData[id];
          });
          print('NAME: ${typerData[id][0]}\tQty: ${typerData[id][4]}\tXP: ${typerData[id][3]}\tLEVEL: ${typerData[id][2]} ');
        }
      );
    }

  } // runTimer()

  myText(String text){
    return SizedBox(
      height: cellHeight,
      child: Text(text,
        style: TextStyle(color: globalFontColor),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();

    timer = Timer(const Duration(milliseconds: 1000), () {});

  } // initState()

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Table(
            children: [
              TableRow(
                children: [
                  myText('name'),
                  myText('qty'),
                  myText('level'),
                  myText('xp'),
                  myText('time'),
                  myText('run'),
                ]
              ),
              for(var i = 0; i < typerData.length; i++)
                TableRow(
                  children: [
                    myText(typerData[i][typerCols['name']]),
                    myText("${typerData[i][typerCols['qty']]}"),
                    myText("${typerData[i][typerCols['level']]}"),
                    myText("${typerData[i][typerCols['xp']]}"),
                    myText("${typerData[i][typerCols['time']]}"),
                    SizedBox(
                      height: cellHeight,
                      child: Text("${typerData[i][typerCols['active']]}",
                        style: TextStyle(color: typerData[i][typerCols['active']] ? const Color(0xFFffff00) : const Color(0xFFff0000)),
                      )
                    ),
                  ]
                )
            ],
    )
        ],
      ),
    );
  }
}

            