import 'package:alif_ios/models/content.dart';
import 'package:alif_ios/models/enrolment.dart';
import 'package:alif_ios/models/lesson.dart';
import 'package:alif_ios/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonService {
  LessonService._();

  static LessonService instance = LessonService._();

  factory LessonService() => instance;

  Future<List<Enrolment>> userLessons() async {
    print(StorageService.instance.userId);
    final doc = await Enrolment().dbRef(StorageService.instance.userId).get();
    return doc.docs.map((e) => e.data()).toList();
  }
  Future<Lesson?> lessonNameById(String id)async{
    final doc = await FirebaseFirestore.instance.collection('courses').doc(id).get();
    return doc.exists?Lesson.fromMap(doc.data()!):null;
  }
  Future<List<Content>> lessonContents(String lessonId) async {
    final doc = await Content().ref(lessonId).get();
    return doc.docs.map((e) => e.data()).toList();
  }
}
