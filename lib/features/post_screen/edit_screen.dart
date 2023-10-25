import 'package:flutter/material.dart';
import 'package:idea_note/constants/gaps.dart';
import 'package:idea_note/data/db_class_info.dart';
import 'package:idea_note/database/db_helper.dart';

import '../../constants/sizes.dart';

class EditScreen extends StatefulWidget {
  static String routeName = "/edit";
  IdeaInfo? ideaInfo;

  EditScreen({super.key, this.ideaInfo});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  /// 제목
  final TextEditingController _titleEditingController = TextEditingController();

  /// 계기
  final TextEditingController _motiveEditingController =
      TextEditingController();

  /// 내용
  final TextEditingController _contentEditingController =
      TextEditingController();

  /// 피드백
  final TextEditingController _feedBackEditingController =
      TextEditingController();

  /// 아이디어 중요도 점수
  bool isClicked01 = false;
  bool isClicked02 = false;
  bool isClicked03 = true;
  bool isClicked04 = false;
  bool isClicked05 = false;

  /// 아이디어 현재 중요도 점수 (Chosen Default Value is 3)
  int importancePoint = 3;

  /// DBHelper
  final dbHelper = DatabaseHelper();

  void _getBack() {
    Navigator.pop(context);
  }

  void _unFocus() {
    FocusScope.of(context).unfocus();
  }

  void _initClickStatus() {
    isClicked01 = false;
    isClicked02 = false;
    isClicked03 = false;
    isClicked04 = false;
    isClicked05 = false;
  }

  Future<void> _setInsertIdeaInfo(IdeaInfo ideaInfo) async {
    await dbHelper.initDataBase();
    await dbHelper.insertDatabase(ideaInfo);
  }

  @override
  void initState() {
    super.initState();

    _titleEditingController;
    _motiveEditingController;
    _contentEditingController;
    _feedBackEditingController;
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _motiveEditingController.dispose();
    _contentEditingController.dispose();
    _feedBackEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: _getBack,
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: Sizes.size24,
          ),
        ),
        title: const Text(
          "새 아이디어 작성하기",
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: _unFocus,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(
              Sizes.size24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "제목",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "아이디어 제목",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(
                          Sizes.size10,
                        ),
                      ),
                    ),
                    controller: _titleEditingController,
                    style: const TextStyle(
                      fontSize: Sizes.size12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Gaps.v24,
                const Text(
                  "아이디어를 작성한 계기",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "아이디어를 작성한 계기",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(
                          Sizes.size10,
                        ),
                      ),
                    ),
                    controller: _motiveEditingController,
                    style: const TextStyle(
                      fontSize: Sizes.size12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Gaps.v24,
                const Text(
                  "아이디어 내용",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                  ),
                  child: TextField(
                    maxLines: 10,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      hintText: "아이디어 내용을 상세히 작성해 주세요.",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(
                          Sizes.size10,
                        ),
                      ),
                    ),
                    controller: _contentEditingController,
                    style: const TextStyle(
                      fontSize: Sizes.size12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Gaps.v24,
                const Text(
                  "아이디어 중요도 점수",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _initClickStatus();
                          setState(() {
                            importancePoint = 1;
                            isClicked01 = true;
                          });
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: isClicked01
                                ? Colors.grey.shade300
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.size10,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          height: Sizes.size40,
                          width: Sizes.size50,
                          child: const Text(
                            "1",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _initClickStatus();
                          setState(() {
                            importancePoint = 2;
                            isClicked02 = true;
                          });
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: isClicked02
                                ? Colors.grey.shade300
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.size10,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          height: Sizes.size40,
                          width: Sizes.size50,
                          child: const Text(
                            "2",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _initClickStatus();
                          setState(() {
                            importancePoint = 3;
                            isClicked03 = true;
                          });
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: isClicked03
                                ? Colors.grey.shade300
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.size10,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          height: Sizes.size40,
                          width: Sizes.size50,
                          child: const Text(
                            "3",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _initClickStatus();
                          setState(() {
                            importancePoint = 4;
                            isClicked04 = true;
                          });
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: isClicked04
                                ? Colors.grey.shade300
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.size10,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          height: Sizes.size40,
                          width: Sizes.size50,
                          child: const Text(
                            "4",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _initClickStatus();
                          setState(() {
                            importancePoint = 5;
                            isClicked05 = true;
                          });
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: isClicked05
                                ? Colors.grey.shade300
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.size10,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          height: Sizes.size40,
                          width: Sizes.size50,
                          child: const Text(
                            "5",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.v24,
                const Text(
                  "유저 피드백 사항 (선택)",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                  ),
                  child: TextField(
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: "떠오른 아이디어를 기반으로\n전달받은 피드백을 정리해 주세요.",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(
                          Sizes.size10,
                        ),
                      ),
                    ),
                    controller: _feedBackEditingController,
                    style: const TextStyle(
                      fontSize: Sizes.size12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Gaps.v32,
                GestureDetector(
                  onTap: () async {
                    String titleValue = _titleEditingController.text.toString();
                    String motiveValue = _motiveEditingController.text.toString();
                    String contentValue = _contentEditingController.text.toString();
                    String feedBackValue = _feedBackEditingController.text.toString();

                    // Validation Scope
                    if (titleValue.isEmpty ||
                        motiveValue.isEmpty ||
                        contentValue.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("비어있는 입력 값이 존재합니다!"),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }

                    // Data INSERT
                    if (widget.ideaInfo == null) {
                      var ideaInfo = IdeaInfo(
                        title: titleValue,
                        motive: motiveValue,
                        content: contentValue,
                        importance: importancePoint,
                        feedBack: feedBackValue.isNotEmpty ? feedBackValue : "",
                        regDate: DateTime.now().millisecondsSinceEpoch,
                      );

                      await _setInsertIdeaInfo(ideaInfo);

                      if (mounted) {
                        Navigator.pop(context);
                      }
                    }
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
                      "작성완료",
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
        ),
      ),
    );
  }
}
