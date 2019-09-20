# # Задание - 1
# # Создайте функцию, принимающую на вход Имя, возраст и город проживания человека
# # Функция должна возвращать строку вида "Василий, 21 год(а), проживает в городе Москва"
#
names = input('В ведите имя: ')
ages = input('В ведите возраст: ')
city = input('В ведите город: ')

def messege( name , ages , city):
    return f'{name} , {ages} год(а), проживает в городе {city}'
print(messege(names,ages,city))
#
#
# # Задание - 2
# # Создайте функцию, принимающую на вход 3 числа, и возвращающую наибольшее из них
#
def max_numbers(*args):
     return max(*args)
 print (max_numbers(8, 15 ,3))

#
# # Задание - 3
# # Создайте функцию, принимающую неограниченное количество строковых аргументов,
# # верните самую длинную строку из полученных аргументов
#
#
#
def long_string(*args):
    return max(args, key=len)

print(long_string('Hello', 'banquet', 'da', 'compact', 'cosy', 'coachman'))

#
#
#
#
# # Задание - 1
# # Вам даны 2 списка одинаковой длины, в первом списке имена людей, во втором зарплаты,
# # вам необходимо получить на выходе словарь, где ключ - имя, значение - зарплата.
# # Запишите результаты в файл salary.txt так, чтобы на каждой строке было 2 столбца,
# # столбцы разделяются пробелом, тире, пробелом. в первом имя, во втором зарплата, например: Vasya - 5000
# # После чего прочитайте файл, выведите построчно имя и зарплату минус 13% (налоги ведь),
# # Есть условие, не отображать людей получающих более зарплату 500000, как именно
# #  выполнить условие решать вам, можете не писать в файл
# # можете не выводить, подумайте какой способ будет наиболее правильным и оптимальным,
# #  если скажем эти файлы потом придется передавать.
# # Так же при выводе имя должно быть полностью в верхнем регистре!
# # Подумайте вспоминая урок, как это можно сделать максимально кратко, используя возможности языка Python.
#


salary_file = open('salary.txt', 'w', encoding='UTF-8')
names = ['Petrov', 'Ivanov', 'Sidorov']
salaries = [30000, 80000, 10000]

def return_dic(names, salaries):
    return dict(zip(names, salaries))

def write_to_file():
    with open('salary.txt', 'w', encoding='UTF-8') as file:
       for name, salary in return_dic(names, salaries).items():
           file.write(f'{name} - {salary}\n')

write_to_file()

salary_file = open('salary.txt', 'r', encoding='UTF-8')
for line in salary_file:
    name, dash, salary = line.split()
    if int(salary) <= 50000:
        income_tax = int(salary) * 0.87
        print(str(name.upper()), dash, int(income_tax))
salary_file.close()


