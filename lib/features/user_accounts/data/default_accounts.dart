import '../../../foundation/theme/stream_palette.dart';
import '../domain/user_account.dart';

abstract final class DefaultAccounts {
  static const List<UserAccount> profiles = [
    UserAccount(
      id: 'profile_1',
      name: 'Alex',
      color: StreamPalette.profileBlue,
    ),
    UserAccount(
      id: 'profile_2',
      name: 'Sarah',
      color: StreamPalette.profileYellow,
    ),
    UserAccount(
      id: 'profile_3',
      name: 'Kids',
      color: StreamPalette.profilePurple,
      isKids: true,
    ),
    UserAccount(
      id: 'profile_4',
      name: 'Michael',
      color: StreamPalette.profileRed,
    ),
  ];
}
