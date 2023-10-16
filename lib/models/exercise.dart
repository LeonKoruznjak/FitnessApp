
class Exercise{
  final String name;
  final String weight;
  final String reps;
  final String sets;
  bool isComepleted;
  bool wasCompleted;

  Exercise({required this.name, required this.sets,  this.isComepleted = false, required this.reps, required this.weight,required this.wasCompleted});
}