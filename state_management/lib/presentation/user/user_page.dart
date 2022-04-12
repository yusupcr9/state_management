import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
            itemBuilder: (context, index) => Slidable(
                  // A key is mandatory when using a dismissible.
                  key: ValueKey(userController.getListUserData[index]),

                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {
                      userController.deleteDataOnList(
                          userController.getListUserData[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Berhasil Dihapus"),
                      ));
                    }),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) {
                          userController.deleteDataOnList(
                              userController.getListUserData[index]);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Berhasil Dihapus"),
                          ));
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Data dibagikan"),
                          ));
                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(userController.getListUserData[index].name!),
                    subtitle: Text(
                        "${userController.getListUserData[index].job!}\n${userController.getListUserData[index].createData!}"),
                    isThreeLine: true,
                    leading: Text(userController.getListUserData[index].id!),
                  ),
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
