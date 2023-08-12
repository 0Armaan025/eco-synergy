// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String uid;
  final String email;
  final String pass;
  final String ecoCurrency;
  UserModel({
    required this.name,
    required this.uid,
    required this.email,
    required this.pass,
    required this.ecoCurrency,
  });

  UserModel copyWith({
    String? name,
    String? uid,
    String? email,
    String? pass,
    String? ecoCurrency,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      pass: pass ?? this.pass,
      ecoCurrency: ecoCurrency ?? this.ecoCurrency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'email': email,
      'pass': pass,
      'ecoCurrency': ecoCurrency,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      email: map['email'] as String,
      pass: map['pass'] as String,
      ecoCurrency: map['ecoCurrency'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, email: $email, pass: $pass, ecoCurrency: $ecoCurrency)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.uid == uid &&
        other.email == email &&
        other.pass == pass &&
        other.ecoCurrency == ecoCurrency;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        pass.hashCode ^
        ecoCurrency.hashCode;
  }
}
