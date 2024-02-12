//
//  MealDetailView.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

struct MealDetailView: View {
    @AppStorage("favorites") var favoriteData: Data = Data()

    @Environment(\.openURL) var openURL

    let meal: Meal
    @State private var sourceUrl: URL?
    @State private var showImage = false
    
    var favoriteMeals: [String]? {
        try? JSONDecoder().decode([String].self, from: favoriteData)
    }
    
    var isFavorited: Bool {
        favoriteMeals?.contains(meal.id) ?? false
    }
    
    var body: some View {
        List {
            Text(meal.name)
                .font(.largeTitle)
            HStack(alignment: .top) {
                AsyncImage(url: meal.thumbnail) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .onTapGesture {
                    if let sourceImage = meal.imageSource,
                       let sourceUrl = URL(string: sourceImage) {
                        openURL(sourceUrl)
                    } else {
                        showImage = true
                    }
                }
                VStack(alignment: .leading) {
                    Text(meal.area)
                    Text(meal.category)
                        .font(.title)
                    Text(meal.tags)
                    Spacer()
                    HStack {
                        if let youtubeUrl = meal.youtubeURL {
                            Button {
                                openURL(youtubeUrl)
                            } label: {
                                Image(systemName: "tv")
                                    .font(.largeTitle)
                            }
                        }
                        if let sourceUrl = meal.source {
                            Button {
                                self.sourceUrl = sourceUrl
                            } label: {
                                Image(systemName: "link.circle.fill")
                                    .font(.largeTitle)
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }

            Section {
//                VStack(alignment: .leading){
                    ForEach(Array(meal.ingredients.indices), id: \.self) { index in
                        HStack {
                            Text(String(index + 1) + ".")
                            Text(meal.ingredients[index].capitalized(with: .current))
                            Spacer()
                            if index < meal.measures.count {
                                Text(meal.measures[index])
                            } else {
                                Text("N/A")
                            }
                        }
//                    }
                }
            } header: {
                Text("Ingredients")
            }
            
            Section {
                Text(meal.instructions)
            } header: {
                Text("Instructions")
            }


        }
        .listStyle(.plain)
        .sheet(item: $sourceUrl) { url in
            WebView(url: url)
        }
        .sheet(isPresented: $showImage){
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    AsyncImage(url: meal.thumbnail) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: proxy.size.width)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: proxy.size.width)
                    Spacer()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    starTapped(favoriteMeals)
                } label: {
                    Image(systemName: isFavorited ? "star.fill" : "star")
                }
            }
        }
    }
    
    private func starTapped(_ favoriteMeals: [String]?){
        guard let favoriteMeals else {
            save(favorites: [meal.id])
            return
        }
        var _favorites: [String] = favoriteMeals
        
        if _favorites.contains(meal.id) {
            _favorites.removeAll{$0 == meal.id}
        } else {
            _favorites.append(meal.id)
        }
        save(favorites: _favorites)

    }
    
    private func save(favorites: [String]) {
        if let favoriteData = try? JSONEncoder().encode(favorites) {
            self.favoriteData = favoriteData
        }
    }
}



#Preview {
    NavigationStack {
        MealDetailView(meal: .mockData)
    }
}
