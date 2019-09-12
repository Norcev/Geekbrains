print('Добро пожаловать')
name = input("Введите имя: ")
surname = input('Введите фамилию: ')
age = int(input('Введите возраст: '))
weight = float(input('Введите свой вес: '))

if age < 30 and weight in range(50, 121):
    print(name, surname, ',вы в хорошем состоянии')
elif age >= 30 and weight > 120:
    print(name, surname, ',вам пора бы занятся собой ')
elif age >= 40 and (weight < 50 or weight > 120):
    print(name, surname, ' ,советуем обратится к врачу')
else:
    print('Программа окончена')
