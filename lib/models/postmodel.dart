class PostModel {
  late String name;
  late String uid;
  late String image;
  late String dateTime;
  late String postImage;
  late String postText;

  PostModel({
    required this.name,
    required this.uid,
    required this.image,
    required this.postImage,
    required this.postText,
    required this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    uid = json!['uid'];
    name = json['name'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    postText = json['postText'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'postText': postText,
    };
  }
}
