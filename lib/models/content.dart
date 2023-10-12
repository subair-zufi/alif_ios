import 'package:cloud_firestore/cloud_firestore.dart';

class Content {
  String? id;
  String? courseId;
  String? type;
  String? content;
  String? title;
  String? description;
  bool? free;
  int? createdAt;

  Content({
    this.id,
    this.courseId,
    this.type,
    this.content,
    this.title,
    this.description,
    this.free,
    this.createdAt,
  });

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      id: map['id'] as String?,
      courseId: map['courseId'] as String?,
      type: map['type'] as String?,
      content: map['content'] as String?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      free: map['free'] as bool?,
      createdAt: map['createdAt'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'type': type,
      'content': content,
      'title': title,
      'description': description,
      'free': free,
      'createdAt': createdAt,
    };
  }

  CollectionReference<Content> ref(String? courseId) =>
      FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId)
          .collection('contents')
          .withConverter(
            fromFirestore: (snap, _) => Content.fromMap(snap.data()!),
            toFirestore: (Content content, _) => content.toMap(),
          );

  DocumentReference<Content> contentById(String? courseId, String? contentId) =>
      FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId)
          .collection('contents')
          .doc(contentId)
          .withConverter(
            fromFirestore: (snap, _) => Content.fromMap(snap.data()!),
            toFirestore: (Content content, _) => content.toMap(),
          );
}
