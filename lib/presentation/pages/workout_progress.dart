import 'package:flutter/material.dart';
import 'package:treinai/main.dart';

class WorkoutProgress extends StatelessWidget {
  const WorkoutProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF09090B),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                    ),
                    Text('TREINO A · 3/8', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('3 de 8', style: TextStyle(color: Color(0xFFD4FF00), fontSize: 14)),
                  ],
                ),
                SizedBox(height: 16),
                Stack(
                  children: [
                    Container(height: 4, decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(2))),
                    FractionallySizedBox(
                      widthFactor: 0.375,
                      child: Container(height: 4, decoration: BoxDecoration(color: Color(0xFFD4FF00), borderRadius: BorderRadius.circular(2))),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF09090B),
                    border: Border.all(color: Color(0xFFD4FF00), width: 2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('EXERCÍCIO 03', style: TextStyle(color: Color(0xFFD4FF00), fontWeight: FontWeight.bold, fontSize: 12)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: Color(0xFFD4FF00), borderRadius: BorderRadius.circular(20)),
                            child: Text('EM ANDAMENTO', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('Crossover', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      SizedBox(height: 24),

                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12), width: 40, height: 40,
                            decoration: BoxDecoration(color: Color(0xFFD4FF00), shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Text('1', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12), width: 40, height: 40,
                            decoration: BoxDecoration(color: Color(0xFFD4FF00), shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Text('2', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12), width: 40, height: 40,
                            decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Color(0xFFD4FF00), width: 2), shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Text('3', style: TextStyle(color: Color(0xFFD4FF00), fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12), width: 40, height: 40,
                            decoration: BoxDecoration(color: Color(0xFF1C1C1E), shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Text('4', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(color: Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  Text('12', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('Reps', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(color: Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  Text('3', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('Série', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(color: Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  Text('15kg', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('Carga', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer_outlined, color: Color(0xFF8E8E93), size: 20),
                          SizedBox(width: 8),
                          Text('Descanso recomendado', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
                        ],
                      ),
                      Text('60s', style: TextStyle(color: Color(0xFFD4FF00), fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 12),

                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PRÓXIMO EXERCÍCIO', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
                      SizedBox(height: 4),
                      Text('Tríceps Pulley • 4 séries • 10-12 reps', style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ),
                
                Spacer(), // isso é muito útil

                Row(
                  children: [
                    Expanded(
                      flex: 1, 
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1C1C1E),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {},
                          child: Text('PULAR', style: TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      flex: 2, 
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD4FF00),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {},
                          child: Text('SÉRIE CONCLUÍDA ✓', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}