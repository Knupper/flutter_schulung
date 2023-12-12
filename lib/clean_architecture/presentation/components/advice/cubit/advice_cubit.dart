import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/clean_architecture/domain/use_cases/advice_use_case.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit({required this.useCase}) : super(const AdviceStateInitial());

  final AdviceUseCase useCase;

  Future<void> fetch() async {
    emit(const AdviceStateLoading());

    final entity = await useCase.getRandomAdvice();

    Future.delayed(const Duration(seconds: 2), () {
      emit(AdviceStateLoaded(advice: entity.advice));
    });
  }
}
