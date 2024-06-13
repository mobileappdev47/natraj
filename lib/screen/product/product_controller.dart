// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
//
// class ProductController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   TextEditingController productId = TextEditingController();
//   TextEditingController productId1 = TextEditingController();
//   TextEditingController productId2 = TextEditingController();
//   TextEditingController productId3 = TextEditingController();
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//   }
//
//
//   File? imagePic;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<File?> pickImageFromGallery() async {
//     final XFile? image =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//     if (image != null) {
//       imagePic = File(image.path);
//     }
//     update(['update']);
//     return null;
//   }
//
//   Future<File?> pickImageFromCamera() async {
//     final XFile? image =
//         await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
//     if (image != null) {
//       imagePic = File(image.path);
//       print('Image picked: ${image.path}');
//     }else{
//       print('No image picked.');
//     }
//
//     update(['update']);
//     return null;
//   }
//
//   Future<String?> uploadImageToStorage() async {
//     try {
//       String fileName = basename(imagePic!.path);
//       print('Uploading image: $fileName');
//
//       Reference firebaseStorageRef =
//           FirebaseStorage.instance.ref().child('uploads/$fileName');
//       UploadTask uploadTask = firebaseStorageRef.putFile(imagePic!);
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadURL = await taskSnapshot.ref.getDownloadURL();
//       print('Image uploaded successfully. Download URL: $downloadURL');
//       return downloadURL;
//     } catch (e) {
//       print('Error uploading image: $e');
//       Get.snackbar('Error', 'Failed to upload image');
//       return null;
//     }
//   }
//
//   Future<void> submitData() async {
//     if (!formKey.currentState!.validate()) return;
//
//     try {
//       String? imageUrl = await uploadImageToStorage();
//       await FirebaseFirestore.instance.collection('products').add({
//         'productId': productId.text,
//         'productId1': productId1.text,
//         'productId2': productId2.text,
//         'productId3': productId3.text,
//         'imageUrl': imageUrl,
//       });
//
//       Get.back();
//       clearFields();
//       Get.snackbar('Success', 'Data added successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to add data');
//     }
//   }
//
//
//   Future<void> updateData(String docId) async {
//     if (!formKey.currentState!.validate()) return;
//
//     try {
//       String? imageUrl = await uploadImageToStorage();
//       Map<String, dynamic> data = {
//         'productId': productId.text,
//         'productId1': productId1.text,
//         'productId2': productId2.text,
//         'productId3': productId3.text,
//       };
//
//       if (imageUrl != null) {
//         data['imageUrl'] = imageUrl;
//       }
//
//       await FirebaseFirestore.instance.collection('products').doc(docId).update(data);
//
//       Get.back();
//       clearFields();
//       Get.snackbar('Success', 'Data updated successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update data');
//     }
//   }
//
//   // Future<void> updateData(String docId) async {
//   //   if (!formKey.currentState!.validate()) return;
//   //
//   //   try {
//   //     String? imageUrl = await uploadImageToStorage();
//   //     await FirebaseFirestore.instance
//   //         .collection('products')
//   //         .doc(docId)
//   //         .update({
//   //       'productId': productId.text,
//   //       'productId1': productId1.text,
//   //       'productId2': productId2.text,
//   //       'productId3': productId3.text,
//   //       'imageUrl': imageUrl,
//   //     });
//   //
//   //     Get.back();
//   //     clearFields();
//   //     Get.snackbar('Success', 'Data updated successfully');
//   //   } catch (e) {
//   //     Get.snackbar('Error', 'Failed to update data');
//   //   }
//   // }
//
//   void clearFields() {
//     productId.clear();
//     productId1.clear();
//     productId2.clear();
//     productId3.clear();
//     imagePic = null;
//     update(['update']);
//   }
// }
//
// // void submitData() async {
// //     try {
// //       await _firestore.collection('products').doc().set({
// //         'productId': productId.text,
// //         'productId1': productId1.text,
// //         'productId2': productId2.text,
// //         'productId3': productId3.text,
// //       });
// //       productId.clear();
// //       productId1.clear();
// //       productId2.clear();
// //       productId3.clear();
// //       Get.back();
// //       Get.snackbar('Success', 'Data added successfully');
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to add data');
// //     }
// //   }



import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController productId = TextEditingController();
  TextEditingController productId1 = TextEditingController();
  TextEditingController productId2 = TextEditingController();
  TextEditingController productId3 = TextEditingController();

  TextEditingController searchController = TextEditingController();

  File? imagePic;
  String? imageUrl;
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      imagePic = File(image.path);
      update(['update']);
    }
    return null;
  }

  Future<File?> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      imagePic = File(image.path);
      update(['update']);
    }
    return null;
  }

  Future<String?> uploadImageToStorage() async {
    if (imagePic == null) return null;

    try {
      String fileName = basename(imagePic!.path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imagePic!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image');
      return null;
    }
  }

  Future<void> submitData() async {
    if (!formKey.currentState!.validate()) return;

    try {
      // Check if productId already exists
      var existingProduct = await FirebaseFirestore.instance
          .collection('products')
          .where('productId', isEqualTo: productId.text)
          .get();

      if (existingProduct.docs.isNotEmpty) {
        // Show error if productId already exists
        Get.snackbar('Error', 'Product ID already exists');
        return;
      }

      String? imageUrl = await uploadImageToStorage();
      await FirebaseFirestore.instance.collection('products').add({
        'productId': productId.text,
        'productId1': productId1.text,
        'productId2': productId2.text,
        'productId3': productId3.text,
        'imageUrl': imageUrl,
      });

      Get.back();
      clearFields();
      Get.snackbar('Success', 'Data added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add data');
    }
  }

  Future<void> updateData(String docId) async {
    if (!formKey.currentState!.validate()) return;

    try {
      // Check if productId already exists in other documents
      var existingProduct = await FirebaseFirestore.instance
          .collection('products')
          .where('productId', isEqualTo: productId.text)
          .get();

      if (existingProduct.docs.isNotEmpty && existingProduct.docs.first.id != docId) {
        // Show error if productId already exists
        Get.snackbar('Error', 'Product ID already exists');
        return;
      }

      String? imageUrl = await uploadImageToStorage();
      Map<String, dynamic> data = {
        'productId': productId.text,
        'productId1': productId1.text,
        'productId2': productId2.text,
        'productId3': productId3.text,
      };

      if (imageUrl != null) {
        data['imageUrl'] = imageUrl;
      }

      await FirebaseFirestore.instance.collection('products').doc(docId).update(data);

      Get.back();
      clearFields();
      Get.snackbar('Success', 'Data updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update data');
    }
  }



  void clearFields() {
    productId.clear();
    productId1.clear();
    productId2.clear();
    productId3.clear();
    imagePic = null;
    imageUrl = null;
    update(['update']);
  }
}
