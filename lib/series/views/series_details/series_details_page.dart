import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/series/series.dart';
import 'package:series_repository/series_repository.dart';

import 'series_details_form.dart';

class SeriesDetailsPage extends StatelessWidget {
  const SeriesDetailsPage({Key? key, required this.series}) : super(key: key);

  final Series series;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EpisodesCubit>(
      create: (context) => EpisodesCubit(
        seriesRepository: RepositoryProvider.of<SeriesRepository>(context),
      )..getEpisodes(series.id),
      child: SeriesDetailsForm(series: series),
    );
  }
}
