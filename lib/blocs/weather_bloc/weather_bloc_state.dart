part of 'weather_bloc.dart';

@immutable
abstract class WeatherBlocState {}

class WeatherBlocInitial extends WeatherBlocState {}

class FetchWeatherByLocation extends WeatherBlocState {}

class OnChangeSearchField extends WeatherBlocState {}
