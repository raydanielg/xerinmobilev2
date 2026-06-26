part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  final bool isCompleted;

  const OnboardingState(this.currentIndex, {this.isCompleted = false});

  const OnboardingState.completed() : isCompleted = true, currentIndex = -1;

  @override
  List<Object?> get props => [currentIndex, isCompleted];

  bool get isFirstSlide => currentIndex == 0;
  bool get isLastSlide => currentIndex == 2;
  bool get canGoNext => currentIndex < 2;
  bool get canGoPrevious => currentIndex > 0;
}
