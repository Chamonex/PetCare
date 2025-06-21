import 'package:pet_care/models/tarefa.dart';

class Pet {
  final String name;
  final String idade;
  final String type;
  final List<Tarefa>? tarefas;

  Pet({required this.name, required this.idade, required this.type, this.tarefas = null});

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
