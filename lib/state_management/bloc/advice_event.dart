part of 'advice_bloc.dart';

abstract class AdviceEvent {
  const AdviceEvent();
}

class FetchRandomAdvice extends AdviceEvent {
  const FetchRandomAdvice();
}
