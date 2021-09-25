class Failure implements Exception {
  String message;
  dynamic error;

  Failure(this.message, [this.error]);

  @override
  String toString() {
    return "Failure:  $message\n$error";
  }
}
