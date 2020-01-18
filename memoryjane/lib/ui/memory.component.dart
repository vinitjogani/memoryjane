import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memoryjane/entities/memory.dart';

class MemoryComponent extends StatelessWidget {

  final Memory memory;
  final bool last;

  MemoryComponent(this.memory, {this.last = false});

  Widget buildTimelineVisual() {
    var widgets = <Widget>[
      Icon(Icons.adjust)
    ];

    if (!last) {
      widgets.add(
          Expanded(
            child: Container(
              color: Colors.grey[700],
              width: 3,
            ),
          )
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: widgets
      ),
    );
  }

  Widget displayMemory({var x = false}) {
    if (Random().nextInt(2) < 1) {
      return Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        softWrap: true,
        style: TextStyle(fontSize: 17),
      );
    }
    else {
      return Image.network("https://api.time.com/wp-content/uploads/2020/01/SnowAngel.jpg?w=600&quality=85");
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        child: Row(
          children: <Widget>[
            buildTimelineVisual(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    displayMemory(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "MAY 06, 2017",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Raleway',
                          color: Colors.grey[1100]
                        ),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
      ),
    );
  }
}
