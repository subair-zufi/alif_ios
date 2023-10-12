import 'package:alif_ios/models/content.dart';
import 'package:alif_ios/models/lesson.dart';
import 'package:alif_ios/pages/content_details_page.dart';
import 'package:alif_ios/services/lesson_service.dart';
import 'package:flutter/material.dart';

class ContentsPage extends StatelessWidget {
  final Lesson lesson;
  const ContentsPage(this.lesson,{super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title??""),
      ),
      body: FutureBuilder<List<Content>>(
        future: LessonService.instance.lessonContents(lesson.id!),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(),);
          return ListView.builder(
            itemCount: snapshot.data?.length??0,
                  
            itemBuilder: (_, index) {
              final myContent = snapshot.data![index];
              return ListTile(
                title: Text(myContent.title!),
                tileColor: index%2==0?const Color(0xfff7f7f7):Colors.white,
                subtitle: Text(myContent.description!),
                leading: myContent.type == 'Video'
                    ? const Icon(Icons.play_circle_outline)
                    : myContent.type == 'PDF'
                        ? const Icon(Icons.insert_drive_file)
                        : const Icon(Icons.title),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ContentDetailsPage(myContent)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
