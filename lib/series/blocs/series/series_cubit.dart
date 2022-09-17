import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_service/network_service.dart';
import 'package:series_repository/series_repository.dart';

part 'series_state.dart';

class SeriesCubit extends Cubit<SeriesState> {
  SeriesCubit({required SeriesRepository seriesRepository})
      : _seriesRepository = seriesRepository,
        super(SeriesInitial());

  final SeriesRepository _seriesRepository;

  Future<void> getSeries({required int page}) async {
    emit(SeriesLoadInProgress());
    try {
      final List<Series> series = await _seriesRepository.getSeries(page: page);
      emit(
        SeriesLoadSuccess(series: series, isLastPage: series.length < 200),
      );
    } on CustomException catch (error) {
      emit(SeriesLoadFailure(exception: error));
    } catch (error) {
      emit(
        SeriesLoadFailure(
          exception: CustomException(
            message: error.toString(),
            errorType: Errors.builtInException,
          ),
        ),
      );
    }
  }
}
