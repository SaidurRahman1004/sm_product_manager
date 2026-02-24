class ApiResponse<T> {
  final String status;
  final T? data;
  final String? message;

  ApiResponse({required this.status, this.data, this.message});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      status: json['status'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      message: json['message'],
    );
  }
}
