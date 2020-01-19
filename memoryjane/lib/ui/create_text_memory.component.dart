import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/ui/layout.dart';
import 'package:memoryjane/ui/memory.component.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tags/tag.dart';

import '../entities/memory.dart';


final format = DateFormat("yyyy-MM-dd HH:mm");


class CreateTextMemoryComponent extends StatefulWidget {

  CreateTextMemoryComponent();

  @override
  _CreateTextMemoryComponentState createState() => _CreateTextMemoryComponentState();
}

class _CreateTextMemoryComponentState extends State<CreateTextMemoryComponent> {

  TextEditingController txt;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  DateTime currentDate = DateTime.now();
  String textMemory;
  List<String> collections = [];
  List<String> allCollections = ['Sriram', 'Steven'];

  @override
  void initState() {
    super.initState();
    txt = TextEditingController();
  }

  Future uploadTextMemory() async {

    Map<String, dynamic> newMemory = Memory(
        type: MemoryType.Text,
        memoryDate: currentDate,
        data: textMemory
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
      await endpoint.add(newMemory);

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
              Center(child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: "Input memory text"),
                onChanged: (String str){
                  setState(() {
                    textMemory = str;
                  });},
              )),
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
                  await uploadTextMemory();
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
