class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? country;
  final String? role;
  final String? status;
  final String? profileImage;
  final bool? isCompleteProfile;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.country,
    this.role,
    this.status,
    this.profileImage,
    this.isCompleteProfile,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      country: json['country'],
      role: json['role'],
      status: json['status'],
      profileImage: json['profileImage'],
      isCompleteProfile: json['isCompleteProfile'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'country': country,
      'role': role,
      'status': status,
      'profileImage': profileImage,
      'isCompleteProfile': isCompleteProfile,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
