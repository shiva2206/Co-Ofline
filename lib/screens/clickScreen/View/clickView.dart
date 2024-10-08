import 'package:co_ofline/utility/constant/color.dart';
import 'package:co_ofline/utility/widgets/appBar/View/appbarView.dart';
import 'package:co_ofline/utility/widgets/drawer/View/drawerView.dart';
import 'package:co_ofline/utility/widgets/drawer/ViewModel/drawerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Click_Body_Screen extends ConsumerStatefulWidget {
  final String shopId;
  const Click_Body_Screen({super.key, required this.shopId});

  @override
  ConsumerState<Click_Body_Screen> createState() => _Click_Body_ScreenState();
}

class _Click_Body_ScreenState extends ConsumerState<Click_Body_Screen> {
  int? _isExpanded;
  int _currentStep = 0;
  int _cancelStep = 0;

  get address => null;

  _continueStepper() {
    if (_currentStep <= 3) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  _cancelStepper() {
    if (_cancelStep <= 1) {
      setState(() {
        _cancelStep += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double mqw = MediaQuery.of(context).size.width;
    double mqh = MediaQuery.of(context).size.height;
    final isOpenBoolean = ref.watch(isOpenProvider(widget.shopId));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kWhite,
        appBar: const MyAppBar(
          title: Text(
            'Click',
            style: TextStyle(
                fontSize: 20, color: kBlue, fontWeight: FontWeight.w800),
          ),
        ),
        drawer: CustomDrawer(
            mqw: mqw,
            mqh: mqh,
            isOpenBoolean: isOpenBoolean,
            onToggleShopOpen: (value){
              ref.read(isOpenProvider(widget.shopId).notifier).updateIsShopOpen(value);
            }),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: mqh * 30 / 2340),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      initiallyExpanded: _isExpanded == index,
                      iconColor: kGrey,
                      tilePadding: EdgeInsets.only(
                          left: mqw * 60 / 1080, right: mqw * 60 / 1080),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: mqw * 285 / 1080,
                            child: const Text(
                              '#abcde1234f',
                              style: TextStyle(
                                  color: kGrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.6),
                            ),
                          ),
                          const Icon(
                            Icons.shopping_bag,
                            color: kBlue,
                            size: 19,
                          ),
                          const Text(
                            '12:23 pm',
                            style: TextStyle(
                                color: kGrey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.5),
                          )
                        ],
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: mqh * 140 / 2340,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: kChipColor.withOpacity(0.35),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mqw * 50 / 1080),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: mqw * 150 / 1080,
                                      child: const Center(
                                        child: Text(
                                          'Name',
                                          style: TextStyle(
                                              color: kGrey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: mqw * 140 / 1080),
                                      child: Container(
                                        color: Colors.transparent,
                                        width: mqw * 130 / 1080,
                                        child: const Center(
                                          child: Text(
                                            'Qty',
                                            style: TextStyle(
                                                color: kGrey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: mqw * 190 / 1080,
                                      child: const Center(
                                        child: Text(
                                          'Size',
                                          style: TextStyle(
                                              color: kGrey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      width: mqw * 160 / 1080,
                                      child: const Center(
                                        child: Text(
                                          'Price',
                                          style: TextStyle(
                                              color: kGrey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, index) {
                                  return SizedBox(
                                    height: mqh * 150 / 2340,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: mqw * 50 / 1080,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            width: mqw * 290 / 1080,
                                            // height: mqh*200/2340,
                                            child: const Center(
                                              child: Text(
                                                'Mushroom Burger',
                                                style: TextStyle(
                                                    color: kGrey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.transparent,
                                            width: mqw * 130 / 1080,
                                            child: const Center(
                                              child: Text(
                                                '8',
                                                style: TextStyle(
                                                    color: kGrey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.5),
                                                maxLines: 1,
                                                textDirection:
                                                    TextDirection.ltr,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.transparent,
                                            width: mqw * 190 / 1080,
                                            child: const Center(
                                              child: Text(
                                                'Full',
                                                style: TextStyle(
                                                    color: kGrey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.5),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.transparent,
                                            width: mqw * 160 / 1080,
                                            child: const Center(
                                              child: Text(
                                                '₹350',
                                                style: TextStyle(
                                                    color: kGrey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            SizedBox(height: mqh * 40 / 2340),
                            Center(
                              child: Container(
                                height: mqh * 110 / 2340,
                                width: mqw * 260 / 1080,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: kChipColor.withOpacity(0.35)),
                                child: const Center(
                                  child: Text(
                                    '₹8400',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        color: kGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mqh * 40 / 2340),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: mqh * 50 / 2340,
                                  bottom: mqh * 25 / 2340,
                                  left: mqw * 130 / 1080,
                                  right: mqw * 130 / 1080),
                              child: Center(
                                child: Stack(
                                  clipBehavior: Clip.hardEdge,
                                  children: [
                                    Positioned(
                                      bottom: mqh * 5 / 2340,
                                      top: mqh * 5 / 2340,
                                      child: Center(
                                        child: Container(
                                          width: mqw * 850 / 1080,
                                          height: mqh * 25 / 2340,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color:
                                                  kChipColor.withOpacity(0.35)),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _currentStep == 0
                                            ? const Icon(Icons.radio_button_on,
                                                color: kGrey, size: 30)
                                            : const Icon(Icons.check_circle,
                                                color: kBlue, size: 30),
                                        _currentStep > 1
                                            ? const Icon(Icons.check_circle,
                                                color: kBlue, size: 30)
                                            : const Icon(Icons.radio_button_on,
                                                color: kGrey, size: 30),
                                        _currentStep == 3
                                            ? const Icon(Icons.check_circle,
                                                color: kBlue, size: 30)
                                            : const Icon(Icons.radio_button_on,
                                                color: kGrey, size: 30)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _currentStep == 0
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: mqw * 100 / 1080),
                                        child: const Text(
                                          'Accept',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kGrey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: mqw * 100 / 1080),
                                        child: const Text(
                                          'Accept',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kBlue,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                _currentStep > 1
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: mqw * 30 / 1080),
                                        child: const Text(
                                          'Ready',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kBlue,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: mqw * 30 / 1080),
                                        child: const Text(
                                          'Ready',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kGrey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                _currentStep == 3
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            right: mqw * 90 / 1080),
                                        child: const Text(
                                          'Success',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kBlue,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            right: mqw * 90 / 1080),
                                        child: const Text(
                                          'Success',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kGrey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                              ],
                            ),
                            SizedBox(height: mqh * 10 / 2340),
                            _currentStep == 0
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mqh * 90 / 2340),
                                    child: Center(
                                      child: Container(
                                        height: mqh * 5 / 2340,
                                        width: mqw * 5 / 1080,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: kWhite),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                              '',
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
                                  )
                                : _currentStep == 1
                                    ? Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: mqh * 90 / 2340),
                                          child: GestureDetector(
                                            onTap: () {
                                              _continueStepper();
                                            },
                                            child: Container(
                                              height: mqh * 0.05,
                                              width: mqw * 225 / 1080,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: kBlue),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Center(
                                                  child: Text(
                                                    'Ready',
                                                    style: TextStyle(
                                                      color: kWhite,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : _currentStep == 1
                                        ? Center(
                                            child: Container(
                                              height: mqh * 0.05,
                                              width: mqw * 225 / 1080,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: kBlue),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _continueStepper();
                                                    },
                                                    child: const Text(
                                                      'Accept',
                                                      style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : _currentStep == 2
                                            ? Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: mqh * 90 / 2340),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _continueStepper();
                                                    },
                                                    child: Container(
                                                      height: mqh * 0.05,
                                                      width: mqw * 240 / 1080,
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          color: kBlue),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Center(
                                                          child: Text(
                                                            'Success',
                                                            style: TextStyle(
                                                              color: kWhite,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: mqh * 0.5 / 2340),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: mqh * 30 / 2340),
                                  height: mqh * 0.05,
                                  width: mqw * 260 / 1080,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(27)),
                                      color: kBlue),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        'Accept',
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: mqh * 30 / 2340),
                                  height: mqh * 0.05,
                                  width: mqw * 260 / 1080,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(27)),
                                      color: kRed),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: mqw * 460 / 1080, top: mqh * 65 / 2340),
                              child: Row(
                                children: [
                                  Container(
                                    height: mqh * 100 / 2340,
                                    width: mqw * 275 / 1080,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        color: kWhite),
                                    child: const Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Image',
                                            style: TextStyle(
                                              color: kBlue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Icon(
                                            Icons.file_upload_outlined,
                                            color: kBlue,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: mqw * 340 / 1080),
                                  // const Text('#1234567890', style: TextStyle(color: kGrey, fontWeight: FontWeight.w400, fontSize: 14.5),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                      onExpansionChanged: (bool expanding) {
                        setState(() {
                          _isExpanded = index;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
