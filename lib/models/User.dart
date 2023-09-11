
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  List<String> images;
  String name;
  String description;
  int likeCount;
  String location;
  int age;
  List<String> tags;

  User({
    required this.images,
    required this.name,
    required this.description,
    required this.likeCount,
    required this.location,
    required this.age,
    required this.tags,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    images: List<String>.from(json["images"].map((x) => x)),
    name: json["name"],
    description: json["description"],
    likeCount: json["likeCount"],
    location: json["location"],
    age: json["age"],
    tags: List<String>.from(json["tags"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "images": List<dynamic>.from(images.map((x) => x)),
    "name": name,
    "description": description,
    "likeCount": likeCount,
    "location": location,
    "age": age,
    "tags": List<dynamic>.from(tags.map((x) => x)),
  };
}
