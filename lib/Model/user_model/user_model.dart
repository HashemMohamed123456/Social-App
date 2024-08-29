class UserModel{
  String? name;
  String? phone;
  String? email;
  String? uId;
  bool?  isEmailVerified;
  String? image;
  String? coverImage;
  String? bio;
  UserModel({this.name,this.phone,this.email,this.uId,this.isEmailVerified,this.image,this.bio,this.coverImage});
  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    uId=json['uId'];
    isEmailVerified=json['isEmailVerified'];
    image=json['image'];
    bio=json['bio'];
    coverImage=json['coverImage'];
  }
   Map<String,dynamic>toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'coverImage':coverImage
    };
  }
}