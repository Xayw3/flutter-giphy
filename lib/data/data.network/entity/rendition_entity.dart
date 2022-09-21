class RenditionEntity {
  final String? url;
  final String? width;
  final String? height;

  RenditionEntity({
    this.height,
    this.url,
    this.width,
  });

  factory RenditionEntity.fromJson(Map<String, dynamic> json) {
    return RenditionEntity(
      url: json['url'] as String?,
      width: json['width'] as String?,
      height: json['height'] as String?,
    );
  }
}