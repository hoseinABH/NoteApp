//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by hosein on 5/11/1401 AP.
//

import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    @AppStorage("lineCount") var lineCount : Int = 1
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Saving data has faild!")
        }
    }
    
    func load(){
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch  {
                print("")
            }
        }
    }
    
    func delete(offsets:IndexSet){
        withAnimation{
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 6) {
                TextField("Add new note" , text:$text)
                Button{
                    guard text.isEmpty == false else {return}
                    
                    let note = Note(id: UUID(), text: text)
                    
                    notes.append(note)
                    
                    text = ""
                    
                    save()
                     
                }label:{
                    Image(systemName: "plus.circle").font(.system(size: 42, weight:.semibold))
            }
            .fixedSize()
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.accentColor)
            }
        
            Spacer()
            
            if notes.count>=1 {
                List {
                    ForEach(0..<notes.count,id:\.self){ i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                            HStack {
                                Capsule().frame(width: 4).foregroundColor(.accentColor)
                                Text(notes[i].text).lineLimit(lineCount).padding(.leading, 5)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .opacity(0.2)
                .padding(25)
                Spacer()
            }
        }
        .navigationTitle("Notes")
        .onAppear(perform: {
            load()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
