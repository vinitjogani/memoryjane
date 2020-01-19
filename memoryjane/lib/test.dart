//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:memoryjane/entities/collection.dart';
//import 'package:memoryjane/entities/memory.dart';
//
//Future<Map<String, Memory>> getMemories() async {
//  var memories = await Firestore.instance.collection("Users").document('vnjogani@gmail.com').collection('Memories').getDocuments();
//  Map<String, Memory> mems = {};
//  for (var document in memories.documents) {
//    mems[document.documentID] = Memory.fromMap(document.data, document.documentID);
//  }
//  return mems;
//}
//
//Future<List<Collection>> getCollections(Map<String, Memory> memoryMap) async {
//  var collectionsEndpoint = Firestore.instance.collection("Users").document('vnjogani@gmail.com!Collections');
//
//  var collections = (await collectionsEndpoint.get());
//
//  //.collection('Collections').getDocuments();
//  List<Collection> cols = [];
//  for (var col in collections.documents) {
//    var memories = col.data['memories'];
//  }
//}
//
