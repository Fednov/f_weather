class AppConfig {
  final String weatherApiApiKey;
  AppConfig({
    required this.weatherApiApiKey,
  });

  AppConfig copyWith({
    String? weatherApiApiKey,
  }) {
    return AppConfig(
      weatherApiApiKey: weatherApiApiKey ?? this.weatherApiApiKey,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppConfig && other.weatherApiApiKey == weatherApiApiKey;
  }

  @override
  int get hashCode => weatherApiApiKey.hashCode;

  @override
  String toString() => 'AppConfig(weatherApiApiKey: $weatherApiApiKey)';
}
