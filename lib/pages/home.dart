import 'package:alif_ios/models/enrolment.dart';
import 'package:alif_ios/models/lesson.dart';
import 'package:alif_ios/pages/contents_page.dart';
import 'package:alif_ios/services/lesson_service.dart';
import 'package:alif_ios/services/storage_service.dart';
import 'package:alif_ios/widgets/auth_dialog.dart';
import 'package:alif_ios/widgets/lesson_shimmer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lessons"),
        actions: [
          if(StorageService.instance.isLoggedIn)
          IconButton(
              onPressed: () {
                StorageService.instance.logout();
                setState(() {});
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StorageService.instance.isLoggedIn
          ? FutureBuilder<List<Enrolment>>(
              future: LessonService.instance.userLessons(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const MyLessonShimmer();
                }
                return ListView.separated(
                  itemBuilder: (_, i) {
                    return _LessonTile(snapshot.data![i]);
                  },
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 0,
                  ),
                );
              })
          : Center(
              child: SizedBox(
                height: 50,
                width: 140,
                child: OutlinedButton(
                    onPressed: () async {
                      await showDialog(
                          context: context, builder: (_) => const AuthDialog());
                      setState(() {});
                    },
                    style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.teal, width: 2)),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final Enrolment lesson;

  const _LessonTile(this.lesson, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Lesson?>(
        future: LessonService.instance.lessonNameById(lesson.courseId!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const MyLessonShimmer();
          final item = snapshot.data!;
          return ListTile(
            title: Row(
              children: [
                Container(
                  height: 60.0,
                  width: 60.0,
                  margin: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(13.0),
                      topLeft: Radius.circular(13.0),
                      bottomLeft: Radius.circular(13.0),
                    ),
                    child: Hero(
                      tag: lesson.courseId!,
                      child: Image.network(
                        item.imgUrl ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .50,
                      child: Text(item.title ?? ""),
                    ),
                  ],
                )
              ],
            ),
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ContentsPage(item)));
            },
          );
        });
  }
}
