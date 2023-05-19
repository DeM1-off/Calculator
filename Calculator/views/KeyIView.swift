//
//  KeyIView.swift
//  Calculator
//
//  Created by Dmitro Dohryk on 19.05.2023.
//

import SwiftUI

struct KeyIView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    @State private var changeColor = false
    
    let buttons : [[Keys]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.subtract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal]
    ]
    
    
    var body: some View {
        
        VStack{
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(changeColor ? Color("Num").opacity(0.4) :
                                        Color.pink.opacity(0.2)
                    )
                    .scaleEffect(changeColor ? 1.5: 1.0)
                    .frame(width: 350,height: 280)
                    .animation(Animation.easeOut
                        .speed(0.17).repeatForever(), value: changeColor )
                    .onAppear(perform: {
                        
                        self.changeColor.toggle()
                        
                    })
                    .overlay(
                        Text(value)
                            .bold()
                            .font(.system(size: 100))
                            .foregroundColor(.black)
                    )
            }.padding()
            ForEach(buttons, id: \.self){ row in
                HStack(spacing:10){
                    ForEach(row,id: \.self){ elem in
                        Button {
                            self.didTap(button: elem)
                        } label: {
                            Text(elem.rawValue)
                                .font(.system(size: 30))
                                .frame(width:self.getWidth(elen: elem), height: self.getHight(elen: elem))
                                .background(elem.buttonColor)
                                .foregroundColor(.black)
                                .cornerRadius(self.getWidth(elen: elem) / 2)
                                .shadow(color: .purple.opacity(0.8), radius: 30)
                        }
                    }
                }.padding(.bottom,4)
                
            }
          }
        }
    
    func getWidth(elen: Keys)-> CGFloat{
        
        if elen == .zero {
            return (UIScreen.main.bounds.width - (5*10)) / 2
        }
        return (UIScreen.main.bounds.width - (5*10)) / 4
    }
    
    func getHight(elen: Keys)-> CGFloat{
        return (UIScreen.main.bounds.width - (5*10)) / 4
    }
    
    func didTap(button: Keys){
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        
        }
    }
    
    
    
    
}

struct KeyIView_Previews: PreviewProvider {
    static var previews: some View {
        KeyIView()
    }
}
