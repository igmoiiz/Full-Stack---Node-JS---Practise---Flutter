// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_end/Controller/Database/database_controller.dart';
import 'package:front_end/Controller/input_controllers.dart';
import 'package:front_end/View/Components/my_button.dart';
import 'package:front_end/View/Components/my_form_field.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  //  instance for input Controllers
  final inputControllers = InputControllers();
  //  instance for database Controllers
  final databaseController = DatabaseController();

  void _postData() async {
    if (inputControllers.formKey.currentState!.validate()) {
      try {
        setState(() {
          inputControllers.loading = true;
        });
        log("Method Executing!");
        String id = inputControllers.idController.text;
        String email = inputControllers.emailController.text;
        String name = inputControllers.nameController.text;
        await databaseController
            .pushDataToBackEnd(id, name, email)
            .then((value) {
          log("Data Pushed to Backend from Post Page!");
          setState(() {
            inputControllers.loading = false;
            inputControllers.idController.clear();
            inputControllers.nameController.clear();
            inputControllers.emailController.clear();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.grey.shade900,
              content: const Text(
                "Data Posted Successfully!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).onError((error, stackTrace) {
          setState(() {
            inputControllers.loading = false;
          });
          log("Error Occurred in Post Page!");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade800,
              content: const Text(
                "Error While Posting Data to Backend!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
      } on HttpException catch (error) {
        log(error.toString());
      } on SocketException catch (error) {
        log(error.toString());
      } on IOException catch (error) {
        log(error.toString());
      } catch (error) {
        log(error.toString());
      } finally {
        setState(() {
          inputControllers.loading = false;
        });
        log("Method Executed Successfully!");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey.shade900,
          content: const Text(
            "Please Fill All Fields",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Post Page",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.message_outlined,
              color: Colors.white,
              size: height * 0.05,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Post Data To BackEnd..",
            style: TextStyle(
              fontSize: height * 0.022,
              color: Colors.white,
            ),
          ),
          SizedBox(height: height * 0.01),
          Form(
            key: inputControllers.formKey,
            child: Column(
              spacing: 20,
              children: [
                MyFormField(
                  text: "ID",
                  controller: inputControllers.idController,
                  icon: Icons.numbers_sharp,
                ),
                MyFormField(
                  text: "Name",
                  controller: inputControllers.nameController,
                  icon: Icons.person,
                ),
                MyFormField(
                  text: "Email",
                  controller: inputControllers.emailController,
                  icon: Icons.alternate_email,
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.01),
          MyButton(
            text: "Post",
            loading: inputControllers.loading,
            onTap: _postData,
          ),
        ],
      ),

      //  floating action button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        onPressed: () {
          Navigator.of(context).pushNamed('/get_page');
        },
        tooltip: 'Display Data',
        child: const Icon(Icons.navigate_next_outlined, color: Colors.white),
      ),
    );
  }
}
