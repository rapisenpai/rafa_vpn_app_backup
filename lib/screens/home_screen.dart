import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';

import '../controllers/home_controller.dart';
// import '../helpers/ad_helper.dart';
// import '../helpers/config.dart';
// import '../helpers/pref.dart';
import '../main.dart';

import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import '../widgets/count_down_timer.dart';
// import '../widgets/home_card.dart';
// import '../widgets/watch_ad_dialog.dart';
import 'location_screen.dart';
import 'network_screen.dart';
import '../models/ip_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());
  final ipData = IPDetails.fromJson({}).obs;
  final Color lightGrayColor = Color(0xFFF1F2F6);
  final Color midnightNavy = Color(0xFF050049);
  final Color whisperGray = Color(0xFFFCFCFC);
  final Color silverGray = Color(0xFFA8A8A8);
  final Color vibrantRed = Color(0xFFFF6666);
  final Color oceanBlue = Color(0xFF4080FC);

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });
    APIs.getIPDetails(ipData: ipData);

    Widget customContainer(
        Widget icon, String title, String subtitle, Color backgroundColor) {
      return SizedBox(
        width: 190, // Set the maximum width for the container
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor,
          ),
          child: Column(
            children: [
              icon,
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      //app bar
      appBar: AppBar(
        // leading: Icon(CupertinoIcons.home),
        title: Text('Defender VPN'),
        actions: [
          // IconButton(
          //     onPressed: () {
          //ad dialog

          // if (Config.hideAds) {
          // Get.changeThemeMode(
          //     Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          // Pref.isDarkMode = !Pref.isDarkMode;
          //   return;
          // }

          // Get.dialog(WatchAdDialog(onComplete: () {
          //   //watch ad to gain reward
          //   AdHelper.showRewardedAd(onComplete: () {
          //     Get.changeThemeMode(
          //         Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          //     Pref.isDarkMode = !Pref.isDarkMode;
          //   });
          // }));
          // },
          // icon: Icon(
          //   Icons.brightness_medium,
          //   size: 26,
          // )),
          IconButton(
              padding: EdgeInsets.only(right: 8),
              onPressed: () => Get.to(() => NetworkTestScreen()),
              icon: Icon(
                CupertinoIcons.info,
                size: 27,
              )),
        ],
      ),

      bottomNavigationBar: _changeLocation(context),

      //body
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        //vpn button
        Obx(() => _vpnButton()),

        // Obx(
        //   () => Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       //country flag
        //       HomeCard(
        //           title: _controller.vpn.value.countryLong.isEmpty
        //               ? 'Country'
        //               : _controller.vpn.value.countryLong,
        //           subtitle: 'FREE',
        //           icon: CircleAvatar(
        //             radius: 30,
        //             backgroundColor: Colors.blue,
        //             child: _controller.vpn.value.countryLong.isEmpty
        //                 ? Icon(Icons.vpn_lock_rounded,
        //                     size: 30, color: Colors.white)
        //                 : null,
        //             backgroundImage: _controller.vpn.value.countryLong.isEmpty
        //                 ? null
        //                 : AssetImage(
        //                     'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
        //           )),

        //       //ping time
        //       HomeCard(
        //           title: _controller.vpn.value.countryLong.isEmpty
        //               ? '100 ms'
        //               : '${_controller.vpn.value.ping} ms',
        //           subtitle: 'PING',
        //           icon: CircleAvatar(
        //             radius: 30,
        //             backgroundColor: Colors.orange,
        //             child: Icon(Icons.equalizer_rounded,
        //                 size: 30, color: Colors.white),
        //           )),
        //     ],
        //   ),
        // ),
        // Usage in StreamBuilder
        StreamBuilder<VpnStatus?>(
          initialData: VpnStatus(),
          stream: VpnEngine.vpnStatusSnapshot(),
          builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Download
              customContainer(
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.arrow_downward_rounded,
                      size: 30, color: Colors.white),
                ),
                '${snapshot.data?.byteIn ?? '0 kbps'}',
                'Download',
                lightGrayColor,
              ),

              // Upload
              customContainer(
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.arrow_upward_rounded,
                      size: 30, color: Colors.white),
                ),
                '${snapshot.data?.byteOut ?? '0 kbps'}',
                'Upload',
                lightGrayColor,
              ),
            ],
          ),
        )
      ]),
    );
  }

  //vpn button
  Widget _vpnButton() => Column(
        children: [
          //button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVpn();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(.1)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor.withOpacity(.3)),
                  child: Container(
                    width: mq.height * .14,
                    height: mq.height * .14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.getButtonColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //icon
                        Icon(
                          Icons.power_settings_new,
                          size: 28,
                          color: Colors.white,
                        ),

                        SizedBox(height: 4),

                        //text
                        Text(
                          _controller.getButtonText,
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 15),

          Container(
            child: Center(
              child: Text(
                'IP Address: ${ipData.value.query}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          SizedBox(height: 10),
          //connection status label
          Container(
            margin:
                EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? ('Not Connected')
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(fontSize: 12.5, color: Colors.white),
            ),
          ),

          //count down timer
          Obx(() => CountDownTimer(
              startTimer:
                  _controller.vpnState.value == VpnEngine.vpnConnected)),
        ],
      );

  Widget _changeLocation(BuildContext context) => SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: () => Get.to(() => LocationScreen()),
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              height: 60,
              child: Row(
                children: [
                  // Country flag or selected country's icon
                  Obx(() => CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: _controller
                                .vpn.value.countryLong.isNotEmpty
                            ? AssetImage(
                                'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png')
                            : AssetImage(
                                'assets/flags/globe.png'), // Replace 'globe.png' with your globe icon
                      )),

                  // For adding some space
                  SizedBox(width: 10),

                  // Text (Select country or Country Name)
                  Text(
                    _controller.vpn.value.countryLong.isNotEmpty
                        ? _controller.vpn.value.countryLong
                        : 'Select Country',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // For covering available spacing
                  Spacer(),

                  Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.white,
                    size: 30,
                  ),

                  // Icon
                  // if (_controller.vpn.value.countryLong.isNotEmpty)
                  //   CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     child: Icon(Icons.keyboard_arrow_up_rounded,
                  //         color: silverGray, size: 26),
                  //   ),
                ],
              ),
            ),
          ),
        ),
      );

  //bottom nav to change location
}
