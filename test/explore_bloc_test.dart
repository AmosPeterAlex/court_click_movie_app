import 'package:bloc_test/bloc_test.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/features/explore/bloc/explore_bloc.dart';
import 'package:court_click_movie_app/features/explore/bloc/explore_event.dart';
import 'package:court_click_movie_app/features/explore/bloc/explore_state.dart';
import 'package:court_click_movie_app/features/explore/domain/explore_repository.dart';
import 'package:court_click_movie_app/foundation/http/api_exceptions.dart';
import 'package:court_click_movie_app/foundation/http/resource_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRepository extends Mock implements ExploreRepository {}

void main() {
  late MockExploreRepository mockRepository;

  const testMedia = MediaItem(
    id: 101,
    title: 'Extraction',
    overview: 'A black-ops mercenary must rescue an Indian drug lord kidnapped son.',
    posterPath: '/extraction.jpg',
    backdropPath: '/extraction_backdrop.jpg',
    voteAverage: 8.4,
    releaseDate: '2020-04-24',
    genreIds: [28, 53],
  );

  setUp(() {
    mockRepository = MockExploreRepository();
  });

  group('ExploreBloc Unit Tests', () {
    test('initial state is ExploreInitial', () {
      final bloc = ExploreBloc(repository: mockRepository);
      expect(bloc.state, equals(const ExploreInitial()));
      bloc.close();
    });

    blocTest<ExploreBloc, ExploreState>(
      'emits [ExploreLoading, ExploreSuggestionsLoaded] when LoadExploreSuggestions succeeds',
      build: () {
        when(() => mockRepository.fetchSuggestedSearches(page: any(named: 'page')))
            .thenAnswer((_) async => const Success([testMedia]));
        return ExploreBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(const LoadExploreSuggestions()),
      expect: () => [
        const ExploreLoading(),
        const ExploreSuggestionsLoaded([testMedia], page: 1),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchSuggestedSearches(page: 1)).called(1);
      },
    );

    blocTest<ExploreBloc, ExploreState>(
      'emits [ExploreLoading, ExploreError] when LoadExploreSuggestions fails',
      build: () {
        when(() => mockRepository.fetchSuggestedSearches(page: any(named: 'page')))
            .thenAnswer((_) async => const Failure(OfflineException()));
        return ExploreBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(const LoadExploreSuggestions()),
      expect: () => [
        const ExploreLoading(),
        isA<ExploreError>().having((e) => e.message.toLowerCase(), 'message', contains('internet connection')),
      ],
    );

    blocTest<ExploreBloc, ExploreState>(
      'emits [ExploreLoading, ExploreSearchResultsLoaded] when query returns results',
      build: () {
        when(() => mockRepository.queryTitles('Extraction', page: any(named: 'page')))
            .thenAnswer((_) async => const Success([testMedia]));
        return ExploreBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(const SearchQueryChanged('Extraction')),
      expect: () => [
        const ExploreLoading(),
        const ExploreSearchResultsLoaded(
          results: [testMedia],
          query: 'Extraction',
          page: 1,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.queryTitles('Extraction', page: 1)).called(1);
      },
    );

    blocTest<ExploreBloc, ExploreState>(
      'emits [ExploreLoading, ExploreEmptyResults] when query returns empty list',
      build: () {
        when(() => mockRepository.queryTitles('NonExistentMovie', page: any(named: 'page')))
            .thenAnswer((_) async => const Success([]));
        return ExploreBloc(repository: mockRepository);
      },
      act: (bloc) => bloc.add(const SearchQueryChanged('NonExistentMovie')),
      expect: () => [
        const ExploreLoading(),
        const ExploreEmptyResults('NonExistentMovie'),
      ],
    );

    blocTest<ExploreBloc, ExploreState>(
      'emits updated ExploreSearchResultsLoaded with appended items on LoadMoreResults',
      build: () {
        const page2Media = MediaItem(
          id: 102,
          title: 'Extraction 2',
          overview: 'Back from the brink of death.',
          posterPath: '/extraction2.jpg',
          backdropPath: '/extraction2_backdrop.jpg',
          voteAverage: 8.1,
          releaseDate: '2023-06-16',
          genreIds: [28, 53],
        );

        when(() => mockRepository.queryTitles('Extraction', page: 2))
            .thenAnswer((_) async => const Success([page2Media]));
        return ExploreBloc(repository: mockRepository);
      },
      seed: () => const ExploreSearchResultsLoaded(
        results: [testMedia],
        query: 'Extraction',
        page: 1,
      ),
      act: (bloc) => bloc.add(const LoadMoreResults()),
      expect: () => [
        const ExploreSearchResultsLoaded(
          results: [testMedia],
          query: 'Extraction',
          page: 1,
          isLoadingMore: true,
        ),
        const ExploreSearchResultsLoaded(
          results: [
            testMedia,
            MediaItem(
              id: 102,
              title: 'Extraction 2',
              overview: 'Back from the brink of death.',
              posterPath: '/extraction2.jpg',
              backdropPath: '/extraction2_backdrop.jpg',
              voteAverage: 8.1,
              releaseDate: '2023-06-16',
              genreIds: [28, 53],
            ),
          ],
          query: 'Extraction',
          page: 2,
          isLoadingMore: false,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.queryTitles('Extraction', page: 2)).called(1);
      },
    );
  });
}
