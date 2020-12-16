class TourismModel {
  String success;
  String message;
  List<Tourism> tourism;

  TourismModel({this.success, this.message, this.tourism});

  TourismModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['tourism'] != null) {
      tourism = new List<Tourism>();
      json['tourism'].forEach((v) {
        tourism.add(new Tourism.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.tourism != null) {
      data['tourism'] = this.tourism.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tourism {
  int id;
  String images;
  String name;
  String adress;
  String price;
  String open;
  String rating;
  String detail;
  String createdAt;
  String updatedAt;

  Tourism(
      {this.id,
      this.images,
      this.name,
      this.adress,
      this.price,
      this.open,
      this.rating,
      this.detail,
      this.createdAt,
      this.updatedAt});

  Tourism.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
    name = json['name'];
    adress = json['adress'];
    price = json['price'];
    open = json['open'];
    rating = json['rating'];
    detail = json['detail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    data['name'] = this.name;
    data['adress'] = this.adress;
    data['price'] = this.price;
    data['open'] = this.open;
    data['rating'] = this.rating;
    data['detail'] = this.detail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
