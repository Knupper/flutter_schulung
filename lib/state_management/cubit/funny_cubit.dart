import 'package:flutter_bloc/flutter_bloc.dart';

class FunnyCubit extends Cubit<FunnyState> {
  FunnyCubit() : super(const FunnyStateInitial());

  String _advice = '';

  Future<void> adviceChanged({required String advice}) async {
    _advice = advice;
    emit(const FunnyStateLoading());
  }

  Future<void> reverse() async {
    final reversed = _advice.split('').reversed.join();
    emit(FunnyStateLoaded(advice: reversed));
  }

  Future<void> capslock() async {
    final capslock = _advice.toUpperCase();
    emit(FunnyStateLoaded(advice: capslock));
  }
}

sealed class FunnyState {
  const FunnyState();
}

class FunnyStateInitial extends FunnyState {
  const FunnyStateInitial();
}

class FunnyStateLoading extends FunnyState {
  const FunnyStateLoading();
}

class FunnyStateLoaded extends FunnyState {
  final String advice;

  const FunnyStateLoaded({required this.advice});
}
