import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/clean_architecture/domain/use_cases/advice_use_case.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit({required this.useCase}) : super(const AdviceStateInitial());

  final AdviceUseCase useCase;

  Future<void> fetchRandom() async {
    emit(const AdviceStateLoading());

    final either = await useCase.getRandomAdvice();

    either.fold(
      (left) => emit(const AdviceStateError(message: 'Translate Error')),
      (right) => emit(
        AdviceStateLoaded(advice: right.advice),
      ),
    );
  }

  Future<void> fetch({required String id}) async {
    emit(const AdviceStateLoading());

    final either = await useCase.getSpecificAdvice(id: id);

    either.fold(
      (left) => emit(AdviceStateError(message: 'Translate Error: $left')),
      (right) => emit(
        AdviceStateLoaded(advice: right.advice),
      ),
    );
  }
}
