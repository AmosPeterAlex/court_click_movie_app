import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../foundation/theme/stream_palette.dart';
import '../../foundation/theme/theme_cubit.dart';
import '../user_accounts/bloc/active_profile_cubit.dart';
import '../user_accounts/data/default_accounts.dart';
import '../user_accounts/domain/user_account.dart';
import '../user_accounts/widgets/account_avatar_card.dart';

class AccountHubScreen extends StatelessWidget {
  const AccountHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Profile switcher horizontal row with active state
              BlocBuilder<ActiveProfileCubit, UserAccount>(
                builder: (context, activeAccount) {
                  return SizedBox(
                    height: 104,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...DefaultAccounts.profiles.map(
                          (account) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: AccountAvatarCard(
                              account: account,
                              size: 58,
                              borderRadius: 4,
                              isSelected: activeAccount.id == account.id,
                              onTap: () {
                                context.read<ActiveProfileCubit>().selectProfile(account);
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Switched to ${account.name}'),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Add Profile square
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF141414) : const Color(0xFFE5E5EA),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: isDark ? const Color(0xFF424242) : const Color(0xFFBDBDBD),
                                  width: 1.2,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: theme.colorScheme.onSurface,
                                  size: 28,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(height: 16), // Align with labels
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Manage profiles link
              Center(
                child: TextButton.icon(
                  onPressed: () => context.go('/profiles'),
                  icon: Icon(Icons.edit, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                  label: Text(
                    'Manage Profiles',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Tell friends card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isDark
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.chat_bubble_outline_rounded, color: theme.colorScheme.onSurface, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          'Tell friends about Netflix.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis non accumsan accumsan quis. Massa,',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 11,
                          decoration: TextDecoration.underline,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Copy link bar
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF141414) : const Color(0xFFE5E5EA),
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(4)),
                            ),
                            child: Text(
                              'https://netflix.com/share/profile',
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                              const ClipboardData(text: 'https://netflix.com/share/profile'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Link copied to clipboard')),
                            );
                          },
                          child: Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white : Colors.black,
                              borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Copy Link',
                              style: TextStyle(
                                color: isDark ? Colors.black : Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Social buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSocialIcon(
                          context: context,
                          icon: Icons.chat,
                          bgColor: StreamPalette.shareWhatsApp,
                          label: 'WhatsApp',
                        ),
                        Container(width: 1, height: 28, color: theme.dividerColor),
                        _buildSocialIcon(
                          context: context,
                          icon: Icons.facebook,
                          bgColor: StreamPalette.shareFacebook,
                          label: 'Facebook',
                        ),
                        Container(width: 1, height: 28, color: theme.dividerColor),
                        _buildSocialIcon(
                          context: context,
                          icon: Icons.mail,
                          bgColor: StreamPalette.shareGmail,
                          label: 'Gmail',
                        ),
                        Container(width: 1, height: 28, color: theme.dividerColor),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.more_horiz, color: theme.colorScheme.onSurface, size: 28),
                            const SizedBox(height: 4),
                            Text('More', style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // My List Row
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                color: theme.cardColor,
                child: Row(
                  children: [
                    Icon(Icons.check, color: theme.colorScheme.onSurface, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'My List',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              // Dark / Light Theme Mode Toggle
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  final isCurrentDark = themeMode == ThemeMode.dark;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCurrentDark ? Icons.dark_mode : Icons.light_mode,
                              color: theme.colorScheme.onSurface,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              isCurrentDark ? 'Dark Mode' : 'Light Mode',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: isCurrentDark,
                          activeThumbColor: StreamPalette.primary,
                          onChanged: (_) {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Setting links
              _buildSettingItem(context, 'App Settings'),
              _buildSettingItem(context, 'Account'),
              _buildSettingItem(context, 'Help'),
              _buildSettingItem(
                context,
                'Sign Out',
                onTap: () => context.go('/profiles'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildSocialIcon({
    required BuildContext context,
    required IconData icon,
    required Color bgColor,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface),
        ),
      ],
    );
  }

  static Widget _buildSettingItem(
    BuildContext context,
    String title, {
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
