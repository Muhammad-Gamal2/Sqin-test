import 'package:flutter/material.dart';
import 'package:series_repository/series_repository.dart';

import 'episode_details_form.dart';

class EpisodeDetailsPage extends StatelessWidget {
  const EpisodeDetailsPage({Key? key, required this.episode}) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return EpisodeDetailsForm(episode: episode);
  }
}
