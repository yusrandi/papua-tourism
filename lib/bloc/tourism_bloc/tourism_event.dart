import 'package:equatable/equatable.dart';
import 'package:papua_tourism/model/tourism_model.dart';

abstract class TourismEvent extends Equatable {}

class FetchTourismEvent extends TourismEvent {
  @override
  List<Object> get props => null;
}

// ignore: must_be_immutable
class CreateTourismEvent extends TourismEvent {
  Tourism tourism;
  CreateTourismEvent(this.tourism);
  @override
  List<Object> get props => null;
}
