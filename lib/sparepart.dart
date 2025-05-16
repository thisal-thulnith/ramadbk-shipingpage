import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(home: SparePartPage(), debugShowCheckedModeBanner: false),
  );
}

class SparePartPage extends StatelessWidget {
  const SparePartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Priority Customers",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // Search Bar
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search orders...",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Info Box (modified with new color scheme)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF3FF), // new background colour
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "Drag and drop customer to record the priority queue. ",
                      style: TextStyle(
                        color: Color(0xFF3248D7), // new text colour
                      ),
                    ),
                    TextSpan(
                      text: "Priority customers will be handled first.",
                      style: TextStyle(
                        color: Color(0xFF3248D7), // new text colour
                      ),
                    ),
                  ],
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 24),
            // All cards in a grid (4 per row)
            GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(8, (index) {
                return PriorityCustomerCard(
                  showMismatch:
                      index < 4
                          ? (index == 2 ? false : true)
                          : (index == 4 || index == 5 || index == 7
                              ? false
                              : true),
                  // All boxes are now high priority including the first box.
                  isHighPriority: true,
                  isDisabled: index < 4 ? (index == 2 ? true : false) : true,
                  // For second row: indices 4-5 => Medium Priority; indices 6-7 => Low Priority
                  priorityLabel:
                      index >= 4
                          ? ((index == 4 || index == 5)
                              ? "Medium Priority"
                              : "Low Priority")
                          : null,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityCustomerCard extends StatelessWidget {
  final bool showMismatch;
  final bool isHighPriority;
  final bool isDisabled;
  final String? priorityLabel;

  const PriorityCustomerCard({
    super.key,
    this.showMismatch = false,
    this.isHighPriority = false,
    this.isDisabled = false,
    this.priorityLabel,
  });

  @override
  Widget build(BuildContext context) {
    // Updated to always use white background for the card details
    final Color baseColor = Colors.white;

    final Widget innerContent = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Avatar, Name, Email, Priority Badge
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.purple,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Toyota Japan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "orders@toyota.co.jp",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (isHighPriority)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        priorityLabel == "Medium Priority"
                            ? Colors.yellow[100]
                            : (priorityLabel == "Low Priority"
                                ? Colors.blue[100]
                                : Colors.red.withOpacity(
                                  0.2,
                                )), // translucent red for high priority
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    // changed to Row for one-line layout
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 12,
                        color:
                            priorityLabel == "Medium Priority"
                                ? Colors.yellow[900]
                                : (priorityLabel == "Low Priority"
                                    ? Colors.blue[900]
                                    : Colors.red[900]),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        priorityLabel ?? "High Priority",
                        style: TextStyle(
                          color:
                              priorityLabel == "Medium Priority"
                                  ? Colors.yellow[900]
                                  : (priorityLabel == "Low Priority"
                                      ? Colors.blue[900]
                                      : Colors.red[900]),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Last Order:\n2023-12-10"),
              Text("Total Order:\n24"),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Location:\nTokyo, Japan"),
              Text("Status:\nActive"),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Part Number:\n",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "TY-2024-C78",
                      style: TextStyle(
                        color: showMismatch ? Colors.red[900] : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Part Name:\n",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Windshield Wiper Motor",
                      style: TextStyle(
                        color: showMismatch ? Colors.red[900] : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text("View Details"),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900], // dark red background
                  foregroundColor: Colors.white, // make button text white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Contact"),
              ),
            ],
          ),
        ],
      ),
    );

    final Widget headerWidget =
        showMismatch
            ? Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red[900], // changed to dark red
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flag, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "Mismatch",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
            : isDisabled
            ? Container(
              width: double.infinity,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            )
            : const SizedBox.shrink();

    final Widget stackedContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: [if (showMismatch || isDisabled) headerWidget, innerContent],
    );

    return AbsorbPointer(
      absorbing: isDisabled,
      child: Container(
        width: 300,
        // Added curved gradient background for the whole card box
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          color: baseColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: stackedContent,
        ),
      ),
    );
  }
}
