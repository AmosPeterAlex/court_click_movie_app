import 'package:flutter_test/flutter_test.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';

void main() {
  group('MediaItem Tests', () {
    test('parses standard movie JSON correctly', () {
      final json = {
        'id': 101,
        'title': 'Inception',
        'overview': 'A dream within a dream.',
        'poster_path': '/inception.jpg',
        'backdrop_path': '/inception_bg.jpg',
        'release_date': '2010-07-16',
        'vote_average': 8.8,
        'vote_count': 35000,
        'popularity': 120.5,
        'genre_ids': [28, 878, 12],
        'adult': false,
        'video': false,
        'original_language': 'en',
      };

      final item = MediaItem.fromJson(json);

      expect(item.id, 101);
      expect(item.title, 'Inception');
      expect(item.posterUrl, contains('/inception.jpg'));
      expect(item.backdropUrl, contains('/inception_bg.jpg'));
      expect(item.genreNames, ['Action', 'Sci-Fi', 'Adventure']);
      expect(item.formattedGenres, 'Action • Sci-Fi • Adventure');
      expect(item.formattedPremiereDate, 'Coming July 16, 2010');
      expect(item.voteAverage, 8.8);
    });

    test('parses TV show fallback fields (name, first_air_date)', () {
      final json = {
        'id': 202,
        'name': 'Stranger Things',
        'first_air_date': '2016-07-15',
        'overview': 'Hawkins adventures.',
        'genre_ids': [18, 9648, 10765],
      };

      final item = MediaItem.fromJson(json);

      expect(item.id, 202);
      expect(item.title, 'Stranger Things');
      expect(item.releaseDate, '2016-07-15');
      expect(item.formattedPremiereDate, 'Coming July 15, 2016');
      expect(item.genreNames, ['Drama', 'Mystery', 'Sci-Fi & Fantasy']);
    });

    test('serializes to JSON correctly', () {
      const item = MediaItem(
        id: 303,
        title: 'Interstellar',
        overview: 'Mankind was born on Earth...',
        genreIds: [12, 18, 878],
        voteAverage: 8.7,
      );

      final json = item.toJson();
      expect(json['id'], 303);
      expect(json['title'], 'Interstellar');
      expect(json['vote_average'], 8.7);
      expect(json['genre_ids'], [12, 18, 878]);
    });

    test('handles empty or missing genres gracefully', () {
      const item = MediaItem(
        id: 404,
        title: 'Unknown Media',
      );

      expect(item.genreNames, isEmpty);
      expect(item.formattedGenres, 'Trending • Popular');
      expect(item.formattedPremiereDate, 'Coming Soon');
    });
  });
}
