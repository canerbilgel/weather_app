enum WeatherType {
  clear,
  clouds,
  rain,
  drizzle,
  thunderstorm,
  snow,
  mist,
  fog,
  haze,
  smoke,
  dust,
  sand,
  ash,
  squall,
  tornado,
  unknown,
}

WeatherType weatherTypeFromMain(String main) {
  switch (main.toLowerCase()) {
    case 'clear':         return WeatherType.clear;
    case 'clouds':        return WeatherType.clouds;
    case 'rain':          return WeatherType.rain;
    case 'drizzle':       return WeatherType.drizzle;
    case 'thunderstorm':  return WeatherType.thunderstorm;
    case 'snow':          return WeatherType.snow;
    case 'mist':          return WeatherType.mist;
    case 'fog':           return WeatherType.fog;
    case 'haze':          return WeatherType.haze;
    case 'smoke':         return WeatherType.smoke;
    case 'dust':          return WeatherType.dust;
    case 'sand':          return WeatherType.sand;
    case 'ash':           return WeatherType.ash;
    case 'squall':        return WeatherType.squall;
    case 'tornado':       return WeatherType.tornado;
    default:              return WeatherType.unknown;
  }
}
