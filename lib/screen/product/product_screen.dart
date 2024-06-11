import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texttile/screen/product/product_controller.dart';
import 'package:texttile/screen/product/product_widget.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key, this.product});

  ProductController productController = Get.put(ProductController());
  final DocumentSnapshot? product;

  @override
  Widget build(BuildContext context) {
    if (product != null) {
      productController.productId.text = product!.get('productId');
      productController.productId1.text = product!.get('productId1');
      productController.productId2.text = product!.get('productId2');
      productController.productId3.text = product!.get('productId3');
      productController.imageUrl = product!.get('imageUrl');
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF6449D8),
          foregroundColor: Colors.white,
          title: Text(product != null ? 'Edit Product' : 'Add Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: productController.formKey,
              child: Column(
                children: [
                  textFieldId(),
                  const SizedBox(
                    height: 10,
                  ),
                  textFieldId1(),
                  const SizedBox(
                    height: 10,
                  ),
                  textFieldId2(),
                  const SizedBox(
                    height: 10,
                  ),
                  textFieldId3(),
                  const SizedBox(
                    height: 10,
                  ),
                  imagePic(),
                  const SizedBox(
                    height: 40,
                  ),
                  buttonSubmit(product != null ? product!.id : null),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonSubmit(String? productId) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFF6449D8)),
      onPressed: () {
        if (productController.formKey.currentState?.validate() ?? false) {
          productId != null
              ? productController.updateData(productId)
              : productController.submitData();
        } else {
          Get.snackbar('Error', 'Please fill all fields correctly');
        }
      },
      child: Text(
        productId != null ? 'Update' : 'Submit',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
