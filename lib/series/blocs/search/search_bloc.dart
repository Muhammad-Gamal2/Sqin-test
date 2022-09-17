import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_service/network_service.dart';
import 'package:series_repository/series_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 400);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required SeriesRepository seriesRepository})
      : _seriesRepository = seriesRepository,
        super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged,
        transformer: debounce(_duration));
    on<SearchQueryCleared>(_onSearchQueryCleared);
  }

  final SeriesRepository _seriesRepository;

  _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadInProgress());
    try {
      final List<Series> series =
          await _seriesRepository.getSearchSeries(query: event.query);
      emit(SearchLoadSuccess(series: series));
    } on CustomException catch (error) {
      emit(SearchLoadFailure(exception: error));
    } catch (error) {
      emit(SearchLoadFailure(
          exception: CustomException(
              message: error.toString(), errorType: Errors.builtInException)));
    }
  }

  _onSearchQueryCleared(
    SearchQueryCleared event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchInitial());
  }
}
