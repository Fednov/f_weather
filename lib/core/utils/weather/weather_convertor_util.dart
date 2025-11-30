final class AppWeatherConvertorUtil {
  AppWeatherConvertorUtil._();

  /// Convert the pressure value in millibars to millimeters of mercury
  static double pressureMbToMillimetresOfMercury({required double pressureMb}) {
    return pressureMb * 0.750063755419211;
  }

  /// Convert kilometers per hour to meters per second
  static double kphToMps({required double kph}) {
    return kph / 3.6;
  }
}
