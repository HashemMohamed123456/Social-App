import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModel/bloc/social_login_cubit/social_login_states.dart';
class SocialLoginCubit extends Cubit<SocialLoginStates>{
SocialLoginCubit():super(SocialLoginInitialState());
static SocialLoginCubit get(context)=>BlocProvider.of<SocialLoginCubit>(context);
TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();
var formKey=GlobalKey<FormState>();
IconData passwordSuffix=Icons.visibility;
bool isPassword=true;
void changePasswordSuffixIcon(){
  isPassword=!isPassword;
  passwordSuffix=isPassword?passwordSuffix=Icons.visibility:Icons.visibility_off;
  emit(ChangePasswordSuffixIconState());
}
void userLogin({required String email,required String password}){
  emit(SocialLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
    print(value.user?.email);
    print(value.user?.uid);
    emit(SocialLoginSuccessState(uId: value.user?.uid));
  }).catchError((error){
    print(error.toString());
    emit(SocialLoginErrorState(error: error.toString()));
  });
}
}