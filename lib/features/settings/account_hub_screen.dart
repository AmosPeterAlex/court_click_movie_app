import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../foundation/theme/stream_palette.dart';
import '../../foundation/theme/stream_typography.dart';
import '../user_accounts/data/default_accounts.dart';
import '../user_accounts/widgets/account_avatar_card.dart';

class AccountHubScreen extends StatelessWidget {
  const AccountHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamPalette.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Profile switcher horizontal row
              SizedBox(
                height: 98,
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
                            color: const Color(0xFF141414),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFF424242), width: 1.2),
                          ),
                          child: const Center(
                            child: Icon(Icons.add, color: StreamPalette.textPrimary, size: 28),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 16), // Align with labels
                      ],
                    ),
                  ],
                ),
              ),
              // Manage profiles link
              Center(
                child: TextButton.icon(
                  onPressed: () => context.go('/profiles'),
                  icon: const Icon(Icons.edit, size: 14, color: StreamPalette.textSecondary),
                  label: const Text(
                    'Manage Profiles',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: StreamPalette.textSecondary,
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
                  color: StreamPalette.surface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          'Tell friends about Netflix.',
                          style: StreamTypography.sectionHeader.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis non accumsan accumsan quis. Massa,',
                      style: StreamTypography.bodySmall.copyWith(color: StreamPalette.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 11,
                          decoration: TextDecoration.underline,
                          color: StreamPalette.textHint,
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
                            color: Colors.black,
                            child: const Text(
                              'https://netflix.com/share/profile',
                              style: TextStyle(fontSize: 11, color: StreamPalette.textHint),
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
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: const Text(
                              'Copy Link',
                              style: TextStyle(
                                color: Colors.black,
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
                          icon: Icons.chat,
                          bgColor: StreamPalette.shareWhatsApp,
                          label: 'WhatsApp',
                        ),
                        Container(width: 1, height: 28, color: StreamPalette.surfaceVariant),
                        _buildSocialIcon(
                          icon: Icons.facebook,
                          bgColor: StreamPalette.shareFacebook,
                          label: 'Facebook',
                        ),
                        Container(width: 1, height: 28, color: StreamPalette.surfaceVariant),
                        _buildSocialIcon(
                          icon: Icons.mail,
                          bgColor: StreamPalette.shareGmail,
                          label: 'Gmail',
                        ),
                        Container(width: 1, height: 28, color: StreamPalette.surfaceVariant),
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.more_horiz, color: Colors.white, size: 28),
                            SizedBox(height: 4),
                            Text('More', style: TextStyle(fontSize: 11, color: Colors.white)),
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
                color: Colors.black,
                child: const Row(
                  children: [
                    Icon(Icons.check, color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'My List',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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
          style: const TextStyle(fontSize: 11, color: Colors.white),
        ),
      ],
    );
  }

  static Widget _buildSettingItem(
    BuildContext context,
    String title, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: StreamPalette.textPrimary,
          ),
        ),
      ),
    );
  }
}
