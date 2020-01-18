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

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List<String> collections = [];
  List<String> allCollections = ['Sriram', 'Steven'];

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
              Text("Pick a date"),
              DateTimeField(
                format: format,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100)
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
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
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )],
      ),
    );
  }
}
