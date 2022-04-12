import 'package:get/get.dart';
import 'package:state_management/domain/core/user/user_data2.dart';

class UserController extends GetxController {
  final _listUserData = <UserData2>[];

  addDataToList(UserData2 data) {
    _listUserData.add(data);
    update();
  }

  List<UserData2> get getListUserData => this._listUserData;

  deleteDataOnList(UserData2 data) {
    _listUserData.remove(data);
    update();
  }
}
