import 'package:flutter/material.dart';
import 'package:front_end/Controller/Database/database_controller.dart';
import 'package:front_end/Models/practise_model.dart';

class GetPage extends StatefulWidget {
  const GetPage({super.key});

  @override
  State<GetPage> createState() => _GetPageState();
}

class _GetPageState extends State<GetPage> {
  final DatabaseController databaseController = DatabaseController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Get Page",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        spacing: 15,
        children: [
          FutureBuilder(
            future: databaseController.getDataFromBackEnd(),
            builder: (context, AsyncSnapshot<List<Practise>> snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final practise = snapshot.data?[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * 0.015),
                      child: Card(
                        color: Colors.grey.shade900,
                        child: ListTile(
                          title: Text(
                            practise?.name.toString() ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            practise?.email.toString() ?? '',
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
