// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Episode _$$_EpisodeFromJson(Map<String, dynamic> json) => _$_Episode(
      id: json['id'] as int,
      image: json['image'] == null
          ? null
          : SeriesImage.fromJson(json['image'] as Map<String, dynamic>),
      name: json['name'] as String,
      season: json['season'] as int,
      number: json['number'] as int,
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$$_EpisodeToJson(_$_Episode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'season': instance.season,
      'number': instance.number,
      'summary': instance.summary,
    };
