import 'package:carousel_slider/carousel_slider.dart';
// import 'package:devkitflutter/config/constant.dart';
// import 'package:devkitflutter/model/feature/banner_slider_model.dart';
// import 'package:devkitflutter/model/feature/category_model.dart';
// import 'package:devkitflutter/ui/reusable/cache_image_network.dart';
// import 'package:devkitflutter/ui/reusable/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:fluttertoast/fluttertoast.dart';

import '../../config/color.dart';
import '../../config/hrm_constant.dart';
import '../../model/banner_slider_model.dart';
import '../../model/category_model.dart';
import '../../reusable/cache_image_network.dart';
import '../../reusable/global_widget.dart';
import '../hrm/main_hrm_screen.dart';
import '../pos/main_pos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // initialize global widget
  final globalWidget = GlobalWidget();

  Color color1 = const Color(0xFF4AB35E);
  Color color2 = Colors.grey;

  //Color _color3 = Color(0xFFf7941e);

  int _currentIndex = 0;

  int _currentImageSlider = 0;

  List<BannerSliderModel> _bannerData = [];
  List<CategoryModel> _categoryData = [];

  @override
  void initState() {
    _bannerData.add(
        BannerSliderModel(id: 1, image: GLOBAL_URL + '/home_banner/1.jpg'));
    _bannerData.add(
        BannerSliderModel(id: 2, image: GLOBAL_URL + '/home_banner/2.jpg'));
    _bannerData.add(
        BannerSliderModel(id: 3, image: GLOBAL_URL + '/home_banner/3.jpg'));
    // _bannerData.add(
    //     BannerSliderModel(id: 4, image: GLOBAL_URL + '/home_banner/4.jpg'));
    // _bannerData.add(
    //     BannerSliderModel(id: 5, image: GLOBAL_URL + '/home_banner/5.jpg'));

    _categoryData.add(CategoryModel(
        id: 1, name: 'Pos', image: GLOBAL_URL + '/menu/store.png'));
    _categoryData.add(CategoryModel(
        id: 2, name: 'HRM', image: GLOBAL_URL + '/menu/products.png'));
    _categoryData.add(CategoryModel(
        id: 3, name: 'QC Master', image: GLOBAL_URL + '/menu/buy_online.png'));
    // _categoryData.add(CategoryModel(
    //     id: 4,
    //     name: 'Apply for Credit',
    //     image: GLOBAL_URL + '/menu/apply_credit.png'));
    // _categoryData.add(CategoryModel(
    //     id: 5,
    //     name: 'Credit\nApplication\nStatus',
    //     image: GLOBAL_URL + '/menu/credit_application_status.png'));
    // _categoryData.add(CategoryModel(
    //     id: 6,
    //     name: 'Credit Payment',
    //     image: GLOBAL_URL + '/menu/credit_payment.png'));
    // _categoryData.add(CategoryModel(
    //     id: 7, name: 'Commission', image: GLOBAL_URL + '/menu/commission.png'));
    // _categoryData.add(CategoryModel(
    //     id: 8, name: 'Check Point', image: GLOBAL_URL + '/menu/point.png'));
    // _categoryData.add(CategoryModel(
    //     id: 9, name: 'Contact Us', image: GLOBAL_URL + '/menu/contact_us.png'));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: _buildDrawer(context),
          appBar: AppBar(
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              //title: Image.asset('assets/images/logo_horizontal.png', height: 24, color: Colors.white),
              title: Text(
                'CRM',
                style: GoogleFonts.alike(
                  textStyle: TextStyle(color: Colors.white),
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              backgroundColor: color1,
              // leading: IconButton(
              //     icon: Icon(Icons.help_outline),
              //     onPressed: () {
              //       //Fluttertoast.showToast(msg: 'Click about us', toastLength: Toast.LENGTH_SHORT);
              //     }),
              actions: <Widget>[
                IconButton(
                    icon: globalWidget.customNotifIcon(
                        count: 8, notifColor: Colors.white),
                    onPressed: () {
                      //Fluttertoast.showToast(msg: 'Click notification', toastLength: Toast.LENGTH_SHORT);
                    }),
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      //Fluttertoast.showToast(msg: 'Click setting', toastLength: Toast.LENGTH_SHORT);
                    })
              ]),
          body: ListView(
            children: [_buildTop(), _buildHomeBanner(), _createMenu()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            selectedFontSize: 8,
            unselectedFontSize: 8,
            iconSize: 28,
            selectedLabelStyle: TextStyle(
                color: _currentIndex == 1 ? color2 : color1,
                fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(color: color2, fontWeight: FontWeight.bold),
            selectedItemColor: _currentIndex == 1 ? color2 : color1,
            unselectedItemColor: color2,
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home,
                      color: _currentIndex == 0 ? color1 : color2)),
              BottomNavigationBarItem(
                  label: 'Cinema',
                  icon: Icon(Icons.movie,
                      color: _currentIndex == 1 ? color1 : color2)),
              BottomNavigationBarItem(
                  label: 'Ticket',
                  icon: Icon(Icons.label,
                      color: _currentIndex == 2 ? color1 : color2))
            ],
          )),
    );
  }

  Widget _buildTop() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              //Fluttertoast.showToast(msg: 'Click profile picture', toastLength: Toast.LENGTH_SHORT);
            },
            child: Hero(
              tag: 'profilePicture',
              child: ClipOval(
                child: buildCacheNetworkImage(
                    url: GLOBAL_URL + '/user/avatar.png', width: 50),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Fluttertoast.showToast(msg: 'Click name', toastLength: Toast.LENGTH_SHORT);
                    },
                    child: Text(
                      'Robert Steven',
                      style: TextStyle(
                          color: color2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Fluttertoast.showToast(msg: 'Click platinum member', toastLength: Toast.LENGTH_SHORT);
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 6),
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: color2, size: 12),
                            SizedBox(width: 4),
                            Text('platinum member',
                                maxLines: 1,
                                style: TextStyle(
                                    color: color2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9))
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Fluttertoast.showToast(msg: 'Click log out', toastLength: Toast.LENGTH_SHORT);
            },
            child: SizedBox(
              height: 30,
              child: Center(
                child: Text('Log Out',
                    style:
                        TextStyle(color: color2, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHomeBanner() {
    return Stack(
      children: [
        CarouselSlider(
          items: _bannerData
              .map((item) => GestureDetector(
                  onTap: () {
                    //Fluttertoast.showToast(msg: 'Click banner '+item.id.toString(), toastLength: Toast.LENGTH_SHORT);
                  },
                  child: buildCacheNetworkImage(
                      width: 0, height: 0, url: item.image)))
              .toList(),
          options: CarouselOptions(
              aspectRatio: 2,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 300),
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageSlider = index;
                });
              }),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _bannerData.map((item) {
              int index = _bannerData.indexOf(item);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: _currentImageSlider == index ? 10 : 5,
                height: _currentImageSlider == index ? 10 : 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _createMenu() {
    return GridView.count(
      childAspectRatio: 1.1,
      shrinkWrap: true,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: 3,
      children: List.generate(_categoryData.length, (index) {
        return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainPosScreen()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainHRMScreen()),
                );
              } else if (index == 2) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const MainQCMastercreen()),
                // );
              }
              //Fluttertoast.showToast(msg: 'Click '+_categoryData[index].name.replaceAll('\n', ' '), toastLength: Toast.LENGTH_SHORT);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[100]!, width: 0.5),
                  color: Colors.white),
              padding: const EdgeInsets.all(8),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    buildCacheNetworkImage(
                        width: 40,
                        height: 40,
                        url: _categoryData[index].image,
                        imageColor: mainColor,
                        plColor: mainColor),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: Text(
                        _categoryData[index].name,
                        style: TextStyle(
                          color: color1,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ])),
            ));
      }),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        // const UserAccountsDrawerHeader(
        //   accountName: Text("DSR73575540002"),
        //   accountEmail: Text("LE MINH TRIEU"),
        //   currentAccountPicture: CircleAvatar(
        //     backgroundColor: Colors.white,
        //     child: Text("A", style: TextStyle(fontSize: 40.0)),
        //   ),
        // ),
        Container(
          color: color1,
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: Column(children: const [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(GLOBAL_URL + '/user/avatar.png'),
            ),
            SizedBox(height: 10),
            Text(
              'DSR73575540002',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              'LE MINH TRIEU',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ]),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'Dashboard',
            style: TextStyle(fontSize: 17),
          ),
          //trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Thông tin cá nhân', style: TextStyle(fontSize: 17)),
          //leading: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.store),
          title: Text('Viếng thăm hôm nay', style: TextStyle(fontSize: 17)),
          onTap: () {
            // Navigator.pop(context);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const VisitTodayScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.check_sharp),
          title: Text('Khách hàng đã thăm hôm nay',
              style: TextStyle(fontSize: 17)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Thoát', style: TextStyle(fontSize: 17)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}
