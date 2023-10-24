// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idea_note/constants/sizes.dart';
import 'package:idea_note/database/db_helper.dart';
import 'package:intl/intl.dart';

import '../../data/db_class_info.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/main";

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Initialize Database
  var dbHelper = DatabaseHelper();
  List<IdeaInfo> listIdeaInfo = [];

  /// Read Database
  /// SELECT * FROM `tb_idea` WHERE (1) ORDER BY regDate DESC
  Future<void> _getIdeaInfo() async {
    await dbHelper.initDataBase();
    listIdeaInfo = await dbHelper.selectDatabase();
    listIdeaInfo.sort(
      (a, b) => b.regDate.compareTo(a.regDate),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getIdeaInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Archive Note",
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          Sizes.size20,
        ),
        child: ListView.builder(
          itemCount: listIdeaInfo.length,
          itemBuilder: (BuildContext context, int index) {
            return listItem(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Post Button Pressed!");
        },
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
        child: Image.asset(
          "assets/images/floating_btn.png",
          height: Sizes.size44,
          width: Sizes.size44,
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.size20,
      ),
      child: Container(
        height: Sizes.size80 + Sizes.size2,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(
              Sizes.size10,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            /// title
            Padding(
              padding: const EdgeInsets.only(
                left: Sizes.size16,
                bottom: Sizes.size16,
              ),
              child: Text(
                "# ${listIdeaInfo[index].title}",
                style: const TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
            ),

            /// regDate
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: Sizes.size8,
                  right: Sizes.size16,
                ),
                child: Text(
                  DateFormat("yyyy.MM.dd HH:mm").format(
                    DateTime.fromMillisecondsSinceEpoch(
                        listIdeaInfo[index].regDate),
                  ),
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: Sizes.size10,
                  ),
                ),
              ),
            ),

            /// importance
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: Sizes.size8,
                  left: Sizes.size16,
                ),
                child: RatingBar.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return const FaIcon(
                      FontAwesomeIcons.star,
                      color: Colors.amber,
                    );
                  },
                  direction: Axis.horizontal,
                  itemSize: Sizes.size16,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  initialRating: listIdeaInfo[index].importance.toDouble(),
                  minRating: 1,
                  onRatingUpdate: (double value) {},
                  ignoreGestures: false,
                  updateOnDrag: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
