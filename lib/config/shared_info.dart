import 'package:papua_tourism/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedInfo {
  SharedPreferences sharedPref;

  void sharedLoginInfo(User user) async {
    sharedPref = await SharedPreferences.getInstance();
    sharedPref.setInt("idUser", user.id);
    sharedPref.setString("email", user.email);
    sharedPref.setString("password", user.password);
    sharedPref.setString("token", user.rememberToken);
  }
}
