import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:court_click_movie_app/features/discover/bloc/discover_bloc.dart';
import 'package:court_click_movie_app/features/discover/bloc/discover_event.dart';
import 'package:court_click_movie_app/features/discover/bloc/discover_state.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/features/discover/presentation/widgets/circular_previews_rail.dart';
import 'package:court_click_movie_app/features/discover/presentation/widgets/hero_featured_banner.dart';
import 'package:court_click_movie_app/features/discover/presentation/widgets/movie_category_rail.dart';
import 'package:court_click_movie_app/features/discover/presentation/widgets/movie_detail_sheet.dart';
import 'package:court_click_movie_app/foundation/components/failure_banner.dart';
import 'package:court_click_movie_app/foundation/components/skeleton_loader.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key, this.profileName = 'Emenalo'});

  final String profileName;

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DiscoverBloc>().add(const FetchCatalogFeed());
  }

  void _showItemDetails(MediaItem item) {
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
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoading) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                SkeletonLoader.heroBannerPlaceholder(),
                const SizedBox(height: 16),
                SkeletonLoader.categoryRailPlaceholder(),
                const SizedBox(height: 16),
                SkeletonLoader.categoryRailPlaceholder(),
              ],
            );
          }

          if (state is DiscoverError) {
            return FailureBanner(
              message: state.message,
              onRetry: () => context.read<DiscoverBloc>().add(const FetchCatalogFeed()),
            );
          }

          if (state is DiscoverLoaded) {
            return RefreshIndicator(
              color: StreamPalette.primary,
              backgroundColor: StreamPalette.surface,
              onRefresh: () async {
                context.read<DiscoverBloc>().add(const RefreshCatalogFeed());
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Featured Header
                    HeroFeaturedBanner(
                      item: state.featuredTitle,
                      onPlayTap: () {
                        if (state.featuredTitle != null) {
                          _showItemDetails(state.featuredTitle!);
                        }
                      },
                      onInfoTap: () {
                        if (state.featuredTitle != null) {
                          _showItemDetails(state.featuredTitle!);
                        }
                      },
                    ),

                    // Previews Rail
                    CircularPreviewsRail(
                      items: state.trendingWeekly,
                      onItemTap: _showItemDetails,
                    ),

                    // Popular on Netflix
                    MovieCategoryRail(
                      title: 'Popular on Netflix',
                      items: state.popularNow,
                      onItemTap: _showItemDetails,
                    ),

                    // Trending Now
                    MovieCategoryRail(
                      title: 'Trending Now',
                      items: state.trendingWeekly,
                      onItemTap: _showItemDetails,
                    ),

                    // Top 10 in Nigeria Today
                    MovieCategoryRail(
                      title: 'Top 10 in Nigeria Today',
                      items: state.criticallyAcclaimed,
                      showRankNumbers: true,
                      onItemTap: _showItemDetails,
                    ),

                    // African Movies / Now Playing
                    MovieCategoryRail(
                      title: 'Now Playing',
                      items: state.inTheaters,
                      onItemTap: _showItemDetails,
                    ),

                    // Top Rated
                    MovieCategoryRail(
                      title: 'Critically Acclaimed',
                      items: state.criticallyAcclaimed,
                      onItemTap: _showItemDetails,
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
