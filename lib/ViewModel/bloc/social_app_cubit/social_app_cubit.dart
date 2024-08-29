import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Model/Post_model/post_model.dart';
import 'package:social_app/Model/user_model/user_model.dart';
import 'package:social_app/View/screeens/chats/chats_screen.dart';
import 'package:social_app/View/screeens/feeds/feeds_screen.dart';
import 'package:social_app/View/screeens/settings/settings_screen.dart';
import 'package:social_app/View/screeens/users/users_screen.dart';
import 'package:social_app/ViewModel/bloc/social_app_cubit/social_app_states.dart';
import 'package:social_app/ViewModel/data/local/keys.dart';
import 'package:firebase_storage/firebase_storage.dart';
class SocialAppCubit extends Cubit<SocialAppStates>{
  SocialAppCubit():super(SocialAppInitialState());
  static SocialAppCubit get(context)=>BlocProvider.of<SocialAppCubit>(context);
  UserModel? userModel;
  PostModel? postModel;
  int navigationBarIndex=0;
  List<Widget>navbarScreens=[
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String>titles=[
    'News Feed',
    'Chats',
    'Users',
    'Settings',
  ];
  TextEditingController editProfileNameController=TextEditingController();
  TextEditingController editProfileBioController=TextEditingController();
  TextEditingController editProfilePhoneController=TextEditingController();
  TextEditingController postController =TextEditingController();
  File? profileImage;
  File? coverImage;
  File? postImage;
  String? profileImageUrl='';
  String? coverImageUrl='';
  var picker=ImagePicker();
  final storage = FirebaseStorage.instance;
  var now=DateTime.now().toString();
  List<PostModel>posts=[
    PostModel(
      
    )
  ];
  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(SharedKeys.uId).get().then((value){
      userModel=UserModel.fromJson(value.data()!);
      print(value.data());
     emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState(error:error.toString()));
    });
  }
  void changeNavBarIndex(int index){
      navigationBarIndex=index;
      emit(SocialChangeNavigationBarIndexState());
  }

  Future<void>getProfileImage()async{
    final pickedFile=await picker.pickImage(source:ImageSource.gallery);
    if(pickedFile!=null){
      profileImage=File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('No Image Selected!');
      emit(SocialProfileImagePickedErrorState());
    }
  }
  Future<void>getCoverImage()async{
    final pickedFile=await picker.pickImage(source:ImageSource.gallery);
    if(pickedFile!=null){
      coverImage=File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print('No Image Selected!');
      emit(SocialCoverImagePickedErrorState());
    }
  } Future<void>getPostImage()async{
    final pickedFile=await picker.pickImage(source:ImageSource.gallery);
    if(pickedFile!=null){
      coverImage=File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else{
      print('No Image Selected!');
      emit(SocialPostImagePickedErrorState());
    }
  }
  void uploadProfileImage({required String? name,
    required String? bio,
    required String? phone,}){
    emit(SocialUpdateUserLoadingState());
    storage
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value){
      value.ref.getDownloadURL().then((value){
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, bio: bio, phone: phone,profilePhoto: value);
      }).catchError((error){
        emit(SocialUploadProfileErrorState());
      });
    }).catchError((error){
      emit(SocialUploadProfileErrorState());
    });
  } void uploadCoverImage({
    required String? name,
    required String? bio,
    required String? phone,}){
    emit(SocialUpdateUserLoadingState());
    storage
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value){
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, bio: bio, phone: phone,coverPhoto: value);
      }).catchError((error){
        emit(SocialUploadCoverErrorState());
      });
    }).catchError((error){
      emit(SocialUploadCoverErrorState());
    });
  }
  void updateUser({
    required String? name,
    required String? bio,
    required String? phone,
    String? profilePhoto,
    String? coverPhoto}){
    emit(SocialUpdateUserLoadingState());
    if(coverImage !=null){
      uploadCoverImage(name: name,phone: phone,bio: bio);
    }else if(profileImage !=null){
      uploadProfileImage(name: name,phone: phone,bio: bio);
    }else{
      UserModel model=UserModel(
        name: name,
        bio: bio,
        phone: phone,
        email: userModel!.email,
        coverImage: coverPhoto??userModel!.coverImage,
        image: profilePhoto??userModel!.image,
        uId: userModel!.uId,
        isEmailVerified: false
      );
      FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update(model.toMap()).then((value){
        getUserData();
      }).catchError((error){
        emit(SocialUpdateUserErrorState());
      });
    }
  }
  void uploadPostImage({
    required String? dateTime,
    required String? text,
}){
    emit(SocialCreatePostLoadingState());
    storage.ref().child('posts/${Uri.file(postImage!.path).pathSegments.last}').putFile(postImage!).then((value){
     value.ref.getDownloadURL().then((value){
       createPost(dateTime: dateTime, text: text,postPhoto: value);
     }).catchError((error){
       emit(SocialCreatePostErrorState());
     });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
  void createPost({
    required String? dateTime,
    required String? text,
    String? postPhoto}){
    emit(SocialCreatePostLoadingState());
    PostModel model=PostModel(
      dateTime: dateTime,
      text: text,
      name:userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      postImage:postPhoto??""
    );
    FirebaseFirestore.instance.collection('posts').add(model.toMap()).then((value){
      emit(SocialCreatePostSuccessState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
  void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageState());
  }
  void getAllPosts(){
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((e){
        posts.add(PostModel.fromJson(e.data()));
      });
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetPostsErrorState());
    });
  }
}