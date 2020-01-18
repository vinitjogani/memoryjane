enum MemoryType {
  Text, Image, Audio, Website
}

class Memory {
  final MemoryType type;
  final String id;
  final DateTime memoryDate;
  final String data;

  Memory({this.type, this.id, this.data, this.memoryDate});
}