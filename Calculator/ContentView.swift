//
//  ContentView.swift
//  Calculator
//
//  Created by 陳冠甫 on 2022/11/25.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine, dot
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent
    
    var bgColor: Color {
        switch self {
        case .zero:
            return Color(.darkGray)
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return Color(.orange)
        }
    }
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .dot: return "."
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .ac: return "AC"
        case .plusMinus: return "±"
        case .percent: return "%"
        }
    }
}

// Env objects
class GlobalEnvironment: ObservableObject {
    @Published var display = "0"
    
    func recieveInput(_ calculatorButton: CalculatorButton) {
        self.display = calculatorButton.title
    }
}

struct ContentView: View {
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equals]
    ]
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            CalculatorButtonView(button: item)
                        }
                    }
                }
            }
        }
    }
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button {
            self.env.recieveInput(button)
            // TODO: do the calculation
        } label: {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button), height: (UIScreen.main.bounds.width - 12 * 5) / 4, alignment: .center)
                .foregroundColor(.white)
                .background(button.bgColor)
                .cornerRadius(self.buttonWidth(button) / 2)
        }
    }
    
    private func buttonWidth(_ button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 12 * 4) / 2
        }
        return (UIScreen.main.bounds.width - 12 * 5) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
