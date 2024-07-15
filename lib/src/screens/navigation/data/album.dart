class Album {
  final String name;
  final String reciter;
  final String nameEnglish;
  final String image;
  final String url;
  int position;

  Album(
      {required this.name,
      required this.reciter,
      required this.nameEnglish,
      required this.image,
      this.position = 0,
      required this.url});

  Album copyWith(
      {String? name,
      String? reciter,
      String? nameEnglish,
      String? image,
      String? url}) {
    return Album(
        name: name ?? this.name,
        reciter: reciter ?? this.reciter,
        nameEnglish: nameEnglish ?? this.nameEnglish,
        url: url ?? this.url,
        image: image ?? this.image);
  }

  @override
  String toString() =>
      "Album(name: $name, reciter: $reciter, nameEnglish: $nameEnglish, image: $image, url: $url, position: $position)";

  factory Album.fromString(String value) {
    final regex = RegExp(
      r"Album\(name: (.*?),\s*reciter: (.*?),\s*nameEnglish: (.*?),\s*image: (.*?),\s*url: (.*?),\s*position: (\d+)\)",
    );
    final match = regex.firstMatch(value);
    if (match != null) {
      return Album(
          name: match.group(1)!,
          reciter: match.group(2)!,
          nameEnglish: match.group(3)!,
          image: match.group(4)!,
          url: match.group(5)!,
          position: int.parse(match.group(6)!));
    }
    throw FormatException("$value doesnt follow the regex");
  }
}
