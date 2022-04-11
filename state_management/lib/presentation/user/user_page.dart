import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/application/user/cubit/controlller/user_controller.dart';
import 'package:state_management/presentation/user/widgets/add_user_dialog.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (userController) => Scaffold(
        body: ListView.builder(
            itemCount: userController.getListUserData.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text(userController.getListUserData[index].name!),
                  subtitle: Text(
                      "${userController.getListUserData[index].job!}\n${userController.getListUserData[index].createData!}"),
                  isThreeLine: true,
                  leading: Text(userController.getListUserData[index].id!),
                )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(title: 'Tambah User', content: AddUserDialog());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
