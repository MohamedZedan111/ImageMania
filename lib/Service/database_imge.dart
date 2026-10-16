import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_mania/Models/imge_model.dart';

class DatabaseImg {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  String DBCollectionName = 'images';

  //C
  Future<void> addImage(imgeModel img) async {
    try {
      await _instance.collection(DBCollectionName).add(img.toJson());
    } catch (e) {
      print("Error in addImage ${e.toString()}");
    }
  }

  //R
  Future<List<imgeModel>> getAllImage() async {
    List<imgeModel> images = [];
    try {
      final imageSnapShot = await _instance.collection(DBCollectionName).get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> imageDoc
          in imageSnapShot.docs) {
        images.add(imgeModel.fromJson(imageDoc.data()));
      }
    } catch (e) {
      print("Error in getAllImage ${e.toString()}");
    }
    return images;
  }

  //R byId
  Future<imgeModel?> getImagebyID(String id) async {
    try {
      final imageSnapShot = await _instance
          .collection(DBCollectionName)
          .doc(id)
          .get();
      final singleImage = imageSnapShot.data();
      if (singleImage != null) {
        return imgeModel.fromJson(singleImage);
      }
    } catch (e) {
      print("Error in getImagebyID ${e.toString()}");
    }
    return null;
  }
  //U
  Future<imgeModel?> UpdateImage(String id, imgeModel img) async {
    try {
      await _instance.collection(DBCollectionName).doc(id).update(img.toJson());
    } catch (e) {
      print("Error in UpdateImage ${e.toString()}");
    }
    return null;
  }

  //D
  Future<imgeModel?> DeleteImage(String id) async {
    try {
      _instance.collection(DBCollectionName).doc(id).delete();
    } catch (e) {
      print("Error in DeleteImage ${e.toString()}");
    }
    return null;
  }
}
