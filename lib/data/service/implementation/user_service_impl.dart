import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/error/exceptions.dart';
import '../../enum/response_data.dart';
import '../../models/user.dart' as model;
import '../interfaces/file_storage_service.dart';
import '../interfaces/user_service.dart';
import '../response/response.dart';

class UserServiceImpl implements UserService {
  final FirebaseFirestore firestore;
  final FileStorageService storageService;
  final FirebaseAuth firebaseAuth;

  const UserServiceImpl({
    required this.firestore,
    required this.storageService,
    required this.firebaseAuth,
  });

  static const userCollection = 'users';

  @override
  Future<Response> addUser(model.User user) async {
    try {
      await firestore
          .collection(userCollection)
          .doc(user.id)
          .set(user.toJson());

      final currentUser = firebaseAuth.currentUser!;
      await currentUser.updateDisplayName(user.username);
      await currentUser.reload();
    } on FirebaseException catch (e) {
      throw DatastoreException(
        code: e.code,
      );
    } catch (_) {
      throw const DatastoreException();
    }

    return const Response(data: ResponseData.empty);
  }

  @override
  Future<Response> getUser(String id) async {
    try {
      DocumentSnapshot userDoc =
          await firestore.collection(userCollection).doc(id).get();

      final user = (userDoc.data() as Map<String, dynamic>);

      return Response(data: user);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }

  @override
  Future<Response> updateUser(model.User user, [Uint8List? photoFile]) async {
    try {
      String photoUrl = '';
      late model.User userUpdated;

      if (photoFile != null) {
        final response = await storageService.uploadImageToStorage(
            'profilePics', photoFile, false);
        photoUrl = response.data;

        userUpdated = user.copyWith(photoUrl: photoUrl);
      } else {
        userUpdated = user;
      }

      await firestore
          .collection(userCollection)
          .doc(userUpdated.id)
          .update(userUpdated.toJson());

      await _updateUserAtFirebaseAuthSystem(user, photoUrl);

      return const Response(data: ResponseData.empty);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }

  @override
  Future<Response> followUser(String userId, String followId) async {
    try {
      DocumentSnapshot snap =
          await firestore.collection(userCollection).doc(userId).get();

      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await firestore.collection(userCollection).doc(followId).update({
          'following': FieldValue.arrayRemove([userId])
        });

        await firestore.collection(userCollection).doc(userId).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        if (following.contains(followId)) {
          await firestore.collection(userCollection).doc(followId).update({
            'following': FieldValue.arrayUnion([userId])
          });

          await firestore.collection(userCollection).doc(userId).update({
            'following': FieldValue.arrayUnion([followId])
          });
        }
      }
      return const Response(data: ResponseData.empty);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }

  _updateUserAtFirebaseAuthSystem(model.User user, String photoUrl) async {
    final currentUser = firebaseAuth.currentUser!;

    await currentUser.updateDisplayName(user.username);
    await currentUser.updatePhotoURL(photoUrl);
    await currentUser.updateEmail(user.email!);

    await currentUser.reload();
  }
}
