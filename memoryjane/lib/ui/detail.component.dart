import 'package:flutter/material.dart';
import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/ui/memory.component.dart';

class DetailComponent extends StatefulWidget {

  final Collection collection;

  DetailComponent(this.collection);

  @override
  _DetailComponentState createState() => _DetailComponentState();
}

class _DetailComponentState extends State<DetailComponent> {
  bool confirm = false;

  Future<bool> confirmDelete(_) async {
    setState(() { confirm = false; });
    await showDialog( builder: (context) => AlertDialog(
      title: Text('Are you sure?'),
      content: const Text('This will permanently and irreversibly delete this memory.'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            setState(() { confirm = true; });
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            setState(() { confirm = false; });
            Navigator.pop(context);
          },
        ),
      ],
    ), context: context);
    return confirm;
  }

  void delete(Memory item) {

  }

  Widget makeDismissible(MemoryComponent memory) {
    return Dismissible(
      background: Container(color: Colors.red),
      child: memory,
      key: Key('i'),
      onDismissed: (_) => delete(memory.memory),
      confirmDismiss: confirmDelete,
      direction: DismissDirection.endToStart,
    );
  }

  List<Widget> makeMemories() {
    List<Widget> output = [];
    var memories = widget.collection.memories;
    if (memories.length > 1) {
      for (var memory in memories.sublist(0, memories.length - 1)) {
        output.add(makeDismissible(MemoryComponent(memory)));
      }
    }
    if (memories.length > 0) {
      output.add(makeDismissible(MemoryComponent(memories.last, last: true)));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close, color: Colors.black,),
                onPressed: () => Navigator.pop(context)
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 0),
            child: Text(
              widget.collection.name,
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
              child: ListView(
                children: makeMemories(),
                padding: EdgeInsets.only(top: 5),
              ),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}