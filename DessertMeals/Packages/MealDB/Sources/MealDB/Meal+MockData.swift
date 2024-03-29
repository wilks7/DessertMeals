//
//  Meal+Mock.swift
//
//
//  Created by Michael Wilkowski on 2/6/24.
//

import Foundation

public extension Meal {
    static var mockData: Meal {
        .init(
            id: "52772",
            name: "Teriyaki Chicken Casserole",
            drinkAlternate: nil,
            category: "Chicken",
            area: "Japanese",
            instructions: """
                Preheat oven to 350°F. Spray a 9x13-inch baking pan with non-stick spray.
                Combine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.
                Meanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.
                Place the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.
                *Meanwhile, steam or cook the vegetables according to package directions.
                Add the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!
                """,
            thumbnail: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"),
            tags: "Meat,Casserole",
            youtubeURL: URL(string: "https://www.youtube.com/watch?v=4aZr5hZXP_s"),
            ingredients: ["soy sauce", "water", "brown sugar", "ground ginger", "minced garlic", "cornstarch", "chicken breasts", "stir-fry vegetables", "brown rice"].filter { !$0.isEmpty },
            measures: ["3/4 cup", "1/2 cup", "1/4 cup", "1/2 teaspoon", "1/2 teaspoon", "4 Tablespoons", "2", "1 (12 oz.)", "3 cups"].filter { !$0.isEmpty },
            source: nil,
            imageSource: nil,
            creativeCommonsConfirmed: nil,
            dateModified: nil
        )
    }
}

public extension MealKey {
    static var mockData: MealKey {
        .init(id: "52772", name: "Teriyaki Chicken Casserole", thumbnail: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"))
    }
}
