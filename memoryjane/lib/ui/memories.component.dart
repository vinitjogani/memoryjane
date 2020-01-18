import 'package:flutter/material.dart';
import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/ui/group.component.dart';
import 'package:memoryjane/signin_auth.dart';
import 'package:memoryjane/sign_in.dart';

// TODO: signin_auth has name and email variable from signing in. Can be used for database updates and UI customization
//String name;
//String email;

class MemoriesComponent extends StatelessWidget {

  final List<Collection> dummyCollections = [
    Collection(
        name: "Sriram",
        coverImage: "https://avatars0.githubusercontent.com/u/15956660?s=460&v=4",
        memories: []
    ),
    Collection(
      name: "Steven",
      coverImage: "https://media-exp2.licdn.com/dms/image/C5103AQEEE_HkW-K6XA/profile-displayphoto-shrink_800_800/0?e=1584576000&v=beta&t=a-imVGOhEkrG0u5zitHzrdXMP7M5Z7D9lMJ_mbNY0hY",
      memories: []
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
            },
            color: Colors.blueGrey,

            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Sign Out',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 50,),
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
          GroupComponent('PEOPLE', dummyCollections),
          GroupComponent('PLACES', dummyCollections),
          GroupComponent('TIME', dummyCollections),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}

