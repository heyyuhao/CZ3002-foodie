class User{

  String userEmail;
  int userType;

  User({this.userEmail, this.userType});

  factory User.fromJson(Map<String, dynamic> data){
    return User(
      userEmail: data['userEmail'],
      userType: data['userType'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "userEmail": userEmail,
      "userType": userType
    };
  }

}