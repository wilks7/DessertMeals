//
//  MealDetailView.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

struct MealDetailView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var model: DessertMealsModel
    
    let mealKey: MealKey
    @State var meal: Meal?
    @State private var sourceUrl: URL?
    @State private var showImage = false
    
    var body: some View {
        List {
            HStack(alignment: .top) {
                imageView
                mealHeader
            }

            instructions
        }
        .navigationTitle(mealKey.name)
        .listStyle(.plain)
        .sheet(item: $sourceUrl) { url in
            WebView(url: url)
        }
        .sheet(isPresented: $showImage){
            FullImageView(url: meal?.thumbnail)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                favoriteButton
            }
        }
        .task {
            if self.meal == nil {
                self.meal = await model.fetch(meal: self.mealKey)
            }
        }
    }
    
    @ViewBuilder
    var favoriteButton: some View {
        let isFavorited = model.favorites.map{$0.id}.contains(mealKey.id)
        Button {
            if let meal {
                if isFavorited {
                    model.remove(meal: meal)
                } else {
                    model.add(meal: meal)
                }
            }
        } label: {
            Image(systemName: isFavorited ? "star.fill" : "star")
        }
    }
    
    @ViewBuilder
    var mealHeader: some View {
        if let meal {
            VStack(alignment: .leading) {
                Text(meal.area)
                Text(meal.category)
                    .font(.title)
                if let tags = meal.tags {
                    Text(tags)
                }
                Spacer()
                HStack {
                    if let youtubeUrl = meal.youtubeURL {
                        Image(systemName: "tv")
                            .font(.largeTitle)
                            .onTapGesture {
                                openURL(youtubeUrl)
                            }
                    }
                    if let sourceUrl = meal.source {
                        Image(systemName: "link.circle.fill")
                            .font(.largeTitle)
                            .onTapGesture {
                                self.sourceUrl = sourceUrl
                            }
                    }
                }
                .padding(.bottom)
            }
        }
    }
    var imageView: some View {
        AsyncImage(url: meal?.thumbnail) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 200)
        } placeholder: {
            ProgressView()
        }
        .frame(height: 200)
        .onTapGesture {
            if let sourceImage = meal?.imageSource,
               let sourceUrl = URL(string: sourceImage) {
                openURL(sourceUrl)
            } else {
                showImage = true
            }
        }
    }
    
    @ViewBuilder
    var instructions: some View {
        if let meal, !meal.ingredients.isEmpty {
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
        }
        if let meal, !meal.instructions.isEmpty {

            Section {
                Text(meal.instructions)
            } header: {
                Text("Instructions")
            }
        }
    }

}

fileprivate struct FullImageView: View {
    let url: URL?
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                AsyncImage(url: url) { image in
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
}

extension MealDetailView {
    init(meal: Meal) {
        self.mealKey = meal.key
        self.meal = meal
    }
}


#Preview {
    NavigationView {
        MealDetailView(mealKey: .mockData)
            .environmentObject(DessertMealsModel())
    }
}
