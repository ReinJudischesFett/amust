import 'package:amust/services/folder_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/folder.dart';

class AddFolderButton extends StatefulWidget {
  const AddFolderButton({Key? key}) : super(key: key);

  @override
  State<AddFolderButton> createState() => _AddFolderButtonState();
}

class _AddFolderButtonState extends State<AddFolderButton> {
  final folderTitleController = TextEditingController();
  final folderService = FolderService();
  @override
  void dispose() {
    folderTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                children: [
                  TextFormField(
                    controller: folderTitleController,
                    decoration: const InputDecoration(
                      label: Text('Folder title'),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    folderService.addFolder(folderTitleController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('add folder'),
                )
              ],
            );
          },
        );
      },
      label: const Text('add folder'),
    );
  }
}
