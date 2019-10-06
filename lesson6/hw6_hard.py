# Задача - 1
# Вам необходимо создать завод по производству мягких игрушек для детей.
# Вам надо продумать структуру классов,
# чтобы у вас был класс, который создает игрушки на основании:
#  Названия, Цвета, Типа (животное, персонаж мультфильма)
# Опишите процедуры создания игрушки в трех методах:
# -- Закупка сырья, пошив, окраска
# Не усложняйте пусть методы просто выводят текст о том, что делают.
# В итоге ваш класс по производству игрушек должен вернуть объект нового класса Игрушка.

# Задача - 2
# Доработайте нашу фабрику, создайте по одному классу на каждый тип, теперь надо в классе фабрика
# исходя из типа игрушки отдавать конкретный объект класса, который наследуется от базового - Игрушка


class Toy:

    def __init__(self, name, color):
        self.name = name
        self.color = color


class ToyAnimal(Toy):

    def __init__(self, name, color):
        Toy.__init__(self, name, color)
        self.type = 'animal'


class ToyMult(Toy):

    def __init__(self, name, color):
        Toy.__init__(self, name, color)
        self.type = 'mult'


class Factory:

    def create_toy(self, name, color, toy_type):
        self._buy_raw_materials()
        self._sewing()
        self._set_color()
        if toy_type == 'animal':
            print("для игрушки животного")
            return ToyAnimal(name, color)

        elif toy_type == 'mult':
            print("для игрушки из мультфильма")
            return ToyMult(name, color)

    def _buy_raw_materials(self):
        print('Закупка материалов')

    def _sewing(self):
        print('Пошивка игрушки.')

    def _set_color(self):
        print('Окраска игрушки.')


factory = Factory()
toy = factory.create_toy('Чебурашка', 'Коричневый', 'mult')
