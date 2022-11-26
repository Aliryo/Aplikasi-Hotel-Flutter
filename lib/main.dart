import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelio/config/app_colors.dart';
import 'package:hotelio/config/app_route.dart';
import 'package:hotelio/config/session.dart';
import 'package:hotelio/models/user_model.dart';
import 'package:hotelio/pages/checkout_page.dart';
import 'package:hotelio/pages/checkout_success_page.dart';
import 'package:hotelio/pages/detail_booking_page.dart';
import 'package:hotelio/pages/detail_page.dart';
import 'package:hotelio/pages/home_page.dart';
import 'package:hotelio/pages/intro_page.dart';
import 'package:hotelio/pages/signin_page.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting('en_UsS');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: AppColor.backgroundScaffold,
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
        ),
      ),
      routes: {
        '/': (context) {
          return FutureBuilder(
              future: Session.getUser(),
              builder: (context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.data == null || snapshot.data!.id == null) {
                  return const IntroPage();
                } else {
                  return HomePage();
                }
              });
        },
        AppRoute.intro: (context) => const IntroPage(),
        AppRoute.signin: (context) => SignInPage(),
        AppRoute.home: (context) => HomePage(),
        AppRoute.detail: (context) => DetailPage(),
        AppRoute.checkout: (context) => CheckoutPage(),
        AppRoute.checkoutSuccess: (context) => const CheckoutSuccessPage(),
        AppRoute.detailBooking: (context) => const DetailBookingPage(),
      },
    );
  }
}
