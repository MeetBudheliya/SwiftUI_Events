//
//  ContentView.swift
//  Animations
//
//  Created by Adsum MAC 1 on 05/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var hidden = false
    var isHide = false
    @State private var opacity = 0.0
    
    @State private var hasOffset = false
    @State private var hasOffsett = false
    
    @Namespace private var animation
    @State private var isFlipped = false
    
    @State private var data = (1...10).map { "Item \($0)" }
    
    @State private var ScrollData = (1...25).map { "Scroll \($0)" }
    
    @State private var TapData = (1...25).map { "Tap \($0)" }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .center, spacing: 20){
                    
                    VStack{
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .center)
                        Button("Tap Me") {
                            if isHide{
                                self.hidden = false
                                self.opacity = 1.0
                            }else{
                                self.opacity = 0.25
                                self.hidden = true
                            }
                            
                        }
                        .opacity(hidden ? opacity : 1)
                        .animation(.easeInOut(duration: 2))
                        
                        Button("Tap Me") {
                            withAnimation(.interactiveSpring()){
                                self.hasOffset.toggle()
                            }
                        }
                        .offset(y: hasOffset ? 50 : 0)
                        
                        Button("Tap Me") {
                            withAnimation(.interpolatingSpring(
                                            mass: 1,
                                            stiffness: 80,
                                            damping: 4,
                                            initialVelocity: 0)) {
                                self.hasOffsett.toggle()
                            }
                        }
                        .offset(y: hasOffsett ? 50 : 0)
                        
                    }
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .center)
                    
                    HStack {
                        if isFlipped {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 50, height: 50)
                                .matchedGeometryEffect(id: "Shape", in: animation)
                            Text("Tap me")
                                .matchedGeometryEffect(id: "Text", in: animation)
                        } else {
                            Text("Tap me")
                                .matchedGeometryEffect(id: "Text", in: animation)
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 50, height: 50)
                                .matchedGeometryEffect(id: "Shape", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            self.isFlipped.toggle()
                        }
                    }
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    VStack{
                        
                        ScrollViewReader{ Scroll in
                            ScrollView(.horizontal, showsIndicators: false){
                                VStack(alignment: .leading, spacing: 10){
                                    HStack{
                                        Button("Scroll") {
                                            withAnimation{
                                                Scroll.scrollTo(ScrollData.last!)
                                            }
                                        }
                                        ForEach(ScrollData, id: \.self) { Text("\($0)"); Divider()
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        ScrollViewReader{ Scroll in
                            ScrollView(.horizontal, showsIndicators: false){
                                VStack(alignment: .leading, spacing: 10){
                                    HStack{
                                        Button("Scroll") {
                                            withAnimation{
                                                Scroll.scrollTo(TapData.last!)
                                            }
                                        }
                                        ForEach(TapData, id: \.self) { item in
                                            Button(item) {
                                                print("\(item)")
                                                if item != TapData.last{
                                                    Scroll.scrollTo(TapData[TapData.firstIndex(of: item)!+1])
                                                }
                                               
                                            }
                                            Divider()
                                        }
                                    }
                                    
                                }
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .center)
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.fixed(UIScreen.main.bounds.width))], spacing: 20) {
                                ForEach(data, id: \.self) { item in
                                    HStack{
                                        Text(item)
                                        Button("Delete") {
                                            print("Delete")
                                            delete(at: [ data.firstIndex(of: item) ?? 0])
                                        }
                                    }
                                }
                            }
                            
                            .padding(.horizontal)
                        }
                        
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .center)
                    }
                    
                    NavigationLink(
                        destination: DetailView(),
                        label: {
                            Text("Navigation")
                        })
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .onAppear {
                        print("ContentView appeared!")
                    }
                    .onDisappear {
                        print("ContentView disappeared!")
                    }
                    
                
            }
            .navigationTitle("Testing Screen")
        }
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
    
    func delete(at offsets: IndexSet) {
        data.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
