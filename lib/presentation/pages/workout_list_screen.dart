import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/models/workout_template_mapper.dart';
import '../../domain/models/workout_template.dart';
import '../bloc/workout_cubit.dart';
import '../bloc/workout_state.dart';
import '../../core/services/chat_service.dart';

const _kWeekShort = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WorkoutCubit>().loadWorkouts();
    });
  }

  static String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Bom dia';
    if (h < 18) return 'Boa tarde';
    return 'Boa noite';
  }

  Future<void> _abrirChatIA(BuildContext context) async {
    final TextEditingController promptController = TextEditingController();
    String respostaIA = "";
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.cardBorder),
              ),
              title: Row(
                children: [
                  const Icon(Icons.smart_toy_rounded, color: AppColors.lime500),
                  const SizedBox(width: 10),
                  Text('TreinAI', style: AppTypography.headingSm),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: promptController,
                    style: AppTypography.bodyMd,
                    maxLines: 3,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Ex: Dica de treino para pernas...',
                      hintStyle: AppTypography.bodyMd.copyWith(color: AppColors.textTertiary),
                      filled: true,
                      fillColor: AppColors.bgElevated,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(color: AppColors.lime500),
                    )
                  else if (respostaIA.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.bgElevated,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Text(
                        respostaIA,
                        style: AppTypography.bodyMd.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'FECHAR',
                    style: AppTypography.buttonMd.copyWith(color: AppColors.textTertiary),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lime500,
                    foregroundColor: AppColors.black,
                  ),
                  onPressed: () async {
                    if (promptController.text.trim().isEmpty) return;

                    setStateDialog(() => isLoading = true);

                    try {
                      final chatService = ChatService();
                      final resposta = await chatService.sendMessage(promptController.text);

                      setStateDialog(() {
                        respostaIA = resposta;
                        isLoading = false;
                      });
                    } catch (e) {
                      setStateDialog(() {
                        respostaIA = "Erro ao conectar: $e";
                        isLoading = false;
                      });
                    }
                  },
                  child: const Text('ENVIAR'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  // ---------------------------------

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().weekday;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      // BOTÃO FLUTUANTE DA IA AQUI!
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.lime500,
        onPressed: () => _abrirChatIA(context),
        child: const Icon(Icons.smart_toy_rounded, size: 28, color: AppColors.black),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_greeting()} 👋',
                        style: AppTypography.titleSm,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'João Silva',
                        style: AppTypography.displaySm,
                      ),
                    ],
                  ),
                ),
                Material(
                  color: AppColors.lime500,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.profile);
                    },
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Text(
                          'J',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sequência de treinos',
                          style: AppTypography.titleMd,
                        ),
                        Text(
                          'Continue assim!',
                          style: AppTypography.bodyMd,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '7',
                    style: AppTypography.statValueLg.copyWith(
                      color: AppColors.lime500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'SEUS TREINOS',
              style: AppTypography.headingSm.copyWith(
                color: AppColors.lime500,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            BlocBuilder<WorkoutCubit, WorkoutState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final templates = state.workouts.map((w) => w.toTemplate()).toList();

                if (templates.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Text(
                      state.errorMessage ?? 'Nenhum treino disponível no momento.',
                      style: AppTypography.bodyMd,
                    ),
                  );
                }

                return Column(
                  children: templates
                      .map(
                        (w) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _WorkoutCard(
                            template: w,
                            isToday: w.scheduledWeekdays.contains(today),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.workoutDetail,
                                arguments: w,
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({
    required this.template,
    required this.isToday,
    required this.onTap,
  });

  final WorkoutTemplate template;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isToday ? AppColors.cardActiveBorder : AppColors.cardBorder,
              width: isToday ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      template.listTitle,
                      style: isToday
                          ? AppTypography.headingMd.copyWith(
                              color: AppColors.lime500,
                            )
                          : AppTypography.headingMd,
                    ),
                  ),
                  if (isToday)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lime500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('HOJE', style: AppTypography.labelSm),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${template.exerciseCount} exercícios · ~${template.durationMinutes} min · Academia',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: 12),
              Row(
                children: List.generate(7, (i) {
                  final weekday = i + 1;
                  final active = template.scheduledWeekdays.contains(weekday);
                  return Expanded(
                    child: Center(
                      child: Text(
                        _kWeekShort[i],
                        style: AppTypography.labelLg.copyWith(
                          fontSize: 11,
                          color: active
                              ? AppColors.lime500
                              : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}