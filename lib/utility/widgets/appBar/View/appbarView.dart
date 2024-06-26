import 'package:co_ofline/utility/widgets/notification/View/notificationView.dart';
import 'package:flutter/material.dart';
import 'package:co_ofline/utility/constant/color.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.title});

  final Widget? title;

  @override
  State<MyAppBar> createState() => _MyAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: kWhite,
      elevation: 0,
      surfaceTintColor: kWhite,
      leading: Padding(padding: EdgeInsets.only(left: mqw * 135 / 1080),
          child: GestureDetector(
          onTap: (){
            Scaffold.of(context).openDrawer();
    },
            child: const Icon(Icons.menu),
      )
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: mqw * 105 / 1080),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notification_Page()));
              },
              icon: const Icon(
                Icons.notifications_outlined,
                color: kGrey,
                size: 22,
              )),
        )
      ],
      bottomOpacity: 0,
      iconTheme: const IconThemeData(color: kGrey, size: 22),
      title: widget.title,
      centerTitle: true,
    );
  }
}
