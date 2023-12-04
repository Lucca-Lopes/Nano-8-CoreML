//
//  LiveCamView.swift
//  Mini-8-CoreML
//
//  Created by Lucca Lopes on 29/11/23.
//

import SwiftUI

struct LiveCamView: View {
    @EnvironmentObject var vm : ClassificationViewModel
    var body: some View {
        ZStack{
            HostedViewController()
                .environmentObject(vm)
            VStack{
                HStack {
                    Text(vm.classification)
                    Text(" - ")
                    Text("\(vm.accuracy)%")
                }
                Button {
                    vm.canTakeImageDelegate?.setPhoto(canTakePhoto: true)
                } label: {
                    Image(systemName: "photo.stack")
                }
            }
            
        }
            .ignoresSafeArea()
    }
}
