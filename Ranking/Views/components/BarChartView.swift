//
//  BarChartView.swift
//  Ranking
//
//  Created by Mathis Fleury on 05/11/2023.
//

import SwiftUI

struct BarChartView: View {
    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                Text("one")
                Spacer()
                    .frame(width: 80.0, height: 200.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("PrimaryColor")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10.0)
            }
            VStack {
                Text("one")
                Spacer()
                    .frame(width: 80.0, height: 100.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("PrimaryColor600")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)

            }
            VStack {
                Text("one")
                Spacer()
                    .frame(width: 80.0, height: 80.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("PrimaryColor700")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)

            }
            VStack {
                Text("one")
                Spacer()
                    .frame(width: 80.0, height: 50.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("PrimaryColor800")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)

            }
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
    }
}
