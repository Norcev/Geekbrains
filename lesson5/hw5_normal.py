# Задача-1:
# Напишите небольшую консольную утилиту,
# позволяющую работать с папками текущей директории.
# Утилита должна иметь меню выбора действия, в котором будут пункты:
# 1. Перейти в папку
# 2. Просмотреть содержимое текущей папки
# 3. Удалить папку
# 4. Создать папку
# При выборе пунктов 1, 3, 4 программа запрашивает название папки
# и выводит результат действия: "Успешно создано/удалено/перешел",
# "Невозможно создать/удалить/перейти"

# Для решения данной задачи используйте алгоритмы из задания easy,
# оформленные в виде соответствующих функций,
# и импортированные в данный файл из easy.py
import os
from hw5_easy import ch_dir, make_dir, remove_dir


def process_user_choice(choice):
    if choice == 1:
        print('Переход в папку\n')
        name_folder = input('Введите имя папки')
        if os.path.exists(name_folder):
            ch_dir(name_folder)
            print(f'Успешный переход в папку {os.getcwd()}\n')
        else:
            print('Данной папки не существует\n')
    elif choice == 2:
        print(f'Содержимое текущей папки {os.listdir()}\n')
    elif choice == 3:
        print('Удаление папки\n')
        remove_folder = input('Введите имя папки для удаления')
        if os.path.exists(remove_folder):
            remove_dir(remove_folder)
            print(f'Папка "{remove_folder}" удалена\n')
        else:
            print(f'Папка "{remove_folder}" отсутствует')
    elif choice == 4:
        print('Создание папки\n')
        create_folder = input('Введите имя папки для создания')
        if not os.path.exists(create_folder):
            make_dir(create_folder)
            print(f'Папка "{create_folder}" успешно создана\n')
    else:
        print('Неверный ввод!!! Попробуйте еще раз.\n')


while True:
    try:
        choice = int(input('Улита работы с файлами\n'
                           'Выберите пункт:\n'
                           '1. Перейти в папку\n'
                           '2. Просмотреть содержимое текущей папки\n'
                           '3. Удалить папку\n'
                           '4. Создать папку\n'
                           '5. Выход\n'
                           '---------------------\n'
                           'Ваш выбор: '))

        if choice == 5:
            print('Программа завершена.\n')
            break
        process_user_choice(choice)
    except ValueError:
        print('\nНе верный ввод. Проверьте введеные данные\n')




