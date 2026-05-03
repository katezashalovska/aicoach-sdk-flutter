/// Configuration for the AI Coach SDK.
/// Host applications must provide an API Key and a User ID to connect to the backend.
class AiCoachConfig {
  /// The unique API Key for the client's tenant.
  final String apiKey;

  /// The ID of the currently logged-in user in the host application.
  final String userId;

  /// The base URL for the AI Coach API.
  final String baseUrl;

  const AiCoachConfig({
    required this.apiKey,
    required this.userId,
    this.baseUrl = 'https://aicoachjack.onrender.com',
  });
}
