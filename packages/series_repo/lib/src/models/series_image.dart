import 'package:freezed_annotation/freezed_annotation.dart';

part 'series_image.freezed.dart';
part 'series_image.g.dart';

@freezed
class SeriesImage with _$SeriesImage {
  const factory SeriesImage({
    required String medium,
    required String original,
  }) = _SeriesImage;

  factory SeriesImage.fromJson(Map<String, Object?> json) =>
      _$SeriesImageFromJson(json);
}
