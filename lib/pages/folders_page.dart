import 'package:amust/pages/opened_folder.dart';
import 'package:amust/services/folder_service.dart';
import 'package:amust/widgets/add_folder_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/folder.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({Key? key}) : super(key: key);

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  final folderService = FolderService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddFolderButton(),
      appBar: AppBar(title: const Text('mission folders')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: folderService.getFolders(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Text('no data');
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.arrow_forward_ios_outlined),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: (() => Navigator.pushNamed(
                                context, OpenedFolder.routeName,
                                arguments: snapshot.data!.docs[index].id)),
                            child: Text(
                              snapshot.data!.docs[index].get('title'),
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => folderService
                            .removeFolder(snapshot.data!.docs[index].id),
                      ),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
