library kupa.globals;

import 'package:firebase_auth/firebase_auth.dart';
  final uid = FirebaseAuth.instance.currentUser?.uid;