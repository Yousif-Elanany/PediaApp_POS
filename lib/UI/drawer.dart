import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/Data/components/textGlobal.dart';
import 'package:pediaPOS/UI/Auth/About.dart';
import 'package:pediaPOS/UI/Auth/connection_screen.dart';
import 'package:pediaPOS/UI/Auth/login.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:pediaPOS/theme/app_colors.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Drawer(
          child: Container(
            color: Color.fromARGB(255, 77, 78, 88),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                createDrawerHeader(context),
                const Divider(
                  color: AppColor.white,
                  thickness: 1,
                ),
                // const Padding(
                //     padding: EdgeInsets.only(left: 20, right: 20),
                //     child: Divider(
                //       thickness: 2,
                //       color: AppColor.liteBlack,
                //     )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      // const SizedBox(
                      //   width: 50,
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: AutoSizeText(
                            CacheHelper.getData(key: "Company_Name"),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.tajawal(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: AutoSizeText(
                          'اسم الشركة :',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.tajawal(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      // const SizedBox(
                      //   width: 50,
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: AutoSizeText(
                            CacheHelper.getData(key: "db_Name"),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.tajawal(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: AutoSizeText(
                          'قاعدة البيانات :',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.tajawal(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.white,
                  thickness: 1,
                ),
                createDrawerBodyItem(
                    context: context,
                    icon: Icons.wysiwyg,
                    text: 'من نحن',
                    onTap: () {
                      AppNavigator.navigateTo(context, AboutScreen());
                    }),
                createDrawerBodyItem(
                    context: context,
                    icon: Icons.wysiwyg,
                    text: 'تغيير قاعدة البيانات ',
                    onTap: () {
                      AppNavigator.navigateTo(context, ConnectionScreen());
                    }),
                CacheHelper.getData(key: "User_ID") != null
                    ? createDrawerBodyItem(
                        context: context,
                        icon: Icons.exit_to_app,
                        text: 'تسجيل الخروج',
                        onTap: () {
                          CacheHelper.removeData(key: "User_ID");
                          provider.listen();
                        })
                    : const SizedBox(
                        width: 0,
                      ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/splash.png",
                  height: 100,
                  color: AppColor.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget createDrawerBodyItem(
    {required BuildContext context,
    required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: textGlobalWhiteBold16(context: context, text: text),
        ),
      ],
    ),
    onTap: onTap,
  );
}

Widget createDrawerHeader(BuildContext context) {
  return ListTile(
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Icon(
        Icons.person,
        color: Colors.black,
        size: 20,
      ),
      CacheHelper.getData(key: "User_ID") != null
          ? InkWell(
              onTap: () {
                // AppNavigator.navigateTo(context, Profile());
              },
              child: textGlobalBlackWhite25(
                  context: context, text: "حسابك الشخصي"))
          : InkWell(
              onTap: () {
                AppNavigator.navigateTo(context, LoginScreen());
              },
              child: textGlobalBlackWhite25(
                  context: context, text: "تسجيل الدخول"),
            ),
      const SizedBox(height: 20),
    ]),
  );
}
