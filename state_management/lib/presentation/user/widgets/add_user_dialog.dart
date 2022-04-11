import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:state_management/application/user/cubit/controlller/user_controller.dart';

import '../../../application/user/cubit/user_cubit.dart';
import '../../../domain/core/user/model/user_req_res.dart';

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

  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () => print("None"),
            loading: (v) => print("Loading"),
            success: (value) {
              userController.addDataToList(value.userData2);
              print(value.userData2.toString());
              Navigator.pop(context);
            },
          );
        },
        builder: (context, state) {
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
                      final _data = RequestData(
                          name: nameController.text, job: jobController.text);
                      context.read<UserCubit>().createNewUser(_data);
                    },
                    child: Text("Save")),
              )
            ],
          );
        },
      ),
    );
  }
}
