class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL
  static const baseURL = "http://192.168.1.4/tourism/public";

  String getTourisms = "$baseURL/api/user/tourisms";
  String loginURL = "$baseURL/api/user/login";
  String registerURL = "$baseURL/api/user/register";
  String imageUrl = "$baseURL/tourism";
}
