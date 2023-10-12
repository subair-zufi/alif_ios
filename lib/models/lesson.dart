import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  String? id;
  String? title;
  String? description;
  String? imgUrl;
  String? medium;
  String? introVideo;
  int? createdAt;
  String? category;
  double? price;
  double? discount;
  double? tax;
  double? otherCharge;
  /// usually when a course is added, the thumbnails will be shown to all users
  /// To resolve issue of having blank course only 'live' courses are shown to users.
  /// 
  /// 
  /// **statuses**
  /// - "live"
  /// - "waiting"
  String? status;

  Lesson({
    this.id,
    this.title,
    this.description,
    this.imgUrl,
    this.medium,
    this.introVideo,
    this.createdAt,
    this.category,
    this.price,
    this.discount,
    this.tax,
    this.otherCharge,
    this.status,
  });

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] as String?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      imgUrl: map['imgUrl'] as String?,
      medium: map['medium'] as String?,
      introVideo: map['introVideo'] as String?,
      createdAt: map['createdAt'] as int?,
      category: map['category'] as String?,
      price: map['price'].toDouble() as double?,
      discount: map['discount'].toDouble() as double?,
      tax: map['tax'].toDouble() as double?,
      otherCharge: map['otherCharge'].toDouble() as double?,
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imgUrl': imgUrl,
      'medium': medium,
      'introVideo': introVideo,
      'createdAt': createdAt,
      'category': category,
      'price': price,
      'discount': discount,
      'tax': tax,
      'otherCharge': otherCharge,
      'status': status,
    };
  }

  

  CollectionReference<Lesson> ref = FirebaseFirestore.instance
      .collection('courses')
      .withConverter(
          fromFirestore: (snap, _) => Lesson.fromMap(snap.data()!),
          toFirestore: (Lesson course, _) => course.toMap());

  Query<Lesson> refByCategoryId(String? categoryId) =>
      FirebaseFirestore.instance
          .collection('courses')
          .where('category', isEqualTo: categoryId)
          .withConverter(
              fromFirestore: (snap, _) => Lesson.fromMap(snap.data()!),
              toFirestore: (Lesson course, _) => course.toMap());

  DocumentReference<Lesson> docRef(String? courseId) =>
      FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId)
          .withConverter(
              fromFirestore: (snap, _) => Lesson.fromMap(snap.data()!),
              toFirestore: (Lesson course, _) => course.toMap());
}
