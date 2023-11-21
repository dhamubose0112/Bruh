import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  // Define a list of notification items
  final List<PostItem> posts = [
    PostItem(
      title: 'Hii thalaiva , idhu dhan MetroJuice park inga ella cigarets uhm irkum tea better ah irkum breadOmlete la carrot la potu tharuvanga try pani parunga ',
      description: '2023-11-01',
    ),
    // Add more notification items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_left,
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    "Posts",
                    style: TextStyle(fontSize: 25, fontFamily: "MyFont"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostCard(post: posts[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostItem {
  final String title;
  final String description;

  PostItem({
    required this.title,
    required this.description,
  });
}

class PostCard extends StatelessWidget {
  final PostItem post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.white, // Replace with your image or background color
                child: Image.asset("assets/logo.png"), // Replace with your image
              ),
            ),
            ListTile(
              title: Text(post.title,style: TextStyle(fontFamily: "Regular"),),
            ),
            ListTile(
              title: Text(
                post.description,
                style: TextStyle(fontSize: 12, color: Colors.grey,fontFamily: "Regular"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Handle delete action here
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle delete action here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

