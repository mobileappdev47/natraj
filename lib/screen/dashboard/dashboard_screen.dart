import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texttile/screen/product/product_controller.dart';
import 'package:texttile/screen/product/product_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataFromFirestore().then((value) {
      setState(() {
        allDataList = value;
        filterList = value;

        filterList.sort((a, b) {
          var aId = a['productId'];
          var bId = b['productId'];

          // Check if both product IDs are numeric
          if (_isNumeric(aId) && _isNumeric(bId)) {
            return int.parse(aId).compareTo(int.parse(bId));
          } else {
            return aId.compareTo(bId);
          }
        });

        // filterList.sort((a,b) => int.parse(a['productId']).compareTo(int.parse(b['productId'])));
      });
    });
  }

  bool _isNumeric(String s) {
    return int.tryParse(s) != null;
  }

  TextEditingController searchController = TextEditingController();

  Future<List<DocumentSnapshot>> fetchDataFromFirestore() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    return querySnapshot.docs;
  }

  List<DocumentSnapshot> allDataList = [];
  List<DocumentSnapshot> filterList = [];

  void searchData(String value) {
    setState(() {
      if (value.isNotEmpty) {
        filterList = allDataList.where((element) {
          String productId = element.get('productId').toString().toLowerCase();
          return productId.contains(value.toLowerCase());
        }).toList();
      } else {
        filterList = allDataList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF6449D8),
          foregroundColor: Colors.white,
          onPressed: () {
            controller.productId.clear();
            controller.productId1.clear();
            controller.productId2.clear();
            controller.productId3.clear();
            controller.imageUrl = null;
            controller.imagePic = null;
            Get.to(ProductScreen())!.then((_) {
              fetchDataFromFirestore().then((value) {
                setState(() {
                  allDataList = value;
                  filterList = value;

                  filterList.sort((a, b) {
                    var aId = a['productId'];
                    var bId = b['productId'];

                    // Check if both product IDs are numeric
                    if (_isNumeric(aId) && _isNumeric(bId)) {
                      return int.parse(aId).compareTo(int.parse(bId));
                    } else {
                      return aId.compareTo(bId);
                    }
                  });
                });
              });
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  // autofocus: true,
                  controller: searchController,
                  onChanged: (value) {
                    searchData(value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      prefixStyle:
                          TextStyle(color: Colors.black.withOpacity(0.2)),
                      hintText: 'Search with productId',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.2)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Product List',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No data found!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    allDataList = snapshot.data!.docs;
                    // searchData(searchController.text);
                    // List<DocumentSnapshot> data = snapshot.data!;
                    return filterList.isEmpty
                        ? const Center(
                            child: Text(
                              ' No data foubnd!',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: filterList.length,
                              itemBuilder: (context, index) {
                                var product = filterList[index];
                                var imageUrl = product['imageUrl'];
                                // Replace with your actual model class and fields
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8),
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color:
                                                                Colors.black)),
                                                    child: imageUrl != null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              imageUrl,
                                                              fit: BoxFit.fill,
                                                            ))
                                                        : const Text(
                                                            'please select image',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'product id : ${filterList[index].get('productId')}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      const Divider(
                                                        color: Colors.black,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'p1 : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            '${filterList[index].get('productId1')}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'p2 : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            '${filterList[index].get('productId2')}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .purple,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'p3 : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            '${filterList[index].get('productId3')}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.pink,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color:
                                                              Color(0xFF6449D8),
                                                        ),
                                                        onPressed: () {
                                                          Get.to(() => ProductScreen(
                                                                  product:
                                                                      filterList[
                                                                          index]))!
                                                              .then((_) {
                                                            fetchDataFromFirestore()
                                                                .then((value) {
                                                              setState(() {
                                                                allDataList =
                                                                    value;
                                                                filterList =
                                                                    value;
                                                                filterList.sort(
                                                                    (a, b) {
                                                                  var aId = a[
                                                                      'productId'];
                                                                  var bId = b[
                                                                      'productId'];

                                                                  // Check if both product IDs are numeric
                                                                  if (_isNumeric(
                                                                          aId) &&
                                                                      _isNumeric(
                                                                          bId)) {
                                                                    return int.parse(
                                                                            aId)
                                                                        .compareTo(
                                                                            int.parse(bId));
                                                                  } else {
                                                                    return aId
                                                                        .compareTo(
                                                                            bId);
                                                                  }
                                                                });
                                                                //   filterList.sort((a,b) => int.parse(a['productId']).compareTo(int.parse(b['productId'])));
                                                              });
                                                            });
                                                          });
                                                        },
                                                      ),
                                                      IconButton(
                                                          icon: const Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              color:
                                                                  Colors.red),
                                                          onPressed: () async {
                                                            // Get the document ID
                                                            String docId =
                                                                filterList[
                                                                        index]
                                                                    .id;

                                                            // Show a confirmation dialog
                                                            bool?
                                                                confirmDelete =
                                                                await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                title: const Text(
                                                                    'Confirm Delete'),
                                                                content: const Text(
                                                                    'Are you sure you want to delete this item?'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(context)
                                                                            .pop(false),
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(context)
                                                                            .pop(true),
                                                                    child: const Text(
                                                                        'Delete'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );

                                                            // If confirmed, delete the document
                                                            if (confirmDelete ==
                                                                true) {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'products')
                                                                  .doc(docId)
                                                                  .delete();
                                                              setState(() {
                                                                filterList
                                                                    .removeAt(
                                                                        index);
                                                                allDataList =
                                                                    filterList;
                                                                filterList.sort(
                                                                    (a, b) {
                                                                  var aId = a[
                                                                      'productId'];
                                                                  var bId = b[
                                                                      'productId'];

                                                                  // Check if both product IDs are numeric
                                                                  if (_isNumeric(
                                                                          aId) &&
                                                                      _isNumeric(
                                                                          bId)) {
                                                                    return int.parse(
                                                                            aId)
                                                                        .compareTo(
                                                                            int.parse(bId));
                                                                  } else {
                                                                    return aId
                                                                        .compareTo(
                                                                            bId);
                                                                  }
                                                                });
                                                                // filterList.sort((a,b) => int.parse(a['productId']).compareTo(int.parse(b['productId'])));
                                                              });
                                                            }
                                                          }
                                                          // Other ListTile properties as needed
                                                          ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
