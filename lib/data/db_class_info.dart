class IdeaInfo {
  int? id; // Index (PK)
  String title; // 아이디어 제목
  String motive; // 아이디어 작성 계기
  String content; // 아이디어 내용
  int importance; // 아이디어 중요도 점수
  String feedBack; // 유저 피드백
  int regDate; // 게시글 생성 일자

  IdeaInfo({
    this.id,
    required this.title,
    required this.motive,
    required this.content,
    required this.importance,
    required this.feedBack,
    required this.regDate,
  });

  /// Parse data into MAP Format
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "motive": motive,
      "content": content,
      "importance": importance,
      "feedBack": feedBack,
      "regDate": regDate,
    };
  }

  /// Encoding & Caching returned data from MAP to CLASS
  factory IdeaInfo.fromMap(Map<String, dynamic> map) {
    return IdeaInfo(
      id: map["id"],
      title: map["title"],
      motive: map["motive"],
      content: map["content"],
      importance: map["importance"],
      feedBack: map["feedBack"],
      regDate: map["regDate"],
    );
  }
}
