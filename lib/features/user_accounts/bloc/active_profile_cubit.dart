import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/default_accounts.dart';
import '../domain/user_account.dart';

class ActiveProfileCubit extends Cubit<UserAccount> {
  ActiveProfileCubit() : super(DefaultAccounts.profiles.first);

  void selectProfile(UserAccount account) {
    emit(account);
  }

  void selectProfileByName(String name) {
    final matched = DefaultAccounts.profiles.firstWhere(
      (p) => p.name.toLowerCase() == name.toLowerCase(),
      orElse: () => DefaultAccounts.profiles.first,
    );
    emit(matched);
  }
}
