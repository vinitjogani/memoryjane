import "dart:math";

String getRandomImageUrl() {
  final _random = new Random();
    const List<String> defaultImageUrls = [
      "https://picsum.photos/id/1002/200",
      "https://picsum.photos/id/1032/200",
      "https://picsum.photos/id/1053/200",
      "https://picsum.photos/id/1081/200",
      "https://picsum.photos/id/114/200"
    ];

    return defaultImageUrls[_random.nextInt(defaultImageUrls.length)];
}