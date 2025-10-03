class Relationship {
  final String name;
  final int age;
  final String relation;
  final String distance;
  final int averageLifespanYears;
  final int recentMemoriesCount;
  final int lastCallDaysAgo;
  final int lastVisitWeeksAgo;
  final int averageContactDays;
  final int callGoalWeekly;
  final int visitGoalMonthly;
  final int visitGoalBehindBy;
  final int recipesLearned;
  final int recipesTotal;
  final List<String> qualityTimeIdeas;

  Relationship({
    required this.name,
    required this.age,
    required this.relation,
    required this.distance,
    required this.averageLifespanYears,
    required this.recentMemoriesCount,
    required this.lastCallDaysAgo,
    required this.lastVisitWeeksAgo,
    required this.averageContactDays,
    required this.callGoalWeekly,
    required this.visitGoalMonthly,
    required this.visitGoalBehindBy,
    required this.recipesLearned,
    required this.recipesTotal,
    required this.qualityTimeIdeas,
  });
}
