import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'services/missions_repository.dart';
import 'widgets/add_mission.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MissionsRepository missionsRepository = MissionsRepository();
  final missionTitleContoller = TextEditingController();
  final missionDescContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddMission(),
      appBar: AppBar(
        title: const Text('992'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: missionsRepository.getMissions(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Text('no data');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Card(
                          child: ListTile(
                              title: Text(
                                snapshot.data!.docs[index].get('title'),
                              ),
                              subtitle: Text(snapshot.data!.docs[index]
                                  .get('description')),
                              leading: IconButton(
                                icon: const Icon(Icons.check_box),
                                onPressed: () {},
                              )),
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
