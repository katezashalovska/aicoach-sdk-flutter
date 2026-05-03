import '../models/coach.dart';
import '../models/chat_item.dart';

/// Centralized mock data for the AI Coach SDK.
/// This will be replaced by actual backend services in the future.
class MockAiCoachData {
  static const Coach jaxsonMiller = Coach(
    id: '1',
    name: 'Jaxson Miller',
    imageUrl:
        'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=500&auto=format&fit=crop',
    rating: 4.8,
    userCount: '350+',
    tags: ['muscle building', 'bodybuilding', 'crossfit'],
    about:
        'Expert in muscle building and bodybuilding with over 10 years of experience.',
    achievements: [
      'Helped over 300+ clients significantly increase strength and muscle mass through personalized training programs',
      'Developed high-performance training systems focused on progressive overload and long-term results',
      'Achieved a high client retention rate due to measurable progress and consistent outcomes',
    ],
    reviews: [
      CoachReview(
        userName: 'Larry D.',
        rating: 5,
        title: '“90 days in, and my chest finally looks flat.”',
        content:
            'I was skeptical, but EstroGuard+ seriously delivered. I dropped almost 25 pounds, my man boobs started shrinking, and even my double chin is noticeably tighter. Energy’s way up too—no more crashing after work. Total transformation.',
      ),
      CoachReview(
        userName: 'Tom M.',
        rating: 5,
        title: '“Week four and my chest finally looks normal again.”',
        content:
            'I was skeptical, but EstroGuard+ surprised me. My energy picked up within days, and by week four my man boobs were noticeably flatter, my jawline looked cleaner, and I felt more like myself—only better. Total confidence boost.',
      ),
    ],
  );

  static const Coach robertHenderson = Coach(
    id: '2',
    name: 'Robert "Bob" Henderson',
    imageUrl:
        'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=500&auto=format&fit=crop',
    rating: 4.8,
    userCount: '199+',
    tags: ['nutrition', 'body recomposition', 'crossfit'],
    about: 'Nutrition specialist focusing on sustainable lifestyle changes.',
    achievements: [
      'Certified Nutritionist with expertise in body recomposition',
      'Guided 200+ individuals through successful weight loss journeys',
      'Speaker at national fitness conferences on metabolic health',
    ],
    reviews: [
      CoachReview(
        userName: 'Sarah K.',
        rating: 5,
        title: '“Life changing experience!”',
        content:
            'The nutrition plan was so easy to follow and the results speak for themselves.',
      ),
    ],
  );

  /// Mock data for the coach selection list.
  static const List<Coach> coaches = [
    jaxsonMiller,
    robertHenderson,
  ];

  /// Mock data for the "My chats" list.
  static final List<ChatItem> chats = [
    ChatItem(
      id: 'chat_1',
      name: robertHenderson.name,
      avatarUrl: robertHenderson.imageUrl,
      lastMessage: 'Hope you will recover as soon as possible',
      hasUnread: false,
    ),
    ChatItem(
      id: 'chat_2',
      name: jaxsonMiller.name,
      avatarUrl: jaxsonMiller.imageUrl,
      lastMessage: 'Hope you will recover as soon as possible',
      hasUnread: true,
    ),
  ];
}
