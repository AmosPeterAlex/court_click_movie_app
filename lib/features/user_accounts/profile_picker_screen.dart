import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../foundation/theme/stream_palette.dart';
import '../../foundation/theme/stream_typography.dart';
import 'data/default_accounts.dart';
import 'domain/user_account.dart';
import 'widgets/account_avatar_card.dart';

class ProfilePickerScreen extends StatelessWidget {
  const ProfilePickerScreen({super.key});

  void _handleAccountChosen(BuildContext context, UserAccount account) {
    context.go('/main', extra: account.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 28,
          errorBuilder: (_, _, _) => const Text(
            'NETFLIX',
            style: TextStyle(
              color: StreamPalette.primary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, size: 22, color: theme.colorScheme.onSurface),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 28,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: DefaultAccounts.profiles.map((account) {
                  return AccountAvatarCard(
                    account: account,
                    size: 104,
                    onTap: () => _handleAccountChosen(context, account),
                  );
                }).toList(),
              ),
              const SizedBox(height: 36),
              GestureDetector(
                onTap: () {
                  // Add profile placeholder
                },
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Add Profile',
                      style: StreamTypography.body.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
