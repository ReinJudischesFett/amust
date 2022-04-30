import 'package:amust/services/mission_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OpenedFolder extends StatefulWidget {
  const OpenedFolder({Key? key}) : super(key: key);
  static const String routeName = '/openedFolder';

  @override
  State<OpenedFolder> createState() => _OpenedFolderState();
}

class _OpenedFolderState extends State<OpenedFolder> {
  final missionTitleController = TextEditingController();
  final missionService = MissionService();
  @override
  void dispose() {
    missionTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String folderId =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  children: [
                    TextFormField(
                      controller: missionTitleController,
                      decoration: const InputDecoration(
                        label: Text('Mission title'),
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      missionService.addMission(
                          folderId, missionTitleController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('add mission'),
                  )
                ],
              );
            },
          );
        },
        label: const Text('add mission'),
      ),
      appBar: AppBar(
        title: const Text('Folder name'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: missionService.getMissions(folderId),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Text('no data');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data!.docs[index].get('missionTitle'),
                        ),
                        leading: Checkbox(
                          value: snapshot.data!.docs[index]
                                  .get('isDone')
                                  .toString()
                                  .toLowerCase() ==
                              'true',
                          onChanged: (bool? newStatus) {
                            missionService.updateMissionStatus(folderId,
                                snapshot.data!.docs[index].id, newStatus!);
                          },
                        ),
                      );
                    },
                  );
                }
              }),
        ],
      ),
    );
  }
}
