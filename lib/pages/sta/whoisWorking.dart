

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhoIsWorkingScrenn extends StatefulWidget {
  final int tabIndex;
  const WhoIsWorkingScrenn({required this.tabIndex, Key? key}) : super(key: key);

  @override
  State<WhoIsWorkingScrenn> createState() => _WhoIsWorkingScrennState();
}

class _WhoIsWorkingScrennState extends State<WhoIsWorkingScrenn> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Số lượng tab
      initialIndex: widget.tabIndex  -1,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text('Who Is Working'),
              Spacer(),
              Icon(Icons.filter_list_alt),
              Icon(Icons.location_on),
            ],
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Kích thước của tab
            tabs: [
              Tab(text: 'Đã vào' " 0"),
              Tab(text: 'Đi muộn' " 0"),
              Tab(text: 'Đúng giờ' " 0"),
              Tab(text: 'Chưa vào' " 0"),
              Tab(text: 'Nghỉ phép' " 0"),
              Tab(text: 'Chia sẻ vị trí' " 0"),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Màu nền
                borderRadius: BorderRadius.circular(10.0), // Góc bo tròn
              ),
              child: const TextField(
                // controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  border: InputBorder.none, // Loại bỏ viền
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  // Nội dung cho Tab 1
                  Center(child: Text('Đã làm')),
                  // Nội dung cho Tab 2
                  Center(child: Text('Đi muộn')),
                  // Nội dung cho Tab 3
                  Center(child: Text('Đúng giờ')),
                  // Nội dung cho Tab 4
                  Center(child: Text('Chưa vào')),
                  // Nội dung cho Tab 5
                  Center(child: Text('Nghỉ phép')),
                  // Nội dung cho Tab 6
                  Center(child: Text('Chia sẻ vị trí')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}