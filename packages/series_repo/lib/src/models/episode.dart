import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'episode.freezed.dart';
part 'episode.g.dart';

@freezed
class Episode with _$Episode {
  const factory Episode({
    required int id,
    SeriesImage? image,
    required String name,
    required int season,
    required int number,
    required String summary,
  }) = _Episode;

  factory Episode.fromJson(Map<String, Object?> json) =>
      _$EpisodeFromJson(json);
}
