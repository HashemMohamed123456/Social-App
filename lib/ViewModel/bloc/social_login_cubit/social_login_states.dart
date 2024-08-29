abstract class SocialLoginStates{}
class SocialLoginInitialState extends SocialLoginStates{}
class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{
  final String? uId;
  SocialLoginSuccessState({required this.uId});
}
class SocialLoginErrorState extends SocialLoginStates{
  final String? error;
  SocialLoginErrorState({required this.error});
}
class ChangePasswordSuffixIconState extends SocialLoginStates{}