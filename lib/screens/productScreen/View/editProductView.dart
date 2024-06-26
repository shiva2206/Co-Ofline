import 'dart:async';
import 'dart:typed_data';

import 'package:co_ofline/screens/productScreen/Model/editProductModel.dart';
import 'package:co_ofline/screens/productScreen/ViewModel/editProductViewModel.dart';
import 'package:co_ofline/utility/image/View/pickimage.dart';
import 'package:co_ofline/utility/widgets/buttons/View/buttonView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:co_ofline/utility/constant/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:co_ofline/utility/constant/string_extensions.dart';

class Edit_Product extends ConsumerStatefulWidget {
  final String shopId;
  final String productId;

  const Edit_Product({super.key, required this.shopId, required this.productId});

  @override
  ConsumerState<Edit_Product> createState() => _Edit_ProductState();
}

class _Edit_ProductState extends ConsumerState<Edit_Product> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController maxQtyController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController sizeVariantController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Uint8List? _image;
  Product? _product;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndSetProduct();
  }

  Future<void> _fetchAndSetProduct() async {
    final product = await FirestoreService().fetchProduct(widget.shopId, widget.productId);
    if (product != null) {
      setState(() {
        _product = product;
        productNameController.text = product.productName;
        maxQtyController.text = product.productName;
        minPriceController.text = product.productName;
        size = product.sizeVariant;
        sizeMenuValue = product.sizeVariant.keys.first;
        priceController.text = size[sizeMenuValue].toString();
        groupValue = product.isVeg ? "Veg" : "Non-Veg";
        _image = product.file;
        _isLoading = false;
      });
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  String groupValue = 'Veg';
  Map<String, dynamic> size = {};
  bool _enabled = true;
  String? dropdownMenuValue;
  String? sizeMenuValue;
  late AsyncValue<List<String>> menu;
  String shopId = 'E6nfYosnGIWZPGObjNqX';

  @override
  void dispose() {
    productNameController.dispose();
    maxQtyController.dispose();
    minPriceController.dispose();
    sizeVariantController.dispose();
    priceController.dispose();
    super.dispose();
  }

  bool _isTickIcon = false;

  @override
  Widget build(BuildContext context) {
    double _mqw = MediaQuery.of(context).size.width;
    double _mqh = MediaQuery.of(context).size.height;
    menu = ref.watch(getCategoriesProvider(shopId));
    print(size);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: kWhite,
          backgroundColor: kWhite,
          title: const Text(
            'Edit Product',
            style: TextStyle(
                color: kBlue, fontWeight: FontWeight.w900, fontSize: 17.5),
          ),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: _mqw * 12 / 1080),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: kGrey, size: 22),
            ),
          ),
        ),
        backgroundColor: kWhite,
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: _mqh * 65 / 2340, bottom: _mqh * 45 / 2340),
                  width: _mqw * 400 / 1080,
                  height: _mqh * 110 / 2340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kGrey, width: 1)),
                  child: DropdownButtonHideUnderline(
                    child: menu.when(
                      data: (menu) {
                        if (dropdownMenuValue == null && menu.isNotEmpty) {
                          dropdownMenuValue = menu[0];
                        }
                        return DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: kWhite,
                          borderRadius: BorderRadius.circular(12),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                            color: kGrey,
                          ),
                          value: dropdownMenuValue,
                          onChanged: (String? value) {
                            setState(() {
                              dropdownMenuValue = value!;
                            });
                          },
                          items: menu.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value.toTitleCase(),
                                  style: const TextStyle(
                                    color: kGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                      error: (error, stackTrace) {
                        return Center(child: Text('Error: $error'));
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                      hintText: 'Product Name',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: kGrey,
                          fontSize: 14)),
                ),
              ),
              SizedBox(
                height: _mqh * 25 / 2340,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextField(
                  controller: maxQtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Max Qty Limit',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: kGrey,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(
                height: _mqh * 25 / 2340,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextField(
                  controller: minPriceController,
                  enabled: _enabled,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Min Price',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: kGrey)),
                ),
              ),
              SizedBox(
                height: _mqh * 25 / 2340,
              ),
              Row(
                children: [
                  SizedBox(
                    width: _mqw * 600 / 1080,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _mqw * 110 / 1080,
                          right: _mqw * 100 / 1080),
                      child:  TextField(
                        controller: sizeVariantController,
                        decoration: const InputDecoration(
                            hintText: 'Size Variant',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: kGrey)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _mqw * 300 / 1080,
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Price',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: kGrey)),
                    ),
                  ),
                  SizedBox(width: _mqw * 15 / 1080),
                  InkWell(
                    onTap: () {
                      if (sizeVariantController.text != "" && priceController.text != "") {
                        size[sizeVariantController.text.toLowerCase()] =
                            int.parse(priceController.text);
                        sizeVariantController.text = "";
                        priceController.text = "";
                        print(size);
                        setState(() {
                          _isTickIcon = true;
                        });

                        Timer(const Duration(seconds: 2), () {
                          setState(() {
                            _isTickIcon = false;
                          });
                        });
                      }
                    },
                    child: Icon(
                        _isTickIcon ? Icons.check : Icons.add,
                        color: kBlue,
                        size: 22),
                  ),
                ],
              ),
              SizedBox(height: _mqh * 85 / 2340),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: kBlue,
                          value: 'Veg',
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value!;
                            });
                          }),
                      const Text(
                        'Veg',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: kBlue),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: kGrey,
                          value: 'Non-Veg',
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value!;
                            });
                          }),
                      const Text(
                        'Non-Veg',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: kGrey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: _mqh * 70 / 2340,
              ),
              _image != null
                  ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: _mqh * 395 / 2340,
                  width: _mqw * 1000 / 1080,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.5),
                          topRight: Radius.circular(20.5)),
                      child: Image.memory(
                        height: _mqh * 395 / 2340,
                        width: _mqw * 1000 / 1080,
                        _image!,
                        fit: BoxFit.cover,
                      )),
                ),
              )
                  : Container(
                margin: EdgeInsets.only(top: _mqh * 20 / 2340),
                height: _mqh * 395 / 2340,
                width: _mqw * 1000 / 1080,
                decoration: BoxDecoration(
                    color: kChipColor.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(20.5)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(kWhite)),
                          title: 'Image from gallery',
                          icon: Icons.image_outlined,
                          onClick: () => {selectImage()}),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _mqh * 150 / 2340,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 180 / 1080),
                child: GestureDetector(
                  onTap: () {
                    if (productNameController.text != "" &&
                        minPriceController.text != "") {
                      final product = Product(
                        productName: productNameController.text.toLowerCase(),
                        sizeVariant: size.isEmpty
                            ? {"size": int.parse(minPriceController.text)}
                            : size,
                        file: _image,
                        subCategory: dropdownMenuValue!.toLowerCase(),
                        inStock: true,
                        isVeg: groupValue == "Veg" ? true : false,
                      );
                      // final addProvider = ref.watch(addProductProvider(product));
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: _mqh * 30 / 2340),
                    height: _mqh * 0.05,
                    width: _mqw * 240 / 1080,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(27)),
                        color: kBlue),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          'Update',
                          style: TextStyle(
                            color: kWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}