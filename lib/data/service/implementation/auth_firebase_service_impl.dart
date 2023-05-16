import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/error/exceptions.dart';
import '../../cache/cache_service.dart';
import '../../enum/response_data.dart';
import '../../models/user.dart';
import '../interfaces/auth_service.dart';
import '../response/response.dart';

class AuthServiceFirebaseImpl implements AuthService {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final UserCacheService cache;

  const AuthServiceFirebaseImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.cache,
  });

  static const userCacheKey = '__user_cache_key__';

  @override
  Response get user {
    final result = firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      cache.write(userCacheKey, user);
      return user;
    });

    return Response(data: result);
  }

  @override
  Response get currentUser {
    final response = cache.read(userCacheKey) ?? User.empty;
    return Response(data: response);
  }

  @override
  Future<Response> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code);
    } catch (_) {
      throw const AuthenticationException();
    }

    return const Response(data: ResponseData.empty);
  }

  @override
  Future<Response> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (kIsWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential =
            await firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;

        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await firebaseAuth.signInWithCredential(credential);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code);
    } catch (_) {
      throw const AuthenticationException();
    }

    return const Response(data: ResponseData.empty);
  }

  @override
  Future<Response> logOut() async {
    try {
      await Future.wait([firebaseAuth.signOut(), googleSignIn.signOut()]);
    } catch (_) {
      throw const AuthenticationException();
    }

    return const Response(data: ResponseData.empty);
  }

  @override
  Future<Response> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      firebase_auth.UserCredential cred =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firebaseAuth.currentUser!.updateDisplayName(username);

      return Response(data: cred.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code);
    } catch (_) {
      throw const AuthenticationException();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
        id: uid, email: email, username: displayName, photoUrl: photoURL);
  }
}
