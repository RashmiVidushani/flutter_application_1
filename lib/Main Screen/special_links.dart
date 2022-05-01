import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/widget/color.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecialLinks extends StatelessWidget {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  SpecialLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.btnColor,
      appBar: AppBar(
        title: const Center(child: Text("Links")),
      ),
      body: _buildStreamListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Add()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStreamListView() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firebase.collection('Links').snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snap.hasData && snap.data != null) {
          final docList = snap.data!.docs;
          if (docList.isEmpty) {
            return const Text("No Data"); // working
          }
          return ListView.builder(
            itemCount: docList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    _launchInBrowser(docList[index].get('URL'));
                  },
                  title: Text(docList[index].get('URL_Name')),
                ),
              );
            },
          );
        }
        return const Text("Something went wrong!");
      },
    );
  }

  Future<void> _launchInBrowser(String url) async {
    // ignore: deprecated_member_use
    if (!await launch(url)) {
      debugPrint("Could not launch $url");
    } else {
      // ignore: deprecated_member_use
      launch(url);
    }
  }
}

class Add extends StatelessWidget {
  final TextEditingController urlNameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  final firebase = FirebaseFirestore.instance;

  Add({Key? key}) : super(key: key);

  Future<void> create() async {
    final String urlName = urlNameController.text.trim();
    final String url = urlController.text.trim();

    try {
      await firebase
          .collection("Links")
          .doc(urlNameController.text.trim())
          .set({
        "URL_Name": urlName,
        "URL": url,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> delete() async {
    try {
      await firebase
          .collection("Links")
          .doc(urlController.text.trim())
          .delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "ADD LINKS",
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: urlNameController,
              decoration: const InputDecoration(
                labelText: "URL name",
              ),
            ),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: "Enter URL",
              ),
            ),
            const SizedBox(height: 24.0),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Appcolor.mainColor,
              ),
              child: Text(
                "Add",
                style: TextStyle(color: Appcolor.btnColor),
              ),
              onPressed: () async {
                await create();
                urlNameController.clear();
                urlController.clear();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
