import 'package:flutter/material.dart';

Widget buildWalletSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Mess Wallet",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
              const SizedBox(height: 12),
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
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Auto Recharge",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Switch(
                    value: true,
                    activeColor: Colors.lightBlueAccent,
                    onChanged: (value) {},
                  )
                ],
              ),
              const SizedBox(height: 8),
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
