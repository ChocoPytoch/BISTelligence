//Here is mainui's variables
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

var listsummary = [];
//FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseApp mobilever = Firebase.app('Detector');
FirebaseApp webver = Firebase.app('Detect System');
FirebaseFirestore firestore = GetPlatform.isMobile
    ? FirebaseFirestore.instanceFor(app: mobilever)
    : FirebaseFirestore.instanceFor(app: webver);
