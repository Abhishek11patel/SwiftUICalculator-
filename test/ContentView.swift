import SwiftUI

struct ContentView: View {
    
    @State private var display: String = ""
    @State private var number1: String?
    @State private var number2: String?
    @State private var operatorPressed: String = ""
    @State private var result: Double?
    
    private let buttons: [[String]] = [
        ["AC", "+/-", "%", "÷"],
        ["7","8","9","×"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",".","=","C"]
    ]
    
    
    private func performOperation() {
        guard let num1 = Double(number1 ?? ""),
              let num2 = Double(number2 ?? "")
        else { return }
        
        switch operatorPressed {
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "×":
            result = num1 * num2
        case "÷":
            result = num2 == 0 ? nil : num1 / num2
        default:
            result = nil
        }
        
        if let result = result {
            display = String(result)
            number1 = nil
            number2 = nil
        } else {
            display = "error"
            number1 = nil
            number2 = nil
        }
    }
    

    private func handleOperator(_ op: String) {
        if !display.isEmpty {
            number1 = display
            operatorPressed = op
            display = ""
        }
    }
    
    
    private func show(_ button: String) {
        display += button
    }
    
    var body: some View {
        VStack {
            Text(display)
                .font(.system(size: 50))
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            switch button {
                            case "AC":
                                display = ""
                                number1 = nil
                                number2 = nil
                                operatorPressed = ""
                            case "+", "-", "×", "÷":
                                handleOperator(button)
                            case "=":
                                number2 = display
                                performOperation()
                            default:
                                show(button)
                            }
                        }) {
                            Text(button)
                                .font(.largeTitle)
                                .frame(width: 70, height: 70)
                                .background(Color.gray)
                                .cornerRadius(35)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
