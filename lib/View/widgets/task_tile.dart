import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final String details;
  final DateTime creationTime;
  final DateTime dueDate;
  final bool pinned;
  final bool isOnline;
  const TaskTile({
    super.key,
    required this.title,
    required this.details,
    required this.creationTime,
    required this.dueDate,
    required this.pinned,
    required this.isOnline,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      collapsedBackgroundColor:
          widget.isOnline ? Theme.of(context).primaryColor : Colors.grey,
      backgroundColor:
          widget.isOnline ? Theme.of(context).primaryColor : Colors.grey,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: const EdgeInsets.all(16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.pinned)
            Expanded(
              child: Transform.rotate(
                angle: -0.5,
                child: const Icon(Icons.push_pin),
              ),
            ),
          Expanded(
            flex: 10,
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "Created on: ${DateFormat("dd LLL").format(widget.creationTime)}",
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      subtitle: Text(
        "Due Date: ${DateFormat("dd LLL").format(DateTime.now())} at ${DateFormat("hh:mm a").format(widget.dueDate)}",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      onExpansionChanged: (isExpanded) {},
      children: [
        Text(
          widget.details,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
