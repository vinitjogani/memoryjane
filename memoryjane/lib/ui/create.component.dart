import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/ui/layout.dart';
import 'package:memoryjane/ui/memory.component.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tags/tag.dart';


final format = DateFormat("yyyy-MM-dd HH:mm");


class CreateComponent extends StatefulWidget {

  final Memory initialMemory;

  CreateComponent(this.initialMemory);

  @override
  _CreateComponentState createState() => _CreateComponentState();
}

class _CreateComponentState extends State<CreateComponent> {

  TextEditingController txt;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  DateTime currentDate = DateTime.now();
  List<String> collections = [];
  List<String> allCollections = ['Sriram', 'Steven'];

  @override
  void initState() {
    super.initState();
    txt = TextEditingController();
  }

  Future<String> uploadImage(String path, String col, String documentID) async {
    print("Uploading");
    final StorageReference storageReference = FirebaseStorage().ref()
        .child('vnjogani@gmail.com/$col/$documentID');
    final StorageUploadTask uploadTask = storageReference.putFile(
        File.fromUri(Uri(path: path)));
    await uploadTask.onComplete;

    String imageURL = await storageReference.getDownloadURL();
    print(imageURL);
    return imageURL;
  }

  Future uploadMemory() async {
    String path = widget.initialMemory.data;


    Map<String, dynamic> newMemory = Memory(
        type: widget.initialMemory.type,
        memoryDate: currentDate,
        data: widget.initialMemory.data
    ).toMap();

    var colListEndpoint = Firestore.instance.collection("vnjogani@gmail.com")
        .document("Collections")
        .collection('List');

    for (var col in collections) {
      await colListEndpoint.document(col).setData({
        'modifiedOn': DateTime.now().toIso8601String()
      });

      var endpoint = Firestore.instance.collection("vnjogani@gmail.com")
          .document("Collections")
          .collection(col.toLowerCase());
      var res = await endpoint.add(newMemory);

      if (widget.initialMemory.type == MemoryType.Image ||
          widget.initialMemory.type == MemoryType.Video) {
        var newPath = await uploadImage(path, col, res.documentID);
        endpoint.document(res.documentID).setData({'data': newPath}, merge: true);
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return LayoutComponent(
      title: "Create",
      action: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: () => Navigator.pop(context)
      ),
      child: ListView(
        children: <Widget>[Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    hintText: "Pick a date"
                ),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990, 1, 1),
                      lastDate: DateTime.now()
                  );
                  var time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  var dt = DateTime(
                      date.year, date.month, date.day, time.hour, time.minute);
                  setState(() {
                    currentDate = dt;
                    txt.text = "${dt.year}-${zeroPad(dt.month)}-${zeroPad(
                        dt.day)} ${zeroPad(dt.hour)}:${zeroPad(dt.minute)}";
                  });
                },
                controller: txt,
                readOnly: true,
              ),
              SizedBox(height: 20,),
              Center(child: displayMemory(widget.initialMemory)),
              SizedBox(height: 20,),
              Tags(
                key: _tagStateKey,
                textField: TagsTextField(
                  textStyle: TextStyle(fontSize: 14),
                  onSubmitted: (String str) {
                    print(str);
                    // Add item to the data source.
                    setState(() {
                      // required
                      collections.add(str);
                    });
                  },
                  width: double.infinity,
                  hintText: "Enter names",
                  lowerCase: true,
                  duplicates: false,
                ),
                itemCount: collections.length, // required
                itemBuilder: (int index) {
                  final item = collections[index];

                  return ItemTags(
                    // Each ItemTags must contain a Key. Keys allow Flutter to
                    // uniquely identify widgets.
                    key: Key(index.toString()),
                    index: index,
                    title: item,
                    active: false,
                    textStyle: TextStyle(fontSize: 14,),
                    removeButton: ItemTagsRemoveButton(),
                    onRemoved: () {
                      setState(() => collections.removeAt(index));
                    },
                  );
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Icon(Icons.done, color: Colors.white,)
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                onPressed: () async {
                  await uploadMemory();
                  Navigator.pop(context);
                },
              )

            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )
        ],
      ),
    );
  }
}
