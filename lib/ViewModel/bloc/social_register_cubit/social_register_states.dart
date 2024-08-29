abstract class SocialRegisterStates{}
class SocialRegisterInitialState extends SocialRegisterStates{}
class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{}
class SocialRegisterErrorState extends SocialRegisterStates{
  String error;
  SocialRegisterErrorState({required this.error});
}
class SocialUserCreationLoadingState extends SocialRegisterStates{}
class SocialUserCreationSuccessState extends SocialRegisterStates{}
class SocialUserCreationsErrorState extends SocialRegisterStates{
  String error;
  SocialUserCreationsErrorState({required this.error});
}
class ChangePasswordSuffixIconState extends SocialRegisterStates{}