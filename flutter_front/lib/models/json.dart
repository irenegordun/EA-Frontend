import 'dart:convert';

class Json {
  // Encodes a message in the format that the elixir server expects
  static String encodeMessageJSON(String message) {
    return jsonEncode({
      'data': {'message': message}
    });
  }

  // No idea if this is going to work or not yet
  static String decodeMessageJSON(String message) {
    return jsonDecode(message)['message'];
  }
}
