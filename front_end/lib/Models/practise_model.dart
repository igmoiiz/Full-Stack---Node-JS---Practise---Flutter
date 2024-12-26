class Practise {
  final String? id;
  final String? name;
  final String? email;

  const Practise({
    required this.id,
    required this.email,
    required this.name,
  });

  factory Practise.fromJson(Map<String, dynamic> json) {
    return Practise(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Practise &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Practise{id: $id, name: $name, email: $email}';
  }
}