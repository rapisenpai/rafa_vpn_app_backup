import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/screens/auth_page.dart';
// import '../helpers/ad_helper.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      // AdHelper.precacheInterstitialAd();
      // AdHelper.precacheNativeAd();

      //navigate to home
      // Get.off(() => HomeScreen());
      Get.off(() => AuthPage());

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          //app logo
          Positioned(
              left: mq.width * .3,
              top: mq.height * .2,
              width: mq.width * .4,
              child: Image.asset('assets/images/vpn.png')),

          //label
          Positioned(
            bottom: mq.height * 0.15,
            width: mq.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  'DEFENDER VPN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1,
                    fontFamily: "Klavika",
                    // fontSize: 14,
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   child: Image.asset(
                //     'assets/images/social_media_icons.png', // Replace with your image path
                //     width: 50, // Adjust the width as needed
                //     height: 50, // Adjust the height as needed
                //     // Other image properties can be adjusted as needed
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
