import random

class Person:
    def __init__(self, name):
        self.name = name
        self.health = 100
        self.damage = int(random.randint(25, 50))
        self.armor = 1.2

    def calculate_damage(self, defender_armor):
        return round(self.damage / defender_armor, 2)

    def attack(self, defender):
        defender.health = round(defender.health - self.calculate_damage(defender.armor), 2)
        return defender.health


class PlayGame:
    def __init__(self, attacker, defender):
        self._start_session(attacker, defender)

    def _start_session(self, player_one, player_two):
        first_attempt = True
        while player_two.health >= 0 and player_two.health >= 0:
            if first_attempt:
                print(f'Игрок: {player_two.name}. Урон: {player_one.attack(player_two)}')
                first_attempt = False
            else:
                player_one, player_two = player_two, player_one
                print(f'Игрок: {player_two.name}. Урон: {player_one.attack(player_two)}')
        else:
            print(f' Игрок: {player_one.name} победил. Остаток здоровья: {player_one.health}')


player_one = Person('Петр')
player_two = Person('Олег')

PlayGame(player_one, player_two)