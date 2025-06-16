class Pet {
  final String name;
  final String idade;
  final String type;

  Pet({required this.name, required this.idade, required this.type});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'] ?? '',
      idade: json['idade'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'idade': idade,
        'type': type,
      };
}
