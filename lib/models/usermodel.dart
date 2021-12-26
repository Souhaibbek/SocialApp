class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uid;
  late String image;
  late String cover;
  late String bio;
  late bool isVerify;

  SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isVerify,
  });

  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    uid = json!['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isVerify = json['isverify'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'cover':cover,
      'bio' : bio,
      'isverify': isVerify,
    };
  }
}
