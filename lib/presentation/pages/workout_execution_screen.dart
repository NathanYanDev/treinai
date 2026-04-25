import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/models/completed_workout.dart';
import '../../domain/models/workout.dart';
import '../../domain/models/workout_exercise.dart';
import '../../domain/models/workout_template_mapper.dart';
import '../../domain/models/workout_template.dart';
import '../../domain/repositories/auth_repository.dart';
import '../bloc/workout_cubit.dart';
import 'workout_complete_args.dart';

class WorkoutExecutionScreen extends StatefulWidget {
  const WorkoutExecutionScreen({super.key, required this.template});

  final WorkoutTemplate template;

  static WorkoutTemplate resolveArgs(Object? arguments) {
    if (arguments is WorkoutTemplate) return arguments;
    if (arguments is Workout) return arguments.toTemplate();
    return const WorkoutTemplate(
      id: 'fallback',
      codeLabel: 'Treino',
      muscleTitle: 'Sem detalhes',
      exerciseCount: 1,
      durationMinutes: 1,
      sessionsHighlight: '1x',
      scheduledWeekdays: [1],
      exercises: [
        WorkoutExercise(
          name: 'Exercício',
          sets: 1,
          repsLabel: '10',
          restSeconds: 60,
          weightKg: 0,
        ),
      ],
    );
  }

  @override
  State<WorkoutExecutionScreen> createState() => _WorkoutExecutionScreenState();
}

class _WorkoutExecutionScreenState extends State<WorkoutExecutionScreen> {
  late int _exerciseIndex;
  late int _setIndex;

  List<WorkoutExercise> get _exercises => widget.template.exercises;

  @override
  void initState() {
    super.initState();
    _exerciseIndex = 0;
    _setIndex = 1;
  }

  WorkoutExercise get _current => _exercises[_exerciseIndex];

  int get _totalExercises => _exercises.length;
  int get _completedExerciseCount => _exerciseIndex;

  double get _topProgress =>
      (_completedExerciseCount + (_setIndex - 1) / _current.sets) /
      _totalExercises;

  Future<void> _finishWorkout() async {
    final totalSets = _exercises.fold<int>(0, (a, e) => a + e.sets);
    const repsPerSet = 10;
    final totalReps = totalSets * repsPerSet;
    final minutes = widget.template.durationMinutes;
    final session = await context.read<AuthRepository>().getCurrentSession();
    final userId = session?.userId ?? 'current_user';

    await context.read<WorkoutCubit>().saveCompletedWorkout(
          CompletedWorkout(
            workoutId: widget.template.id,
            userId: userId,
            completedAt: DateTime.now(),
            durationMinutes: minutes,
            totalSets: totalSets,
            totalReps: totalReps,
          ),
        );

    final args = WorkoutCompleteArgs(
      workoutLabel: widget.template.codeLabel,
      completedExercises: _totalExercises,
      totalExercises: _totalExercises,
      durationMinutes: minutes,
      totalSets: totalSets,
      totalReps: totalReps,
      streakDays: 8,
      isNewRecord: true,
    );

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.workoutComplete,
      arguments: args,
    );
  }

  void _completeSet() {
    if (_setIndex < _current.sets) {
      setState(() => _setIndex++);
      return;
    }
    if (_exerciseIndex < _exercises.length - 1) {
      setState(() {
        _exerciseIndex++;
        _setIndex = 1;
      });
      return;
    }
    _finishWorkout();
  }

  void _skipExercise() {
    if (_exerciseIndex < _exercises.length - 1) {
      setState(() {
        _exerciseIndex++;
        _setIndex = 1;
      });
    } else {
      _finishWorkout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ex = _current;
    final progressLabel = '${_exerciseIndex + 1}/$_totalExercises';
    final nextEx = _exerciseIndex < _exercises.length - 1
        ? _exercises[_exerciseIndex + 1]
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: Row(
                children: [
                  Material(
                    color: AppColors.bgElevated,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(12),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.template.codeLabel.toUpperCase()} · $progressLabel',
                              style: AppTypography.titleSm.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${_exerciseIndex + 1} de $_totalExercises',
                              style: AppTypography.titleSm.copyWith(
                                color: AppColors.lime500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: LinearProgressIndicator(
                            value: _topProgress.clamp(0.0, 1.0),
                            minHeight: 3,
                            backgroundColor: AppColors.grey800,
                            color: AppColors.lime500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.grey900,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.lime500, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'EXERCÍCIO ${(_exerciseIndex + 1).toString().padLeft(2, '0')}',
                                      style: AppTypography.labelSm.copyWith(
                                        color: AppColors.lime500,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(ex.name, style: AppTypography.titleLg),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.lime500,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'EM ANDAMENTO',
                                  style: AppTypography.labelSm,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: List.generate(ex.sets, (i) {
                              final n = i + 1;
                              final done = n < _setIndex;
                              final current = n == _setIndex;
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: i == ex.sets - 1 ? 0 : 8,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: done
                                            ? AppColors.lime500
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: current
                                              ? AppColors.lime500
                                              : AppColors.grey800,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        '$n',
                                        style: AppTypography.titleMd.copyWith(
                                          color: done || current
                                              ? (done
                                                    ? AppColors.black
                                                    : AppColors.textPrimary)
                                              : AppColors.textTertiary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _StatMini(
                                  value: ex.repsLabel.contains('-')
                                      ? ex.repsLabel.split('-').last
                                      : '12',
                                  label: 'Reps',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _StatMini(
                                  value: '$_setIndex',
                                  label: 'Série',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _StatMini(
                                  value: ex.weightKg > 0
                                      ? '${ex.weightKg}kg'
                                      : '—',
                                  label: 'Carga',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey900,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Descanso recomendado',
                              style: AppTypography.bodyMd,
                            ),
                          ),
                          Text(
                            '${ex.restSeconds}s',
                            style: AppTypography.titleMd.copyWith(
                              color: AppColors.lime500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey900,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PRÓXIMO EXERCÍCIO',
                            style: AppTypography.bodySm.copyWith(
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            nextEx != null
                                ? '${nextEx.name} · ${nextEx.sets} séries · ${nextEx.repsLabel} reps'
                                : '— Fim do treino —',
                            style: AppTypography.titleSm.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: _skipExercise,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textTertiary,
                        side: const BorderSide(color: AppColors.grey700),
                        minimumSize: const Size(0, 52),
                      ),
                      child: const Text('PULAR'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _completeSet,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('SÉRIE CONCLUÍDA'),
                          SizedBox(width: 6),
                          Icon(Icons.check_rounded, color: AppColors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatMini extends StatelessWidget {
  const _StatMini({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgElevated,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(value, style: AppTypography.statValueLg),
          const SizedBox(height: 2),
          Text(label, style: AppTypography.statLabel),
        ],
      ),
    );
  }
}
