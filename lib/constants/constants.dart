import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const appName = "EcoSynergy";
const appTagLine = "Elevate Life, Embrace Harmony";

//firebase vars

var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;

// some user vars

String userName = "";

String userUid = "";

String userEmail = "";
