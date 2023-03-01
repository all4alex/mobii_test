class UserDto {
  String? id;
  String? name;
  String? imageUrl;

  UserDto({this.id, this.name, this.imageUrl});

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json['id'] as String?,
        name: json['name'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
      };
}
