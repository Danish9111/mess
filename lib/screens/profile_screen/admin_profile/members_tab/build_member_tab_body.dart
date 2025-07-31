import 'package:flutter/material.dart';
import 'package:mess/extentions.dart';
import 'package:mess/screens/profile_screen/admin_profile/members_tab/all_members.dart';

//  '
class BuildMemberTabBody extends StatefulWidget {
  const BuildMemberTabBody({super.key});

  @override
  State<BuildMemberTabBody> createState() => BuildMemberTabBodyState();
}

class BuildMemberTabBodyState extends State<BuildMemberTabBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Total Members in Mess",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        // const Center(child: TotalMembers()),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Inactive Members Card
              const MemberCard(
                backgroundColor: Colors.lightBlueAccent,
                text: 'Active Members',
                icon: Icons.group,
                membersCount: 100,
                iconBackgroundColor: Colors.white,
                textColor: Colors.white,
                isActive: true,
              ),
              const SizedBox(
                width: 20,
              ),

              MemberCard(
                backgroundColor: Colors.grey.shade200,
                text: 'Inactive Members',
                icon: Icons.group_off,
                membersCount: 5,
                iconBackgroundColor: Colors.white,
                textColor: Colors.grey.shade500,
                isActive: false,
              ),
            ],
          )),
        )
      ],
    );
  }
}

class MemberCard extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final IconData icon;
  final int membersCount;
  final Color iconBackgroundColor;
  final bool isActive;

  const MemberCard({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.icon,
    required this.membersCount,
    required this.iconBackgroundColor,
    required this.isActive,
  });
  @override
  State<MemberCard> createState() => MemberCardState();
}

class MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AllMembers(
                      isActive: widget.isActive,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 12,
              spreadRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          children: [
            // Decorative elements (scaled down)
            Positioned(
              top: -10, // Adjusted position
              right: -10, // Adjusted position
              child: Container(
                height: 60, // Smaller circle
                width: 60, // Smaller circle
                decoration: BoxDecoration(
                  color: Colors.white.applyOpacity(0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -15, // Adjusted position
              left: -15, // Adjusted position
              child: Container(
                height: 50, // Smaller circle
                width: 50, // Smaller circle
                decoration: BoxDecoration(
                  color: Colors.white.applyOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Content (scaled proportionally)
            Padding(
              padding: const EdgeInsets.all(16.0), // Reduced padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                children: [
                  Container(
                    padding: const EdgeInsets.all(8), // Reduced padding
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.icon,
                      size: 24, // Smaller icon
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10), // Reduced spacing
                  Text(
                    " ${widget.text}",
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 14, // Smaller font
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4), // Reduced spacing
                  Text(
                    '${widget.membersCount}',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 12, // Smaller font
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// class TotalMembers extends StatelessWidget {
//   const TotalMembers({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return InkWell(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const AllMembers()));
//         // Navigator.pushNamed(context, route)
//       },
//       child: Container(
//         height: screenHeight * .3,
//         width: screenWidth * .9,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.blue.shade300,
//               Colors.lightBlueAccent.shade200,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blue.applyOpacity(0.3),
//               blurRadius: 12,
//               spreadRadius: 4,
//               offset: const Offset(0, 4),
//             )
//           ],
//         ),
//         child: Stack(
//           children: [
//             // Decorative elements
//             Positioned(
//               top: -20,
//               right: -20,
//               child: Container(
//                 height: 120,
//                 width: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.white.applyOpacity(0.15),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -30,
//               left: -30,
//               child: Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.white.applyOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),

//             // Content
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.people_alt_rounded,
//                       size: 32,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Total Members',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     '42', // Replace with dynamic value
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 42,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Roboto',
//                     ),
//                   ),
//                   const Spacer(),
//                   const Align(
//                     alignment: Alignment.bottomRight,
//                     child: Text(
//                       'In Mess',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 16,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
