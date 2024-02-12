//
//  MealCell.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import SwiftUI
import MealDB

struct MealCell: View {
    let name: String
    let thumbnail: URL?
    var size: CGFloat = 50

    var body: some View {
        HStack {
            AsyncImage(
                url: thumbnail,
                content: { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: size, maxHeight: size)
                },
                placeholder: {
                    ProgressView()
                }
            )
            .frame(width: size, height: size)
            Text(name.capitalized)
                .fontWeight(.semibold)
        }
    }
}
extension MealCell {
    init(meal: Meal, size: CGFloat = 50) {
        self.thumbnail = meal.thumbnail
        self.name = meal.name
        self.size = size
    }
    
    init(mealKey meal: MealKey, size: CGFloat = 50) {
        self.thumbnail = meal.thumbnail
        self.name = meal.name
        self.size = size
    }
}

#Preview {
    MealCell(meal: .mockData)
}
