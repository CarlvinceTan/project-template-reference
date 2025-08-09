// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:agora/core/logging/logger.dart' as _i114;
import 'package:agora/core/supabase_module.dart' as _i608;
import 'package:agora/core/theme/bloc/theme_cubit.dart' as _i767;
import 'package:agora/features/auth/data/datasource/auth_remote_datasource.dart'
    as _i391;
import 'package:agora/features/auth/data/repositories/auth_repository_impl.dart'
    as _i706;
import 'package:agora/features/auth/domain/repositories/auth_repository.dart'
    as _i151;
import 'package:agora/features/auth/domain/use_cases/is_authenticated.dart'
    as _i771;
import 'package:agora/features/auth/domain/use_cases/login_with_email_and_password.dart'
    as _i29;
import 'package:agora/features/auth/domain/use_cases/logout.dart' as _i195;
import 'package:agora/features/auth/domain/use_cases/resend_verification_email.dart'
    as _i148;
import 'package:agora/features/auth/domain/use_cases/restore_password.dart'
    as _i203;
import 'package:agora/features/auth/domain/use_cases/signup_with_email_and_password.dart'
    as _i365;
import 'package:agora/features/auth/domain/use_cases/verify_email.dart'
    as _i734;
import 'package:agora/features/auth/presentation/bloc/auth_bloc.dart' as _i943;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final supabaseModule = _$SupabaseModule();
    gh.singleton<_i767.ThemeCubit>(() => _i767.ThemeCubit());
    await gh.singletonAsync<_i454.SupabaseClient>(
      () => supabaseModule.supabaseClient,
      preResolve: true,
    );
    gh.singleton<_i114.AppLogger>(() => _i114.AppLogger());
    gh.factory<_i391.AuthRemoteDataSource>(
      () => _i391.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i151.AuthRepository>(
      () => _i706.AuthRepositoryImpl(gh<_i391.AuthRemoteDataSource>()),
    );
    gh.factory<_i365.SignupWithEmailAndPassword>(
      () => _i365.SignupWithEmailAndPassword(gh<_i151.AuthRepository>()),
    );
    gh.factory<_i771.IsAuthenticated>(
      () => _i771.IsAuthenticated(gh<_i151.AuthRepository>()),
    );
    gh.factory<_i734.VerifyEmail>(
      () => _i734.VerifyEmail(gh<_i151.AuthRepository>()),
    );
    gh.factory<_i29.LoginWithEmailAndPassword>(
      () => _i29.LoginWithEmailAndPassword(gh<_i151.AuthRepository>()),
    );
    gh.factory<_i195.Logout>(() => _i195.Logout(gh<_i151.AuthRepository>()));
    gh.factory<_i203.RestorePassword>(
      () => _i203.RestorePassword(gh<_i151.AuthRepository>()),
    );
    gh.factory<_i148.ResendVerificationEmail>(
      () => _i148.ResendVerificationEmail(gh<_i151.AuthRepository>()),
    );
    gh.factory<_i943.AuthBloc>(
      () => _i943.AuthBloc(
        userSignUp: gh<_i365.SignupWithEmailAndPassword>(),
        userLogin: gh<_i29.LoginWithEmailAndPassword>(),
        restorePassword: gh<_i203.RestorePassword>(),
        verifyEmail: gh<_i734.VerifyEmail>(),
        resendVerificationEmail: gh<_i148.ResendVerificationEmail>(),
        logout: gh<_i195.Logout>(),
      ),
    );
    return this;
  }
}

class _$SupabaseModule extends _i608.SupabaseModule {}
