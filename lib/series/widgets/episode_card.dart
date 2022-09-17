import 'package:flutter/material.dart';
import 'package:movie_app/series/series.dart';
import 'package:series_repository/series_repository.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EpisodeDetailsPage(
              episode: episode,
            ),
          ));
        },
        title: Text(episode.name),
        leading: episode.image?.medium != null
            ? Image.network(episode.image?.medium ?? '')
            : const SizedBox(),
      ),
    );
  }
}
