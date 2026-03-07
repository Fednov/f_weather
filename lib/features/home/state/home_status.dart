abstract class HomeStatus {
  const HomeStatus({
    this.errorMessage,
  });

  final String? errorMessage;
}

class HomeScreenStatusInit extends HomeStatus {
  const HomeScreenStatusInit();
}

class HomeScreenStatusLoading extends HomeStatus {
  const HomeScreenStatusLoading();
}

class HomeScreenStatusSuccess extends HomeStatus {
  const HomeScreenStatusSuccess();
}

class HomeScreenStatusError extends HomeStatus {
  const HomeScreenStatusError({super.errorMessage});
}
