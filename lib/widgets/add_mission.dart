import 'package:flutter/material.dart';

import '../models/mission.dart';
import '../services/missions_repository.dart';

class AddMission extends StatefulWidget {
  const AddMission({Key? key}) : super(key: key);

  @override
  State<AddMission> createState() => _AddMissionState();
}

class _AddMissionState extends State<AddMission> {
  final missionTitleContoller = TextEditingController();
  final missionDescContoller = TextEditingController();
  final MissionsRepository missionsRepository = MissionsRepository();

  @override
  void dispose() {
    missionDescContoller.dispose();
    missionTitleContoller.dispose();
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
                    controller: missionTitleContoller,
                    decoration: const InputDecoration(
                      label: Text('Mission title'),
                    ),
                  ),
                  TextFormField(
                    controller: missionDescContoller,
                    decoration: const InputDecoration(
                      label: Text('Mission description'),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    missionsRepository.addMission(Mission(
                        missionTitle: missionTitleContoller.text,
                        missionDesc: missionDescContoller.text));
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
    );
  }
}
