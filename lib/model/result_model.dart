class ResultModel {
  final String responsecode;
  final String responsemsg;
  final List responsedata;

  ResultModel({this.responsecode, this.responsemsg, this.responsedata});

  factory ResultModel.fromJson(Map<String, dynamic> jsonMap) {
    var list = jsonMap['responsedata'] as List;

    final data = ResultModel(
        responsecode: jsonMap['responsecode'],
        responsemsg: jsonMap['responsemsg'],
        responsedata: list);
    return data;
  }
}
