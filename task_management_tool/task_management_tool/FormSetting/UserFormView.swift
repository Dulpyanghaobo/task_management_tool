//
//  UserFormView.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import SwiftUI

struct UserFormView: View {
    @State private var userInfo = UserInfo()

    var body: some View {
        NavigationView {
            Form {
                BasicInformationSection(basicInformation: $userInfo.basicInformation)
                VitalsSection(vitals: $userInfo.vitals)
                FitnessAndActivitySection(fitnessAndActivity: $userInfo.fitnessAndActivity)
                NutritionSection(nutrition: $userInfo.nutrition)
                MindfulnessSection(mindfulness: $userInfo.mindfulnessAndStressReduction)
                UVExposureSection(uvExposure: $userInfo.uvExposure)
                LabResultsSection(labResults: $userInfo.labAndTestResults)
                SleepSection(sleep: $userInfo.sleep)
                ReproductiveHealthSection(reproductiveHealth: $userInfo.reproductiveHealth)
                MobilityMetricsSection(mobilityMetrics: $userInfo.mobilityMetrics)
                SymptomsSection(symptoms: $userInfo.symptoms)
                Button("Save", action: {
                })
            }
            .navigationBarTitle("Health Profile", displayMode: .inline)
        }
    }
}

struct BasicInformationSection: View {
    @Binding var basicInformation: BasicInformation
    
    var body: some View {
        Section(header: Text("Basic Information")) {
            HStack {
                Text("Height (cm)")
                    .padding(.leading, 0)
                TextField("", value: $basicInformation.height, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Weight (kg)")
                    .padding(.leading, 0) // 同上
                Spacer() // 同上
                TextField("", value: $basicInformation.weight, format: .number)
                    .keyboardType(.decimalPad) // 同上
                    .multilineTextAlignment(.trailing) // 同上
            }
            DatePicker("Date of Birth", selection: $basicInformation.dateOfBirth, displayedComponents: .date)
            Picker("Biological Sex", selection: $basicInformation.biologicalSex) {
                ForEach(BiologicalSex.allCases, id: \.self) { sex in
                    Text(sex.rawValue.capitalized).tag(sex)
                }
            }

            Picker("Skin Type", selection: $basicInformation.fitzpatrickSkinType) {
                ForEach(FitzpatrickSkinType.allCases, id: \.self) { type in
                    Text("Type \(type.rawValue)").tag(type)
                }
            }

        }
    }
}

// Placeholder view for Vitals section
struct VitalsSection: View {
    @Binding var vitals: Vitals
    
    var body: some View {
        Section(header: Text("Vitals")) {
            HStack {
                Text("Blood Pressure")
                    .padding(.leading, 0)
                TextField("", value: $vitals.bloodPressure.systolic, format: .number)
                    .keyboardType(.numberPad)
                    .frame(minWidth: 0, maxWidth: 80, alignment: .trailing).multilineTextAlignment(.trailing)
                Text("/")
                TextField("", value: $vitals.bloodPressure.diastolic, format: .number)
                    .keyboardType(.numberPad)
                    .frame(minWidth: 0, maxWidth: 80, alignment: .trailing).multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Body Temperature (°C)")
                Spacer() // Pushes content to the right
                TextField("", value: $vitals.bodyTemperature, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing) // Aligns text to the right within the TextField
                    // Ensure there's no extra padding here that might push the TextField away from the edge
            }

            HStack {
                Text("Respiratory Rate (breaths/min)")
                Spacer() // Pushes content to the right
                TextField("", value: $vitals.respiratoryRate, format: .number)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing) // Aligns text to the right within the TextField
                    // Same here, ensure no unnecessary padding
            }

            // ECG Samples might require a different UI approach, considering it's an array of Double
        }
    }
}


// Placeholder view for Fitness and Activity section
struct FitnessAndActivitySection: View {
    @Binding var fitnessAndActivity: FitnessAndActivity
    
    var body: some View {
        Section(header: Text("Fitness and Activity")) {
            HStack {
                Text("Steps")
                TextField("", value: $fitnessAndActivity.steps, format: .number)
                    .keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Distance Walked/Run (km)")
                TextField("", value: $fitnessAndActivity.distanceWalkedOrRun, format: .number)
                    .keyboardType(.decimalPad).multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Flights Climbed")
                TextField("", value: $fitnessAndActivity.flightsClimbed, format: .number)
                    .keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Exercise Minutes")
                TextField("", value: $fitnessAndActivity.exerciseMinutes, format: .number)
                    .keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Stand Hours")
                TextField("", value: $fitnessAndActivity.standHours, format: .number)
                    .keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Activity Energy (Active Calories)")
                TextField(")", value: $fitnessAndActivity.activityEnergy, format: .number)
                    .keyboardType(.numberPad).multilineTextAlignment(.trailing)
            }
        }
    }
}

struct NutritionSection: View {
    @Binding var nutrition: Nutrition
    
    var body: some View {
        Section(header: Text("Nutrition")) {
            TextField("Dietary Energy (Calories Consumed)", value: $nutrition.dietaryEnergy, format: .number)
                .keyboardType(.numberPad)
            TextField("Water Intake (L)", value: $nutrition.waterIntake, format: .number)
                .keyboardType(.decimalPad)
            TextField("Caffeine Intake (mg)", value: $nutrition.caffeineIntake, format: .number)
                .keyboardType(.decimalPad)
            // Navigation to NutritionDetails editing could go here
        }
    }
}

struct MindfulnessSection: View {
    @Binding var mindfulness: MindfulnessAndStressReduction
    
    var body: some View {
        Section(header: Text("Mindfulness and Stress Reduction")) {
            TextField("Mindful Minutes", value: $mindfulness.mindfulMinutes, format: .number)
                .keyboardType(.numberPad)
            TextField("Stress Level", value: $mindfulness.stressLevel, format: .number)
                .keyboardType(.numberPad)
        }
    }
}

struct UVExposureSection: View {
    @Binding var uvExposure: UVExposure
    
    var body: some View {
        Section(header: Text("UV Exposure")) {
            TextField("UV Index", value: $uvExposure.uvIndex, format: .number)
                .keyboardType(.numberPad)
            TextField("UV Exposure Minutes", value: $uvExposure.uvExposureMinutes, format: .number)
                .keyboardType(.numberPad)
        }
    }
}

struct LabResultsSection: View {
    @Binding var labResults: LabAndTestResults
    
    var body: some View {
        Section(header: Text("Lab and Test Results")) {
            TextField("Blood Glucose (mg/dL)", value: $labResults.bloodGlucose, format: .number)
                .keyboardType(.decimalPad)
            TextField("Blood Oxygen Saturation (%)", value: $labResults.bloodOxygenSaturation, format: .number)
                .keyboardType(.decimalPad)
            TextField("Inhaler Usage", value: $labResults.inhalerUsage, format: .number)
                .keyboardType(.numberPad)
            // Additional fields as needed
        }
    }
}

struct SleepPeriodView: View {
    @Binding var sleepPeriod: SleepPeriod
    
    var body: some View {
        DatePicker("In Bed", selection: $sleepPeriod.inBed.start, displayedComponents: .date)
        DatePicker("Asleep", selection: $sleepPeriod.asleep.start, displayedComponents: .date)
        // Additional logic for duration if needed
    }
}

struct SleepSection: View {
    @Binding var sleep: Sleep

    var body: some View {
        Section(header: Text("Sleep")) {
            ForEach(Array(zip(sleep.sleepAnalysis.indices, sleep.sleepAnalysis)), id: \.0) { index, period in
                NavigationLink(destination: SleepPeriodView(sleepPeriod: $sleep.sleepAnalysis[index])) {
                    Text("Period \(index + 1)")
                }
            }
            .onDelete(perform: deleteSleepPeriod)
            
            Button("Add Sleep Period") {
                addSleepPeriod()
            }
        }
    }
    
    private func addSleepPeriod() {
        sleep.sleepAnalysis.append(SleepPeriod())
    }
    
    private func deleteSleepPeriod(at offsets: IndexSet) {
        sleep.sleepAnalysis.remove(atOffsets: offsets)
    }
}

struct ReproductiveHealthSection: View {
    @Binding var reproductiveHealth: ReproductiveHealth

    var body: some View {
        Section(header: Text("Reproductive Health")) {
            NavigationLink(destination: MenstrualCyclesView(menstrualCycles: $reproductiveHealth.menstrualCycles)) {
                Text("Menstrual Cycles")
            }
            NavigationLink(destination: OvulationTestsView(ovulationTests: $reproductiveHealth.ovulationTests)) {
                Text("Ovulation Tests")
            }
            // Additional sub-sections as needed
        }
    }
}

// Placeholder views for sub-sections
struct MenstrualCyclesView: View {
    @Binding var menstrualCycles: [MenstrualCycle]
    // Implementation similar to SleepSection for listing and editing cycles
    var body: some View { Text("Menstrual Cycles Placeholder") }
}

struct OvulationTestsView: View {
    @Binding var ovulationTests: [OvulationTest]
    // Similar implementation for listing and editing tests
    var body: some View { Text("Ovulation Tests Placeholder") }
}

struct MobilityMetricsSection: View {
    @Binding var mobilityMetrics: MobilityMetrics

    var body: some View {
        Section(header: Text("Mobility Metrics")) {
            TextField("Walking Speed (m/s)", value: $mobilityMetrics.walkingSpeed, format: .number)
                .keyboardType(.decimalPad)
            TextField("Step Length (m)", value: $mobilityMetrics.stepLength, format: .number)
                .keyboardType(.decimalPad)
            TextField("Walking Asymmetry (%)", value: $mobilityMetrics.walkingAsymmetry, format: .number)
                .keyboardType(.decimalPad)
            TextField("Double Support Percentage (%)", value: $mobilityMetrics.doubleSupportPercentage, format: .number)
                .keyboardType(.decimalPad)
            TextField("Stair Ascent Speed (steps/min)", value: $mobilityMetrics.stairAscentSpeed, format: .number)
                .keyboardType(.numberPad)
            TextField("Stair Descent Speed (steps/min)", value: $mobilityMetrics.stairDescentSpeed, format: .number)
                .keyboardType(.numberPad)
            TextField("Six-Minute Walk Test Distance (m)", value: $mobilityMetrics.sixMinuteWalkTestDistance, format: .number)
                .keyboardType(.decimalPad)
        }
    }
}

struct SymptomsSection: View {
    @Binding var symptoms: Symptoms
    let allSymptoms: [SymptomType] = [.appetiteChanges, .dizziness, .fatigue, .fever, .headache, .nausea] // Example symptom types

    var body: some View {
        Section(header: Text("Symptoms")) {
            ForEach(allSymptoms, id: \.self) { symptom in
                Button(action: {
                    toggleSymptom(symptom)
                }) {
                    HStack {
                        Text(symptom.rawValue)
                        Spacer()
                        if symptoms.symptomTypes.contains(symptom) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
    }

    private func toggleSymptom(_ symptom: SymptomType) {
        if let index = symptoms.symptomTypes.firstIndex(of: symptom) {
            symptoms.symptomTypes.remove(at: index)
        } else {
            symptoms.symptomTypes.append(symptom)
        }
    }
}
