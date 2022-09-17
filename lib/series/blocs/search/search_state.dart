part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadInProgress extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadSuccess extends SearchState {
  const SearchLoadSuccess({required this.series});

  final List<Series> series;

  @override
  List<Object> get props => [series];
}

class SearchLoadFailure extends SearchState {
  const SearchLoadFailure({required this.exception});

  final CustomException exception;

  @override
  List<Object> get props => [exception];
}
