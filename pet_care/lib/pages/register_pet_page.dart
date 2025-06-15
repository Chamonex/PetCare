import 'package:flutter/material.dart';
import '../widgets/home_button.dart';
import '../utils/app_utils.dart';

class RegisterPetPage extends StatefulWidget {
  const RegisterPetPage({super.key});

  @override
  State<RegisterPetPage> createState() => _RegisterPetPageState();
}

class _RegisterPetPageState extends State<RegisterPetPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null) {
    setState(() {
      timeController.text = picked.format(context);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Pet'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 600,
            maxHeight: 1000,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Pet Name',
                    hintText: 'Enter your pet\'s name',
                  ),
                ),
                const SizedBox(height: 24),
                HomeButton(
                  icon: const Icon(Icons.home),
                  onPressed: () => changePage(context, 'register_pet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}