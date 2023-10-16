

class ExerciseOption {
  final String name;

  ExerciseOption({required this.name});
}

List<String> exerciseCategories = [
  'Back',
  'Biceps',
  'Chest',
  'Core',
  'Forearms',
  'Legs',
  'Shoulders',
  'Triceps',
  // Add more exercise categories
];

Map<String, List<ExerciseOption>> exerciseOptions = {
  'Back': [
    ExerciseOption(name: 'Alternate Lateral Pulldown'),
    ExerciseOption(name: 'Barbell Bent Over Row'),
    ExerciseOption(name: 'Barbell Incline Row'),
    ExerciseOption(name: 'Barbell Deadlift'),
    ExerciseOption(name: 'Barbell Pullover'),
    ExerciseOption(name: 'Barbell Shrug'),
    ExerciseOption(name: 'Cable Lateral Pulldown'),
    ExerciseOption(name: 'Cable Low Seated Row'),
    ExerciseOption(name: 'Cable High Seated Row'),
    ExerciseOption(name: 'Cable Seated One Arm Alternate Row'),
    ExerciseOption(name: 'Chin-ups'),
    ExerciseOption(name: 'Dumbbell One Arm Bent-over Row'),
    ExerciseOption(name: 'Dumbbell Bent-over Row'),
    ExerciseOption(name: 'Dumbbell Deadlift'),
    ExerciseOption(name: 'Pull-up'),
    // Add more exercise options for back
  ],
  'Biceps': [
    ExerciseOption(name: 'Barbbell Curl'),
    ExerciseOption(name: 'Barbbell Standing Close-grip Curl'),
    ExerciseOption(name: 'Barbbell Standing Wide-grip Curl'),
    ExerciseOption(name: 'Barbbell Preacher Curl'),
    ExerciseOption(name: 'Barbbell Lying Preacher Curl'),
    ExerciseOption(name: 'Cable Curl'),
    ExerciseOption(name: 'Cable Overhead Curl'),
    ExerciseOption(name: 'Cable One Arm Curl'),
    ExerciseOption(name: 'Dumbbell Alternate Biceps Curl'),
    ExerciseOption(name: 'Dumbbell Biceps Curl'),
    ExerciseOption(name: 'Dumbbell Concentration Curl'),
    ExerciseOption(name: 'Dumbbell Hammer Curl'),
    ExerciseOption(name: 'Dumbbell Incline Biceps Curl'),
    ExerciseOption(name: 'EZ Barbbell Close-grip Curl'),
    // Add more exercise options for biceps
  ],


  'Chest': [
    ExerciseOption(name: 'Barbbell Bench Press'),
    ExerciseOption(name: 'Barbbell Decline Bench Press'),
    ExerciseOption(name: 'Barbbell Incline Bench Press'),
    ExerciseOption(name: 'Barbbell Wide Bench Press'),
    ExerciseOption(name: 'Cable Bench Press'),
    ExerciseOption(name: 'Cable Cross-over'),
    ExerciseOption(name: 'Cable Incline Bench Press'),
    ExerciseOption(name: 'Cable Low Fly'),
    ExerciseOption(name: 'Cable Middle Fly'),
    ExerciseOption(name: 'Cable Standing Fly'),
    ExerciseOption(name: 'Chest Dip'),
    ExerciseOption(name: 'Dumbbell Around Pullover'),
    ExerciseOption(name: 'Dumbbell Bench Press'),
    ExerciseOption(name: 'Dumbbell Incline Bench Press'),
    ExerciseOption(name: 'Dumbbell Decline Bench Press'),
    ExerciseOption(name: 'Dumbbell Fly'),
    ExerciseOption(name: 'Dumbbell Decline Fly'),
    ExerciseOption(name: 'Push-up'),
    ExerciseOption(name: 'Incline Push-up'),
    ExerciseOption(name: 'Decline Push-up'),


    // Add more exercise options for chest
  ],

  'Core': [
    ExerciseOption(name: 'Air Bike'),
    ExerciseOption(name: 'Air Twisting Crunch'),
    ExerciseOption(name: 'Alternate Heel Touchers'),
    ExerciseOption(name: 'Bottoms-up'),
    ExerciseOption(name: 'Bridge (cross knee)'),
    ExerciseOption(name: 'Bycicle Twisting Crunch'),
    ExerciseOption(name: 'Cross Body Crunch'),
    ExerciseOption(name: 'Crunch Floor'),
    ExerciseOption(name: 'Decline Crunch'),
    ExerciseOption(name: 'Front Plank'),
    ExerciseOption(name: 'Hyperextensions'),
    // Add more exercise options for core
  ],

  'Forearms': [
    ExerciseOption(name: 'Barbbell Wrist Curl'),
    ExerciseOption(name: 'Barbbell Reverse Curl'),
    ExerciseOption(name: 'Barbbell Standing Back Wrist Curl'),
    ExerciseOption(name: 'Cable Wrist Curl'),
    ExerciseOption(name: 'Cable Revesre Wrist Curl'),
    ExerciseOption(name: 'Dumbbell One Arm Wrist Curl'),
    ExerciseOption(name: 'Dumbbell Reverse Wrist Curl'),
    ExerciseOption(name: 'Finger Curls'),
    ExerciseOption(name: 'Lunges'),
    // Add more exercise options for forearms
  ],



  'Legs': [
    ExerciseOption(name: 'Barbbell Bench Squat'),
    ExerciseOption(name: 'Barbbell Clean-grip Front Squat'),
    ExerciseOption(name: 'Barbbell Front Squat'),
    ExerciseOption(name: 'Barbbell Deadlift'),
    ExerciseOption(name: 'Barbbell Romanian Deadlift'),
    ExerciseOption(name: 'Barbbell Sumo Deadlift'),
    ExerciseOption(name: 'Barbbell Full Squat'),
    ExerciseOption(name: 'Barbbell Good Morning'),
    ExerciseOption(name: 'Barbbell Seated Good Morning'),
    ExerciseOption(name: 'Barbbell Hack Squat'),
    ExerciseOption(name: 'Barbbell Jefferson Squat'),
    ExerciseOption(name: 'Barbbell Jump Squat'),
    ExerciseOption(name: 'Barbbell Lunge'),
    ExerciseOption(name: 'Barbbell Hip Thrust'),
    ExerciseOption(name: 'Barbbell One Leg Squat'),
    ExerciseOption(name: 'Barbbell Overhead Squat'),
    ExerciseOption(name: 'Barbbell Step-up'),
    ExerciseOption(name: 'Cable Pull-through'),
    ExerciseOption(name: 'Cable Standing Hip Extension'),
    ExerciseOption(name: 'Dumbbell Lunge'),
    ExerciseOption(name: 'Dumbbell Squat'),
    ExerciseOption(name: 'Dumbbell Standing Calf'),
    ExerciseOption(name: 'Lever Seated Calf Raise'),
    ExerciseOption(name: 'Leg Curl'),
    ExerciseOption(name: 'Lever Leg Extension'),
    // Add more exercise options for legs
  ],
  'Shoulders': [
    ExerciseOption(name: 'Barbbell Clean And Press'),
    ExerciseOption(name: 'Barbbell Front Raise'),
    ExerciseOption(name: 'Barbbell Rear Delt Row'),
    ExerciseOption(name: 'Cable Forward Raise'),
    ExerciseOption(name: 'Cable Lateral Raise'),
    ExerciseOption(name: 'Dumbbell One Arm Lateral  Raise'),
    ExerciseOption(name: 'Dumbbell One Arm Lateral Raise'),
    ExerciseOption(name: 'Dumbbell Arnold Press'),
    ExerciseOption(name: 'Dumbbell Front Raise '),
    ExerciseOption(name: 'Dumbbell Incline Raise '),
    ExerciseOption(name: 'Dumbbell Rear Fly'),
    ExerciseOption(name: 'Dumbbell Reverse Fly'),
    ExerciseOption(name: 'Dumbbell Seated Shoulder Press'),
    ExerciseOption(name: 'Kettlebell Arnold Press'),
    ExerciseOption(name: 'Kettlebell Two Arm Military Press'),

    // Add more exercise options for shoulders
  ],

  'Triceps': [
    ExerciseOption(name: 'Barbbell Close-Grip Bench Press'),
    ExerciseOption(name: 'Barbbell Lying Extension'),
    ExerciseOption(name: 'Cabel Triceps Extension'),
    ExerciseOption(name: 'Cable Pushdown'),
    ExerciseOption(name: 'Cable Rear Drive'),
    ExerciseOption(name: 'Close-grip Push-up'),
    ExerciseOption(name: 'Diamond Push-up'),
    ExerciseOption(name: 'Dumbbell Close-grip Press'),
    ExerciseOption(name: 'Dumbbell Decline Triceps Extension'),
    ExerciseOption(name: 'Dumbbell Lying Triceps Extension'),
    ExerciseOption(name: 'Cable Kickback'),
    ExerciseOption(name: 'Dumbbell Kickback'),
    ExerciseOption(name: 'Dumbbell Seated Kickback'),
    ExerciseOption(name: 'EZ Barbell Close-grip Face Press'),
    ExerciseOption(name: 'Triceps Dip'),

    // Add more exercise options for triceps
  ],



  // Add more exercise categories and their respective exercise options
};
