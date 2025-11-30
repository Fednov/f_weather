abstract class HomeScreenStatus {
  const HomeScreenStatus({
    this.errorMessage,
  });

  final String? errorMessage;
}

class HomeScreenStatusInit extends HomeScreenStatus {
  const HomeScreenStatusInit();
}

class HomeScreenStatusLoading extends HomeScreenStatus {
  const HomeScreenStatusLoading();
}

class HomeScreenStatusSuccess extends HomeScreenStatus {
  const HomeScreenStatusSuccess();
}

class HomeScreenStatusError extends HomeScreenStatus {
  const HomeScreenStatusError({super.errorMessage});
}
