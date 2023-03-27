import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_diary/add_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
final usersRef = FirebaseFirestore.instance.collection('assignment');

class HomePage extends StatefulWidget {
  static String id = "homepage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'The Diary',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
      ),
      extendBody: true,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple.shade900,
        onPressed: () {
          Navigator.pushNamed(context, AddFile.id);
        },
        label: const Text("Create Diary"),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 18.0, top: 18),
            child: Text(
              "Assignments",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: usersRef.snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  List<Widget> arr = [];
                  final messages = snapshot.data?.docs;
                  for (var message in messages!) {
                    arr.add(
                      //   Padding(
                      //     padding: const EdgeInsets.all(18),
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         color: const Color.fromARGB(255, 213, 173, 235),
                      //         borderRadius: const BorderRadius.all(
                      //           Radius.circular(
                      //             20,
                      //           ),
                      //         ),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.purple.withOpacity(0.5),
                      //             spreadRadius: 1,
                      //             blurRadius: 2,
                      //           ),
                      //         ],
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(
                      //             top: 8.0, left: 16, bottom: 8.0, right: 8.0),
                      //         child: Row(
                      //           children: [
                      //             const CircleAvatar(
                      //                 radius: 28,
                      //                 backgroundImage: NetworkImage(
                      //                     'https://cdn-icons-png.flaticon.com/512/1154/1154987.png?w=740&t=st=1679910352~exp=1679910952~hmac=1a103f049719d6d7c85da5ff5f2868fba8ae1b1319a8cd7cbf880924cb31877f')),
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 18.0),
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Row(
                      //                     children: [
                      //                       Text(
                      //                         '${message.get('title')}',
                      //                         style: const TextStyle(
                      //                           color: Colors.black,
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 24.0,
                      //                         ),
                      //                       ),
                      //                       SizedBox(width: 50),
                      //                       Text(
                      //                         'Class: ${message.get('class')}',
                      //                         style: const TextStyle(
                      //                           color: Colors.black,
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 18.0,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   const SizedBox(
                      //                     height: 6,
                      //                   ),
                      //                   Text(
                      //                     '${message.get('description')}',
                      //                     style: const TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.normal,
                      //                       fontSize: 18.0,
                      //                     ),
                      //                   ),
                      //                   Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 8.0),
                      //                     child: Text(
                      //                       '${message.get('due_date').toString().substring(0, 10)}',
                      //                       style: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.normal,
                      //                         fontSize: 18.0,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD2D4FF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        radius: 28,
                                        backgroundImage: NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/1154/1154987.png?w=740&t=st=1679910352~exp=1679910952~hmac=1a103f049719d6d7c85da5ff5f2868fba8ae1b1319a8cd7cbf880924cb31877f')),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          message.get('title'),
                                          style: GoogleFonts.publicSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 28)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            message.get('description'),
                                            style: GoogleFonts.publicSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 16)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                          child: Text(
                                        "Due Date: ${message.get('due_date').toString().substring(0, 10)}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      SizedBox(
                                        width: 120,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Text(
                                            "Class: ${message.get("class")}",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  }
                  return ListView(
                    children: arr,
                  );
                } else {
                  return const Text('');
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
