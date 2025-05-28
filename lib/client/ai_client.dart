
abstract class AiClient {
  Future<String> query({required String prompt, String? system, String? context, String model});
}
