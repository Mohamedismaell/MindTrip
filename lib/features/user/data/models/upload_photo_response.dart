class UploadPhotoResponse {
  final String url;

  const UploadPhotoResponse({required this.url});

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) {
    return UploadPhotoResponse(url: json['url'] as String);
  }
}
