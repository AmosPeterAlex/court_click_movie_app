import 'package:equatable/equatable.dart';
import '../../../foundation/constants/tmdb_endpoints.dart';

class MediaItem extends Equatable {
  const MediaItem({
    required this.id,
    required this.title,
    this.originalTitle,
    this.overview = '',
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage = 0.0,
    this.voteCount = 0,
    this.popularity = 0.0,
    this.genreIds = const [],
    this.mediaType,
    this.adult = false,
    this.video = false,
    this.originalLanguage,
  });

  final int id;
  final String title;
  final String? originalTitle;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<int> genreIds;
  final String? mediaType;
  final bool adult;
  final bool video;
  final String? originalLanguage;

  String get posterUrl {
    if (posterPath == null || posterPath!.isEmpty) return '';
    return '${TmdbEndpoints.posterBaseUrl}$posterPath';
  }

  String get backdropUrl {
    if (backdropPath == null || backdropPath!.isEmpty) return '';
    return '${TmdbEndpoints.originalImageBaseUrl}$backdropPath';
  }

  static const Map<int, String> _genreLabels = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Sci-Fi',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
    10759: 'Action & Adventure',
    10762: 'Kids',
    10765: 'Sci-Fi & Fantasy',
    10766: 'Soap',
  };

  List<String> get genreNames {
    return genreIds.map((id) => _genreLabels[id]).whereType<String>().toList();
  }

  String get formattedGenres {
    if (genreNames.isEmpty) return 'Trending • Popular';
    return genreNames.take(4).join(' • ');
  }

  String get formattedPremiereDate {
    if (releaseDate == null || releaseDate!.isEmpty) return 'Coming Soon';
    try {
      final tokens = releaseDate!.split('-');
      if (tokens.length >= 3) {
        final year = tokens[0];
        final monthIdx = int.tryParse(tokens[1]) ?? 1;
        final day = int.tryParse(tokens[2]) ?? 1;
        const monthNames = [
          'January', 'February', 'March', 'April', 'May', 'June',
          'July', 'August', 'September', 'October', 'November', 'December'
        ];
        if (monthIdx >= 1 && monthIdx <= 12) {
          return 'Coming ${monthNames[monthIdx - 1]} $day, $year';
        }
      }
    } catch (_) {}
    return 'Coming $releaseDate';
  }

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] ?? json['name'] ?? 'Untitled') as String,
      originalTitle: (json['original_title'] ?? json['original_name']) as String?,
      overview: (json['overview'] as String?) ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: (json['release_date'] ?? json['first_air_date']) as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      mediaType: json['media_type'] as String?,
      adult: (json['adult'] as bool?) ?? false,
      video: (json['video'] as bool?) ?? false,
      originalLanguage: json['original_language'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      if (originalTitle != null) 'original_title': originalTitle,
      'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (releaseDate != null) 'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'genre_ids': genreIds,
      if (mediaType != null) 'media_type': mediaType,
      'adult': adult,
      'video': video,
      if (originalLanguage != null) 'original_language': originalLanguage,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        originalTitle,
        overview,
        posterPath,
        backdropPath,
        releaseDate,
        voteAverage,
        voteCount,
        popularity,
        genreIds,
        mediaType,
        adult,
        video,
        originalLanguage,
      ];
}
