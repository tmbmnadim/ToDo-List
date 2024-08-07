import 'package:flutter/material.dart';
import 'package:todolist/View/Home/homepage.dart';
import 'package:todolist/View/widgets/custom_text_button.dart';

class NotificationViewModel {
  final BuildContext context;
  NotificationViewModel(this.context);

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          CustomTextButton(
            text: "OK",
            onTap: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homepage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
