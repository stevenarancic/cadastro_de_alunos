import 'package:cadastro_de_alunos/models/student.dart';
import 'package:cadastro_de_alunos/repositories/studentdb_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Alunos',),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Matrícula do aluno',
                  hintText: 'EX: 123',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome do aluno',
                  hintText: 'Somente letras',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                controller: _nameController,
              ),
              SizedBox(height: 5,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail do aluno',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  ElevatedButton(onPressed: (){
                    saveRegister();
                  }, child: Text('Cadastrar',),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void saveRegister() async{
    final String name = _nameController.text;
    final String email = _emailController.text;
    String message;
    if(!EmailValidator.validate(email)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Mensagem do sistema'),
          content: Text('E-mail inválido!'),
          actions: [
             TextButton(onPressed: () {
               Navigator.of(context).pop();
             }, child: Text('OK'))
          ],
        ),
      );
    } else {
      Student student = Student(
        name: name, 
        email: email,
      );
      var repository = StudentDBRepository();
      var result = await repository.insert(student);
      if(result!=0) {
        message = 'O aluno $name foi cadastrado(a) com sucesso!';
      } else {
        message = 'Erro ao cadastrar aluno(a) $name!';
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Mensagem do sistema'),
          content: Text(message),
          actions: [
             TextButton(onPressed: () {
               Navigator.of(context).pop();
             }, child: Text('OK'))
          ],
        ),
      );
    }
  }
}