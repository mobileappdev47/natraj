import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texttile/screen/login/login_controller.dart';

Widget textFieldEmail() {
  return GetBuilder<LoginController>(
    builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          const SizedBox(height: 5,),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Email";
              } else if (!(value.isEmail)) {
                return "Please Enter Valid Email";
              } else {
                return null;
              }
            },
            controller: controller.emailController,
            decoration: InputDecoration(
              hintText: "Email",
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
          ),
        ],
      );
    },
  );
}

Widget textFieldPassword() {
  return GetBuilder<LoginController>(
    builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          SizedBox(height: 5,),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter you password";
              } else if (value.length < 6) {
                return "Please Enter Must Be 6 Character";
              } else {
                return null;
              }
            },
            controller: controller.passwordController,
            decoration: InputDecoration(
              hintText: "Password",
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
          ),
        ],
      );
    },
  );
}

Widget button() {
  return GetBuilder<LoginController>(
    builder: (controller) {
      return Center(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF6449D8),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              // If valid, perform sign-in
              controller.login();
            }
          },
          child: const Text('Log in'),
        ),
      );
    },
  );
}
