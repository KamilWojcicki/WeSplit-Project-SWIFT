//
//  ContentView.swift
//  WeSplit
//
//  Created by Kamil Wójcicki on 25/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    //ta zmienna pozwoli nam schować klawiaturę po wpisaniu odpowiedniej wartości.
    @FocusState private var amoutIsFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandValue = checkAmount + tipValue
        let amountPerPerson = grandValue / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View{
        NavigationView{
            Form{
                Section{
                    //jeśli chcemy aby użytkownik wprowadził nie string tylko np liczbę, w tym przypadku gotówkę
                    TextField("Amount", value: $checkAmount, format:
                        .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                    //jeśli chcemy użyć klawiatury numerycznej uzywamy funkcji:
                    .keyboardType(.decimalPad)
                        .focused($amoutIsFocused)
                    //dodajemy wybór ilość osób
                    Picker("Number of people: ", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                //segmented control for tip percentage
                Section{
                    Picker("Tip percentage:", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            //format: procent
                            Text($0, format: .percent)
                        }
                    }
                    //umieszczenie wyboru w segmentach
                    .pickerStyle(.segmented)
                }header: {
                    Text("How much tip do you want to leave")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                }header: {
                    Text("Total amount per person")
                }
            }
            .navigationTitle("We split")
            //ta funkcja pozwoli nam zasłonić klawiaturę poprzez kliknięcie w przycisk Done
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amoutIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
