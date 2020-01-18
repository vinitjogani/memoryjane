import 'package:flutter/material.dart';

class LayoutComponent extends StatelessWidget {

  final IconButton action;
  final String title;
  final Widget child;

  LayoutComponent({this.child, this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Row(
            children: <Widget>[ action ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 0),
            child: Text(
              title,
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
              child: child,
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
