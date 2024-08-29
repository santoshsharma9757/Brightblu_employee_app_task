class UserInfo {
  final String? id;
  final String? name;
  final String? email;
  final int? age;
  final String? dob;
  final String? gender;
  final String? employmentStatus;
  final String? address;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.age,
    this.dob,
    this.gender,
    this.employmentStatus,
    this.address,
  });

  // Converts the object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'dob': dob,
      'gender': gender,
      'employmentStatus': employmentStatus,
      'address': address,
    };
  }

  // Factory constructor to create UserInfo from a Map
  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] as String?,
      email: map['email'] as String?,
      age: map['age'] as int?,
      dob: map['dob'] as String?,
      gender: map['gender'] as String?,
      employmentStatus: map['employmentStatus'] as String?,
      address: map['address'] as String?,
    );
  }

  // Adds a copyWith method to create a modified copy of UserInfo
  UserInfo copyWith({
    String? id,
    String? name,
    String? email,
    int? age,
    String? dob,
    String? gender,
    String? employmentStatus,
    String? address,
  }) {
    return UserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      employmentStatus: employmentStatus ?? this.employmentStatus,
      address: address ?? this.address,
    );
  }
}
