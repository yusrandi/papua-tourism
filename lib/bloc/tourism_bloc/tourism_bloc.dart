import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_event.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_state.dart';
import 'package:papua_tourism/repository/tourism_repository.dart';

class TourismBloc extends Bloc<TourismEvent, TourismState> {
  TourismRepository repository;
  TourismBloc(this.repository) : super(TourismInitialState());

  @override
  TourismState get initialState => TourismInitialState();

  @override
  Stream<TourismState> mapEventToState(TourismEvent event) async* {
    if (event is FetchTourismEvent) {
      yield* mapFetchTourismEventToState(event);
    } else if (event is CreateTourismEvent) {
      yield* mapCreateTourismEventToState(event);
    }
  }

  Stream<TourismState> mapFetchTourismEventToState(TourismEvent event) async* {
    yield TourismLoadingState();
    try {
      var tourisms = await repository.getTourism();
      yield TourismLoadedState(tourisms);
    } catch (e) {
      yield TourismErrorState(e.toString());
    }
  }

  Stream<TourismState> mapCreateTourismEventToState(
      CreateTourismEvent event) async* {
    yield TourismLoadingState();
    try {
      var tourisms = await repository.createTourism(event.tourism);
      yield TourismSuccessState(tourisms);
    } catch (e) {
      yield TourismErrorState(e.toString());
    }
  }
}
