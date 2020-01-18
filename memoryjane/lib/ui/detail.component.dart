import 'package:flutter/material.dart';
import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/ui/memory.component.dart';

class DetailComponent extends StatelessWidget {

  final Collection collection;

  DetailComponent(this.collection);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close, color: Colors.black,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5),
            child: Text(
              collection.name,
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[400]),
                )
              ),
              child: ListView(
                children: <Widget>[
                  MemoryComponent(),
                  MemoryComponent(),
                  MemoryComponent(),
                  MemoryComponent(last: true),
                ],
              ),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}