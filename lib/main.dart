import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hi",
      home: Scaffold(
          appBar: AppBar(title: const Text("lets try this!")),
          floatingActionButton: FloatingActionButton(
            onPressed: () => FirebaseFirestore.instance
                .collection('testing')
                .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
            child: Icon(Icons.add),
          ),
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('testing').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final docData = snapshot.data.docs[index].data();
                      final dateTime =
                          (docData['timestamp'] as Timestamp).toDate();

                      return ListTile(title: Text(dateTime.toString()));
                    });
              })),
    );
  }
}
