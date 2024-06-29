import 'package:flutter/material.dart';
import '../../config/color.dart';
import 'wan_ip_screen.dart';

class WanIPListScreen extends StatelessWidget {
  const WanIPListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> wanIPList = ['Cham Cong1', 'Cham Cong2'];
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        title: const Text(
          'Danh sách Wan IP',
          style: TextStyle(color: blueBlack),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WanIPScreen()),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: (wanIPList.isEmpty)
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
                    itemCount: wanIPList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 45,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  wanIPList[index],
                                  style:
                                      const TextStyle(color: blueBlack, fontSize: 16),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(Icons.arrow_forward_ios,
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
