//
//  HotelsView.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import SwiftUI

struct HotelsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var h1 = false
    @State private var h2 = false
    @State private var h3 = false
    @State private var h4 = false
    @State private var h5 = false
    @State private var h6 = false
    @State private var h7 = false
    @State private var h8 = false
    @StateObject private var commentsManager = CommentsManager()
    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack {
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image("tabler-icon-arrow-narrow-left")
                    })
                    .padding(.leading, 20)
                    
                    Image("Frame 8")
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding(.top, 50)
                ScrollView{
                    HStack{
                        Button(action: {
                            h1.toggle()
                        }, label: {
                            Image("Frame 22")
                        })
                        Button(action: {
                            h2.toggle()
                        }, label: {
                            Image("Frame 23")
                        })
                    }
                    
                    HStack{
                        Button(action: {
                            h3.toggle()
                        }, label: {
                            Image("Frame 24")
                        })
                        Button(action: {
                            h4.toggle()
                        }, label: {
                            Image("Frame 25")
                        })
                    }
                    
                    HStack{
                        Button(action: {
                            h5.toggle()
                        }, label: {
                            Image("Frame 26")
                        })
                        Button(action: {
                            h6.toggle()
                        }, label: {
                            Image("Frame 27")
                        })
                    }
                    
                    HStack{
                        Button(action: {
                            h7.toggle()
                        }, label: {
                            Image("Frame 28")
                        })
                        Button(action: {
                            h8.toggle()
                        }, label: {
                            Image("Frame 29")
                        })
                    }
                }.padding(.top,20)
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(Image("hotels")).ignoresSafeArea()
                .fullScreenCover(isPresented: $h1, content: {
                    Hotel1View().environmentObject(commentsManager)
                })
                .fullScreenCover(isPresented: $h2, content: {
                    Hotel2View().environmentObject(commentsManager)
                })
                .fullScreenCover(isPresented: $h3, content: {
                    Hotel3View().environmentObject(commentsManager)
                })
                .fullScreenCover(isPresented: $h4, content: {
                    Hotel4View().environmentObject(commentsManager)
                })
                .fullScreenCover(isPresented: $h5, content: {
                    Hotel5View().environmentObject(commentsManager)
                })
                .fullScreenCover(isPresented: $h6, content: {
                    Hotel6View().environmentObject(commentsManager)
                })
                .fullScreenCover(isPresented: $h7, content: {
                    Hotel7View().environmentObject(commentsManager)
                })
                .fullScreenCover(isPresented: $h8, content: {
                    Hotel8View().environmentObject(commentsManager)
                })
        }
    }
}

#Preview {
    HotelsView()
}
