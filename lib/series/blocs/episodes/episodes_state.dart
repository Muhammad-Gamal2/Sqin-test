part of 'episodes_cubit.dart';

abstract class EpisodesState extends Equatable {
  const EpisodesState();
}

class EpisodesInitial extends EpisodesState {
  @override
  List<Object> get props => [];
}

class EpisodesLoadInProgress extends EpisodesState {
  @override
  List<Object> get props => [];
}

class EpisodesLoadSuccess extends EpisodesState {
  const EpisodesLoadSuccess(
      {required this.episodes, required this.episodesMap});

  final List<Episode> episodes;
  final Map<int, List<Episode>> episodesMap;

  @override
  List<Object> get props => [episodes, episodesMap];
}

class EpisodesLoadFailure extends EpisodesState {
  const EpisodesLoadFailure({required this.exception});

  final CustomException exception;

  @override
  List<Object> get props => [exception];
}
