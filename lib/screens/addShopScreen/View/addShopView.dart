import 'dart:async';
import 'dart:typed_data';
import 'package:co_ofline/screens/BNB.dart';
import 'package:co_ofline/screens/addShopScreen/Model/addShopModel.dart';
import 'package:co_ofline/utility/constant/string_extensions.dart';
import 'package:co_ofline/utility/image/View/pickimage.dart';
import 'package:co_ofline/utility/widgets/buttons/View/buttonView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:co_ofline/utility/constant/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:co_ofline/screens/addShopScreen/ViewModel/addShopViewModel.dart';

class Add_Shop extends ConsumerStatefulWidget {
  const Add_Shop({Key? key}) : super(key: key);

  @override
  ConsumerState<Add_Shop> createState() => _Add_ShopState();
}

class _Add_ShopState extends ConsumerState<Add_Shop> {
  Uint8List? _image;
  List<String> sub_category = [];

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  final shopController = TextEditingController();
  final addressController = TextEditingController();
  final startingController = TextEditingController();
  final upiController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final sub_categoryController = TextEditingController();

  Future<String?> saveShopDetails() async {
    print(sub_category);
    String shop_name = shopController.text;
    String address = addressController.text;
    String startingYear = startingController.text;
    double latitude = double.parse(latitudeController.text);
    double longitude = double.parse(longitudeController.text);
    String shop_upi = upiController.text;

    String? resp = await ShopData().saveData(
      shop_name: shop_name,
      address: address,
      file: _image!,
      latitude: latitude,
      longitude: longitude,
      startingYear: startingYear,
      shop_upi: shop_upi,
      sub_category: sub_category,
    );
    return resp;
  }

  bool _isTickIcon = false;

  @override
  Widget build(BuildContext context) {
    // final shopDataState = ref.watch(addShopViewModelProvider);

    double _mqw = MediaQuery.of(context).size.width;
    double _mqh = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: kWhite,
          backgroundColor: kWhite,
          title: const Text(
            'Add Shop',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextFormField(
                  controller: shopController,
                  cursorColor: kBlue,
                  decoration: InputDecoration(
                    hintText: 'Shop Name',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kGrey,
                        fontSize: 14),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: kBlue, width: _mqh * 2 / 1080),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextFormField(
                  controller: addressController,
                  cursorColor: kBlue,
                  decoration:  InputDecoration(
                      hintText: 'Address',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: kGrey,
                          fontWeight: FontWeight.w500),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue, width: _mqh * 2 / 1080),
                    ),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextFormField(
                  controller: startingController,
                  cursorColor: kBlue,
                  decoration:  InputDecoration(
                      hintText: 'Since',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: kGrey,
                          fontWeight: FontWeight.w500),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue, width: _mqh * 2 / 1080),
                    ),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextFormField(
                  controller: upiController,
                  cursorColor: kBlue,
                  decoration:  InputDecoration(
                      hintText: 'UPI ID',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: kGrey,
                          fontWeight: FontWeight.w500),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue, width: _mqh * 2 / 1080),
                    ),),
                ),
              ),
              SizedBox(
                height: _mqh * 25 / 2340,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: _mqw * 400 / 1080,
                          child: TextFormField(
                            controller: latitudeController,
                            cursorColor: kBlue,
                            decoration:  InputDecoration(
                                hintText: 'Latitude',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: kGrey),
                            focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue, width: _mqh * 2 / 1080),
                    ),),
                          ),
                        ),
                        SizedBox(width: _mqw * 60 / 1080),
                        SizedBox(
                          width: _mqw * 400 / 1080,
                          child: TextFormField(
                            controller: longitudeController,
                            cursorColor: kBlue,
                            decoration:  InputDecoration(
                                hintText: 'Longitude',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: kGrey),
                            focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue, width: _mqh * 2 / 1080),
                    ),),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _mqh * 25 / 2340,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: _mqw * 925 / 1080,
                        child: Padding(
                          padding: EdgeInsets.only(left: _mqw * 110 / 1080),
                          child: TextField(
                            controller: sub_categoryController,
                            cursorColor: kBlue,
                            decoration:  InputDecoration(
                                hintText: 'Menu',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: kGrey),
                            focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlue, width: _mqh * 2 / 1080),
                    ),),
                          ),
                        ),
                      ),
                      SizedBox(width: _mqw * 15 / 1080),
                      InkWell(
                        child: Icon(_isTickIcon ? Icons.check : Icons.add,
                            color: kBlue, size: 22),
                        onTap: () {
                          setState(() {
                            _isTickIcon = true;
                            sub_category.add(sub_categoryController.text);
                            sub_categoryController.text = "";
                          });

                          Timer(const Duration(seconds: 2), () {
                            setState(() {
                              _isTickIcon = false;
                            });
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: _mqh * 50 / 2340,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: sub_category.isEmpty
                      ? kWhite
                      : kChipColor.withOpacity(0.35),
                  height: _mqh * 75 / 1080,
                  width: _mqw * 925 / 1080,
                  child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sub_category.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 15, bottom: 8),
                              child: Center(
                                  child: InkWell(
                                child: Text(
                                  sub_category[index].toTitleCase(),
                                  style: const TextStyle(
                                    color: kBlue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onLongPress: () {
                                  setState(() {
                                    sub_category.remove(sub_category[index]);
                                  });
                                },
                              )),
                            );
                          },
                        ),
                ),
              ),
              SizedBox(
                height: _mqh * 50 / 2340,
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
                height: _mqh * 140 / 2340,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 180 / 1080),
                child: GestureDetector(
                  onTap: () async{
                    String? shopId = await saveShopDetails();
                    if(shopId==null) ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Shop not added'),
                                                duration: Duration(seconds: 3), // Adjust the duration as needed
                                              ),
                                          ); 
                    else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BnbLessScreen(
                                  shopId: shopId,
                                )));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: _mqh * 30 / 2340),
                    height: _mqh * 0.05,
                    width: _mqw * 260 / 1080,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(27)),
                        color: kBlue),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          'Submit',
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
