class PostData {
  List<String> imageUrls;
  String comment;
  String location;
  DateTime time;
  String thought;

  PostData({
    required this.imageUrls,
    required this.comment,
    required this.location,
    required this.time,
    required this.thought,
  });

  // Add a method to convert PostData to a map
  Map<String, dynamic> toMap() {
    return {
      'imageUrls': imageUrls,
      'comment': comment,
      'location': location,
      'time': time,
      'thought': thought,
    };
  }
}
