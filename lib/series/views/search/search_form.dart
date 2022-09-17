import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/series/series.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchLoadFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.exception.toString()),
              ),
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  onChanged: (query) {
                    if (query.isEmpty) {
                      context
                          .read<SearchBloc>()
                          .add(const SearchQueryCleared());
                      return;
                    }
                    context.read<SearchBloc>().add(
                          SearchQueryChanged(query: query),
                        );
                  },
                ),
              ),
              if (state is SearchLoadInProgress)
                const CircularProgressIndicator()
              else if (state is SearchLoadSuccess)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.series.length,
                    itemBuilder: (context, index) {
                      final series = state.series[index];
                      return SeriesCard(series: series);
                    },
                  ),
                )
              else
                const SizedBox()
            ],
          ),
        );
      },
    );
  }
}
