import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String title;
  final String? link;
  final String? description;
  final int commentCount;
  final String ProfilePic;
  final String username;
  final String uid;
  final String type;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    this.link,
    this.description,
    required this.commentCount,
    required this.username,
    required this.ProfilePic,
    required this.uid,
    required this.type,
    required this.createdAt,

  });

  Post copyWith({
    String? id,
    String? title,
    String? link,
    String? description,
    String? ProfilePic,
    int? commentCount,
    String? username,
    String? uid,
    String? type,
    DateTime? createdAt,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      description: description ?? this.description,
      commentCount: commentCount ?? this.commentCount,
      username: username ?? this.username,
      ProfilePic: ProfilePic ?? this.ProfilePic,
      uid: uid ?? this.uid,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'link': link,
      'description': description,
      'commentCount': commentCount,
      'username': username,
      'ProfilePic': ProfilePic,
      'uid': uid,
      'type': type,
      'createdAt': createdAt.millisecondsSinceEpoch,

    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      link: map['link'],
      description: map['description'],
      commentCount: map['commentCount']?.toInt() ?? 0,
      username: map['username'] ?? '',
      ProfilePic: map['ProfilePic'] ?? '',
      uid: map['uid'] ?? '',
      type: map['type'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),

    );
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title, link: $link, description: $description,  commentCount: $commentCount, username: $username,ProfilePic: $ProfilePic, uid: $uid, type: $type, createdAt: $createdAt, )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.id == id &&
        other.title == title &&
        other.link == link &&
        other.description == description &&
        other.commentCount == commentCount &&
        other.username == username &&
        other.ProfilePic == ProfilePic &&
        other.uid == uid &&
        other.type == type &&
        other.createdAt == createdAt ;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    title.hashCode ^
    link.hashCode ^
    description.hashCode ^
    commentCount.hashCode ^
    username.hashCode ^
    ProfilePic.hashCode ^
    uid.hashCode ^
    type.hashCode ^
    createdAt.hashCode ;
  }
}