import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/usermodel.dart';
import 'package:socialapp/modules/register/registercubit/regstates.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('${value.user!.email} is registered');

      userCreate(
        uid: value.user!.uid,
        username: username,
        email: email,
        phone: phone,
        isVerify: false,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error));
    });
  }

  void userCreate({
    required String email,
    required String username,
    required String phone,
    required String uid,
    required bool isVerify,
  }) {

    SocialUserModel model = SocialUserModel(
      uid: uid,
      name: username,
      email: email,
      phone: phone,
      image:
          'https://image.freepik.com/photos-gratuite/jeune-belle-femme-pull-chaud-rose-aspect-naturel-souriant-portrait-isole-cheveux-longs_285396-896.jpg',
      bio: 'Write your bio ...',
      isVerify: false,
      cover:
          'https://img.freepik.com/photos-gratuite/figurines-humaines-utilisant-echelle-pour-atteindre-ampoule-allumee-fissuree-comme-concept-idee_23-2149081897.jpg?size=338&ext=jpg',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toJson())
        .then((value) {
      print('user is created');
      emit(SocialUserCreateSuccessState());
    }).catchError((error) {
      emit(SocialUserCreateErrorState(error));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassShow = true;

  void changeSuffixIcon() {
    isPassShow = !isPassShow;
    suffix = isPassShow ? Icons.visibility : Icons.visibility_off;
    emit(SocialRegisterPasswordChangeVisibilityState());
  }
}
