import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/ui/layout.dart';
import 'package:memoryjane/ui/memory.component.dart';

class CollectionDetailComponent extends StatefulWidget {

  final Collection collection;

  CollectionDetailComponent(this.collection);

  @override
  _CollectionDetailComponentState createState() => _CollectionDetailComponentState();
}

class _CollectionDetailComponentState extends State<CollectionDetailComponent> {
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

  Future delete(Memory item) async {
    widget.collection.memories.remove(item);
    print("Removing ${item.id} from ${widget.collection.name}");
    await Firestore.instance.collection('vnjogani@gmail.com')
      .document('Collections').collection(widget.collection.name.toLowerCase())
      .document(item.id).delete();
  }

  Widget makeDismissible(MemoryComponent memory) {
    return Dismissible(
      background: Container(color: Colors.red),
      child: memory,
      key: Key(memory.memory.id),
      onDismissed: (_) async => await delete(memory.memory),
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
    return LayoutComponent(
      title: widget.collection.name,
      child: ListView(
        children: makeMemories(),
        padding: EdgeInsets.only(top: 10),
      ),
      action: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: () => Navigator.pop(context)
      ),
    );
  }
}