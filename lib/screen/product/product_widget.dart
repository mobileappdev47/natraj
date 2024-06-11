import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texttile/screen/product/product_controller.dart';

Widget textFieldId() {
  return GetBuilder<ProductController>(
    builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product value',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please enter Product value";
              } else {
                return null;
              }
            },
            controller: controller.productId,
            decoration: InputDecoration(
                hintText: 'product ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ],
      );
    },
  );
}

Widget textFieldId1() {
  return GetBuilder<ProductController>(
    builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product value1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please enter Product value1";
              } else {
                return null;
              }
            },
            controller: controller.productId1,
            decoration: InputDecoration(
                hintText: 'Product price 1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ],
      );
    },
  );
}

Widget textFieldId2() {
  return GetBuilder<ProductController>(
    builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product value2',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please enter Product value2";
              } else {
                return null;
              }
            },
            controller: controller.productId2,
            decoration: InputDecoration(
                hintText: 'Product price 2',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ],
      );
    },
  );
}

Widget textFieldId3() {
  return GetBuilder<ProductController>(
    builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product value3',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please enter Product value3";
              } else {
                return null;
              }
            },
            controller: controller.productId3,
            decoration: InputDecoration(
                hintText: 'product price 3',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ],
      );
    },
  );
}



Widget imagePic() {
  return GetBuilder<ProductController>(
    id: 'update',
    builder: (controller) {
      return Column(
        children: [
          if (controller.imageUrl != null && controller.imagePic == null)
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(controller.imageUrl!, height: 150, width: 150, fit: BoxFit.cover)),
          if (controller.imagePic != null)
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(controller.imagePic!, height: 150, width: 150, fit: BoxFit.cover)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  controller.pickImageFromGallery();
                },
                child: const Text('Pick from Gallery'),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  controller.pickImageFromCamera();
                },
                child: const Text('Pick from Camera'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
