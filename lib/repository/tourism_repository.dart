import 'package:papua_tourism/model/response_model.dart';
import 'package:papua_tourism/model/tourism_model.dart';
import 'package:http/http.dart' as http;
import 'package:papua_tourism/config/api.dart';
import 'dart:convert';

abstract class TourismRepository {
  Future<List<Tourism>> getTourism();
  Future<String> createTourism(Tourism tourism);
}

class TourismRepositoryImpl implements TourismRepository {
  final String TAG = "TourismRepositoryImpl";

  @override
  Future<List<Tourism>> getTourism() async {
    var _response = await http.get(Api.instance.getTourisms);
    if (_response.statusCode == 200) {
      print("$TAG getTourism true");

      var data = json.decode(_response.body);
      // print("$TAG getTourism true $data");

      List<Tourism> tourisms = TourismModel.fromJson(data).tourism;
      return tourisms;
    } else {
      print("$TAG getTourism false");
      throw Exception();
    }
  }

  @override
  Future<String> createTourism(Tourism tourism) async {
    var _response = await http.post(Api.instance.getTourisms, body: {
      "name": tourism.name,
      "adress": tourism.adress,
      "price": tourism.price,
      "open": tourism.open,
      "rating": tourism.rating,
      "detail": tourism.detail,
    });
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      print("$TAG createTourism true");

      var data = json.decode(_response.body);
      String msg = ResponseModel.fromJson(data).message;
      print(msg);
      return msg;
    } else {
      print("$TAG createTourism true");

      throw Exception();
    }
  }
}
