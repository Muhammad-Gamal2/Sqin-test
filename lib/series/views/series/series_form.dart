import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/series/series.dart';
import 'package:series_repository/series_repository.dart';

class SeriesForm extends StatefulWidget {
  const SeriesForm({Key? key}) : super(key: key);

  @override
  State<SeriesForm> createState() => _SeriesFormState();
}

class _SeriesFormState extends State<SeriesForm> {
  final PagingController<int, Series> _pagingController =
      PagingController<int, Series>(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener(
      (int pageKey) {
        context.read<SeriesCubit>().getSeries(page: pageKey);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Series'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocListener<SeriesCubit, SeriesState>(
        listener: (context, state) {
          if (state is SeriesLoadSuccess) {
            if (state.isLastPage) {
              _pagingController.appendLastPage(state.series);
            } else {
              final int nextPageKey = (_pagingController.nextPageKey ?? 1) + 1;
              _pagingController.appendPage(state.series, nextPageKey);
            }
          }
          if (state is SeriesLoadFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.exception.toString()),
                ),
              );
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _pagingController.refresh();
          },
          child: PagedListView<int, Series>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Series>(
              itemBuilder: (BuildContext context, Series item, int index) {
                return SeriesCard(series: item);
              },
              noItemsFoundIndicatorBuilder: (BuildContext context) {
                return Center(
                  child: Text(
                    "no series found",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                  ),
                );
              },
              newPageProgressIndicatorBuilder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              firstPageProgressIndicatorBuilder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
