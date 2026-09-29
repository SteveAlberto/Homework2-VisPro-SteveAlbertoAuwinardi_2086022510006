import 'package:flutter/material.dart';

class Langganan {
  String nama;
  int harga;
  String status;

  Langganan(this.nama, this.harga, this.status);
}

class LayarAwal extends StatefulWidget {
  const LayarAwal({super.key});

  @override
  State<LayarAwal> createState() => _LayarAwalState();
}

class _LayarAwalState extends State<LayarAwal> {
  int _totalTagihan = 76000;

  final List<Langganan> _daftarLangganan = [
    Langganan('Netflix Premium', 47000, '2/5 Lunas'),
    Langganan('Spotify Family', 29000, 'Lunas Semua!'),
  ];

  void _tambahLanggananBaru() {
    setState(() {
      _daftarLangganan.add(Langganan('Canva Pro', 20000, '0/4 Lunas'));
      _totalTagihan += 20000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patungan Langganan')),
      body: Column(
        children: [
          KartuTotalTagihan(totalTagihan: _totalTagihan),
          const SizedBox(height: 10),
          const Text('Daftar Patungan Aktif'),
          const SizedBox(height: 10),
          Expanded(child: DaftarItemLangganan(dataLangganan: _daftarLangganan)),
        ],
      ),
      floatingActionButton: TombolTambah(onTambah: _tambahLanggananBaru),
    );
  }
}

class KartuTotalTagihan extends StatelessWidget {
  final int totalTagihan;
  const KartuTotalTagihan({super.key, required this.totalTagihan});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Text(
          'Total Tagihan: Rp $totalTagihan', 
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class DaftarItemLangganan extends StatelessWidget {
  final List<Langganan> dataLangganan;
  const DaftarItemLangganan({super.key, required this.dataLangganan});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataLangganan.length,
      itemBuilder: (context, index) {
        final item = dataLangganan[index];
        return KartuLangganan(nama: item.nama, harga: item.harga, status: item.status);
      },
    );
  }
}

class KartuLangganan extends StatelessWidget {
  final String nama;
  final int harga;
  final String status;
  const KartuLangganan({super.key, required this.nama, required this.harga, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.subscriptions),
        title: Text(nama),
        subtitle: Text(status),
        trailing: Text('Rp $harga'),
      ),
    );
  }
}

class TombolTambah extends StatelessWidget {
  final Function() onTambah; 
  const TombolTambah({super.key, required this.onTambah});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton( 
      onPressed: onTambah,
      child: const Icon(Icons.add),
    );
  }
}