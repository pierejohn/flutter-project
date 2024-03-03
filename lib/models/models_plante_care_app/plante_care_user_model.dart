class planteCareUserModel
{
  String ? name;
  String ? email;
  String ? phone;
  String ? uId;
  String ? image;
  String ? coverImage;
  String ? bio;
  bool ? isEmailVerified;


  planteCareUserModel({
    this.email
    ,this.name
    ,this.phone
    ,this.uId
    ,this.image
    ,this.coverImage
    ,this.bio
    ,this.isEmailVerified
    });

  planteCareUserModel.fromJson(Map<String,dynamic>json)
  {
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    coverImage=json['coverImage'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'coverImage':coverImage,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}