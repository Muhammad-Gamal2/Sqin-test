import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/series/series.dart';
import 'package:movie_app/series/views/series/series_form.dart';
import 'package:series_repository/series_repository.dart';

class SeriesPage extends StatelessWidget {
  const SeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeriesCubit>(
      create: (context) => SeriesCubit(
        seriesRepository: RepositoryProvider.of<SeriesRepository>(context),
      ),
      child: const SeriesForm(),
    );
  }
}
