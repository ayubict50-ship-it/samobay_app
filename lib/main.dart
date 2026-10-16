import 'package:flutter/material.dart';

void main() {
  runApp(const SamobayApp());
}

class SamobayApp extends StatelessWidget {
  const SamobayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'সমবায় সমিতি ম্যানেজমেন্ট',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const MemberListScreen(),
    );
  }
}

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  String societyName = "জামালপুর সমবায় সমিতি লিঃ";
  final _societyNameController = TextEditingController();

  final List<Map<String, dynamic>> samobayMembers = [
    {
      "name": "মোঃ আইয়ুব হোসেন ভূঁইয়া",
      "mobile": "01728-021804",
      "monthlyDeposit": 2000,
      "totalMonths": 8,
      "paidMonths": 6,
      "profitShare": 1500,
    },
    {
      "name": "রহিম উদ্দিন",
      "mobile": "01711-123456",
      "monthlyDeposit": 2000,
      "totalMonths": 8,
      "paidMonths": 8,
      "profitShare": 2000,
    },
  ];

  // কন্ট্রোলারসমূহ
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _depositController = TextEditingController();
  final _paidMonthsController = TextEditingController();
  final _profitController = TextEditingController();

  // সমিতির নাম পরিবর্তনের ডায়ালগ
  void _showEditSocietyNameDialog() {
    _societyNameController.text = societyName;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('সমিতির নাম পরিবর্তন করুন'),
          content: TextField(
            controller: _societyNameController,
            decoration: const InputDecoration(labelText: 'সমিতির নাম'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('বাতিল'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                if (_societyNameController.text.isNotEmpty) {
                  setState(() {
                    societyName = _societyNameController.text;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('সংরক্ষণ'),
            ),
          ],
        );
      },
    );
  }

  // নতুন সদস্য যোগ করার ডায়ালগ
  void _showAddMemberDialog() {
    _nameController.clear();
    _mobileController.clear();
    _depositController.text = "2000";
    _paidMonthsController.text = "1";
    _profitController.text = "0";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('নতুন সদস্য যোগ করুন'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'সদস্যের নাম'),
                ),
                TextField(
                  controller: _mobileController,
                  decoration: const InputDecoration(labelText: 'মোবাইল নম্বর'),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: _depositController,
                  decoration: const InputDecoration(labelText: 'মাসিক জমা (টাকা)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _paidMonthsController,
                  decoration: const InputDecoration(labelText: 'জমা দেওয়া মোট মাস'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _profitController,
                  decoration: const InputDecoration(labelText: 'লাভের অংশ (টাকা)'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('বাতিল'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                if (_nameController.text.isNotEmpty && _depositController.text.isNotEmpty) {
                  setState(() {
                    samobayMembers.add({
                      "name": _nameController.text,
                      "mobile": _mobileController.text.isEmpty ? "ন নেই" : _mobileController.text,
                      "monthlyDeposit": int.tryParse(_depositController.text) ?? 2000,
                      "totalMonths": 8,
                      "paidMonths": int.tryParse(_paidMonthsController.text) ?? 1,
                      "profitShare": int.tryParse(_profitController.text) ?? 0,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('সংরক্ষণ করুন'),
            ),
          ],
        );
      },
    );
  }

  // সদস্যের তথ্য এডিট বা ডিলিট করার অপশন ডায়ালগ
  void _showMemberOptionsDialog(int index) {
    var member = samobayMembers[index];
    _nameController.text = member["name"];
    _mobileController.text = member["mobile"];
    _depositController.text = member["monthlyDeposit"].toString();
    _paidMonthsController.text = member["paidMonths"].toString();
    _profitController.text = member["profitShare"].toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${member["name"]}-এর তথ্য'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'সদস্যের নাম'),
                ),
                TextField(
                  controller: _mobileController,
                  decoration: const InputDecoration(labelText: 'মোবাইল নম্বর'),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: _depositController,
                  decoration: const InputDecoration(labelText: 'মাসিক জমা (টাকা)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _paidMonthsController,
                  decoration: const InputDecoration(labelText: 'জমা দেওয়া মোট মাস'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _profitController,
                  decoration: const InputDecoration(labelText: 'লাভের অংশ (টাকা)'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  samobayMembers.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('ডিলিট করুন'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('বাতিল'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                setState(() {
                  samobayMembers[index] = {
                    "name": _nameController.text,
                    "mobile": _mobileController.text,
                    "monthlyDeposit": int.tryParse(_depositController.text) ?? 2000,
                    "totalMonths": 8,
                    "paidMonths": int.tryParse(_paidMonthsController.text) ?? 1,
                    "profitShare": int.tryParse(_profitController.text) ?? 0,
                  };
                });
                Navigator.pop(context);
              },
              child: const Text('আপডেট করুন'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalCollection = 0;
    int totalProfit = 0;

    for (var member in samobayMembers) {
      int monthlyDeposit = member["monthlyDeposit"];
      int paidMonths = member["paidMonths"];
      int profitShare = member["profitShare"];
      
      totalCollection += (monthlyDeposit * paidMonths);
      totalProfit += (profitShare as int);
    }
    int grandTotalFund = totalCollection + totalProfit;

    return Scaffold(
      appBar: AppBar(
        title: Text(societyName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: _showEditSocietyNameDialog,
            tooltip: 'সমিতির নাম পরিবর্তন করুন',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("📊 সমিতির আর্থিক সারসংক্ষেপ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                const Divider(),
                Text("• মোট সদস্য সংখ্যা: ${samobayMembers.length} জন", style: const TextStyle(fontSize: 15)),
                Text("• মূল সঞ্চয় জমা: $totalCollection টাকা", style: const TextStyle(fontSize: 15)),
                Text("• মোট লাভের অংশ: $totalProfit টাকা", style: const TextStyle(fontSize: 15)),
                Text("• সর্বমোট ক্যাশ ফান্ড: $grandTotalFund টাকা", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("সদস্যগণের তালিকা (এডিট করতে নামের ওপর ক্লিক করুন):", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: samobayMembers.length,
              itemBuilder: (context, index) {
                var m = samobayMembers[index];
                int monthlyDeposit = m["monthlyDeposit"];
                int paidMonths = m["paidMonths"];
                int profitShare = m["profitShare"];
                
                int totalPaid = monthlyDeposit * paidMonths;
                int grandTotal = totalPaid + (profitShare as int);
                int dueMonths = 8 - paidMonths;
                int dueAmount = monthlyDeposit * dueMonths;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 2,
                  child: ListTile(
                    onTap: () => _showMemberOptionsDialog(index),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[700],
                      child: Text("${index + 1}", style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(
                      m["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      "মোবাইল: ${m["mobile"]}\nমূল জমা: $totalPaid ৳ | লাভ: $profitShare ৳\nবকেয়া: $dueMonths মাস ($dueAmount ৳)",
                    ),
                    trailing: Text(
                      "মোট: $grandTotal ৳",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[800], fontSize: 15),
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddMemberDialog,
        backgroundColor: Colors.green[700],
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('নতুন সদস্য', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
