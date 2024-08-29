import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Model/user_model/user_model.dart';
import 'package:social_app/ViewModel/bloc/social_register_cubit/social_register_states.dart';
class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit():super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=>BlocProvider.of<SocialRegisterCubit>(context);
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  IconData passwordSuffix=Icons.visibility;
  bool isPassword=true;
  var formKey=GlobalKey<FormState>();
  void changePasswordSuffixIcon(){
    isPassword=!isPassword;
    passwordSuffix=isPassword?passwordSuffix=Icons.visibility:Icons.visibility_off;
    emit(ChangePasswordSuffixIconState());
  }
  void userRegister({required String name,
    required String phone,
    required String email,
    required String password}){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
      print(value.user?.email);
      print(value.user?.uid);
      createUser(name: name, phone: phone, email: email, uId:value.user?.uid);
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState(error: error.toString()));
    });
  }
  void createUser({
    required String? name
    ,required String? phone
    ,required String? email,
    required String? uId}){
    emit(SocialUserCreationLoadingState());
    UserModel userModel=UserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      isEmailVerified: false,
      image: 'https://img.freepik.com/premium-photo/illustration-cristiano-ronaldo-portugal-cr7-vector-illustration_1124573-19749.jpg?w=740',
      bio:'Write Your Bio Here....',
      coverImage: 'https://img.freepik.com/premium-photo/cristiano-ronaldo-dribbling-ball_1267718-5919.jpg?w=826'
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value){
      emit(SocialUserCreationSuccessState());
    }).catchError((error){
      emit(SocialUserCreationsErrorState(error: error.toString()));
    });
  }
}