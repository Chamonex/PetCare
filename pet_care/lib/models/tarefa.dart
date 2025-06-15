// import './user.dart';
import 'package:flutter/material.dart';

class Tarefa {
  String titulo;
  TimeOfDay horario;
  bool notificar;
  // User? usuarios[];
  
  Tarefa({
    required this.titulo,
    required this.horario,
    this.notificar = false,
  });

  void toggleNotificar() {
    notificar = !notificar;
  }

  void setHorario(TimeOfDay novoHorario) {
    horario = novoHorario;
  }

  void setTitulo(String novoTitulo) {
    titulo = novoTitulo;
  }

  
}