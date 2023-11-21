import 'package:flutter/material.dart';
import '../../../Login/login.dart';
import 'AboutScreen.dart';
import 'PostScreen.dart';

class ProfileScreen extends StatelessWidget {
  // Define a list of notification items with custom data
  final List<CustomNotificationItem> notifications = [
    CustomNotificationItem(
      icon: Icons.access_time_filled_outlined,
      title: 'Your Posts',
    ),
    CustomNotificationItem(
      icon: Icons.info,
      title: 'About',
    ),

    CustomNotificationItem(
      icon: Icons.person_remove,
      title: "Delete Account",
    ),

    CustomNotificationItem(
      icon: Icons.logout,
      title: "Log Out",
    ),
    // Add more custom notification items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 16),
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 25, fontFamily: "MyFont"),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Dhamu",
                    style: TextStyle(fontSize: 15, fontFamily: "Regular", color: Colors.grey),
                  ),
                  Text(
                    "dhamubose1122002@gmail.com",
                    style: TextStyle(fontSize: 15, fontFamily: "Regular", color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: index == notifications.length - 1
                          ? Icon(
                        Icons.logout,
                        color: Colors.red, // Change the logout icon color to red for the last item
                      )
                          : Icon(notifications[index].icon),
                      title: Text(
                        notifications[index].title,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Regular",
                          color: index == notifications.length - 1
                              ? Colors.red // Change text color to red for the last item
                              : Colors.black, // Use black for other items
                        ),
                      ),
                      trailing: index == notifications.length - 1
                          ? Icon(
                        Icons.chevron_right,
                        color: Colors.red, // Change the right arrow color to red for the last item
                      )
                          : Icon(
                        Icons.chevron_right,
                        color: Colors.black, // Use black for other items
                      ),
                      onTap: () {
                        if (index == 0) { // Index 1 corresponds to "Your Posts"
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PostScreen()), // Replace with the actual screen name
                          );
                        }
                        else if(index == 1){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AboutScreen()), // Replace with the actual screen name
                          );

                        }
                        else if (index == notifications.length - 1) {
                          // Show an alert dialog for "Log Out"
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text("Log Out",style: TextStyle(fontFamily: "Regular"),),
                                content: Text("Are you sure you want to log out?",style: TextStyle(fontFamily: "Regular"),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
                                      );
                                    },
                                    child: Text("Yes",style: TextStyle(fontFamily: "Regular",color: Colors.red),),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No",style: TextStyle(fontFamily: "Regular",color: Colors.black),),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else if(index == notifications.length - 2){showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text("Delete Account",style: TextStyle(fontFamily: "Regular"),),
                              content: Text("Are you sure you want to Delete?",style: TextStyle(fontFamily: "Regular"),),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()),
                                    );
                                  },
                                  child: Text("Yes",style: TextStyle(fontFamily: "Regular",color: Colors.red),),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No",style: TextStyle(fontFamily: "Regular",color: Colors.black),),
                                ),
                              ],
                            );
                          },
                        );}
                      },
                    ),
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

class CustomNotificationItem {
  final IconData icon;
  final String title;

  CustomNotificationItem({
    required this.icon,
    required this.title,
  });
}
