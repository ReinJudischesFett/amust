import 'package:amust/pages/folders_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/opened_folder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(routes: {
    OpenedFolder.routeName: (context) => const OpenedFolder(),
  }, home: const FoldersPage()));
}
