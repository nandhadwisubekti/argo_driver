import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'setting_page.dart';
import 'profile_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _selectedVehicle = 'Motor';
  final _kmController = TextEditingController();
  final _discountController = TextEditingController();
  double _totalFare = 0.0;
  double _discountAmount = 0.0;
  double _finalFare = 0.0;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _kmController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'User';
    });
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  _calculateFare() {
    if (_kmController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Masukkan jarak terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double km = double.tryParse(_kmController.text) ?? 0;
    double discount = double.tryParse(_discountController.text) ?? 0;

    if (km <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Jarak harus lebih dari 0 km'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double fare = 0;

    if (_selectedVehicle == 'Motor') {
      if (km <= 5) {
        fare = 10000;
      } else {
        fare = 10000 + (km * 1800);
      }
    } else { // Mobil
      if (km <= 4) {
        fare = 30000;
      } else {
        fare = 30000 + (km * 8000);
      }
    }

    double discountAmount = fare * (discount / 100);
    double finalFare = fare - discountAmount;

    setState(() {
      _totalFare = fare;
      _discountAmount = discountAmount;
      _finalFare = finalFare;
    });
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.blue[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_taxi,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang, $_userName!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Hitung tarif perjalanan Anda',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: _logout,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          // Vehicle Selection
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Kendaraan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Row(
                            children: [
                              Icon(Icons.motorcycle, color: Colors.blue),
                              SizedBox(width: 8),
                              Text('Motor'),
                            ],
                          ),
                          value: 'Motor',
                          groupValue: _selectedVehicle,
                          onChanged: (value) {
                            setState(() {
                              _selectedVehicle = value!;
                              _totalFare = 0;
                              _discountAmount = 0;
                              _finalFare = 0;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Row(
                            children: [
                              Icon(Icons.directions_car, color: Colors.blue),
                              SizedBox(width: 8),
                              Text('Mobil'),
                            ],
                          ),
                          value: 'Mobil',
                          groupValue: _selectedVehicle,
                          onChanged: (value) {
                            setState(() {
                              _selectedVehicle = value!;
                              _totalFare = 0;
                              _discountAmount = 0;
                              _finalFare = 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          // Input Fields
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Perjalanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Distance Input
                  TextFormField(
                    controller: _kmController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Total Jarak (km)',
                      prefixIcon: Icon(Icons.straighten),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Discount Input
                  TextFormField(
                    controller: _discountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Diskon (%)',
                      prefixIcon: Icon(Icons.percent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: 'Opsional',
                    ),
                  ),
                  SizedBox(height: 20),
                  // Calculate Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _calculateFare,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Hitung Tarif',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          // Result
          if (_totalFare > 0)
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil Perhitungan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildResultRow('Kendaraan', _selectedVehicle),
                    _buildResultRow('Jarak', '${_kmController.text} km'),
                    _buildResultRow('Tarif Dasar', 'Rp ${_totalFare.toStringAsFixed(0)}'),
                    if (_discountAmount > 0)
                      _buildResultRow('Diskon (${_discountController.text}%)', '- Rp ${_discountAmount.toStringAsFixed(0)}'),
                    Divider(thickness: 2),
                    _buildResultRow(
                      'Total Tarif',
                      'Rp ${_finalFare.toStringAsFixed(0)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 16),
          // Tariff Info
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Tarif',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Motor:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('• ≤ 5km: Rp 10.000'),
                  Text('• > 5km: Rp 10.000 + (km × Rp 1.800)'),
                  SizedBox(height: 8),
                  Text(
                    'Mobil:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('• ≤ 4km: Rp 30.000'),
                  Text('• > 4km: Rp 30.000 + (km × Rp 8.000)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.blue[800] : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.blue[800] : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildHomeTab(),
      SettingPage(),
      ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}