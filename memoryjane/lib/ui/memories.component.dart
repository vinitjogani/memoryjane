import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/ui/create.component.dart';
import 'package:memoryjane/ui/group.component.dart';
import 'package:memoryjane/signin_auth.dart';
import 'package:memoryjane/sign_in.dart';
import 'package:memoryjane/ui/layout.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

// TODO: signin_auth has name and email variable from signing in. Can be used for database updates and UI customization
//String name;
//String email;


class MemoriesComponent extends StatefulWidget {

  @override
  _MemoriesComponentState createState() => _MemoriesComponentState();
}

class _MemoriesComponentState extends State<MemoriesComponent> {

  final List<Collection> dummyCollections = [
    Collection(
        name: "Sriram",
        coverImageUrl: "https://avatars0.githubusercontent.com/u/15956660?s=460&v=4",
        memories: [
          Memory(type: MemoryType.Text, data: "Hello, world!", id: "123", memoryDate: DateTime(2020, 1, 7, 3, 33))
        ]
    ),
    Collection(
      name: "Steven",
      coverImageUrl: "https://media-exp2.licdn.com/dms/image/C5103AQEEE_HkW-K6XA/profile-displayphoto-shrink_800_800/0?e=1584576000&v=beta&t=a-imVGOhEkrG0u5zitHzrdXMP7M5Z7D9lMJ_mbNY0hY",
      memories: []
    ),
  ];

  void mediaCallback(List<SharedMediaFile> value) {
    if (value != null && value.length  > 0) {
      for (var m in value) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>
                CreateComponent(Memory(data: m.path, type: MemoryType.Image))
        ));
      }
      print("Shared:" + (value?.map((f)=> f.path)?.join(",") ?? ""));
    }
  }

  void textCallback(String value) async {
    if (value == null) return;
    print(value);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CreateComponent(Memory(data: value, type: MemoryType.Text))
    ));
  }

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    ReceiveSharingIntent.getMediaStream().listen(mediaCallback);

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then(mediaCallback);

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    ReceiveSharingIntent.getTextStream().listen(textCallback);

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then(textCallback);
  }

  void signOut() {
    signOutGoogle();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      child: ListView(
        children: <Widget>[
          GroupComponent('PEOPLE', dummyCollections),
          GroupComponent('PLACES', dummyCollections),
          GroupComponent('TIME', dummyCollections),
          SizedBox(height: 40,)
        ],
        padding: EdgeInsets.all(0),
      ),
      title: "Memories",
      action: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black,),
          onPressed: signOut
      ),
    );
  }

}

