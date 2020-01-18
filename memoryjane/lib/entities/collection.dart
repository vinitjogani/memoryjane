import 'package:memoryjane/entities/memory.dart';

class Collection {
  final String id;
  final String name;
  String coverImageUrl;
  final List<Memory> memories;

  Collection({this.id, this.name, this.coverImageUrl, this.memories});
}