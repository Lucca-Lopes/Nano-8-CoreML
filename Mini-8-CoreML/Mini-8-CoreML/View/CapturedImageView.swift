

import SwiftUI

struct CapturedImageView: View {
    @EnvironmentObject var vm: ClassificationViewModel
    @Environment (\.dismiss) var dismiss
    @Environment (\.screenSize) var screenSize
    
    @State var exportedView: UIImage? = nil
    @State var expanded: Bool = false
    @State var expanded2: Bool = false
    @State var iconHeight: CGFloat = 22
        
    var body: some View {
        VStack{
            Image(uiImage: (vm.importedImage) ?? UIImage(named: "cachorro")!)
                .resizable()
                .scaledToFill()
                .frame(width: screenSize.width, height: screenSize.height * 0.5)
                .ignoresSafeArea()
            
            //view de descrição da doença do cachorro
            VStack{
                //nome da doença e acurácia
                HStack(alignment: .center){
                    Text(vm.classification)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color("labelColor"))
                    
                    Spacer()
                    
                    Text("\(vm.accuracy)%")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color("labelColor"))
                    
                    ZStack(alignment: .bottom){
                        Image(systemName: "pawprint.fill")
                            .frame(width: 22, height: vm.cgAccuracy * 0.22, alignment: .bottom)
                            .clipped()
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("labelColor"))

                        
                        Image(systemName: "pawprint")
                            .frame(width: 22, height: 22)
                            .clipped()
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("labelColor"))
                    }
                    
                }
                
                Divider()
                    .background(Color("labelColor"))
                
                    VStack(alignment: .leading){
                        //descrição
                        Text("description")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("labelColor"))
                            .padding(.vertical)
                        Text(vm.description)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(Color("labelColor"))
                            .frame(width: screenSize.width * 0.9, alignment: .topLeading)
                            .lineLimit(expanded ? nil : 5)

                        if vm.description == "healthyDescription"{
                            
                        } else if vm.description == "skinLesionDescription"{
                        } else {
                            //botão para expandir
                            Button{
                                expanded.toggle()
                            } label: {
                                Text(expanded ? "readLess" : "readMore")
                            }
                            .foregroundStyle(Color("AccentColor"))
                            .frame(width: screenSize.width * 0.9, alignment: .bottomTrailing)
                        }
                        
                        //recomendações
                        Text("recommendation")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("labelColor"))
                            .padding(.vertical)
                        
                        Text(vm.recommendation)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(Color("labelColor"))
                            .frame(width: screenSize.width * 0.9, alignment: .topLeading)
                            .lineLimit(expanded2 ? nil : 5)
                        if vm.recommendation == "healthyRecomendation"{
                            
                        } else {
                            //botão para expandir
                            Button{
                                expanded2.toggle()
                            } label: {
                                Text(expanded2 ? "readLess" : "readMore")
                            }
                            .foregroundStyle(Color("AccentColor"))
                            .frame(width: screenSize.width * 0.9, alignment: .bottomTrailing)
                        }
                    }
            }
            .padding(.horizontal)
            .frame(width: screenSize.width, height: expanded || expanded2 ? screenSize.height : screenSize.height * 0.7, alignment: .top)
            .background{
                BackgroundView()
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding(.top, expanded || expanded2 ? 0 : 250)
            }
            
            .frame(height: screenSize.height * 0.45)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    vm.importedImage = nil
                } label: {
                    Image(systemName: "chevron.backward")
                        .fontWeight(.bold)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: Image(uiImage: self.exportedView ?? UIImage()), preview: SharePreview("Teste", image: Image(uiImage: self.exportedView ?? UIImage()))){
                    Image(systemName: "square.and.arrow.up")
                        .fontWeight(.bold)
                }
                .onChange(of: self.vm.description){ newValue in
                        self.exportedView = ImageRenderer(content: self.body).uiImage!
                    }

            }
        }
        .accentColor(.white)
    }
}
