import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/features/discover/presentation/widgets/movie_detail_sheet.dart';
import 'package:court_click_movie_app/features/explore/bloc/explore_bloc.dart';
import 'package:court_click_movie_app/features/explore/bloc/explore_event.dart';
import 'package:court_click_movie_app/features/explore/bloc/explore_state.dart';
import 'package:court_click_movie_app/features/explore/presentation/widgets/search_result_tile.dart';
import 'package:court_click_movie_app/foundation/components/failure_banner.dart';
import 'package:court_click_movie_app/foundation/components/no_results_display.dart';
import 'package:court_click_movie_app/foundation/components/skeleton_loader.dart';
import 'package:court_click_movie_app/foundation/helpers/event_debouncer.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';
import 'package:court_click_movie_app/foundation/theme/stream_typography.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _controller = TextEditingController();
  final EventDebouncer _debouncer = EventDebouncer();

  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(const LoadExploreSuggestions());
  }

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      if (mounted) {
        context.read<ExploreBloc>().add(SearchQueryChanged(query));
      }
    });
    setState(() {});
  }

  void _onClear() {
    _controller.clear();
    context.read<ExploreBloc>().add(const ClearSearchQuery());
    setState(() {});
  }

  void _showDetails(MediaItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MovieDetailSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamPalette.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Search Bar matching Screenshot 4
            Container(
              height: 44,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: StreamPalette.searchBarBg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Icon(Icons.search, color: StreamPalette.searchIconHint, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: _onSearchChanged,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Search for a show, movie, genre, etc.',
                        hintStyle: TextStyle(
                          color: StreamPalette.searchIconHint,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.close, color: StreamPalette.searchIconHint, size: 18),
                      onPressed: _onClear,
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.mic, color: StreamPalette.searchIconHint, size: 20),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Content
            Expanded(
              child: BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  if (state is ExploreLoading) {
                    return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (_, _) => SkeletonLoader.tileRowPlaceholder(),
                    );
                  }

                  if (state is ExploreError) {
                    return FailureBanner(
                      message: state.message,
                      onRetry: () => context.read<ExploreBloc>().add(
                            _controller.text.isEmpty
                                ? const LoadExploreSuggestions()
                                : SearchQueryChanged(_controller.text),
                          ),
                    );
                  }

                  if (state is ExploreEmptyResults) {
                    return NoResultsDisplay(
                      title: "No results found for '${state.query}'",
                    );
                  }

                  final List<MediaItem> items;
                  final String headerTitle;

                  if (state is ExploreSearchResultsLoaded) {
                    items = state.results;
                    headerTitle = 'Movies & TV';
                  } else if (state is ExploreSuggestionsLoaded) {
                    items = state.suggestions;
                    headerTitle = 'Top Searches';
                  } else {
                    items = const [];
                    headerTitle = 'Top Searches';
                  }

                  return ListView.builder(
                    itemCount: items.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Text(
                            headerTitle,
                            style: StreamTypography.headline.copyWith(fontSize: 20),
                          ),
                        );
                      }
                      final item = items[index - 1];
                      return SearchResultTile(
                        item: item,
                        isTop10: index == 1,
                        onTap: () => _showDetails(item),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
