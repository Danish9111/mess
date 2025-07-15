import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mess/providers/google_user_provider.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/glassy_days_container.dart';
import 'dashboard_body.dart';
import 'package:mess/extentions.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/dashboard_drawer.dart';
import 'dart:developer';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends ConsumerState<DashboardScreen> {
  final List<String> days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

  @override
  Widget build(BuildContext context) {
    final googleUser = ref.watch(userProvider);
    log('i am from  dashboard screen');
    final url = googleUser?.photoUrl;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: buildDrawer(context),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
          ),
        ),
        flexibleSpace: Stack(
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
            ),

            // Content layout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Profile section + actions
                  SizedBox(height: MediaQuery.of(context).padding.top + 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile with avatar and text
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.white.applyOpacity(0.3),
                              child: url == null
                                  ? const Icon(Icons.person,
                                      size: 30, color: Colors.white)
                                  : ClipOval(
                                      child: Image.network(url),
                                    )),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nadeem Danish',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Favourite Meal : Chicken Biryani 😍',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.applyOpacity(0.9),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Vertical action buttons
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.applyOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications_active,
                                  color: Colors.white, size: 26),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings,
                                  color: Colors.white, size: 26),
                              onPressed: () =>
                                  scaffoldKey.currentState?.openDrawer(), //() {
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const GlassyDaysContainer(),

                  // Enhanced glassy days bar with click functionality
                ],
              ),
            ),
          ],
        ),
        title: const Text(''),
        toolbarHeight: MediaQuery.of(context).size.height * 0.3,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // body: const DashboardBody(),
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Colors.lightBlueAccent,
              height: double.infinity,
              width: double.infinity,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(90),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(90),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DashboardBody(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
