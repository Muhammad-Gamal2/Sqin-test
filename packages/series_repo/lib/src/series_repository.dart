import 'package:network_service/network_service.dart';
import 'package:series_repository/series_repository.dart';

class SeriesRepository {
  SeriesRepository({NetworkService? networkService})
      : _networkService = networkService ?? NetworkService();

  final NetworkService _networkService;

  /// list all of the series.
  ///
  /// [page] parameter is the page number.
  Future<List<Series>> getSeries({
    required int page,
  }) async {
    const showRequest = '/shows';

    final response = await _networkService.get(showRequest, queryParameters: {
      "page": page,
    });

    return List<Series>.from(
      response.data.map(
        (series) => Series.fromJson(series),
      ),
    );
  }

  /// search series by name.
  ///
  /// [query] parameter is the search key word.
  Future<List<Series>> getSearchSeries({
    required String query,
  }) async {
    const searchRequest = '/search/shows';

    final response = await _networkService.get(
      searchRequest,
      queryParameters: {
        "q": query,
      },
    );

    return List<Series>.from(
      response.data.map(
        (model) => Series.fromJson(model['show']),
      ),
    );
  }

  /// list all of the series' episodes.
  ///
  /// [seriesId] parameter is the series id.
  Future<List<Episode>> getSeriesEpisodes({
    required int seriesId,
  }) async {
    final episodesRequest = '/shows/$seriesId/episodes';

    final response = await _networkService.get(episodesRequest);

    return List<Episode>.from(
      response.data.map(
        (episode) => Episode.fromJson(episode),
      ),
    );
  }
}
