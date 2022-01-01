import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/models/messagemodel.dart';
import 'package:socialapp/models/postmodel.dart';
import 'package:socialapp/models/usermodel.dart';
import 'package:socialapp/modules/home/chats.dart';
import 'package:socialapp/modules/home/feeds.dart';
import 'package:socialapp/modules/home/posts.dart';
import 'package:socialapp/modules/home/settings/settings.dart';
import 'package:socialapp/modules/home/users.dart';
import 'package:socialapp/modules/socialcubit/sostates.dart';
import 'package:socialapp/shared/components/constants.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUsersData() {
    emit(SocialGetUsersLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = SocialUserModel.fromJson(value.data());
      print(value.data());
      emit(SocialGetUsersSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialGetUsersErrorState(error));
    });
  }

  int currentIndex = 0;
  List<String> titles = [
    'News Feeds',
    'Chats',
    'Add Posts',
    'Users',
    'Settings',
  ];
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    AddPostScreen(),
    UsersScreens(),
    SettingsScreen(),
  ];

  List<BottomNavyBarItem> items = [
    BottomNavyBarItem(
      icon: Icon(IconBroken.Home),
      title: Text('Feeds'),
      activeColor: Colors.blue,
      inactiveColor: Colors.black,
    ),
    BottomNavyBarItem(
      icon: Icon(IconBroken.Chat),
      title: Text('Chats'),
      activeColor: Colors.blue,
      inactiveColor: Colors.black,
    ),
    BottomNavyBarItem(
      icon: Icon(
        IconBroken.Plus,
      ),
      title: Text('Posts'),
      activeColor: Colors.blue,
      inactiveColor: Colors.black,
    ),
    BottomNavyBarItem(
      icon: Icon(IconBroken.Location),
      title: Text('Users'),
      activeColor: Colors.blue,
      inactiveColor: Colors.black,
    ),
    BottomNavyBarItem(
      icon: Icon(IconBroken.Setting),
      title: Text('Settings'),
      activeColor: Colors.blue,
      inactiveColor: Colors.black,
    ),
  ];

  void changeBotNavBarItem(index) {
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      if (index == 1) getUsers();
      currentIndex = index;
      emit(SocialBotNavBarItemState());
    }
  }

  File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialPickedProfileImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialPickedProfileImageErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialPickedCoverImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialPickedCoverImageErrorState());
    }
  }

  void uploadProfileImg() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
            name: model!.name,
            phone: model!.phone,
            bio: model!.bio,
            image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImg() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
            name: model!.name,
            phone: model!.phone,
            bio: model!.bio,
            cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  Future<void> updateUser({
    required String bio,
    required String name,
    required String phone,
    String? cover,
    String? image,
  }) async {
    emit(SocialUploadLoadingState());

    SocialUserModel userModel = SocialUserModel(
      uid: model!.uid,
      name: name,
      email: model!.email,
      phone: phone,
      image: image ?? model!.image,
      cover: cover ?? model!.cover,
      bio: bio,
      isVerify: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .update(userModel.toJson())
        .then((value) {
      getUsersData();
      emit(SocialUpdateUserDataSuccessState());
    }).catchError((error) {
      emit(SocialUpdateUserDataErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPickedPostImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialPickedPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String postText,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(postImage: value, dateTime: dateTime, postText: postText);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  PostModel? postModel;

  void createPost({
    required String dateTime,
    required String postText,
    String? postImage,
  }) async {
    emit(SocialCreatePostLoadingState());

    postModel = PostModel(
      name: model!.name,
      uid: model!.uid,
      image: model!.image,
      postImage: postImage ?? '',
      postText: postText,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel!.toJson())
        .then((value) {
      getUsersData();
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
        }).catchError((error) {});
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error));
    });
  }

  void likePost(String postId) {
    emit(SocialLikePostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uid)
        .set({'like': true}).then((value) {
      getPosts();

      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error));
    });
  }

  void commentPost(String postId) {
    emit(SocialCommentPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uid)
        .set({'comments': true}).then((value) {
      getPosts();
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0) {
      emit(SocialGetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error));
      });
    }
  }

  void sendMessages({
    required String text,
    required String dateTime,
    required String receiverId,
  }) {
    MessageModel messageModel = MessageModel(
      dateTime: dateTime,
      senderId: model!.uid,
      receiverId: receiverId,
      text: text,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState());
    });
    //set the receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uid)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    messages = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      messages.sort((a,b) {
        var aDate = a.dateTime; //before -> var adate = a.expiry;
        var bDate = b.dateTime; //var bdate = b.expiry;
        return aDate.compareTo(bDate);
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}
