//Here is mainui's variables
// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

var listsummary = [];
var keynum = [330, 300, 308, 326, 250, 250];

//FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseApp mobilever = Firebase.app('Detector');
FirebaseApp webver = Firebase.app('Detect System');
FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: mobilever);
