import 'package:alif_ios/models/content.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContentDetailsPage extends StatefulWidget {
  const ContentDetailsPage(this.content, {super.key});

  final Content content;

  @override
  State<ContentDetailsPage> createState() => _ContentDetailsPageState();
}

class _ContentDetailsPageState extends State<ContentDetailsPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: extractYoutubeVid(widget.content.content!),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  String extractYoutubeVid(String url) {
    if (url.contains('=')) {
      return url.substring(url.indexOf('=') + 1);
    } else {
      return url.substring(url.lastIndexOf('/') + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF15162B),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
      ),
    );
  }
}
