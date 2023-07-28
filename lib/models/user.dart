class User {
  int id;
  String name;
  String user;
  String mobile;
  String bi;
  String password;
  int event_id;
  String event_name;
  String date;



  User({
    required this.id,
    required this.name,
    required this.user,
    required this.mobile,
    required this.bi,
    required this.password,
    required this.date,
    required this.event_id,
    required this.event_name,
  });


  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      user: json['user']['user'],
      bi: json['user']['bi'],
      date: json['user']['date'],
      mobile: json['user']['mobile'],
      password: json['user']['password'],
      event_id: json['user']['event_id'],
      event_name: json['user']['event_name'],
    );
  }
}