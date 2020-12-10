//
//  ActionView.swift
//  betterCalculator
//
//  Created by Anthony Protho on 12/10/20.
//

import SwiftUI

struct ActionView: View {
    let button: CalculatorButton
    @Binding var state: CalculationState
    
    var body: some View {
        Button(action: {
            //what happens when this is tapped
            self.tapped()
        }, label: {
            Text(button.rawValue)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                .background(button.backgroundColor)
                .cornerRadius(buttonHeight())
        })
    }
    func buttonHeight() ->CGFloat{
        return (UIScreen.main.bounds.width - 5 * 10)/4
    }
    
    func buttonWidth(button:CalculatorButton) -> CGFloat{
        if button == .zero{
            return (UIScreen.main.bounds.width - 4 * 10)/4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 10)/4
    }
    
    func tapped(){
        switch button {
        case .ac:
            state.currentNumber = 0
            state.storedNumber = nil
            state.storedAction = nil
        case .equals:
            guard let storedAction = state.storedAction else { return}
            guard let storedNumber = state.storedNumber else { return}
            guard let result = storedAction.calculate(storedNumber, state.currentNumber) else {
                return
            }
            state.currentNumber = result
            state.storedNumber = nil
            state.storedAction = nil
            break
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
            if let number = Double(button.rawValue){
                state.appendNumber(number)
            }
        case.dot:
            //Not supported yet
            break
        case .percent:
            //Not supported yet
            break
        default:
            state.storedNumber = state.currentNumber
            state.currentNumber = 0
            state.storedAction = button
            break
        }
    }
}





mutating func appendNumber(_ number: Double){
        if number.truncatingRemainder(dividingBy: 1) == 0 && currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
            currentNumber = 10 * currentNumber + number
            print("The current number is: \(currentNumber)")
        }
        else {
            currentNumber = number
        }
    }
}

import SwiftUI

enum CalculatorButton: String{
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case equals = "="
    case plus = "+"
    case minus = "-"
    case multiply = "×"
    case divide = "÷"
    case ac = "AC"
    case plusMinus = "+/-"
    case percent = "%"
    case dot = "."
    
    var backgroundColor: Color{
        switch self {
        case .equals, .plus, .minus, .multiply, .divide:
            return Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        case .ac, .plusMinus, .percent:
            return Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        }
    }
}

struct ContentView: View {

    let buttonOptions: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equals]
    ]
    var body: some View {
        VStack(spacing:10){
            HStack{
                Spacer()
                Text("0")
                    .font(.largeTitle)
            }
            ForEach(buttonOptions, id: \.self){ row in
                HStack{
                    ForEach(row, id:\.self){ button in
                        Button(action: {}, label: {
                            Text(button.rawValue)
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                                .background(button.backgroundColor)
                                .cornerRadius(buttonHeight())
                        })
                    }
                }
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom).padding(10)
    }
    
    func buttonHeight() ->CGFloat{
        return (UIScreen.main.bounds.width - 5 * 10)/4
    }
    
    func buttonWidth(button:CalculatorButton) -> CGFloat{
        if button == .zero{
            return (UIScreen.main.bounds.width - 4 * 10)/4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 10)/4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
