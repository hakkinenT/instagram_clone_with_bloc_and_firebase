import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/app_bloc.dart';
import 'cubit/post_cubit.dart';
import 'data/cache/cache_service.dart';
import 'data/repositories/implementation/authentication_repository_impl.dart';
import 'data/repositories/implementation/comment_repository_impl.dart';
import 'data/repositories/implementation/post_repository_impl.dart';
import 'data/repositories/implementation/user_repository_impl.dart';
import 'data/repositories/interfaces/authentication_repository.dart';
import 'data/repositories/interfaces/comment_repository.dart';
import 'data/repositories/interfaces/post_repository.dart';
import 'data/repositories/interfaces/user_repository.dart';
import 'data/service/implementation/auth_firebase_service_impl.dart';
import 'data/service/implementation/comment_service_impl.dart';
import 'data/service/implementation/file_storage_service_impl.dart';
import 'data/service/implementation/post_service_impl.dart';
import 'data/service/implementation/user_service_impl.dart';
import 'data/service/interfaces/auth_service.dart';
import 'data/service/interfaces/comment_service.dart';
import 'data/service/interfaces/file_storage_service.dart';
import 'data/service/interfaces/post_service.dart';
import 'data/service/interfaces/user_service.dart';
import 'pages/login/cubit/login_cubit.dart';
import 'pages/profile/cubit/profile_cubit.dart';
import 'pages/sign_up/cubit/sign_up_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Bloc
  sl.registerFactory(
    () => AppBloc(
      authenticationRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => LoginCubit(
      authenticationRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => SignUpCubit(
      authenticationRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => ProfileCubit(
      userRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => PostCubit(
      postRepository: sl(),
      commentRepository: sl(),
    ),
  );

  //! Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImp(
      authService: sl(),
      userService: sl(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userService: sl(),
      storageService: sl(),
    ),
  );

  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      postService: sl(),
      storageService: sl(),
    ),
  );

  sl.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(
      service: sl(),
    ),
  );

  //! Services
  sl.registerLazySingleton<AuthService>(
    () => AuthServiceFirebaseImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
      cache: sl(),
    ),
  );

  sl.registerLazySingleton<FileStorageService>(
    () => FileStorageServiceImpl(
      storage: sl(),
    ),
  );

  sl.registerLazySingleton<UserService>(
    () => UserServiceImpl(
      firestore: sl(),
    ),
  );

  sl.registerLazySingleton<UserCacheService>(
    () => UserCacheService(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<PostService>(
    () => PostServiceImpl(
      firestore: sl(),
    ),
  );

  sl.registerLazySingleton<CommentService>(
    () => CommentServiceImpl(
      firestore: sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => GoogleSignIn.standard());
}
