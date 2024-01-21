class OutOfBoundsException implements Exception {
  OutOfBoundsException(this.message);
  String message;
  @override
  String toString() => message;
}
