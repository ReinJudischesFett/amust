import 'package:cloud_firestore/cloud_firestore.dart';

class FolderService {
  final foldersRef = FirebaseFirestore.instance.collection('folders');

  void addFolder(String folderTitle) {
    foldersRef.add({'title': folderTitle, 'missions': []});
  }

  void removeFolder(String id) {
    foldersRef.doc(id).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFolders() {
    return foldersRef.snapshots();
  }
}
