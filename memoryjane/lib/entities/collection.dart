import 'package:memoryjane/entities/memory.dart';
import 'package:memoryjane/utilities.dart';

class Collection {
  String name;
  String coverImageUrl;
  final List<Memory> memories;

  Collection({this.name, this.coverImageUrl, this.memories}) {
    if (coverImageUrl == null) {
      setCoverImage();
    }
    if (name.length > 0) {
      name = name[0].toUpperCase() + name.substring(1).toLowerCase();
    }
    memories.sort((m1, m2) {
      return -m1.memoryDate.compareTo(m2.memoryDate);
    });
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