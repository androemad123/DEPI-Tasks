class UserModel {
  final String id;
  final String name;
  final String? profileImageUrl;
  final bool isOnline;

  const UserModel({
    required this.id,
    required this.name,
    this.profileImageUrl,
    this.isOnline = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      profileImageUrl: map['profileImageUrl'],
      isOnline: map['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'isOnline': isOnline,
    };
  }
}
