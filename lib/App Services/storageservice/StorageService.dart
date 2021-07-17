// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';

// class CloudStorageService {
//   Future<CloudStorageResult?> uploadImage(
//       {required File imageToUpload, required String title}) async {
//     var imageFileName =
//         title + DateTime.now().millisecondsSinceEpoch.toString();
//     final Reference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child(imageFileName);

//     UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

//     TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);
//     var downloadUrl = await storageSnapshot.ref.getDownloadURL();
//     uploadTask.whenComplete(() {
//       var url = downloadUrl.toString();
//       return CloudStorageResult(imageTitle: imageFileName, imageUrl: url);
//     });
//     return null;
//   }
// }

// class CloudStorageResult {
//   final String imageUrl;
//   final String imageTitle;

//   CloudStorageResult({required this.imageTitle, required this.imageUrl});
// }
