import 'package:flutter/material.dart';

Widget buildProfileHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.lightBlueAccent),
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
              Text(
                "Nadeem Danish",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
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
                        color: Colors.amber[800], fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _buildStatItem(Icons.calendar_today, "Mar 2023"),
                  _buildStatItem(Icons.restaurant, "487 Meals"),
                  _buildStatItem(Icons.timelapse, "1.5 Years"),
                ],
              ),
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
        Icon(icon, size: 14, color: Colors.white),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.white))
      ],
    ),
  );
}
