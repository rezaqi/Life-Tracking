import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/features/dashboard/doman/usecase/use.dart';
import 'package:life_tracking/features/dashboard/presentation/bloc/event.dart';
import 'package:life_tracking/features/dashboard/presentation/bloc/state.dart';

@injectable
class LifeExpectancyBloc
    extends Bloc<LifeExpectancyEvent, LifeExpectancyState> {
  GetLifeExpectancy usecase;
  LifeExpectancyBloc(this.usecase) : super(LifeInitial()) {
    on<FetchLifeExpectancy>((event, emit) async {
      emit(LifeLoading());
      try {
        final data = await usecase.call(event.country);
        if (data == null) {
          emit(const LifeError("No data found"));
          return;
        }

        final expectancy = event.gender == "male"
            ? data.male
            : event.gender == "female"
            ? data.female
            : data.general;

        final progress = event.age / expectancy;
        emit(LifeLoaded(data, progress));
      } catch (e) {
        emit(LifeError(e.toString()));
      }
    });
  }
}
