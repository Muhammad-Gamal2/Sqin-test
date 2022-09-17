import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_service/network_service.dart';
import 'package:series_repository/series_repository.dart';

part 'episodes_state.dart';

class EpisodesCubit extends Cubit<EpisodesState> {
  EpisodesCubit({required SeriesRepository seriesRepository})
      : _seriesRepository = seriesRepository,
        super(EpisodesInitial());

  final SeriesRepository _seriesRepository;

  Future<void> getEpisodes(int seriesId) async {
    try {
      emit(EpisodesLoadInProgress());
      final episodes =
          await _seriesRepository.getSeriesEpisodes(seriesId: seriesId);
      final episodesMap = <int, List<Episode>>{}
        ..addEntries(episodes.map((e) => MapEntry(e.season, [e])));
      emit(EpisodesLoadSuccess(episodes: episodes, episodesMap: episodesMap));
    } on CustomException catch (e) {
      emit(EpisodesLoadFailure(exception: e));
    } catch (e) {
      emit(
        EpisodesLoadFailure(
          exception: CustomException(
            message: e.toString(),
            errorType: Errors.builtInException,
          ),
        ),
      );
    }
  }
}
