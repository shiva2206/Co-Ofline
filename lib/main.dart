import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_ofline/auth/View/authView.dart';
import 'package:co_ofline/screens/BNB.dart';
import 'package:co_ofline/screens/addShopScreen/View/addShopView.dart';
import 'package:co_ofline/screens/dashboardScreen/Model/dashboardModel.dart';
import 'package:co_ofline/screens/dashboardScreen/view/dashboardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utility/constant/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utility/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kWhite,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: kWhite,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const ProviderScope(child: Co_Ofline()));
}

class Co_Ofline extends StatefulWidget {
  const Co_Ofline({super.key});

  @override
  State<Co_Ofline> createState() => _Co_OflineState();
}

class _Co_OflineState extends State<Co_Ofline> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kWhite,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) {
                return const AuthPage();
              } else {
                return FutureBuilder<ShopModel?>(
                  future: checkEmailExists(snapshot.data!.email!),
                  builder: (context, AsyncSnapshot<ShopModel?> futureSnapshot) {
                    if (futureSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(color: kBlue));
                    } else if (futureSnapshot.hasError) {
                      return Text(futureSnapshot.error.toString());
                    } else {
                      if (futureSnapshot.data != null) {
                        return Dashboard_Body_Screen(shopId: futureSnapshot.data!.id);
                      } else {
                        return const Add_Shop();
                      }
                    }
                  },
                );
              }
            }
            return const Center(
                child: CircularProgressIndicator(color: kBlue));
          },
        ),
      ),
    );
  }
}

Future<ShopModel?> checkEmailExists(String email) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Shop')
      .where('owner', isEqualTo: email)
      .limit(1) // Limit to one result to improve performance
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return ShopModel.fromFirestore(querySnapshot.docs.first);
  }
  return null;
}