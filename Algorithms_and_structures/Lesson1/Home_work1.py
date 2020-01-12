
# 1. Найти сумму и произведение цифр трехзначного числа, которое вводит пользователь.

NUMB = int(input("Введите целое трехзначное число: "))

NUMBER_1 = NUMB // 100
NUMBER_2 = (NUMB // 10) % 10
NUMBER_3 = NUMB % 10

print(f"Сумма = {NUMBER_1 + NUMBER_2 + NUMBER_3}")
print(f"Произведение = {NUMBER_1 * NUMBER_2 * NUMBER_3}")

# 3. По введенным пользователем координатам двух точек вывести уравнение прямой вида y=kx+b, проходящей через эти точки.
print("Координаты точки A(x1;y1):")
x1 = float(input("\tx1 = "))
y1 = float(input("\ty1 = "))

print("Координаты точки B(x2;y2):")
x2 = float(input("\tx2 = "))
y2 = float(input("\ty2 = "))

print("Уравнение прямой, проходящей через эти точки:")
k = (y1 - y2) / (x1 - x2)
b = y2 - k * x2
print(" y = %.2f*x + %.2f" % (k, b))



# 5. Пользователь вводит две буквы. Определить, на каких местах алфавита они стоят и сколько между ними находится букв.
chars = 'abcdefghijklmnopqrstuvwxyz'

char_range = input('Введите диапазон символов от a до z в формате x,y: ').split(',')
print(char_range)
a = chars.index(char_range[0]) + 1
b = chars.index(char_range[1]) + 1

c = b - a

print('Первая буква: {} - находится на {} позиции,\
      вторая буква {} - находится на {} позиции.\
      Расстояние между ними {}'.format(char_range[0], a, char_range[1], b, c))


# 6. Пользователь вводит номер буквы в алфавите. Определить, какая это буква


chars = 'abcdefghijklmnopqrstuvwxyz'
charindex = int(input('Введите номер буквы английского альфавита'))
char = chars[charindex-1]
print('Буква: {}'.format(char))

# 8. Определить, является ли год, который ввел пользователем, високосным или невисокосным.

YEAR = int(input("Введите год "))

if YEAR % 4 != 0 or (YEAR % 100 == 0 and YEAR % 400 != 0):
    print("Обычный")#
else:
    print("Високосный")

# 9. Вводятся три разных числа. Найти, какое из них является средним (больше одного, но меньше другого).

NUMBER_1 = int(input("Введите первое число "))
NUMBER_2 = int(input("Введите второе число "))
NUMBER_3 = int(input("Введите третье число "))

if NUMBER_2 < NUMBER_1 < NUMBER_3 or NUMBER_3 < NUMBER_1 < NUMBER_2:
    print('Среднее:', NUMBER_1)
elif NUMBER_1 < NUMBER_2 < NUMBER_3 or NUMBER_3 < NUMBER_2 < NUMBER_1:
    print('Среднее:', NUMBER_2)
else:
    print('Среднее:', NUMBER_3)