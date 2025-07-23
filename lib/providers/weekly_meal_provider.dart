import 'package:flutter_riverpod/flutter_riverpod.dart';

final weeklyMealProvider =
    StateProvider<Map<String, Map<String, List<String>>>>((ref) => {
          'monday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
          'tuesday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
          'wednesday': {
            'breakfast': [],
            'lunch': [],
            'dinner': [],
            'snacks': []
          },
          'thursday': {
            'breakfast': [],
            'lunch': [],
            'dinner': [],
            'snacks': []
          },
          'friday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
          'saturday': {
            'breakfast': [],
            'lunch': [],
            'dinner': [],
            'snacks': []
          },
          'sunday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
        });
