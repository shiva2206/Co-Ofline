import 'package:co_ofline/screens/dashboardScreen/ViewModel/dashboardViewModel.dart';
import 'package:co_ofline/screens/dashboardScreen/view/dashboardCardView.dart';
import 'package:co_ofline/utility/widgets/appBar/View/appbarView.dart';
import 'package:co_ofline/utility/widgets/drawer/View/drawerView.dart';
import 'package:co_ofline/utility/widgets/drawer/ViewModel/drawerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:co_ofline/utility/constant/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard_Body_Screen extends ConsumerStatefulWidget {
  final String shopId;

  const Dashboard_Body_Screen({super.key, required this.shopId});

  @override
  ConsumerState<Dashboard_Body_Screen> createState() =>
      _Dashboard_Body_ScreenState();
}

class _Dashboard_Body_ScreenState extends ConsumerState<Dashboard_Body_Screen> {
  @override
  Widget build(BuildContext context) {
    double mqh = MediaQuery.of(context).size.height;
    double mqw = MediaQuery.of(context).size.width;
    final isOpenBoolean = ref.watch(isOpenProvider(widget.shopId));
    final shopData = ref.watch(shopProvider(widget.shopId));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kWhite,
        appBar: MyAppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.remove_red_eye, color: kBlue, size: 15),
              SizedBox(width: mqw * 10 / 1080),

              shopData.when(data: (shops){
                return  Text(
                  shops.live_views.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800, color: kBlue),
                );

              }, error: (error, stackTrace){
                return  Center(child: Text('Error:$error'));
              }, loading: (){
                return const Center(child: CircularProgressIndicator(color: kBlue));
              })

            ],
          ),
        ),
        drawer: CustomDrawer(
            mqw: mqw,
            mqh: mqh,
            isOpenBoolean: isOpenBoolean,
            onToggleShopOpen: (value) {
              ref.read(isOpenProvider(widget.shopId).notifier).updateIsShopOpen(value);
            }),
        body: shopData.when(data: (shops){
         return Center(
            child: Column(
              children: [
                SizedBox(height: mqh * 35 / 2340),
                Dashboard_card(
                    mqh: mqh, mqw: mqw, title: 'Pre-order', number: shops.total_order.toInt()),
                SizedBox(height: mqh * 58 / 2340),
                Dashboard_card(
                    mqh: mqh, mqw: mqw, title: 'Amount', number: shops.total_amount),
                SizedBox(height: mqh * 58 / 2340),
                Dashboard_card(
                    mqh: mqh, mqw: mqw, title: 'Favourite', number: shops.fav_count.toInt()),
                SizedBox(height: mqh * 58 / 2340),
                Dashboard_card(
                    mqh: mqh, mqw: mqw, title: 'Views', number: shops.views.toInt()),
              ],
            ),
          );



        }, error: (error, stackTrace){
          return Center(
            child: Text('Error:$error'),
          );
        }, loading: (){
          return const Center(
            child: CircularProgressIndicator(
              color: kBlue,
            ),
          );
        })

      ),
    );
  }
}
