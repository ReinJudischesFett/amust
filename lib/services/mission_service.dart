import 'package:cloud_firestore/cloud_firestore.dart';

class MissionService {
  final foldersRef = FirebaseFirestore.instance.collection('folders');

  void addMission(String folderId, String missionTitle) {
    foldersRef
        .doc(folderId)
        .collection('missions')
        .add({'missionTitle': missionTitle, 'isDone': false});
  }

  void updateMissionStatus(String folderId, String missionId, bool newStatus) {
    foldersRef
        .doc(folderId)
        .collection('missions')
        .doc(missionId)
        .update({'isDone': newStatus});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMissions(String folderId) {
    return foldersRef.doc(folderId).collection('missions').snapshots();
  }
}
