import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AssignScreen extends StatelessWidget {
  const AssignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AssignController controller = Get.put(AssignController());
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _buildAppbar(context),
              buildSearchBar(true, (bool k) => {}, context),
              const SizedBox(height: 10),
              buildListItem(context)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          elevation: 0,
          heroTag: "btn",
          backgroundColor: mainColor,
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              isScrollControlled: true,
              context: context,
              //useRootNavigator: false,
              builder: (BuildContext context) {
                return buildModalBottom(context);
              },
            );
          },
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ));
  }
}

Widget _buildDayWeek() {
  DateTime now = DateTime.now();
  int day = now.day;
  int firstDayOfWeek = now.weekday;
  DateFormat('EEEE').format(now);
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 7; i++)
            Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      getDay(i + 1),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    (now.subtract(Duration(days: firstDayOfWeek - 1 - i)).day !=
                            day)
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(
                              child: Text(
                                now
                                    .subtract(
                                        Duration(days: firstDayOfWeek - 1 - i))
                                    .day
                                    .toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          )
                        : Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: mainColor),
                            child: Center(
                              child: Text(
                                now
                                    .subtract(
                                        Duration(days: firstDayOfWeek - 1 - i))
                                    .day
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                  ]),
            )
        ],
      ),
      // Center(child: Text('Chưa có công việc'),)
    ],
  );
}

Widget _buildAppbar(BuildContext context) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text('TN', style: TextStyle(color: Colors.white)),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.assign,
              style: const TextStyle(fontSize: 20)),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.myJob,
                  style: const TextStyle(color: Colors.grey)),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
      const Expanded(child: SizedBox.shrink()),
      const Icon(Icons.change_circle_outlined)
    ],
  );
}

Widget buildListItem(BuildContext context) {
  return Column(
    children: [
      listItem(AppLocalizations.of(context)!.newJob),
      const SizedBox(height: 10),
      listItem(AppLocalizations.of(context)!.today),
      const SizedBox(height: 10),
      listItem(AppLocalizations.of(context)!.upcoming),
      const SizedBox(height: 10),
      listItem(AppLocalizations.of(context)!.doNot),
    ],
  );
}

Widget buildSearchBar(
    bool k, Function(bool) selectedList, BuildContext context) {
  return Row(
    children: [
      InkWell(
        onTap: () {
          selectedList(true);
        },
        child:
            Icon(Icons.checklist, color: k ? mainColor : Colors.grey, size: 30),
      ),
      const SizedBox(width: 10),
      InkWell(
        onTap: () {
          selectedList(false);
        },
        child: Icon(Icons.calendar_month_outlined,
            color: !k ? mainColor : Colors.grey, size: 30),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
          child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor.withOpacity(0.3)),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          cursorColor: backgroundColor,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
            ),
            //contentPadding: EdgeInsets.only(top: -17),
            contentPadding: EdgeInsets.zero,
            isCollapsed: true,
            hintText: AppLocalizations.of(context)!.job,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      )),
      const SizedBox(
        width: 10,
      ),
      InkWell(
        onTap: () {
          // Get.to(() => FilterAssignScreen());
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.tune),
        ),
      ),
    ],
  );
}

Widget listItem(String name) {
  return SizedBox(
    height: 40,
    child: Row(
      children: [
        const Icon(
          Icons.arrow_drop_down,
          size: 30,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 18),
        )
      ],
    ),
  );
}

Widget buildModalBottom(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context)!.viewInsets.bottom),
    // height: 500,

    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            width: 50,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.lock,
                color: mainColor,
              ),
              const SizedBox(width: 5),
              Text(AppLocalizations.of(context)!.myJob,
                  style: TextStyle(color: Colors.grey[600], fontSize: 17)),
              const Expanded(child: SizedBox.shrink()),
              Text(AppLocalizations.of(context)!.create,
                  style: TextStyle(color: mainColor, fontSize: 17)),
              const SizedBox(width: 5),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.job,
                  hintStyle: TextStyle(color: Colors.grey[400]!),
                  contentPadding: EdgeInsets.only(left: 5)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text('TN', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              const Text('trung nguyen'),
              const Expanded(child: SizedBox.shrink()),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.date_range,
                  color: backgroundColor,
                ),
              ),
              const SizedBox(width: 10),
              Text(AppLocalizations.of(context)!.deadline,
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.description,
                    hintStyle: TextStyle(color: Colors.grey[400]!),
                    contentPadding: const EdgeInsets.only(left: 5)),
                keyboardType: TextInputType.multiline),
          ),
        ],
      ),
    ),
  );
}
