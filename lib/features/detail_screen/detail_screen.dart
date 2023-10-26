import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idea_note/constants/gaps.dart';
import 'package:idea_note/data/db_class_info.dart';
import 'package:idea_note/database/db_helper.dart';
import 'package:idea_note/features/post_screen/edit_screen.dart';
import '../../constants/sizes.dart';

//ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  static String routeName = "/detail";

  IdeaInfo? ideaInfo;

  final _dbHelper = DatabaseHelper();

  DetailScreen({super.key, this.ideaInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: Sizes.size24,
          ),
        ),
        title: Text(
          ideaInfo!.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              // 데이터 삭제 처리 전, 사용자에게 동의 의사 묻기
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("ALERT"),
                    content: const Text("정말로 삭제 하시겠어요?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "취소",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Data DELETE Section
                      TextButton(
                        onPressed: () async {
                          await _setDeleteIdeaInfo(ideaInfo!.id!);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "삭제",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text(
              "삭제",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: Sizes.size16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          Sizes.size24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Motive Load
                    const Text(
                      "아이디어를 떠올린 계기",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      ideaInfo!.motive,
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Gaps.v32,

                    /// Content Load
                    const Text(
                      "아이디어 내용",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      ideaInfo!.content,
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Gaps.v32,

                    /// Importance Load
                    const Text(
                      "아이디어 중요도 점수",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v10,
                    RatingBar.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return const FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.amber,
                        );
                      },
                      direction: Axis.horizontal,
                      itemSize: Sizes.size34,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                      ),
                      initialRating: ideaInfo!.importance.toDouble(),
                      minRating: 1,
                      onRatingUpdate: (double value) {},
                      ignoreGestures: true,
                      updateOnDrag: false,
                    ),
                    Gaps.v32,

                    /// Feedback Load
                    const Text(
                      "유저 피드백 사항",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      ideaInfo!.feedBack,
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  EditScreen.routeName,
                  arguments: ideaInfo,
                );
              },
              child: Container(
                decoration: ShapeDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      Sizes.size10,
                    ),
                  ),
                ),
                height: Sizes.size64 + Sizes.size1,
                alignment: Alignment.center,
                child: const Text(
                  "수정하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setDeleteIdeaInfo(int id) async {
    await _dbHelper.initDataBase();
    await _dbHelper.deleteDatabase(id);
  }
}
