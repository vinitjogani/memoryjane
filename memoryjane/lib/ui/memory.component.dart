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
    if (memory.type == MemoryType.Text) {
      return Text(
        memory.data,
        softWrap: true,
        style: TextStyle(fontSize: 17),
      );
    }
    else if (memory.type == MemoryType.Image) {
      return Image.network(memory.data);
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
                        memory.getDateString(),
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
