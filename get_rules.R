# read in data
trans = read.transactions("mydata.csv", format = "single", sep = ";", cols = c("transactionID", "productID"), encoding = "UTF-8")
 
# run apriori algorithm
rules = apriori(trans, parameter = list(supp = 0.005, conf = 0.001, minlen = 2))
 
# sort rules by lift
rules = sort(rules, by = "lift", decreasing = T)
 
# print out rules to console
inspect(rules)
 
# remove redundant rules
subset.matrix = is.subset(rules,rules)
subset.matrix[lower.tri(subset.matrix,diag=T)] = 1
rules = rules[!redundant]
 
# write to df
ruledf = data.frame(
 lhs = labels(lhs(rules)),
 rhs = labels(rhs(rules)),
 rules@quality)
 
# filter rules on specific product
ruledf = filter(ruledf, lhs == "{Product_183}")
