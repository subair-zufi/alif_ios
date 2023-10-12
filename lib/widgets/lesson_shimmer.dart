import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyLessonShimmer extends StatelessWidget {
  const MyLessonShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Column(
          children: [
            ListTile(
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
                      child: Container(
                        color: Colors.grey,
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
                      Container(
                        width: 150.0,
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Container(
                        height: 10.0,
                        width: 120.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Container(
                        width: 120.0,
                        height: 10.0,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
