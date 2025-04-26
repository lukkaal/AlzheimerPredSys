import 'package:ad_application/using_model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';
@riverpod
CurrentUserRepository currentUserRepository(CurrentUserRepositoryRef ref) { // 这里的 ref 是 provider_ref 可以在这个函数体内通过 ref.watch 等方式访问其他的 provider
  return CurrentUserRepository();
}


class CurrentUserRepository {
  UserModel? currentUser;

  void updateUser(UserModel user) {
    currentUser = user; // 更新当前用户信息
  }
}