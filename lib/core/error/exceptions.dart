class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);
}

class EmailNotVerifiedException implements Exception {
  final String message;
  const EmailNotVerifiedException([
    this.message = "البريد الإلكتروني غير مفعل، يرجى التحقق من بريدك.",
  ]);
}

class GeminiException implements Exception {
  final String message;
  const GeminiException(this.message);
}
