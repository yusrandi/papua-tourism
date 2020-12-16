import 'package:equatable/equatable.dart';
import 'package:papua_tourism/model/tourism_model.dart';

abstract class TourismState extends Equatable {}

class TourismInitialState extends TourismState {
  @override
  List<Object> get props => [];
}

class TourismLoadingState extends TourismState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TourismLoadedState extends TourismState {
  List<Tourism> tourisms;
  TourismLoadedState(this.tourisms);

  @override
  List<Object> get props => null;
}

// ignore: must_be_immutable
class TourismSuccessState extends TourismState {
  String msg;
  TourismSuccessState(this.msg);

  @override
  List<Object> get props => null;
}

// ignore: must_be_immutable
class TourismErrorState extends TourismState {
  String msg;
  TourismErrorState(this.msg);

  @override
  List<Object> get props => null;
}
