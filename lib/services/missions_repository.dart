import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/mission.dart';

class MissionsRepository {
  final missionsRef =
      FirebaseFirestore.instance.collection('missions').withConverter<Mission>(
            fromFirestore: (snapshot, _) => Mission.fromJson(snapshot.data()!),
            toFirestore: (mission, _) => mission.toJson(),
          );

  void addMission(String missionTitle) {
    missionsRef.add(Mission(missionTitle: missionTitle, isDone: false));
  }

  void updateMissionCheckbox(String id, bool value) {
    missionsRef.doc(id).update({'isDone': value});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMissions() {
    return FirebaseFirestore.instance.collection('missions').snapshots();
  }
}
