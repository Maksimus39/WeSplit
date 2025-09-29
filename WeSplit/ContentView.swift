
import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    let tipPercentages = 0..<101
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Фон
                LinearGradient(
                    colors: [.blue, .purple, .indigo],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Основной контент
                VStack(spacing: 20) {
                    // Заголовок
                    Text("WeSplit")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    // Карточка с формой
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.ultraThinMaterial) // Замена для iOS 15+
                        .overlay(
                            VStack {
                                // Секция ввода суммы
                                HStack {
                                    Text("Check Amount:")
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    TextField("Amount", value: $checkAmount,
                                            format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                        .keyboardType(.decimalPad)
                                        .focused($amountIsFocused)
                                        .multilineTextAlignment(.trailing)
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                
                                // Секция количества людей
                                HStack {
                                    Text("Number of People:")
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    Picker("", selection: $numberOfPeople) {
                                        ForEach(2..<100) { number in
                                            Text("\(number)")
                                        }
                                    }
                                    .pickerStyle(.menu)
                                }
                                .padding(.horizontal)
                                
                                // Секция чаевых
                                HStack {
                                    Text("Tip Percentage:")
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    Picker("", selection: $tipPercentage) {
                                        ForEach(0..<101) { percentage in
                                            Text("\(percentage)%")
                                        }
                                    }
                                    .pickerStyle(.menu)
                                }
                                .padding(.horizontal)
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                // Результаты
                                VStack(spacing: 10) {
                                    HStack {
                                        Text("Total per person:")
                                            .foregroundStyle(.primary)
                                        Spacer()
                                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                            .fontWeight(.semibold)
                                    }
                                    
                                    HStack {
                                        Text("Total amount:")
                                        Spacer()
                                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                            .fontWeight(.semibold)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        )
                        .frame(height: 300)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    // Дополнительная карточка с информацией
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(.ultraThinMaterial) // Замена для iOS 15+
                        .overlay(
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Tip Details")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                HStack {
                                    Text("Tip Amount:")
                                    Spacer()
                                    Text(checkAmount * Double(tipPercentage) / 100, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                }
                                
                                HStack {
                                    Text("Original Amount:")
                                    Spacer()
                                    Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                }
                            }
                            .padding()
                        )
                        .frame(height: 120)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
