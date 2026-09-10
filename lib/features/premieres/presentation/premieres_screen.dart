import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/features/discover/presentation/widgets/movie_detail_sheet.dart';
import 'package:court_click_movie_app/features/premieres/bloc/premieres_bloc.dart';
import 'package:court_click_movie_app/features/premieres/bloc/premieres_event.dart';
import 'package:court_click_movie_app/features/premieres/bloc/premieres_state.dart';
import 'package:court_click_movie_app/features/premieres/presentation/widgets/notification_item_row.dart';
import 'package:court_click_movie_app/features/premieres/presentation/widgets/upcoming_movie_card.dart';
import 'package:court_click_movie_app/foundation/components/failure_banner.dart';
import 'package:court_click_movie_app/foundation/components/skeleton_loader.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';

class PremieresScreen extends StatefulWidget {
  const PremieresScreen({super.key});

  @override
  State<PremieresScreen> createState() => _PremieresScreenState();
}

class _PremieresScreenState extends State<PremieresScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PremieresBloc>().add(const FetchPremieresFeed());
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<PremieresBloc, PremieresState>(
          builder: (context, state) {
            if (state is PremieresLoading) {
              return ListView(
                children: [
                  const SizedBox(height: 16),
                  SkeletonLoader.tileRowPlaceholder(),
                  SkeletonLoader.tileRowPlaceholder(),
                  const SizedBox(height: 24),
                  SkeletonLoader.heroBannerPlaceholder(),
                ],
              );
            }

            if (state is PremieresError) {
              return FailureBanner(
                message: state.message,
                onRetry: () => context.read<PremieresBloc>().add(const FetchPremieresFeed()),
              );
            }

            if (state is PremieresLoaded) {
              return RefreshIndicator(
                color: StreamPalette.primary,
                backgroundColor: theme.cardColor,
                onRefresh: () async {
                  context.read<PremieresBloc>().add(const RefreshPremieresFeed());
                },
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 32),
                  children: [
                    // Notifications header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: StreamPalette.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Top 2 arrival previews
                    ...state.notificationPreviews.map(
                      (item) => NotificationItemRow(
                        item: item,
                        onTap: () => _showDetails(item),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Upcoming Movie Feed
                    ...state.upcomingFeed.map(
                      (item) => UpcomingMovieCard(
                        item: item,
                        onTap: () => _showDetails(item),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
