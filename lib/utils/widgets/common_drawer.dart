import 'package:flutter/material.dart';
import 'package:twitterclone/utils/helper/shared_preferences_helper.dart';
import 'package:twitterclone/view/authetication/login_screen.dart';

class CommonDrawer extends StatelessWidget {
  CommonDrawer({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final SharedPreferenceHelper _preferenceHelper = SharedPreferenceHelper();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.account_circle_rounded, size: 100),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(SharedPreferenceHelper().getUserModel()?.email ?? ""),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: drawerRow(Icons.home_outlined, "Homepage")),
                GestureDetector(
                    onTap: () {
                      clickLogout(context);
                    },
                    child: drawerRow(Icons.logout_rounded, "Logout"))
              ],
            )),
      ),
    );
  }

  Widget drawerRow(IconData icon, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }

  void clickLogout(BuildContext context) {
    _preferenceHelper.clearAll();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }
}
