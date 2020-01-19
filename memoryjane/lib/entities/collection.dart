import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/utilities.dart';

class Collection {
  final String id;
  final String name;
  String coverImageUrl;
  final List<Memory> memories;

  Collection({this.id, this.name, this.coverImageUrl, this.memories}) {
    if (coverImageUrl == null) {
      setCoverImage();
    }
  }

  void setCoverImage() {
    coverImageUrl = getRandomImageUrl();
  }

  String getCoverImage() {
    Memory imageMemory = getLatestImageMemory();

    if (imageMemory != null) {
      coverImageUrl = imageMemory.data;
    }

    return coverImageUrl;
  }

  Memory getLatestImageMemory() {
    for (var memory in memories) {
      if(memory.type == MemoryType.Image) {
        return memory;
      }
    }
    return null;
  }
}