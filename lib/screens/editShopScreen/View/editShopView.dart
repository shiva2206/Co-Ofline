import 'dart:async';
import 'dart:typed_data';
import 'package:co_ofline/screens/BNB.dart';
import 'package:co_ofline/screens/addShopScreen/Model/addShopModel.dart';
import 'package:co_ofline/utility/image/View/pickimage.dart';
import 'package:co_ofline/utility/widgets/buttons/View/buttonView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:co_ofline/utility/constant/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Edit_Shop extends ConsumerStatefulWidget {
  const Edit_Shop({Key? key}) : super(key: key);

  @override
  ConsumerState<Edit_Shop> createState() => _Edit_ShopState();
}

class _Edit_ShopState extends ConsumerState<Edit_Shop> {
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

  bool _isTickIcon = false;

  @override
  Widget build(BuildContext context) {

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
            'Edit Shop',
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
                  decoration: const InputDecoration(
                      hintText: 'Shop Name',
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
                child: TextFormField(
                  controller: addressController,
                  cursorColor: kBlue,
                  decoration: const InputDecoration(
                      hintText: 'Address',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: kGrey,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextFormField(
                  controller: startingController,
                  cursorColor: kBlue,
                  decoration: const InputDecoration(
                      hintText: 'Started Year',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: kGrey,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 110 / 1080),
                child: TextFormField(
                  controller: upiController,
                  cursorColor: kBlue,
                  decoration: const InputDecoration(
                      hintText: 'UPI ID',
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
                child: Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: _mqw * 400 / 1080,
                          child: TextFormField(
                            controller: latitudeController,
                            cursorColor: kBlue,
                            decoration: const InputDecoration(
                                hintText: 'Latitude',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: kGrey)),
                          ),
                        ),
                        SizedBox(width: _mqw * 60 / 1080),
                        SizedBox(
                          width: _mqw * 400 / 1080,
                          child: TextFormField(
                            controller: longitudeController,
                            cursorColor: kBlue,
                            decoration: const InputDecoration(
                                hintText: 'Longitude',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: kGrey)),
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
                  SizedBox(
                    width: _mqw * 925 / 1080,
                    child: Padding(
                      padding: EdgeInsets.only(left: _mqw * 110 / 1080),
                      child: TextField(
                        controller: sub_categoryController,
                        cursorColor: kBlue,
                        decoration:  const InputDecoration(
                            hintText: 'Menu',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: kGrey)),
                      ),
                    ),
                  ),
                  SizedBox(width: _mqw * 15 / 1080),
                  InkWell(
                    child: Icon(_isTickIcon ? Icons.check : Icons.add, color: kBlue, size: 22),
                    onTap: () {
                      setState(() {
                        if (sub_categoryController.text!="")
                        {
                          _isTickIcon = true;
                          sub_category.add(sub_categoryController.text);
                          sub_categoryController.text = "";
                        }
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
              SizedBox(
                height: _mqh * 80 / 2340,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: sub_category.isEmpty ? kWhite : kChipColor,
                  height: _mqh * 75 / 1080,
                  width: _mqw * 925 / 1080,
                  child: sub_category.isEmpty ?
                  const SizedBox(height: 0, width: 0,) :
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sub_category.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: InkWell(
                            child: Text(
                              sub_category[index],
                              style: const TextStyle(
                                color: kBlue,
                                backgroundColor: kChipColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onLongPress: () {
                              setState(() {
                                sub_category.remove(sub_category[index]);
                              });
                            },
                          )
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: _mqh * 85 / 2340),
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
                height: _mqh * 170 / 2340,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: _mqw * 180 / 1080),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const BnbLessScreen(shopId: 'OXs4BYJwFZwKGtDdpuab',)));
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
