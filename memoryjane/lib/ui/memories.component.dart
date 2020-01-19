import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/ui/create.component.dart';
import 'package:memoryjane/ui/create_text_memory.component.dart';
import 'package:memoryjane/ui/group.component.dart';
import 'package:memoryjane/signin_auth.dart';
import 'package:memoryjane/sign_in.dart';
import 'package:memoryjane/ui/layout.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// TODO: signin_auth has name and email variable from signing in. Can be used for database updates and UI customization
//String name;
//String email;



class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({this.resumeCallBack});

  final AsyncCallback resumeCallBack;

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }
  }
}


class MemoriesComponent extends StatefulWidget {

  @override
  _MemoriesComponentState createState() => _MemoriesComponentState();
}

class _MemoriesComponentState extends State<MemoriesComponent> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Collection> personCollections = [];
  List<Collection> timeCollections = [];

  void mediaCallback(List<SharedMediaFile> value) {
    if (value != null && value.length  > 0) {
      for (var m in value) {
        MemoryType type = MemoryType.Image;
        if (m.path.endsWith('.mp4') || m.path.endsWith('.mpeg')) {
          type = MemoryType.Video;
        }
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>
                CreateComponent(Memory(data: m.path, type: type))
        ));
      }
    }
  }

  Future downloadCollections() async {
    print("Downloading...");
    
    Map<String, List<Memory>> memoryMonthMap = {};
    List<Collection> personCols = [], timeCols = [];
    var colDocs = await Firestore.instance.collection((await FirebaseAuth.instance.currentUser()).email)
        .document('Collections').collection('List').getDocuments();
    var endpoint = Firestore.instance.collection((await FirebaseAuth.instance.currentUser()).email)
        .document('Collections');

    for(var doc in colDocs.documents) {
      var memoryDocs = await endpoint.collection(doc.documentID).getDocuments();
      var memories = memoryDocs.documents.map((x) => Memory.fromMap(x.data, x.documentID)).toList();
      for (var mem in memories) {
        var key = mem.getMonthKey();
        if (!memoryMonthMap.containsKey(key))
          memoryMonthMap[key] = [];
        memoryMonthMap[key].add(mem);
      }
      personCols.add(Collection(name: doc.documentID, memories: memories));
    }


    for (var key in memoryMonthMap.keys) {
      timeCols.add(Collection(name: key, memories: memoryMonthMap[key]));
    }

    setState(() {
      personCollections.clear();
      personCollections.addAll(personCols.where((x) => x.memories.length > 0).toList());
      timeCollections.clear();
      timeCollections.addAll(timeCols);
    });

  }

  void textCallback(String value) async {
    if (value == null) return;

    var memType = MemoryType.Text;

    if(value.startsWith("http") || value.startsWith("www")) {
      memType = MemoryType.Website;
    }

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CreateComponent(Memory(data: value, type: memType))
    ));
  }

  Future<FirebaseUser> _handleSignIn() async {
    var u = await _auth.currentUser();

    if (u == null) {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      u = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + u.displayName);
    }

    return u;
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


    WidgetsBinding.instance.addObserver(LifecycleEventHandler(resumeCallBack: downloadCollections));

    _handleSignIn().then((_) {
      downloadCollections();
    });
  }

  void signOut() {
    signOutGoogle();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
  }

  void createTextMemory() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            CreateTextMemoryComponent()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      child: ListView(
        children: <Widget>[
          GroupComponent('PEOPLE', personCollections),
          GroupComponent('TIME', timeCollections),
          SizedBox(height: 40,)
        ],
        padding: EdgeInsets.all(0),
      ),
      title: "Memories",
      action: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black,),
          onPressed: signOut
      ),
      fab: FloatingActionButton(
        child: Icon(Icons.keyboard, color: Colors.white),
        onPressed: createTextMemory,
        backgroundColor: Colors.black87,
      )
    );
  }

}

