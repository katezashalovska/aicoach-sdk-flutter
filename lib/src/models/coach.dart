class CoachReview {
  final String userName;
  final int rating;
  final String title;
  final String content;

  const CoachReview({
    required this.userName,
    required this.rating,
    required this.title,
    required this.content,
  });
}

class Coach {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String userCount;
  final List<String> tags;
  final String about;
  final List<String> achievements;
  final List<CoachReview> reviews;

  const Coach({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.userCount,
    required this.tags,
    this.about = '',
    this.achievements = const [],
    this.reviews = const [],
  });
}
