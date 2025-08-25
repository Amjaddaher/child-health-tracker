import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../bloc/measurement_bloc.dart';
import '../bloc/measurement_event.dart';
import '../bloc/measurement_state.dart';
import '../../domain/entities/measurement.dart';
import 'add_measurement_page.dart';

class GrowthPage extends StatelessWidget {
  final String childId;

  const GrowthPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('growth.title'.tr)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddMeasurementPage(childId: childId),
            ),
          );
          context.read<MeasurementBloc>().add(LoadMeasurements(childId));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<MeasurementBloc, MeasurementState>(
        builder: (context, state) {
          if (state is MeasurementInitial) {
            context.read<MeasurementBloc>().add(LoadMeasurements(childId));
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MeasurementLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MeasurementError) {
            return Center(
              child: Text(
                'common.error_with_message'.trParams({'msg': state.message}),
              ),
            );
          }

          final items = (state as MeasurementLoaded).items;
          if (items.isEmpty) {
            return Center(child: Text('growth.no_measurements'.tr));
          }

          List<_Point> _toPoints(
            List<Measurement> list,
            double? Function(Measurement) getY,
          ) {
            final pts = <_Point>[];
            for (var i = 0; i < list.length; i++) {
              final m = list[i];
              final y = getY(m);
              if (y != null) {
                pts.add(_Point(x: i.toDouble(), y: y, label: m.date));
              }
            }
            return pts;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _GrowthCard(
                title: 'growth.weight_title'.tr,
                points: _toPoints(items, (m) => m.weight),
              ),
              const SizedBox(height: 16),
              _GrowthCard(
                title: 'growth.height_title'.tr,
                points: _toPoints(items, (m) => m.height),
              ),
              const SizedBox(height: 16),
              _GrowthCard(
                title: 'growth.head_title'.tr,
                points: _toPoints(items, (m) => m.headCirc),
              ),
              const SizedBox(height: 24),
              Text(
                'growth.measurements_label'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ...items.map(
                (m) => Column(
                  children: [
                    SizedBox(height: 12,),
                    Card(
                      child: ListTile(
                        title: Text('${m.date.toLocal()}'.split(' ').first),
                        subtitle: Text(
                          'growth.measurement_item'.trArgs([
                            m.weight?.toString() ?? '-',
                            m.height?.toString() ?? '-',
                            m.headCirc?.toString() ?? '-',
                          ]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            context.read<MeasurementBloc>().add(
                              RemoveMeasurement(id: m.id, childId: childId),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GrowthCard extends StatelessWidget {
  final String title;
  final List<_Point> points;

  const _GrowthCard({required this.title, required this.points, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: points.isEmpty
                  ? Center(child: Text('growth.no_enough_data'.tr))
                  : LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final idx = value.toInt().clamp(
                                  0,
                                  points.length - 1,
                                );
                                final d = points[idx].label;
                                return Text('${d.month}/${d.year % 100}');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              for (var i = 0; i < points.length; i++)
                                FlSpot(points[i].x, points[i].y),
                            ],
                            isCurved: true,
                            dotData: const FlDotData(show: true),
                          ),
                        ],
                        gridData: const FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Point {
  final double x;
  final double y;
  final DateTime label;

  const _Point({required this.x, required this.y, required this.label});
}
