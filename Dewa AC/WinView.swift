//
//  WinView.swift
//  Dewa AC
//
//  Created by Nindya Alita Rosalia on 04/04/23.
//

import SwiftUI

struct WinView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color("blue back"))
                .frame(width: 500, height: 350)
                .cornerRadius(20)
                .padding(.top, 30.0)
            
            VStack{
                Text("Yeyyy kamu berhasil menemukan gambar ayam")
                    .font(.custom("SFCompactRounded-Semibold", size: 18))
                    .foregroundColor(.white)
                Image("Bitmap")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
            }
        }
        .background(Image("bg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .opacity(0.5)
        )
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()
    }
}
