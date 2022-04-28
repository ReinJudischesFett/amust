class Mission {
  late String missionTitle;
  late String missionDesc;

  Mission({required this.missionDesc, required this.missionTitle});

  Mission.fromJson(Map<String, dynamic> json)
      : this(
          missionTitle: json['title']! as String,
          missionDesc: json['description']! as String,
        );

  Map<String, dynamic> toJson() {
    return {'title': missionTitle, 'description': missionDesc};
  }
}
