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

  factory CoachReview.fromJson(Map<String, dynamic> json) {
    return CoachReview(
      userName: json['reviewerName'] ?? '',
      rating: json['rating'] ?? 0,
      title: json['title'] ?? '',
      content: json['subtitle'] ?? '',
    );
  }
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

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['photoUrl'] ?? '',
      rating: 4.8, // Default or calculate from reviews
      userCount: '350+', // Default value as it's not in the DTO
      tags: List<String>.from(json['specialties'] ?? []),
      about: json['about'] ?? '',
      achievements: List<String>.from(json['achievements'] ?? []),
      reviews: (json['reviews'] as List? ?? [])
          .map((r) => CoachReview.fromJson(r))
          .toList(),
    );
  }
}
