import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'series.freezed.dart';
part 'series.g.dart';

@freezed
class Series with _$Series {
  const factory Series({
    required int id,
    SeriesImage? image,
    required String name,
    required List<String> genres,
    String? summary,
    Schedule? schedule,
  }) = _Series;

  factory Series.fromJson(Map<String, Object?> json) => _$SeriesFromJson(json);
}
