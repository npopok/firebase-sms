import 'package:flutter/material.dart';

enum StepState {
  completed,
  current,
  planned,
}

class StepIndicator extends StatelessWidget {
  static const circleRadius = 18;
  static const stateFillColors = [Colors.transparent, Color(0xFFFFB800), Color(0xFFECECEC)];
  static const completedBorder = Color(0xFF39A314);
  static const connectionColor = Color(0xFFECECEC);

  final int maxSteps;
  final int currentStep;

  const StepIndicator({
    required this.maxSteps,
    required this.currentStep,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.generate(
        maxSteps * 2 - 1,
        (index) {
          if (index.isEven) {
            var step = index ~/ 2;
            var state = step < currentStep
                ? StepState.completed
                : (step == currentStep ? StepState.current : StepState.planned);
            return _buildStepCircle(context, state, step + 1);
          } else {
            return _buildConnectionLine();
          }
        },
      ),
    );
  }

  Widget _buildStepCircle(BuildContext context, StepState state, int index) {
    return Container(
      height: circleRadius * 2,
      width: circleRadius * 2,
      decoration: _getStepDecoration(state),
      child: state == StepState.completed
          ? const Icon(Icons.done, size: 20, color: completedBorder)
          : Align(
              alignment: Alignment.center,
              child: Text(
                index.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  BoxDecoration _getStepDecoration(StepState state) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: stateFillColors[state.index],
      border: Border.all(
        width: state == StepState.completed ? 1 : 0,
        color: state == StepState.completed ? completedBorder : Colors.transparent,
      ),
    );
  }

  Widget _buildConnectionLine() {
    return Container(
      height: 1,
      width: 44,
      color: connectionColor,
    );
  }
}
