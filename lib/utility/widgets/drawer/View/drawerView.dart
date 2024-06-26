import 'package:co_ofline/auth/View/authView.dart';
import 'package:co_ofline/screens/editShopScreen/View/editShopView.dart';
import 'package:co_ofline/utility/constant/color.dart';
import 'package:co_ofline/utility/widgets/drawer/View/aboutView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';

class CustomDrawer extends ConsumerWidget {
  final double mqw;
  final double mqh;
  final bool isOpenBoolean;
  final Function(bool) onToggleShopOpen;

  const CustomDrawer({
    required this.mqw,
    required this.mqh,
    required this.isOpenBoolean,
    required this.onToggleShopOpen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      width: mqw * 630 / 1080,
      backgroundColor: kWhite,
      elevation: 0,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqw * 10 / 1080),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mqw * 48 / 1080),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mqw * 149 / 1080,
                    height: mqh * 90 / 2340,
                  ),
                  SizedBox(
                    height: mqh * 30 / 2340,
                    width: mqw * 30 / 1080,
                    child: Switch(
                      splashRadius: 0,
                      inactiveTrackColor: kWhite,
                      inactiveThumbColor: kGrey.withOpacity(0.6),
                      activeColor: kBlue,
                      value: isOpenBoolean,
                      onChanged: onToggleShopOpen,
                    ),
                  ),
                  SizedBox(
                    height: mqh * 160 / 2340,
                  ),
                ],
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: kGrey,
                size: 20.5,
              ),
              title: Text(
                'IIT Madras, Chennai',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, color: kGrey),
              ),
            ),
            GestureDetector(
              onTap: () async {
                const urlPreview = '';

                await Share.share('Ofline : Local Market \n$urlPreview');
              },
              child: ListTile(
                leading: Icon(
                  Icons.share,
                  color: kGrey.withOpacity(0.60),
                  size: 18.5,
                ),
                title: const Text(
                  'Share App',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500, color: kGrey),
                ),
              ),
            ),
            ListTile(
                leading: const Icon(
                  Icons.storefront,
                  color: kGrey,
                  size: 20,
                ),
                title: InkWell(
                  child: const Text(
                    'Edit Shop',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: kGrey),
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => const Edit_Shop()));
                  },
                )),
            const ListTile(
              leading: Icon(
                Icons.subscriptions_outlined,
                color: kGrey,
                size: 18.6,
              ),
              title: Text(
                'YouTube',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, color: kGrey),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.history,
                color: kGrey,
                size: 20.5,
              ),
              title: Text(
                'History',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, color: kGrey),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutScreen()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.info_outline_rounded,
                  color: kGrey,
                  size: 20,
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500, color: kGrey),
                ),
              ),
            ),
            SizedBox(
              height: mqh * 110 / 2340,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mqw * 180 / 1080),
              child: GestureDetector(
                onTap: () async {
                  await GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();

                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          maintainState: true,
                          builder: (context) => const AuthPage()));
                },
                child: Container(
                  height: mqh * 0.045,
                  width: mqw * 160 / 1080,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(27)),
                      color: kBlue),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 14,
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
    );
  }
}
