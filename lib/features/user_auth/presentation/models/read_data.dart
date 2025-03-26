import 'package:flutter/material.dart';
import 'package:nuur_din/features/user_auth/presentation/models/user_model.dart';
import 'package:nuur_din/features/user_auth/presentation/models/firestore_helper.dart';
import 'package:nuur_din/features/user_auth/presentation/models/update_data.dart';

class ReadDataPage extends StatelessWidget {
  const ReadDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read Data Page"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<UserModel>>(
                stream: FirestoreHelper.read(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Something went wrong"));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No data available"));
                  }

                  final userData = snapshot.data!;
                  return ListView.builder(
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      final singleUser = userData[index];

                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(singleUser.username ?? "No Name"),
                          subtitle: Text(singleUser.age != null ? "${singleUser.age}" : "No Age"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit button
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.teal),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UpdateDataPage(
                                        user: UserModel(
                                          id: singleUser.id,
                                          username: singleUser.username,
                                          age: singleUser.age,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Delete button
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: Text('Delete'),
                                      content: Text('Are you sure you want to delete?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            FirestoreHelper.delete(UserModel(
                                              id: singleUser.id,
                                              username: singleUser.username,
                                              age: singleUser.age,
                                            ));
                                            Navigator.pop(context);
                                          },
                                          child: Text("Yes"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
