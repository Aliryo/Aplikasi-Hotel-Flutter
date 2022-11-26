import 'package:get/get.dart';
import 'package:hotelio/models/user_model.dart';

class UserController extends GetxController {
  final _data = UserModel().obs;
  UserModel get data => _data.value;
  setData(n) => _data.value = n;
}
