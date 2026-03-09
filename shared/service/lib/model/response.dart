class BaseResponse<T> {
  BaseResponse({required this.code, this.data, this.message = ''});

  factory BaseResponse.fromJson({
    required Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? deserialize,
  }) {
    return BaseResponse<T>(
      code: json['code'],
      data: (json['data'] != null && deserialize != null)
          ? deserialize(json['data'])
          : null,
      message: json['message'],
    );
  }

  factory BaseResponse.fromIterableJson({
    required Map<String, dynamic> json,
    T Function(Iterable<dynamic>)? deserialize,
  }) {
    return BaseResponse(
      code: json['code'],
      data: (json['data'] != null && deserialize != null)
          ? deserialize(json['data'])
          : null,
      message: json['message'],
    );
  }

  factory BaseResponse.fromPrimitiveJson({required Map<String, dynamic> json}) {
    return BaseResponse<T>(
      code: json['code'],
      data: json['data'],
      message: json['message'],
    );
  }

  int? code;
  T? data;
  String message;
}
