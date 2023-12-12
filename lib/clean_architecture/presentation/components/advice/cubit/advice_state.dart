part of 'advice_cubit.dart';

sealed class AdviceState {
  const AdviceState();
}

class AdviceStateInitial extends AdviceState {
  const AdviceStateInitial();
}

class AdviceStateLoading extends AdviceState {
  const AdviceStateLoading();
}

class AdviceStateLoaded extends AdviceState {
  final String advice;

  const AdviceStateLoaded({required this.advice});
}

class AdviceStateError extends AdviceState {
  final String message;

  const AdviceStateError({required this.message});
}
