import 'package:flutter/material.dart';
import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/ui/collection.component.dart';
import 'package:memoryjane/ui/group.component.dart';

class MemoriesComponent extends StatelessWidget {

  final List<Collection> dummyCollections = [
    Collection(
        name: "Sriram",
        coverImage: "https://avatars0.githubusercontent.com/u/15956660?s=460&v=4",
    ),
    Collection(
      name: "Steven",
      coverImage: "https://media-exp2.licdn.com/dms/image/C5103AQEEE_HkW-K6XA/profile-displayphoto-shrink_800_800/0?e=1584576000&v=beta&t=a-imVGOhEkrG0u5zitHzrdXMP7M5Z7D9lMJ_mbNY0hY",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 70,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Memories",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w800
              ),
            ),
          ),
          SizedBox(height: 20,),
          GroupComponent(dummyCollections),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
