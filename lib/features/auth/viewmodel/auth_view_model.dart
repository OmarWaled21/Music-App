import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_locale_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocaleRepository _authLocaleRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocaleRepository = ref.watch(authLocaleRepositoryProvider);
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
    return state = AsyncData(user);
  }
}
