import 'package:flutter/material.dart';

Widget buildWalletSection() {
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
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                  Text("Rs.1,250",
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
                      style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  Text("Rs.320",
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
