import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(title: 'Notification 1', subtitle: 'This is your first notification'),
    // Add more notification items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notification",
                style: TextStyle(fontSize: 25, fontFamily: "MyFont"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {

                          },
                        ),
                      ],

                      child: Card(

                        child: ListTile(
                          title: Text(
                            notifications[index].title,
                            style: TextStyle(fontFamily: "Regular"),
                          ),
                          subtitle: Text(
                            notifications[index].subtitle,
                            style: TextStyle(fontFamily: "Regular"),
                          ),

                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String subtitle;

  NotificationItem({required this.title, required this.subtitle});
}

