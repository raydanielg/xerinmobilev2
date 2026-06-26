import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState(0));

  void nextSlide() {
    if (state.currentIndex < 2) {
      emit(OnboardingState(state.currentIndex + 1));
    }
  }

  void previousSlide() {
    if (state.currentIndex > 0) {
      emit(OnboardingState(state.currentIndex - 1));
    }
  }

  void goToSlide(int index) {
    if (index >= 0 && index <= 2) {
      emit(OnboardingState(index));
    }
  }

  void completeOnboarding() {
    emit(const OnboardingState.completed());
  }
}
