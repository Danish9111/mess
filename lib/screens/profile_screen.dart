import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

// import 'package:flutter/material.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(screenHeight, screenWidth),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // 👤 USER PROFILE SECTION
//             _buildProfileHeader(context),

//             // 🏆 PROGRESS & BADGES
//             _buildProgressSection(),

//             // 📅 MEAL ACTIVITY
//             _buildMealActivity(),

//             // 💸 WALLET SECTION
//             _buildWalletSection(),

//             // 🔄 PREFERENCES
//             _buildPreferences(),

//             // 📊 FEEDBACK
//             _buildFeedback(),

//             // 📱 SETTINGS
//             _buildSettings(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// PreferredSizeWidget _buildAppBar(screenHeight, screenWidth) {
//   return PreferredSize(
//     preferredSize: Size.fromHeight(300),
//     child: Container(
//         height: screenHeight * .5,
//         width: double.infinity,
//         padding: EdgeInsets.only(top: 30, left: 16, right: 16),
//         decoration: BoxDecoration(
//           color: Colors.lightBlueAccent,
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//         child: Container()),
//   );
// }

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Profile',
            style: TextStyle(
                color: Colors.lightBlueAccent[700],
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.lightBlueAccent),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildProgressSection(context),
            _buildMealActivity(),
            _buildWalletSection(),
            _buildPreferences(),
            _buildFeedback(),
            _buildSettings(context),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 👤 User Profile Header
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlueAccent.withOpacity(0.1), Colors.white]),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.lightBlueAccent[100],
            backgroundImage: NetworkImage('https://example.com/profile.jpg'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Alex Johnson",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber),
                  ),
                  child: Text("Gold Member",
                      style: TextStyle(
                          color: Colors.amber[800],
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildStatItem(Icons.calendar_today, "Mar 2023"),
                    _buildStatItem(Icons.restaurant, "487 Meals"),
                    _buildStatItem(Icons.timelapse, "1.5 Years"),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text("Profile Complete: 85%",
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.85,
                        backgroundColor: Colors.grey[200],
                        color: Colors.lightBlueAccent,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.lightBlueAccent),
          SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }

  // 🏆 Progress & Badges Section
  Widget _buildProgressSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Loyalty Points",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("340/500",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[700],
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6)),
              ),
              Container(
                width: 340 / 500 * MediaQuery.of(context).size.width * 0.8,
                height: 12,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.lightBlueAccent, Colors.blueAccent]),
                    borderRadius: BorderRadius.circular(6)),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text("Your Impact",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco, color: Colors.green),
                SizedBox(width: 8),
                Text("You saved 22kg of food waste this year!",
                    style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text("Badges Earned",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildBadge("Early Bird", "assets/early_bird.json"),
                _buildBadge("Zero Waste Hero", "assets/recycle.json"),
                _buildBadge("Consistent Diner", "assets/medal.json"),
                _buildBadge("Spice Master", "assets/chili.json"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBadge(String title, String lottiePath) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.lightBlueAccent, width: 2),
            ),
            child: Lottie.asset(lottiePath),
          ),
          SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }

  // 📅 Meal Activity Section
  Widget _buildMealActivity() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Meal Activity",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          _buildMealActivityItem(
              "Last Meal", "Chicken Biryani", "Today", 4.5, Icons.history),
          Divider(height: 20, thickness: 1),
          _buildMealActivityItem("Favorite Meal", "Paneer Tikka Masala",
              "Ordered 32 times", 4.8, Icons.favorite),
          Divider(height: 20, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("This Month", style: TextStyle(fontWeight: FontWeight.w500)),
              Text("12 meals • ₹2,380",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[700],
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Divider(height: 20, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.subscriptions, color: Colors.green),
                  SizedBox(width: 8),
                  Text("Subscription",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(16)),
                child: Text("Active • Renews 15 Oct",
                    style: TextStyle(
                        color: Colors.green[800], fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMealActivityItem(
      String title, String meal, String info, double rating, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent[50], shape: BoxShape.circle),
          child: Icon(icon, color: Colors.lightBlueAccent),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              SizedBox(height: 4),
              Text(meal, style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(info, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            SizedBox(height: 4),
            RatingBarIndicator(
              rating: rating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemSize: 16,
              unratedColor: Colors.grey[300],
            ),
          ],
        )
      ],
    );
  }

  // 💸 Wallet Section
  Widget _buildWalletSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Mess Wallet",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.lightBlueAccent)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Current Balance",
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[700])),
                    Text("₹1,250",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent[700])),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pending Dues",
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[600])),
                    Text("₹320",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange[800])),
                  ],
                ),
                SizedBox(height: 16),
                Divider(height: 1),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Auto Recharge",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Switch(
                      value: true,
                      activeColor: Colors.lightBlueAccent,
                      onChanged: (value) {},
                    )
                  ],
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Payment History →",
                        style: TextStyle(color: Colors.lightBlueAccent[700])),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 🔄 Preferences Section
  Widget _buildPreferences() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Meal Preferences",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildPreferenceChip("Vegetarian", Icons.eco, true),
              _buildPreferenceChip(
                  "No Allergies", Icons.health_and_safety, true),
              _buildPreferenceChip(
                  "Normal Spice", Icons.local_fire_department, true),
            ],
          ),
          SizedBox(height: 16),
          Text("Meal Schedule", style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: Colors.grey[200]!, width: 1),
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.lightBlueAccent[50]),
                children: [
                  _buildDayHeader("Mon"),
                  _buildDayHeader("Tue"),
                  _buildDayHeader("Wed"),
                  _buildDayHeader("Thu"),
                  _buildDayHeader("Fri"),
                  _buildDayHeader("Sat"),
                  _buildDayHeader("Sun"),
                ],
              ),
              TableRow(
                children: List.generate(
                    7, (index) => _buildMealToggle("Breakfast", true)),
              ),
              TableRow(
                children: List.generate(
                    7, (index) => _buildMealToggle("Lunch", true)),
              ),
              TableRow(
                children: List.generate(
                    7, (index) => _buildMealToggle("Dinner", index != 6)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPreferenceChip(String text, IconData icon, bool selected) {
    return FilterChip(
      label: Text(text),
      avatar: Icon(icon, size: 18),
      selected: selected,
      checkmarkColor: Colors.lightBlueAccent,
      selectedColor: Colors.lightBlueAccent[50],
      backgroundColor: Colors.grey[100],
      onSelected: (value) {},
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey[300]!)),
    );
  }

  Widget _buildDayHeader(String day) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(day,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildMealToggle(String meal, bool enabled) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[200]!))),
      child: Column(
        children: [
          Text(meal.substring(0, 1), style: TextStyle(fontSize: 10)),
          SizedBox(height: 2),
          Switch(
            value: enabled,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Colors.lightBlueAccent,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  // 📊 Feedback Section
  Widget _buildFeedback() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your Feedback",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeedbackStat("4.6", "Avg Rating"),
              _buildFeedbackStat("Taste", "Top Category"),
              _buildFeedbackStat("24", "Reviews"),
            ],
          ),
          SizedBox(height: 16),
          Text("Recent Feedback",
              style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Column(
            children: [
              _buildFeedbackItem("Chicken Curry", "Taste was excellent", 4.5),
              _buildFeedbackItem(
                  "Vegetable Pulao", "Could use more spices", 3.5),
              _buildFeedbackItem("Dal Makhani", "Perfect as always!", 5.0),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text("See All →",
                  style: TextStyle(color: Colors.lightBlueAccent[700])),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFeedbackStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent[700])),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildFeedbackItem(String meal, String comment, double rating) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meal, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text(comment,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ],
            ),
          ),
          RatingBarIndicator(
            rating: rating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20,
            unratedColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  // 📱 Settings Section
  Widget _buildSettings(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Account Settings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildSettingsButton(
                  Icons.notifications, "Notifications", true, context),
              _buildSettingsButton(Icons.language, "Language", false, context),
              _buildSettingsButton(
                  Icons.share, "Refer a Friend", false, context),
              _buildSettingsButton(Icons.help, "Help Center", false, context),
              _buildSettingsButton(
                  Icons.privacy_tip, "Privacy Policy", false, context),
              _buildSettingsButton(Icons.exit_to_app, "Logout", false, context),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSettingsButton(
      IconData icon, String text, bool toggle, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(icon, color: Colors.lightBlueAccent),
                SizedBox(width: 12),
                Expanded(child: Text(text)),
                if (toggle)
                  Switch(
                    value: true,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Colors.lightBlueAccent,
                    onChanged: (value) {},
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
