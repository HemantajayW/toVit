import 'package:firebase_auth/firebase_auth.dart';
import 'package:tovit/datamodels/User.dart';
import 'package:tovit/globalvariables.dart';

class DatabaseServices {
  static void getCurrentUserInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    currentUserInfo = toVitUser(
        email: currentFirebaseUser?.email,
        id: currentFirebaseUser?.uid,
        name: currentFirebaseUser?.displayName,
        phone: currentFirebaseUser?.phoneNumber);
    print(currentUserInfo.toString());
  }
}
