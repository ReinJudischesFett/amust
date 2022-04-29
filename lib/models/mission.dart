class Mission {
  late String missionTitle;
  late bool isDone;

  Mission({required this.missionTitle, required this.isDone});

  Mission.fromJson(Map<String, dynamic> json)
      : this(
          missionTitle: json['title']! as String,
          isDone: json['isDone']! as bool,
        );

  Map<String, dynamic> toJson() {
    return {'title': missionTitle, 'isDone': isDone};
  }
}
