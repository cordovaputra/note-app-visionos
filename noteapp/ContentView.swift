import SwiftUI
import RealityKit
import RealityKitContent

struct Note: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

class NoteStore: ObservableObject {
    @Published var notes = [Note]()
}

struct ContentView: View {
    @ObservedObject var noteStore = NoteStore()
    @State private var showingAddNote = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(noteStore.notes) { note in
                    NavigationLink(destination: DetailView(note: note)) {
                        Text(note.title)
                    }
                }
                .onDelete(perform: delete)

            }
            .navigationBarItems(trailing: HStack{
                Image("cordova")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

            })
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddNote = true
            }) {
                Group {
                    Image(systemName: "plus")
                }
            })
            

            .sheet(isPresented: $showingAddNote) {
                AddNoteView(noteStore: self.noteStore)
            }
            
            .padding(.top, 10)
        }
    }
    func delete(at offsets: IndexSet) {
        noteStore.notes.remove(atOffsets: offsets)
    }
}

struct DetailView: View {
    let note: Note
    
    var body: some View {
        
        VStack {
            Text(note.title)
                .font(.title)
            Text(note.content)
                .padding()
            Spacer()
                
        }
    }
}

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var noteStore: NoteStore
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("What's the title?", text: $title)
                TextField("Share your thoughts here", text: $content)
            }
            .navigationBarTitle("New Note")
            .navigationBarItems(trailing: Button(action: {
                self.noteStore.notes.append(Note(title: self.title, content: self.content))
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            })
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
        }
    }
}

#Preview {
    ContentView()
}
