//
//  UserInfo.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import Foundation

struct UserInfo {
    var basicInformation: BasicInformation = BasicInformation()
    var vitals: Vitals = Vitals()
    var fitnessAndActivity: FitnessAndActivity = FitnessAndActivity()
    var nutrition: Nutrition = Nutrition()
    var sleep: Sleep = Sleep()
    var mindfulnessAndStressReduction = MindfulnessAndStressReduction()
    var reproductiveHealth: ReproductiveHealth = ReproductiveHealth()
    var uvExposure: UVExposure = UVExposure()
    var mobilityMetrics: MobilityMetrics = MobilityMetrics()
    var symptoms: Symptoms = Symptoms()
    var labAndTestResults: LabAndTestResults = LabAndTestResults()
}

struct BasicInformation {
    var height: Double = 0.0
    var weight: Double = 0.0
    var dateOfBirth: Date = Date()
    var biologicalSex: BiologicalSex = .other
    var fitzpatrickSkinType: FitzpatrickSkinType = .typeI
}

// Example for Vitals struct, others would follow a similar pattern
struct Vitals {
    var heartRate: Int = 0
    var bloodPressure: (systolic: Int, diastolic: Int) = (0, 0)
    var bodyTemperature: Double = 36.5 // Average human body temperature in Celsius
    var respiratoryRate: Int = 0
    var ecgSamples: [Double] = []
}

struct FitnessAndActivity {
    var steps: Int = 0
    var distanceWalkedOrRun: Double = 0.0
    var flightsClimbed: Int = 0
    var exerciseMinutes: Int = 0
    var standHours: Int = 0
    var activityEnergy: Int = 0
    var workouts: [Workout] = []
}

struct Nutrition {
    var dietaryEnergy: Int = 0
    var nutritionDetails: NutritionDetails = NutritionDetails()
    var waterIntake: Double = 0.0
    var caffeineIntake: Double = 0.0
}

struct Sleep {
    var sleepAnalysis: [SleepPeriod] = []
}

struct MindfulnessAndStressReduction {
    var mindfulMinutes: Int = 0
    var stressLevel: Int = 0
}


struct SleepPeriod {
    var inBed: DateInterval = DateInterval(start: Date(), duration: 0)
    var asleep: DateInterval = DateInterval(start: Date(), duration: 0)
}

struct ReproductiveHealth {
    var menstrualCycles: [MenstrualCycle] = []
    var ovulationTests: [OvulationTest] = []
    var sexualActivity: [SexualActivityRecord] = []
}

struct MenstrualCycle {
    var startDate: Date = Date()
    var endDate: Date = Date()
}

struct OvulationTest {
    var date: Date = Date()
    var result: Bool = false
}

struct SexualActivityRecord {
    var date: Date = Date()
    var protected: Bool = false
}

struct UVExposure {
    var uvIndex: Int = 0 // Assuming 0 as a safe default meaning no exposure
    var uvExposureMinutes: Int = 0 // Default to no exposure
}

struct MobilityMetrics {
    var walkingSpeed: Double = 0.0 // Defaults suggesting no movement
    var stepLength: Double = 0.0
    var walkingAsymmetry: Double = 0.0
    var doubleSupportPercentage: Double = 0.0
    var stairAscentSpeed: Double = 0.0
    var stairDescentSpeed: Double = 0.0
    var sixMinuteWalkTestDistance: Double = 0.0
}

struct Symptoms {
    var symptomTypes: [SymptomType] = []
}

struct LabAndTestResults {
    var bloodGlucose: Double = 0.0 // Default values indicating no data
    var bloodOxygenSaturation: Double = 0.0
    var inhalerUsage: Int = 0
}

struct Workout {
    var type: WorkoutType = .running // Default to a common workout type
    var duration: TimeInterval = 0.0 // Indicates no duration by default
    var intensity: WorkoutIntensity = .low // Default to low intensity
    var caloriesBurned: Int = 0 // Indicates no activity
}

struct NutritionDetails {
    var carbohydrates: Double = 0.0
    var fats: Double = 0.0
    var proteins: Double = 0.0
    var vitamins: [Vitamin] = []
    var minerals: [Mineral] = []
    var waterIntake: Double = 0.0 // Default suggesting no intake
    var caffeineIntake: Double = 0.0 // Default suggesting no intake
}

struct Vitamin {
    var type: VitaminType = .vitaminA // Default to Vitamin A
    var amount: Double = 0.0 // Default amount
}

struct Mineral {
    var type: MineralType = .calcium // Default to Calcium
    var amount: Double = 0.0 // Default amount
}

enum MineralType: String {
    case calcium
    case iron
    case magnesium
    case potassium
    case zinc
    // Add more as needed
}

enum SymptomType: String, CaseIterable {
    case appetiteChanges = "Appetite Changes"
    case dizziness = "Dizziness"
    case fatigue = "Fatigue"
    case fever = "Fever"
    case headache = "Headache"
    case nausea = "Nausea"
    // Make sure it conforms to Identifiable if necessary
}


enum WorkoutIntensity: String {
    case low
    case medium
    case high
}

enum VitaminType: String {
    case vitaminA
    case vitaminC
    case vitaminD
    case vitaminE
    case vitaminK
    case vitaminB6
    case vitaminB12
    // Add more as needed
}

enum WorkoutType: String {
    case running
    case cycling
    case swimming
    case weightTraining
    case yoga
    case pilates
    // Add more as needed
}

enum BiologicalSex: String, CaseIterable {
    case male = "Male", female = "Female", other = "Other"
}


enum FitzpatrickSkinType: Int, CaseIterable {
    case typeI = 1, typeII, typeIII, typeIV, typeV, typeVI
}
