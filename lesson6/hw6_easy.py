# Опишите несколько классов TownCar, SportCar, WorkCar, PoliceCar
# У каждого класса должны быть следующие аттрибуты:
# speed, color, name, is_police - Булево значение.
# А так же несколько методов: go, stop, turn(direction) - которые должны сообщать,
#  о том что машина поехала, остановилась, повернула(куда)

# Задача - 2
# Посмотрите на задачу-1 подумайте как выделить общие признаки классов
# в родительский и остальные просто наследовать от него.


class Car:
    def __init__(self,speed,color,name,is_police,direction):
        self.speed = speed
        self.color = color
        self.name = name
        self.is_police = bool(is_police)
        self.direction = direction

    def go(self):
        if self.speed != 0:
           return 'движется'

    def turn(self):
        if self.direction == 1:
            return 'на лево'
        elif self.direction == 2:
            return 'на право'


    def stop(self):
        if self.speed == 0:
            return 'стоит'


class TownCar(Car):
   pass


class SportCar(Car):
    pass


class WorkCar(Car):
    pass


class PoliceCar(Car):
    pass

    one_car = TownCar(12, 'зеленного', 'Granta', True,1)
    print(f'Городской автомобиль {one_car.name} {one_car.color} цвета'
          f'{one_car.go()} {one_car.turn()} со скоростью {one_car.speed} км/час ')

    tho_car = SportCar(100, 'синего', 'BMW', True,2)
    print(f'Спортивный автомобиль {tho_car.name} {tho_car.color} цвета'
          f'{tho_car.go()} {tho_car.turn()} со скоростью {tho_car.speed} км/час ')

    three_car = WorkCar(0, 'оранжевого', 'Камаз', True,0)
    print(f'Рабочий автомобиль {three_car.name} {three_car.color} цвета '
          f'{three_car.stop()}')







# class BasicCar:
#     def __init__(self, speed, color, name):
#         self.speed = speed
#         self.color = color
#         self.name = name
#         self.is_police = bool()
#
#     def go(self):
#         print('Машина едет')
#
#     def turn(self, direction):
#         print(f'Машина еден на {direction}')
#     def stop(self):
#         print('Машина стоит')
#
#
# class TownCar(BasicCar):
#     pass
#
#
# class SportCar(BasicCar):
#     pass
#
#
# class WorkCar(BasicCar):
#     pass
#
#
# class PoliceCar(BasicCar):
#     pass
#
#
# one_car = TownCar.go(0)
