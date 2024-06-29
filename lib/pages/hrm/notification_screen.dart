import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';



class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2FBF8),
        appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.white,elevation: 0,),
        body: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Icon(Icons.clear,color: blueBlack.withOpacity(0.5),size: 30,),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                InkWell(child: Icon(Icons.tune)),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 40,
            child: TabBar(
                labelColor: mainColor,
                indicatorColor: mainColor,
                unselectedLabelColor: Colors.grey[400],
                padding: const EdgeInsets.all(0),
                labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                tabs: [
                  Tab(
                      child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Thông báo', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 5),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: mainColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(3)),
                          child: Center(
                              child: Text(
                            '0',
                            style: TextStyle(color: mainColor),
                          )),
                        )
                      ],
                    ),
                  )),
                  Tab(child: Text('Tin tức', style: TextStyle(fontSize: 16))),
                  Tab(child: Text('Nội quy ', style: TextStyle(fontSize: 16))),
                ]),
          ),
          Expanded(
              child: Container(
                  color: mainColor.withOpacity(0.15),
                  child: TabBarView(children: [
                    Center(
                        child: Text('Chưa có thông báo',
                            style: TextStyle(fontSize: 18))),
                    Center(
                        child: Text('Tin tức', style: TextStyle(fontSize: 18))),
                    Center(
                        child: Text('Nội quy', style: TextStyle(fontSize: 18)))
                  ]))),
        ]),
      ),
    );
  }
}
