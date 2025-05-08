import 'package:flutter/material.dart';

void main() {
  runApp(const ShippingApp());
}

class ShippingApp extends StatelessWidget {
  const ShippingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ShippingPage(),
    );
  }
}

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  String? _selectedSalesPerson;
  final List<String> _salesPersons = [
    'Select',
    'John Doe',
    'Jane Smith',
    'Alice Brown',
  ];

  // State for checkboxes in the table
  final List<bool> _tableCheckboxes = List.generate(4, (_) => false);

  // State for notification checkboxes
  final Map<String, bool> _notificationCheckboxes = {
    'Notify customer when booking is confirmed': false,
    'Notify customer when shipment is picked up': false,
    'Notify customer when shipment is in transit': false,
    'Notify customer when shipment is delivered': false,
  };

  @override
  void initState() {
    super.initState();
    _selectedSalesPerson = _salesPersons.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Add white background
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Book Freight',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Explicitly set white background
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ), // Changed to black border
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(
                      80,
                    ), // Increased shadow opacity
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create New Shipment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  // Form
                  SizedBox(
                    // Changed from Padding to SizedBox
                    width: double.infinity,
                    child: Wrap(
                      // Changed from GridView to Wrap
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        SizedBox(
                          width: 300, // Fixed width for form fields
                          child: _buildTextField(
                            'Order Reference',
                            'Enter order number',
                          ),
                        ),
                        SizedBox(
                          width: 300, // Fixed width for form fields
                          child: _buildDropdown('Customer', [
                            'Select customer',
                            'Customer A',
                            'Customer B',
                          ]),
                        ),
                        SizedBox(
                          width: 300, // Fixed width for form fields
                          child: _buildDropdown('Freight Type', [
                            'Select freight type',
                            'Air',
                            'Sea',
                            'Land',
                          ]),
                        ),
                        SizedBox(
                          width: 300, // Fixed width for form fields
                          child: _buildTextField(
                            'Origin',
                            'Enter origin location',
                          ),
                        ),
                        SizedBox(
                          width: 300, // Fixed width for form fields
                          child: _buildTextField(
                            'Destination',
                            'Enter destination',
                          ),
                        ),
                        SizedBox(
                          width: 300, // Fixed width for form fields
                          child: _buildDropdown('Carrier', [
                            'Select carrier',
                            'DHL',
                            'FedEx',
                            'UPS',
                          ]),
                        ),
                        SizedBox(
                          width: 300, // Fixed width for form fields
                          child: _buildTextField(
                            'Package Weight (kg)',
                            'Enter package weight',
                          ),
                        ),
                        SizedBox(
                          width: 300, // Fixed width for form fields
                          child: _buildDimensionsField(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Rate Lookup
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        border: Border.all(color: const Color(0xFFDDDDDD)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'LIVE RATE LOOKUP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.refresh,
                              size: 16,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Refresh Rates',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFFDDDDDD)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFDDDDDD)),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Table(
                        border: TableBorder.symmetric(
                          outside: const BorderSide(color: Color(0xFFDDDDDD)),
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(0.5),
                        },
                        children: [
                          const TableRow(
                            decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'CARRIER',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'SERVICE',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Rate (₹)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'ETA',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Select',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ...List.generate(
                            4,
                            (index) => TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'DHL',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Express',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '15,800',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '3-5 days',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Checkbox(
                                    value: _tableCheckboxes[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _tableCheckboxes[index] =
                                            value ?? false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Notifications
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children:
                          _notificationCheckboxes.keys.map((label) {
                            return _buildCheckbox(
                              label,
                              _notificationCheckboxes[label]!,
                              (value) {
                                setState(() {
                                  _notificationCheckboxes[label] =
                                      value ?? false;
                                });
                              },
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Book Freight Button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 120,
                          maxWidth: 200,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA30000),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Book Freight',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Explicitly set white background
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEEEEEE)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(
                      80,
                    ), // Increased shadow opacity
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shipping',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 500,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search shipments...',
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Align to the left
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.refresh, size: 20),
                            label: const Text('Fetch Tracking #'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(
                                horizontal:
                                    20, // Match the horizontal padding of the search bar
                                vertical:
                                    15, // Match the vertical padding of the search bar
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(color: Colors.black87),
                              ),
                              elevation: 0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_drop_down, size: 20),
                            label: const Text('All'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(
                                horizontal:
                                    20, // Match the horizontal padding of the search bar
                                vertical:
                                    15, // Match the vertical padding of the search bar
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(color: Colors.black87),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth:
                            MediaQuery.of(context).size.width -
                            40, // 40 for padding
                      ),
                      child: DataTable(
                        columnSpacing: 16,
                        horizontalMargin: 0,
                        headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey[100],
                        ),
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        columns: const [
                          DataColumn(label: Text('Shipment ID')),
                          DataColumn(label: Text('Customer')),
                          DataColumn(label: Text('Carrier')),
                          DataColumn(label: Text('Tracking #')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('ETA')),
                        ],
                        rows: List.generate(
                          4,
                          (index) => DataRow(
                            cells: [
                              const DataCell(Text('SHP-2023-0125')),
                              const DataCell(Text('Toyota Japan')),
                              const DataCell(Text('DHL Express')),
                              DataCell(
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'DHL4851236987',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'In Transit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const DataCell(Text('Dec 15, 2023')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Explicitly set white background
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEEEEEE)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(
                      80,
                    ), // Increased shadow opacity
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shipment Status Timeline',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'SHP-2023-0125 • DHL Express',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      Positioned(
                        left: 85, // Adjusted to align with first circle center
                        right: 85, // Adjusted to align with last circle center
                        top: 19, // Fine-tuned to center with circles
                        child: Container(
                          height: 2,
                          color: Colors.grey[300], // Using solid color
                        ),
                      ),
                      SizedBox(
                        height: 160, // Reduced height for better alignment
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTimelineStep(
                              title: 'Shipment Picked Up',
                              subtitle: 'Tokyo, Japan\nDec 10, 2023 - 14:35',
                              color: Colors.red[200]!,
                              isCompleted: true,
                            ),
                            _buildTimelineStep(
                              title: 'Departed Origin',
                              subtitle:
                                  'Tokyo International Airport\nDec 11, 2023 - 08:22',
                              color: Colors.blue[200]!,
                              isCompleted: true,
                            ),
                            _buildTimelineStep(
                              title: 'In Transit',
                              subtitle: 'Singapore Hub\nDec 12, 2023 - 03:15',
                              color: Colors.green[200]!,
                              isCompleted: true,
                            ),
                            _buildTimelineStep(
                              title: 'Arriving at Destination',
                              subtitle:
                                  'Sydney, Australia\nDec 12, 2023\nEstimated: Dec 14, 2023 - 09:00',
                              color: Colors.grey[300]!,
                              isCompleted: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> options) {
    String? selectedValue = options.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items:
              options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
            ),
          ),
          style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
        ),
      ],
    );
  }

  Widget _buildDimensionsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dimensions (cm)',
          style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'L',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'W',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'H',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
        ),
      ],
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required Color color,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(
            Icons.check,
            color: isCompleted ? Colors.black : Colors.transparent,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
