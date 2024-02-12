//
//  MealDetailViewLarge.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

struct MealDetailViewLarge: View {
    let meal: Meal
    @State private var sourceUrl: URL?

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                AsyncImage(url: meal.thumbnail) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            }
            ScrollView(.vertical) {
                Rectangle().fill(Color.clear).frame(height: proxy.size.width)
                VStack {
                    HStack(alignment: .top) {
                        Text(meal.name)
                            .font(.largeTitle)
                        Spacer()
                        HStack {
                            if let youtubeUrl = meal.youtubeURL {
                                Link(destination: youtubeUrl) {
                                    Image(systemName: "tv")
                                        .font(.title)
                                }
                            }
                            if let sourceUrl = meal.source {
                                Button {
                                    self.sourceUrl = sourceUrl
                                } label: {
                                    Image(systemName: "link.circle.fill")
                                        .font(.title)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    VStack(alignment: .leading) {
                        Text(meal.area)
                            .font(.title)
                        HStack {
                            Text(meal.category)
                            Spacer()
                            Text(meal.tags)
                        }
                    }
                    .padding(.bottom)
                    Section {
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
                            Divider()
                        }
                    } header: {
                        HStack {
                            Text("Ingredients")
                            Spacer()
                        }
                        .font(.title2.bold())
                        .padding(.bottom, 6)
                    }
                    Section {
                        Text(meal.instructions)
                    } header: {
                        HStack {
                            Text("Instructions")
                            Spacer()
                        }
                        .font(.title2.bold())
                        .padding(.bottom, 6)
                    }
                    .padding(.top, 6)
                }
                .padding(.horizontal)
                .background(Color.white)
                
            }
        }
        .padding(.top, 1) // padding needed to fix scroll view bug

    }
}

#Preview {
    MealDetailViewLarge(meal: .mockData)
}
