class AnswerModel {
  String index;
  String title;
  String answer;
  String userSelect;
  bool isRight;
  List<String> answerList;

  AnswerModel(
      {this.index,
        this.title,
        this.answer,
        this.userSelect,
        this.isRight,
        this.answerList});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    title = json['title'];
    answer = json['answer'];
    userSelect = json['userSelect'];
    isRight = json['isRight'];
    answerList = json['answerList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['title'] = this.title;
    data['answer'] = this.answer;
    data['userSelect'] = this.userSelect;
    data['isRight'] = this.isRight;
    data['answerList'] = this.answerList;
    return data;
  }
}
