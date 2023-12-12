import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/clean_architecture/domain/use_cases/advice_use_case.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit({required this.useCase}) : super(const AdviceStateInitial());

  final AdviceUseCase useCase;

  Future<void> fetchRandom() async {
    emit(const AdviceStateLoading());

    final entity = await useCase.getRandomAdvice();

    emit(AdviceStateLoaded(advice: entity.advice));
  }

  Future<void> fetch({required String id}) async {
    emit(const AdviceStateLoading());

    final entity = await useCase.getSpecificAdvice(id: id);
    emit(AdviceStateLoaded(advice: entity.advice));
  }
}
