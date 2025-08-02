//
//  LoginView.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import SwiftUI

struct LoginView: View {
    //    @StateObject var vm = ContentViewModel()
    @ObservedObject var metaMaskRepo: MetaMaskRepo
    @State private var status = "Offline"
    
    var body: some View {
        VStack {
            
            Image("eth")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .padding()
                .background(Circle().foregroundColor(.white))
                .shadow(radius: 10)
                .padding()
                .background(Color.white)
            
            Text("VOTE-INATOR 3000")
                .font(.title)
                .fontWeight(.bold)
            
            
            Text("A decentralized voting app")
                .font(.title2)
                .opacity(0.8)
                .padding(.bottom, 30)
            
            
            Button {
                Task { await metaMaskRepo.connectToDapp() }
            } label: {
                HStack {
                    Image("metamask")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding(.leading)
                    
                    Text("Connect to MetaMask")
                        .font(.title2)
                        .padding([.vertical, .trailing])
                        .padding(.leading, 6)
                        .fixedSize(horizontal: true, vertical: true)
                    
                }
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
        }
        .padding()

    }
}
