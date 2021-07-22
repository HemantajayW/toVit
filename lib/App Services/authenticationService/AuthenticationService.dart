import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:tovit/App%20Services/sharedPreferences/sharedPreferenceContants.dart';
import 'package:tovit/App%20Services/sharedPreferences/sharedpreferences.dart';

import '../locator.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<dynamic>? _deepLinkBackground;

  AuthenticationService() {
    initialiseFirebaseOnlink(_deepLinkBackground);
  }
  Future<bool> isUserLoggedIn() async {
    User? user = auth.currentUser;
    return user != null;
  }

  Future<dynamic> logout() async {
    try {
      await auth.signOut();
      sharedPreferences.setBool(LOGIN_SP, false);

      print("logged out succesfully");
      return true;
    } catch (w) {
      print(w.toString());
      return w;
    }
  }

  var sharedPreferences = locator<AppSharedPreferences>();

  sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  isuserverified() {
    User? user = FirebaseAuth.instance.currentUser;
    user!.reload();
    print(user.email);
    print(user.emailVerified);
    return user.emailVerified;
  }

  Future<dynamic> loginwithmail(email, password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (isuserverified()) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<dynamic> registermail(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  var acs = ActionCodeSettings(
      // URL you want to redirect back to. The domain (www.example.com) for this
      // URL must be whitelisted in the Firebase Console.
      url: 'https://tovit.page.link/',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.haw.toVit',
      androidPackageName: 'com.haw.toVit',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');

  sendsigninlint(email) async {
    print("############################################$email");
    await auth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: acs,
    );
  }

  signinusinglink(email, emaillink) async {
    var authres =
        await auth.signInWithEmailLink(email: email, emailLink: emaillink);
    return authres.user;
  }

  Future getDynamiClikData() async {
    //Returns the deep linked data
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    return data?.link;
  }

  Future getDynamiBGData() {
    //Returns the deep linked data
    return _deepLinkBackground ??
        Future(() {
          return false;
        });
  }

  initialiseFirebaseOnlink(_deepLinkBackground) {
    FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
      final Uri deepLink = dynamicLink!.link;

      if (deepLink != null) {
        _deepLinkBackground = Future(() {
          return deepLink;
        });
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  User currentuser() {
    return auth.currentUser!;
  }

  updatename(String name) async {
    await auth.currentUser!.updateProfile(
      displayName: name,
    );
    print("name updated: $name");
  }

  updateprofilePIC(String profilePIC) async {
    await auth.currentUser!.updateProfile(
      photoURL: profilePIC,
    );
  }
}

//   Future<dynamic> useGoogleAuthentication() async {
//     final result = await firebaseAuthenticationService.signInWithGoogle();
//     if (!result.hasError) {
//       // String photoUrl = result.user!.photoURL ?? "null";

//       sharedPreferences.setBool(LOGIN_SP, true);
//       sharedPreferences.setString(PROFILEPIC_SP, result.user!.photoURL!);

//       sharedPreferences.setString(PROFILENAME_SP, result.user!.displayName!);

//       return result.user;
//     } else {
//       return result.errorMessage;
//     }
//   }

//   Future<bool> isUserLoggedIn() async {
//     User? user = auth.currentUser;
//     return user != null;
//   }

//   Future<dynamic> logout() async {
//     try {
//       await auth.signOut();
//       sharedPreferences.setBool(LOGIN_SP, false);

//       if (await googleSignIn.isSignedIn()) {
//         googleSignIn.signOut();
//         sharedPreferences.setBool(LOGIN_SP, false);

//         print("signed out of google acc");
//       }
//       print("logged out succesfully");
//       return true;
//     } catch (w) {
//       print(w.toString());
//       return w;
//     }
//   }

//   Future<UserCredential> signInWithPhoneNumber(
//       String verificationId, String code) async {
//     final PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verificationId,
//       smsCode: code,
//     );
//     final authResult = await auth.signInWithCredential(credential);

//     return authResult;

//     // final User user = (await _auth.signInWithCredential(credential)).user;
//   }

//   Future phoneAuthentication({
//     required String phoneNumber,
//     required Function(PhoneAuthCredential authCrendential) onVerified,
//     required Function(FirebaseAuthException error) onVerificationFailed,
//     required Function(String code, int? forceResend) onCodeSent,
//     required Function(String verificationId) oncodeAutoRetrievalTimeout,
//   }) async {
//     await auth.verifyPhoneNumber(
//         timeout: Duration(seconds: 7),
//         phoneNumber: phoneNumber,
//         // autoRetrievedSmsCodeForTesting: "180311",
//         verificationCompleted: onVerified,
//         verificationFailed: onVerificationFailed,
//         codeSent: onCodeSent,
//         codeAutoRetrievalTimeout: oncodeAutoRetrievalTimeout);
//   }

//   Future resendCode({
//     required String phoneNumber,
//     required int forceResendingToken,
//     required Function(PhoneAuthCredential authCrendential) onVerified,
//     required Function(FirebaseAuthException error) onVerificationFailed,
//     required Function(String code, int? forceResend) onCodeSent,
//     required Function(String verificationId) oncodeAutoRetrievalTimeout,
//   }) async {
//     await auth.verifyPhoneNumber(
//         timeout: Duration(seconds: 5),
//         phoneNumber: phoneNumber,
//         forceResendingToken: forceResendingToken,
//         // autoRetrievedSmsCodeForTesting: "180311",
//         verificationCompleted: onVerified,
//         verificationFailed: onVerificationFailed,
//         codeSent: onCodeSent,
//         codeAutoRetrievalTimeout: oncodeAutoRetrievalTimeout);
//   }
// }
