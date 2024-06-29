
import 'package:flutter/material.dart';

import '../../config/color.dart';
import 'qr_screen.dart';
import 'wan_ip_screen.dart';
import 'wifi_screen.dart';

class WifiListScreen extends StatelessWidget {
  const WifiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> wifiList = [];
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        title: const Text(
          'Danh sách Wifi',
          style: TextStyle(color: blueBlack),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WifiScreen()),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: (wifiList.isEmpty)
          ? const Center(
              child: Text(
              'Trang này chưa có dữ liệu',
              style: TextStyle(fontSize: 17, color: Colors.blueGrey),
            ))
          : Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                  child: ListView.separated(
                    itemCount: wifiList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                 
                        },
                        child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 45,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  wifiList[index],
                                  style: TextStyle(color: blueBlack, fontSize: 16),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: blueGrey1, size: 20)
                              ],
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 2),
                  ),
             
                
                ),
            ],
          ),
    );
  }
}
