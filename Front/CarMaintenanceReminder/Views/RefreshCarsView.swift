//
//  RefreshCarsView.swift
//  MaintenanceReminder
//
//  Created by YASSINE on 13/7/2023.
//

import SwiftUI

struct RefreshCarsView: View {
    @State var refresh = false
    var body: some View {
        NavigationStack{
            ZStack{
                Image(systemName: "slowmo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }.onAppear(){
                refresh = true
            }
            .navigationDestination(isPresented: $refresh) {
                CarsView()
            }
        }
    }
}

struct RefreshCarsView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshCarsView()
    }
}
