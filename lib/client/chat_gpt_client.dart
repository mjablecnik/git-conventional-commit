import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:git_conventional_commit/client/ai_client.dart';

class ChatGptClient implements AiClient {
  static final DotEnv env = DotEnv()..load();

  final Dio _dio;
  final String _apiKey;
  final String _apiUrl;

  ChatGptClient({String? apiUrl})
    : _dio = Dio(),
      _apiUrl = apiUrl ?? 'https://api.openai.com/v1/chat/completions',
      _apiKey = env['OPENAI_API_KEY'] ?? '' {
    if (_apiKey.isEmpty) {
      throw Exception('OPENAI_API_KEY not found in .env file.');
    }
    _dio.options.headers['Authorization'] = 'Bearer $_apiKey';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  /// Sends a prompt to the ChatGPT API and returns the response text.
  /// [prompt] is the user's message.
  /// [model] defaults to 'gpt-3.5-turbo'.
  @override
  Future<String> query({required String prompt, String? system, String? context, String model = 'gpt-4.1'}) async {
    final contextMessage = context != null ? '\n\n======CONTEXT======\n\n$context\n\n=============\n\n' : '';
    final data = {
      'model': model,
      'messages': [
        if (system != null) {'role': 'developer', 'content': system},
        {'role': 'user', 'content': prompt+contextMessage},
      ],
    };

    try {
      final response = await _dio.post(_apiUrl, data: data);
      final choices = response.data['choices'];
      if (choices != null && choices.isNotEmpty) {
        return choices[0]['message']['content'] as String;
      } else {
        throw Exception('No response from ChatGPT API.');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch response: ${e.response?.data ?? e.message}');
    }
  }

  /// Loads environment variables from the .env file.
  /// Call this before using the client, e.g. in main().
  static void loadEnv() {
    env.load();
  }
}
