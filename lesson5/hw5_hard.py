# Задание-1:
# Доработайте реализацию программы из примера examples/5_with_args.py,
# добавив реализацию следующих команд (переданных в качестве аргументов):
#   cp <file_name> - создает копию указанного файла
#   rm <file_name> - удаляет указанный файл (запросить подтверждение операции)
#   cd <full_path or relative_path> - меняет текущую директорию на указанную
#   ls - отображение полного пути текущей директории
# путь считать абсолютным (full_path) -
# в Linux начинается с /, в Windows с имени диска,
# все остальные пути считать относительными.

# Важно! Все операции должны выполняться в той директории, в который вы находитесь.
# Исходной директорией считать ту, в которой был запущен скрипт.

# P.S. По возможности, сделайте кросс-платформенную реализацию.


# Данный скрипт можно запускать с параметрами:
# python with_args.py param1 param2 param3
import shutil
import os
import sys
print('sys.argv = ', sys.argv)


def print_help():
    print("help - получение справки")
    print("mkdir <dir_name> - создание директории")
    print("ping - тестовый ключ")
    print('cp <file_name> - создает копию указанного файла')
    print('rm <file_name> - удаляет указанный файл (запросить подтверждение операции)')
    print('cd <full_path or relative_path> - меняет текущую директорию на указанную')
    print('ls - отображение полного пути текущей директории')

def make_dir():
    if not dir_name:
        print("Необходимо указать имя директории вторым параметром")
        return
    dir_path = os.path.join(os.getcwd(), dir_name)
    try:
        os.mkdir(dir_path)
        print(f'директория {dir_name} создана')
    except FileExistsError:
        print(f'директория {dir_name} уже существует')

def remove_dir():
    if not dir_name:
        print("Необходимо указать имя удаляемой директории вторым параметром")
        return
    if os.path.exists(dir_name):
        print(f'файлу {dir_name} существует и будет удален')
        yes_no = input('y - удалить, n - не удалять')
        if yes_no == 'y':
            try:
                os.remove(dir_name)
            except Exception:
                print('файл занят и не может быть удален')
        elif  yes_no == 'n':
            print('удаление отмененно')
        else:
            print('файл не существует')

def ping():
    print("pong")

def ls_dir():
    print(f'текущая директория: {os.getcwd()}')

def cd_dir():
    if not dir_name:
        print("необходимо указать путь")
        return
    else:
        try:
            os.chdir(dir_name)
            print(f'Текущий путь {os.getcwd()}')
        except Exception as error:
            print(error)

def copy_file():
    if not dir_name:
        print("имя копируемого файла")
        return
    else:
        filename = dir_name.split('\\')[-1]
        print(filename)
        # os.system(f'copy {dir_name} copy_{filename}')
        shutil.copyfile(f'{dir_name}',f' copy_{filename}')
        print(os.listdir())



do = {
    "help": print_help,
    "mkdir": make_dir,
    "ping": ping,
    "rm": remove_dir,
    "ls": ls_dir,
    "cd": cd_dir,
    "cp": copy_file
}

try:
    dir_name = sys.argv[2]
except IndexError:
    dir_name = None

try:
    key = sys.argv[1]
except IndexError:
    key = None


if key:
    if do.get(key):
        do[key]()
    else:
        print("Задан неверный ключ")
        print("Укажите ключ help для получения справки")
