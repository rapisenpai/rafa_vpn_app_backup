import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vpn_basic_project/screens/login.dart';
import '../apis/apis.dart';
import '../main.dart';
import '../models/ip_details.dart';
import '../models/network_data.dart';
import '../widgets/network_card.dart';

class NetworkTestScreen extends StatelessWidget {
  NetworkTestScreen({Key? key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginPage(
          onTap: () {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    final ipData = IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Network'),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),

      // Refresh button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            // Refresh IP details on button press
            ipData.value = IPDetails.fromJson({});
            APIs.getIPDetails(ipData: ipData);
          },
          child: Icon(CupertinoIcons.refresh),
        ),
      ),

      body: Obx(
        () => ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: mq.width * .04,
            right: mq.width * .04,
            top: mq.height * .01,
            bottom: mq.height * .1,
          ),
          children: [
            // User information
            Column(
              children: [
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.photoURL ?? ''),
                ),
                SizedBox(height: 16),
                Text('Account Name: ${user.displayName ?? ''}'),
                SizedBox(height: 8),
                Text('Email: ${user.email ?? ''}'),
              ],
            ),

            // Divider or spacing if needed
            SizedBox(height: 20),

            // Network cards
            NetworkCard(
              data: NetworkData(
                title: 'IP Address',
                subtitle: ipData.value.query,
                icon: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.blue,
                ),
              ),
            ),

            NetworkCard(
              data: NetworkData(
                title: 'Internet Provider',
                subtitle: ipData.value.isp,
                icon: Icon(Icons.business, color: Colors.orange),
              ),
            ),

            NetworkCard(
              data: NetworkData(
                title: 'Location',
                subtitle: ipData.value.country.isEmpty
                    ? 'Fetching ...'
                    : '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}',
                icon: Icon(
                  CupertinoIcons.location,
                  color: Colors.pink,
                ),
              ),
            ),

            NetworkCard(
              data: NetworkData(
                title: 'Pin-code',
                subtitle: ipData.value.zip,
                icon: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.cyan,
                ),
              ),
            ),

            NetworkCard(
              data: NetworkData(
                title: 'Timezone',
                subtitle: ipData.value.timezone,
                icon: Icon(CupertinoIcons.time, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
