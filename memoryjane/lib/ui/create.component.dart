import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/ui/layout.dart';
import 'package:memoryjane/ui/memory.component.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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

  String uploadImage(String path) {
    // TODO: Upload image and return url
    return '<STORAGE URL>';
  }

  Memory constructMemory() {
    String data = widget.initialMemory.data;

    if (widget.initialMemory.type == MemoryType.Image) {
      data = uploadImage(widget.initialMemory.data);
    }

    return Memory(
      type: widget.initialMemory.type,
      memoryDate: currentDate,
      data: data
    );
  }

  void uploadMemory(List<String> collections) {
    Memory newMemory = constructMemory();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.initialMemory.data);
    return LayoutComponent(
      title: "Create",
      action: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: () => Navigator.pop(context)
      ),
      child: ListView(
        children:<Widget>[Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration:  InputDecoration(
                  hintText: "Pick a date"
                ),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990, 1, 1),
                      lastDate: DateTime.now()
                  );
                  var time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  var dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                  setState(() {
                    currentDate = dt;
                    txt.text = "${dt.year}-${zeroPad(dt.month)}-${zeroPad(dt.day)} ${zeroPad(dt.hour)}:${zeroPad(dt.minute)}";
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
                ), onPressed: () {},
              )

            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )],
      ),
    );
  }
}
