import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

class PostDetailPage extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(post['title'] ?? 'Post Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post['caption'] ?? '', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Views: ${post['viewers']}"),
            SizedBox(height: 20),
            Text(
              post['updatedAt'] != null
                  ? GetTimeAgo.parse(DateTime.parse(post['updatedAt']))
                  : "",
            ),
            SizedBox(height: 20),
            Text("Comments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

            Divider(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(hintText: "Write a comment..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String comment = commentController.text;
                    if (comment.isNotEmpty) {
                      // Handle sending comment
                      print("Comment sent: $comment");
                      commentController.clear();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
