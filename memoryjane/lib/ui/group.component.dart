import 'package:flutter/material.dart';

import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/ui/collection.component.dart';

class GroupComponent extends StatelessWidget {

  final String name;
  final List<Collection> collections;

  GroupComponent(this.name, this.collections);

  List<Widget> buildListView() {
    List<Widget> output = [];
    for (var c in collections) {
      output.add(CollectionComponent(c));
    }
    output.add(SizedBox(width: 20,));
    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (collections.length == 0 && name != "PEOPLE")
      return Text("");

    if (collections.length == 0)
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text("Nothing here yet! Share to MJ to save memories.")
        ),
      );

    return Container(
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[400]),
          ),
        color: Colors.white
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 15,),
            child: Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Raleway'
              ),
            ),
          ),
          Container(
            height: 300,
            child: ListView(
              children: buildListView(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
