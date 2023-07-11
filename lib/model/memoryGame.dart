class memoryGame {
  int? id;
  String? foundation;
  String? topic;
  String? subTopic;
  List<String>? cCSS;
  String? correctAnswer;
  String? templateType;
  List<Options>? options;
  Title? title;
  String? typeOfQuestion;
  Feedback? feedback;

  memoryGame(
      {this.id,
        this.foundation,
        this.topic,
        this.subTopic,
        this.cCSS,
        this.correctAnswer,
        this.templateType,
        this.options,
        this.title,
        this.typeOfQuestion,
        this.feedback});

  memoryGame.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foundation = json['Foundation'];
    topic = json['Topic'];
    subTopic = json['SubTopic'];
    cCSS = json['CCSS'].cast<String>();
    correctAnswer = json['CorrectAnswer'];
    templateType = json['TemplateType'];
    if (json['Options'] != null) {
      options = <Options>[];
      json['Options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    title = json['Title'] != null ? new Title.fromJson(json['Title']) : null;
    typeOfQuestion = json['Type_of_Question'];
    feedback = json['Feedback'] != null
        ? new Feedback.fromJson(json['Feedback'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Foundation'] = this.foundation;
    data['Topic'] = this.topic;
    data['SubTopic'] = this.subTopic;
    data['CCSS'] = this.cCSS;
    data['CorrectAnswer'] = this.correctAnswer;
    data['TemplateType'] = this.templateType;
    if (this.options != null) {
      data['Options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.title != null) {
      data['Title'] = this.title!.toJson();
    }
    data['Type_of_Question'] = this.typeOfQuestion;
    if (this.feedback != null) {
      data['Feedback'] = this.feedback!.toJson();
    }
    return data;
  }
}

class Options {
  String? image;
  bool isError=false;
  bool isCorrect=false;
  Options({this.image});

  Options.fromJson(Map<String, dynamic> json) {
    image = json['Image'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Image'] = this.image;
    return data;
  }
}

class Title {
  String? text;
  Null audio;

  Title({this.text, this.audio});

  Title.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    audio = json['Audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.text;
    data['Audio'] = this.audio;
    return data;
  }
}

class Feedback {
  String? text;
  String? image;
  String? audio;
  String? video;

  Feedback({this.text, this.image, this.audio, this.video});

  Feedback.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    image = json['Image'];
    audio = json['Audio'];
    video = json['Video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.text;
    data['Image'] = this.image;
    data['Audio'] = this.audio;
    data['Video'] = this.video;
    return data;
  }
}