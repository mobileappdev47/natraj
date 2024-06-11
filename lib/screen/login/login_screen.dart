import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texttile/screen/login/login_controller.dart';
import 'package:texttile/screen/login/login_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: loginController.formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'LogIn',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF6449D8),fontSize: 30),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  textFieldEmail(),
                  const SizedBox(
                    height: 10,
                  ),
                  textFieldPassword(),
                  const SizedBox(
                    height: 30,
                  ),
                  button(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
