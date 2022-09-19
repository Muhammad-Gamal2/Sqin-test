import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:series_repository/series_repository.dart';

class EpisodeDetailsForm extends StatelessWidget {
  const EpisodeDetailsForm({Key? key, required this.episode}) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(episode.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (episode.image?.original != null)
              Image.network(episode.image?.original ?? '', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(episode.name),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Season ${episode.season}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Episode ${episode.number}"),
            ),
            Html(data: episode.summary ?? ''),
          ],
        ),
      ),
    );
  }
}
