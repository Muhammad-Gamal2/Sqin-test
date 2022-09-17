import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:movie_app/series/series.dart';
import 'package:series_repository/series_repository.dart';

class SeriesDetailsForm extends StatelessWidget {
  const SeriesDetailsForm({Key? key, required this.series}) : super(key: key);

  final Series series;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(series.name),
      ),
      body: BlocConsumer<EpisodesCubit, EpisodesState>(
        listener: (context, state) {
          if (state is EpisodesLoadFailure) {
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
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    if (series.image?.original != null)
                      Image.network(series.image?.original ?? '',
                          height: height * 0.8, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(series.name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(series.genres.join(', ')),
                    ),
                    Html(data: series.summary),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Episodes",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (state is EpisodesLoadSuccess)
                      ...state.episodesMap.keys.map((key) {
                        return ExpansionTile(
                          title: Text("Season $key"),
                          children: [
                            ...state.episodesMap[key]!.map((episode) {
                              return EpisodeCard(
                                episode: episode,
                              );
                            }).toList()
                          ],
                        );
                      }),
                    if (state is EpisodesLoadInProgress)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
//
// return Padding(
// padding: const EdgeInsets.symmetric(vertical: 4.0),
// child: ListTile(
// title: Text(episode.name),
// leading: episode.image?.medium != null
// ? Image.network(episode.image?.medium ?? '')
// : const SizedBox(),
// ),
// );
