class UserModel {
  final String? name;
  final String? email;
  final String? id;
  final String? phone;

  UserModel({
    this.name,
    this.email,
    this.id,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
        id: json!['id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
      };
}
