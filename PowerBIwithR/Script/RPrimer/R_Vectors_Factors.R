# Using Factors...

statef <- as.factor(c("RI", "MA", "CT", "ME", "VT", "NH"))
statef

# Contrast factors with Character vectors...
statecode <- c("RI", "MA", "CT", "RI", "ME", "ME", "VT", "NH")
statecode

# Duplicates removed, levels are sorted...
statef <- as.factor(c("RI", "MA", "CT", "RI", "ME", "ME", "VT", "NH"))
statef

str(iris)  # Shows Species is a Factor

# Let's do a bar plot on the frequency by species
count_by_species <- table(iris$Species)  # table value frequency
count_by_species

barplot(count_by_species, col= c("red", "blue", "green"))




