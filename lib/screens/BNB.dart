import 'package:co_ofline/screens/clickScreen/View/clickView.dart';
import 'package:co_ofline/screens/dashboardScreen/ViewModel/dashboardViewModel.dart';
import 'package:co_ofline/screens/dashboardScreen/view/dashboardView.dart';
import 'package:co_ofline/screens/productScreen/View/displayedProductView.dart';
import 'package:co_ofline/utility/widgets/drawer/ViewModel/drawerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:co_ofline/utility/constant/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BnbLessScreen extends ConsumerStatefulWidget {
  String shopId = 'E6nfYosnGIWZPGObjNqX';
  BnbLessScreen({super.key, required this.shopId});

  @override
  ConsumerState<BnbLessScreen> createState() => _BnbLessScreenState();
}

class _BnbLessScreenState extends ConsumerState<BnbLessScreen> {
  int myIndex = 0;


  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    final shopData = ref.watch(shopProvider(widget.shopId));

    List<Widget> bnbScreen = [
      Dashboard_Body_Screen(shopId: widget.shopId),
      Click_Body_Screen(shopId: widget.shopId),
      Product_Screen(shopId: widget.shopId, startingYear: '2025')
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kWhite,
        body: IndexedStack(
          index: myIndex,
          children: bnbScreen,
        ),
        bottomNavigationBar: SizedBox(
          height: mqh*185/2340,
          child: BottomNavigationBar(
            onTap: (index){
              setState(() {
                myIndex = index;
              });
            },
            currentIndex: myIndex,
            selectedItemColor: kBlue,
            unselectedItemColor: kGrey.withOpacity(0.6),
            showSelectedLabels: true,
            selectedLabelStyle: const TextStyle(
              color: kBlue, fontWeight: FontWeight.w500, fontSize: 16

            ),
            iconSize: 22,
            backgroundColor: kWhite,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.storage,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.touch_app_outlined),
                label: 'Click',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined),
                label: 'Product',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

