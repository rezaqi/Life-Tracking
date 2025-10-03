// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'core/di/reigter_model.dart' as _i560;
import 'features/auth/data/services/auth_service.dart' as _i871;
import 'features/auth/domain/auth_service.dart' as _i260;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/dashboard/data/repo/repo.dart' as _i733;
import 'features/dashboard/data/source/source.dart' as _i510;
import 'features/dashboard/doman/repo.dart' as _i721;
import 'features/dashboard/doman/usecase/use.dart' as _i449;
import 'features/dashboard/presentation/bloc/bloc.dart' as _i784;
import 'features/life_celendar/data/datasources/dm.dart' as _i408;
import 'features/life_celendar/data/datasources/local_db.dart' as _i938;
import 'features/life_celendar/data/datasources/source_remote.dart' as _i838;
import 'features/life_celendar/data/repositories/life_repo_impl.dart' as _i780;
import 'features/life_celendar/domain/repositories/life_repository.dart'
    as _i26;
import 'features/life_celendar/domain/usecase/usecase.dart' as _i800;
import 'features/life_celendar/presentation/bloc/life_bloc.dart' as _i876;
import 'features/onboarding/data/repositories/onboarding_repository.dart'
    as _i283;
import 'features/onboarding/doman/usecases/usecase.dart' as _i352;
import 'features/onboarding/presentation/bloc/onboarding_bloc.dart' as _i100;
import 'features/onboarding/presentation/viewmodel/onboarding_viewmodel.dart'
    as _i580;
import 'features/tabs/presentaion/manager/tab_bloc.dart' as _i461;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i461.TabBloc>(() => _i461.TabBloc());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i938.LocalDb>(() => registerModule.localDb);
    gh.lazySingleton<_i510.LifeExpectancyDataSource>(
      () => _i510.LifeExpectancyDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i408.DmLifeCalender>(() => _i838.LifeCalenderDataSourceImpl());
    gh.factory<_i26.LifeRepository>(
      () => _i780.LifeRepositoryImpl(
        gh<_i938.LocalDb>(),
        gh<_i408.DmLifeCalender>(),
      ),
    );
    gh.factory<_i721.LifeExpectancyRepository>(
      () => _i733.LifeExpectancyRepositoryImpl(
        gh<_i510.LifeExpectancyDataSource>(),
      ),
    );
    gh.factory<_i260.AuthService>(() => _i871.FirebaseAuthService());
    gh.factory<_i449.GetLifeExpectancy>(
      () => _i449.GetLifeExpectancy(gh<_i721.LifeExpectancyRepository>()),
    );
    gh.factory<_i784.LifeExpectancyBloc>(
      () => _i784.LifeExpectancyBloc(gh<_i449.GetLifeExpectancy>()),
    );
    gh.factory<_i283.OnboardingRepository>(
      () => _i283.OnboardingRepository(prefs: gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i800.UseCaseLifeCalender>(
      () => _i800.UseCaseLifeCalender(gh<_i26.LifeRepository>()),
    );
    gh.factory<_i100.OnboardingBloc>(
      () => _i100.OnboardingBloc(gh<_i283.OnboardingRepository>()),
    );
    gh.factory<_i363.AuthBloc>(() => _i363.AuthBloc(gh<_i260.AuthService>()));
    gh.factory<_i352.SaveUserUseCase>(
      () => _i352.SaveUserUseCase(gh<_i283.OnboardingRepository>()),
    );
    gh.factory<_i876.LifeBloc>(
      () => _i876.LifeBloc(
        gh<_i26.LifeRepository>(),
        gh<_i800.UseCaseLifeCalender>(),
      ),
    );
    gh.factory<_i580.OnboardingViewModel>(
      () => _i580.OnboardingViewModel(bloc: gh<_i100.OnboardingBloc>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i560.RegisterModule {}
