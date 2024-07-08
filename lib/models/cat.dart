class Cat {
  final String imageUrl;
  final int statusCode;

  Cat({
    required this.imageUrl,
    required this.statusCode,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      imageUrl: 'https://http.cat/${json['statusCode']}',
      statusCode: json['statusCode'],
    );
  }
}
