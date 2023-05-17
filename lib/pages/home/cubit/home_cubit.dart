import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void onPageChanged(int page) {
    emit(
      state.copyWith(page: page),
    );
  }
}
