part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchQueryChanged extends SearchEvent {
  const SearchQueryChanged({required this.query});

  final String query;

  @override
  List<Object> get props => <Object>[query];
}

class SearchQueryCleared extends SearchEvent {
  const SearchQueryCleared();

  @override
  List<Object> get props => <Object>[];
}
