import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(title: 'Tambah User', content: AddUserDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: "Name"),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: jobController,
          decoration: InputDecoration(hintText: "Job"),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
              onPressed: () {
                print(nameController.text);
                print(jobController.text);
              },
              child: Text("Save")),
        )
      ],
    );
  }
}
