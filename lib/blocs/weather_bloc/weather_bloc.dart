import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<WeatherBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
