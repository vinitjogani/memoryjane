import 'package:flutter/material.dart';
import 'package:memoryjane/entities/collection.dart';
import 'package:memoryjane/ui/collection_detail.component.dart';

class CollectionComponent extends StatelessWidget {
  final Collection collection;

  CollectionComponent(this.collection);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 15,
        bottom: 15,
      ),
      child: GestureDetector(
        onTap: () {
          var route = MaterialPageRoute(
            builder: (context) => CollectionDetailComponent(this.collection),
          );
          Navigator.push(context, route);
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  collection.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600
                  ),
                ),
              )
            ],
            alignment: Alignment.bottomLeft,
          ),
          width: 250,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(collection.getCoverImage()),
                fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[800],
                offset: Offset(5, 5),
                blurRadius: 15,
                spreadRadius: 2,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
