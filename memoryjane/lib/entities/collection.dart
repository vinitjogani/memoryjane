import 'package:memoryjane/entities/memory.dart';

class Collection {
  final String name;
  final String coverImage;
  final List<Memory> memories;

  Collection({this.name, this.coverImage, this.memories});
}