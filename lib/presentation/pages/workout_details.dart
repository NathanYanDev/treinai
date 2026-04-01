import 'package:flutter/material.dart';
import 'package:treinai/main.dart';

class WorkoutDetails extends StatelessWidget {
  const WorkoutDetails({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Color(0xFF09090B),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Treino A', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
                        Text('Peito e Tríceps', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert, color: Colors.white),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Text('67', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Exercícios', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Text('NaN', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Duração', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(color:  Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Text('Breaking Bad', style: TextStyle(color: Color(0xFFD4FF00), fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Séries', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //FFD4FF00 + BLACK; FF1C1C1E + FF8E8E93
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    // DOMINGO
                    children: [
                      const Text('D', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Container(
                        width: 32, 
                        height: 32,
                        decoration: const BoxDecoration(color: Color(0xFFD4FF00), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('D', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // SEGUNDA
                  Column(
                    children: [
                      const Text('S', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Container(
                        width: 32, 
                        height: 32,
                        decoration: const BoxDecoration(color: Color(0xFF1C1C1E), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('S', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold)), 
                      ),
                    ],
                  ),
                  // TERÇA
                  Column(
                    children: [
                      const Text('T', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Container(
                        width: 32, 
                        height: 32,
                        decoration: const BoxDecoration(color: Color(0xFF1C1C1E), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('T', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // QUARTA
                  Column(
                    children: [
                      const Text('Q', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Container(
                        width: 32, 
                        height: 32,
                        decoration: const BoxDecoration(color: Color(0xFF1C1C1E), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('Q', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // QUINTA
                  Column(
                    children: [
                      const Text('Q', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Container(
                        width: 32, 
                        height: 32,
                        decoration: const BoxDecoration(color: Color(0xFF1C1C1E), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('Q', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // SEXTA
                  Column(
                    children: [
                      const Text('S', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Container(
                        width: 32, height: 32,
                        decoration: const BoxDecoration(color: Color(0xFF1C1C1E), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('S', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  // SÁBADO
                  Column(
                    children: [
                      const Text('S', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Container(
                        width: 32, height: 32,
                        decoration: const BoxDecoration(color: Color(0xFF1C1C1E), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('S', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            // EXERCÍCIOS
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [

                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Text('01', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Supino Reto', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text('4 séries • 8-12 reps • 90s', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(8))),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Text('02', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Supino Inclinado', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text('3 séries • 10-12 reps • 60s', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(8))),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Text('03', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Crossover', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text('3 séries • 12-15 reps • 60s', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(8))),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Text('04', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tríceps Pulley', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text('4 séries • 10-12 reps • 60s', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(8))),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4FF00),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {},
                  child: const Text('INICIAR TREINO', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
