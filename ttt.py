numbers = [2, 5, 13, 7, 6, 4]
size = 6
summ = 0
avg = 0
index = 0

for index in range(size):
    summ = summ + numbers[index]
    index = index + 1
avg = summ / size
print(avg)
