class RopError {
  final String message;
  final String? errorCode;

  RopError(this.message, {this.errorCode});

  @override
  String toString() => errorCode != null ? '$errorCode: $message' : message;
}
