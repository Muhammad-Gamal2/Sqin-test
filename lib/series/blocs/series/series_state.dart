part of 'series_cubit.dart';

abstract class SeriesState extends Equatable {
  const SeriesState();
}

class SeriesInitial extends SeriesState {
  @override
  List<Object> get props => [];
}

class SeriesLoadInProgress extends SeriesState {
  @override
  List<Object> get props => [];
}

class SeriesLoadSuccess extends SeriesState {
  const SeriesLoadSuccess({required this.series, required this.isLastPage});

  final List<Series> series;
  final bool isLastPage;

  @override
  List<Object> get props => [series];
}

class SeriesLoadFailure extends SeriesState {
  const SeriesLoadFailure({required this.exception});

  final CustomException exception;

  @override
  List<Object> get props => [exception];
}
