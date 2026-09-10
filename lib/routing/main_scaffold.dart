import 'package:flutter/material.dart';
import '../features/discover/presentation/discover_screen.dart';
import '../features/explore/presentation/explore_screen.dart';
import '../features/offline/offline_downloads_screen.dart';
import '../features/premieres/presentation/premieres_screen.dart';
import '../features/settings/account_hub_screen.dart';
import '../foundation/theme/stream_palette.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key, this.profileName = 'Emenalo'});

  final String profileName;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DiscoverScreen(profileName: widget.profileName),
      const ExploreScreen(),
      const PremieresScreen(),
      OfflineDownloadsScreen(
        onFindSomethingToDownload: () => _onTabSelected(1),
      ),
      const AccountHubScreen(),
    ];

    return Scaffold(
      backgroundColor: StreamPalette.background,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: StreamPalette.bottomNavDivider,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabSelected,
          backgroundColor: StreamPalette.bottomNavBg,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: StreamPalette.textHint,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: [
            _buildNavItem(
              assetPath: 'assets/icons/home.png',
              fallbackIcon: Icons.home_filled,
              label: 'Home',
              isSelected: _currentIndex == 0,
            ),
            _buildNavItem(
              assetPath: 'assets/icons/search.png',
              fallbackIcon: Icons.search,
              label: 'Search',
              isSelected: _currentIndex == 1,
            ),
            // Coming soon tab with red badge "4"
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildNavIcon(
                    assetPath: 'assets/icons/coming_soon.png',
                    fallbackIcon: Icons.video_library_outlined,
                    isSelected: _currentIndex == 2,
                  ),
                  Positioned(
                    top: -4,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: StreamPalette.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: const Center(
                        child: Text(
                          '4',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              label: 'Coming Soon',
            ),
            _buildNavItem(
              assetPath: 'assets/icons/download.png',
              fallbackIcon: Icons.download_outlined,
              label: 'Downloads',
              isSelected: _currentIndex == 3,
            ),
            _buildNavItem(
              assetPath: 'assets/icons/more.png',
              fallbackIcon: Icons.menu,
              label: 'More',
              isSelected: _currentIndex == 4,
            ),
          ],
        ),
      ),
    );
  }

  static BottomNavigationBarItem _buildNavItem({
    required String assetPath,
    required IconData fallbackIcon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: _buildNavIcon(
        assetPath: assetPath,
        fallbackIcon: fallbackIcon,
        isSelected: isSelected,
      ),
      label: label,
    );
  }

  static Widget _buildNavIcon({
    required String assetPath,
    required IconData fallbackIcon,
    required bool isSelected,
  }) {
    final color = isSelected ? Colors.white : StreamPalette.textHint;
    return Image.asset(
      assetPath,
      width: 22,
      height: 22,
      color: color,
      errorBuilder: (_, _, _) => Icon(fallbackIcon, size: 22, color: color),
    );
  }
}
