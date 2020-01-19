import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:link_previewer/link_previewer.dart';
import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/ui/video.component.dart';
import 'package:video_player/video_player.dart';


Widget displayMemory(Memory memory) {
  if (memory.type == MemoryType.Text) {
    return Text(
      memory.data,
      softWrap: true,
      style: TextStyle(fontSize: 17),
    );
  }
  else if (memory.type == MemoryType.Website) {
    return LinkPreviewer(
      link: memory.data,
      direction: ContentDirection.vertical,
    );
  }
  else if (memory.type == MemoryType.Video) {
    return VideoComponent(memory.data);
  }
  else if (memory.type == MemoryType.Image) {
    if (memory.data.startsWith('http'))
      return Image.network(memory.data);
    else
      return Image.file(File.fromUri(Uri(path: memory.data)));
  }
  return Text(
    "This type of memory is not supported yet.",
    softWrap: true,
    style: TextStyle(fontSize: 17),
  );
}


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
                    displayMemory(memory),
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
