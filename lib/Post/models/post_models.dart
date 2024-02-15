class PostsModel {
  int id;
  String title;
  String description;
  String imgLink;
  String email;

  PostsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgLink,
    required this.email,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imgLink: json["img_link"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "img_link": imgLink,
        "email": email,
      };
}
