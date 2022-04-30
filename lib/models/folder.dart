import 'mission.dart';

class Folder {
  late String title;
  List<Mission> missions = [];
  Folder({required this.title, required this.missions});

  Folder.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title']! as String,
          missions: json['missions']! as List<Mission>,
        );

  Map<String, dynamic> toJson() {
    return {'title': title, 'missions': missions};
  }
}
