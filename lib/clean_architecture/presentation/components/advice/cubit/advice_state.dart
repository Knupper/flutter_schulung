part of 'advice_cubit.dart';

sealed class AdviceState with EquatableMixin {
  const AdviceState();

  @override
  List<Object?> get props => [];
}

class AdviceStateInitial extends AdviceState {
  const AdviceStateInitial();
}

class AdviceStateLoading extends AdviceState {
  const AdviceStateLoading();
}

class AdviceStateLoaded extends AdviceState {
  final String advice;
  final int id;

  const AdviceStateLoaded({required this.advice, required this.id});

  @override
  List<Object?> get props => [
        advice,
        id,
      ];
}

class AdviceStateError extends AdviceState {
  final String message;

  const AdviceStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
