import os


# Задача-1:
# Напишите скрипт, создающий директории dir_1 - dir_9 в папке,
# из которой запущен данный скрипт.
# И второй скрипт, удаляющий эти папки.


def make_dir(i):
    os.mkdir(f'{i}')  # функция  создания папок


def remove_dir(i):
    os.rmdir(f'{i}')  # функция  удаления папок


def ch_dir(i):
    os.chdir(i)

if __name__ == '__main__':

        for r in range(9):
            if not os.path.exists(f'dir_{r + 1}'):
                make_dir(f'dir_{r + 1}')
            else:
                print('Создание не возможно файлы уже существуют!')

        for r in range(9):
            if os.path.exists(f'dir_{r + 1}'):
                remove_dir(f'dir_{r + 1}')
            else:
                print(f'Файл dir_{r + 1} отсутствует')


        print(f'Текущая директория {os.getcwd()}')
        print(os.listdir())


