names = ['Petrov', 'Ivanov', 'Sidorov']
salaries = [30000, 800000, 10000]


def map_lists(names, salaries):
    return dict(zip(names, salaries))   # возвращает словарь


def write_to_file(filename, input_text):    # функция принимиет имя файла и текст файла
    with open(filename, 'w', encoding='UTF-8') as file:   # создает новый файл
        for name, salary in input_text.items():           # возвращат комбинацию ключа и значения
            file.write(f'{name} - {salary}\n')            # завписывает в файл


def read_file(file_path):   # перелаем функции путь к файлу
    result = dict()         # создаем пустой словарь

    with open(file_path, encoding='UTF-8') as file:             # отрываем по умолчанию для чтения
        data = [line.split() for line in file.readlines()]      # добавляем из фаила оформатироованую информацию

    for name, _, salary in data:         # цикл с заглушкой
        if int(salary) < 500000:
            result[str(name).upper()] = int(salary) * (1 - 0.13)   # Добаылем значения в словарь dict['key'] = 'value'
    return result


write_to_file('salary.txt', map_lists(names, salaries))  # передаем функции имя файла и текст файла
print(read_file('salary.txt'))    # передаем функции путь к файлу
