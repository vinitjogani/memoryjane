import 'package:flutter/material.dart';
import 'package:memoryjane/entities/collection.dart';

class DetailComponent extends StatelessWidget {

  final Collection collection;

  DetailComponent(this.collection);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 5,),
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
          ListView(
            children: <Widget>[
              
            ],
          ),
        ],
      ),
    );
  }
}