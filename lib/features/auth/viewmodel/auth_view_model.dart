import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_locale_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthLocaleRepository _authLocaleRepository;
  late final AuthRemoteRepository _authRemoteRepository;
  late final CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authLocaleRepository = ref.watch(authLocaleRepositoryProvider);
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPrefrences() async {
    await _authLocaleRepository.init();
  }

  Future<AsyncValue> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );

    return res.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }

  Future<AsyncValue> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    return res.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = _loginSuccess(r)!,
    );
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _authLocaleRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncData(user);
  }

  Future<UserModel?> getData() async {
    state = const AsyncLoading();
    final token = _authLocaleRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.getCurrentUser(token);
      final val = res.fold(
        (l) => state = AsyncError(l.message, StackTrace.current),
        (r) {
          _currentUserNotifier.addUser(r);
          return state = AsyncData(r);
        },
      );
      return val.value;
    }
    return null;
  }
}
