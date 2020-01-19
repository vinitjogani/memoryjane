enum MemoryType {
  Text, Image, Video, Audio, Website
}

const months = [
  "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP",
  "AUG", "NOV", "DEC"
];

String zeroPad(x) {
  var str = x.toString();
  return str.length > 1 ? str : '0' + str;
}

class Memory {
  final MemoryType type;
  final String id;
  final DateTime memoryDate;
  final String data;

  Memory({this.type, this.id, this.data, this.memoryDate});

  String getDateString() {
    var month = months[memoryDate.month - 1];
    var day = zeroPad(memoryDate.day);
    var hour = zeroPad(memoryDate.hour);
    var minute = zeroPad(memoryDate.minute);

    return "$hour:$minute on $month $day, ${memoryDate.year}";
  }

  static Memory fromMap(Map<String, dynamic> json, var id) {
    return Memory(
      type: MemoryType.values[json['type']],
      id: id,
      data: json['data'],
      memoryDate: DateTime.parse(json['memoryDate'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': MemoryType.values.indexOf(type),
      'data': data,
      'memoryDate': memoryDate.toIso8601String()
    };
  }

  String getMonthKey() {
    return months[memoryDate.month-1] + " '${memoryDate.year.toString().substring(2)}";
  }

}