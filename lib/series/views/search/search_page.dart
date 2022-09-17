import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/series/series.dart';
import 'package:movie_app/series/views/search/search_form.dart';
import 'package:series_repository/series_repository.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
        seriesRepository: RepositoryProvider.of<SeriesRepository>(context),
      ),
      child: const SearchForm(),
    );
  }
}
